public class FC_Helper
{
    //Class variables
  Freight_Calculator__c fc;
  String FC_type;
  String airport;

    //Constructor
    public FC_Helper(String instanceId)
    {
        this.fc = [SELECT Id, 
                      Total_Artworks_Weight__c,
                      Products_Added__c,
                      Collection_City__c,
                      Destination_City__c,
                      Crate_Length_To_Be__c,
                      Crate_Width_To_Be__c,
                      Crate_Height_To_Be__c,
                      Chargeable_Weight__c, 
                      Total_Declared_Value__c,
                      Type_of_Services__c
                      FROM Freight_Calculator__c 
                      WHERE Id = :instanceId]; 
        
          If ( fc.Products_Added__c == false  || fc.Products_Added__c == null ) {
                    fc.Products_Added__c = true;
                    fc.CurrencyIsoCode = 'HKD';
                    update fc;

                    this.fc = [SELECT Id, 
                      Total_Artworks_Weight__c,
                      Products_Added__c,
                      Collection_City__c,
                      Destination_City__c,
                      Crate_Length_To_Be__c,
                      Crate_Width_To_Be__c,
                      Crate_Height_To_Be__c,
                      Chargeable_Weight__c, 
                      Total_Declared_Value__c,
                      Type_of_Services__c
                      FROM Freight_Calculator__c 
                      WHERE Id = :instanceId];   
          }            

    }         // End Constructor  

    public void insertProducts(String pageFrom){

         deleteProducts();

         If (fc.Collection_City__c == 'Hong Kong (HKG airport)') {
                    FC_type = 'Origin';
                    airport = fc.Destination_City__c;
                    fc.Type_of_Services__c = 'Origin handling in ' + airport + ' (via air)'; 
         }    
         Else{
                    FC_type = 'Destination'; 
                    airport = fc.Collection_City__c;
                    fc.Type_of_Services__c = 'Destination handling in ' + airport + ' (via air)';
         } 
               
         update fc;

         AddProducts();
         
         if (FC_type == 'Origin') 
          {
              AirFreightProducts();

              /*if (pageFrom == 'CratePage')*/ CrateProducts();                      
          }    

    }    // End Function insertProducts..  


    //Function to add Freight Products, based on Origin
    public void AddProducts(){
        
      FreightProductLineItem__c[] fp = new List<FreightProductLineItem__c>();
      List<FreightCalc_Products__c> products = FreightCalc_Products__c.getAll().values();
      Decimal cost ;
              
        for(FreightCalc_Products__c p :products) {
            If (  (    ( FC_type =='Origin' && p.Type__c == 'Export' )
                    || ( FC_type =='Destination' &&  p.Type__c == 'Import'  )
                    || (p.Type__c != 'Export'  && p.Type__c != 'Import')
                  ) && p.Active__c == TRUE 
                ) {

                    If (p.Dependent_Field__c == 'CustomLogic-Crate'){

                            Temporary_Crate__c[] crates  = [SELECT crt.Volumetric_Weight__c,
                                                                   crt.Type__c 
                                                              FROM Temporary_Crate__c crt
                                                              WHERE crt.Freight_No__c = :fc.Id  AND
                                                              crt.Volumetric_Weight__c  > 150];

                            for(Temporary_Crate__c crt:crates){

                                    FreightProductLineItem__c fp_line = new FreightProductLineItem__c(
                                    Freight_Calculator__c =fc.Id,
                                    CurrencyIsoCode = 'HKD',
                                    Product_Name_Physical__c = p.Product_Name__c,
                                    Product_Code_Physical__c = p.Type__c, 
                                    Optional_Physical__c     = p.Optional__c,
                                    Price__c = p.Price__c );
                                    fp.add(fp_line);  
                                                
                           }
                    }Else {

                      FreightProductLineItem__c fp_line = new FreightProductLineItem__c(
                      Freight_Calculator__c =fc.Id,
                      CurrencyIsoCode = 'HKD',
                      Product_Name_Physical__c = p.Product_Name__c,
                      Product_Code_Physical__c = p.Type__c, 
                      Optional_Physical__c     = p.Optional__c );

                      insert fp_line;

                      If (p.Dependent_Field__c == 'Chargeable_Weight__c') {
                            
                            cost = p.Rate__c * fc.Chargeable_Weight__c;
                            If ( cost > p.Price__c ) fp_line.Price__c = cost;  
                            Else fp_line.Price__c = p.Price__c;

                      }Else If (p.Dependent_Field__c == 'Total_Declared_Value__c'){
                     
                            fp_line.Price__c = p.Rate__c * fc.Total_Declared_Value__c;
                            System.debug('Cost : ' + fp_line.Price__c + ' Rate: ' + p.Rate__c + ' Declared Value: ' + fc.Total_Declared_Value__c  );

                      }Else If (p.Dependent_Field__c == 'M3') {
                            
                            cost = p.Rate__c * ( (fc.Crate_Length_To_Be__c * fc.Crate_Width_To_Be__c * fc.Crate_Height_To_Be__c) / 1000000 ); 
                            If ( cost > p.Price__c ) fp_line.Price__c = cost;  
                            Else fp_line.Price__c = p.Price__c;

                      }Else  fp_line.Price__c = p.Price__c ;

                      

                      //fp.add(fp_line);
                      update fp_line;
                   }
                }  
          }          

        //insert fp;
    } // Add Products

  

  public void AirFreightProducts(){

                 FreightCalc_Airfreight__c prd =     [SELECT 
                              p.Airport_Name__c,
                              p.Price__c,
                              p.Weight__c
                              FROM FreightCalc_Airfreight__c p 
                              WHERE p.Airport_Name__c = :airport AND 
                              p.Weight__c >= :fc.Total_Artworks_Weight__c  
                              ORDER BY p.Weight__c LIMIT 1];

                FreightProductLineItem__c fp_line = new FreightProductLineItem__c(
                Freight_Calculator__c = fc.Id,
                Product_Name_Physical__c = prd.Airport_Name__c,
                Product_Code_Physical__c = 'Airfreight',
                Price__c = prd.Price__c ,
                CurrencyIsoCode = 'HKD'  );   

                insert fp_line;    
  
  }  // End Airfreight Products


  // Function to delete all Temporary Crates associated with a Freight Calculator Record....
  public void refreshCrate() {

    Temporary_Crate__c[] allCrates = [SELECT crt.Id FROM Temporary_Crate__c  crt
                         WHERE crt.Freight_No__c = :fc.Id ]; 

    FreightProductLineItem__c[] crateProducts =   [SELECT fprd.Id FROM FreightProductLineItem__c  fprd
                         WHERE fprd.Product_Code__c  = 'Crate' and fprd.Freight_Calculator__c = :fc.Id ];                    
    
        delete allCrates;
        delete crateProducts;

    Temporary_Crate__c crt = new Temporary_Crate__c();
    crt.Freight_No__c = fc.Id;
    crt.Type__c = 'Crate';
    crt.FreightProduct_Added__c = FALSE;
    crt.Length__c = fc.Crate_Length_To_Be__c;
    crt.Width__c = fc.Crate_Width_To_Be__c;
    crt.Height__c = fc.Crate_Height_To_Be__c;

    insert crt; 

  }  // End Function Refresh Crate deleteProducts  

  // Function to delete all Products associated with the Freight calculator
  public void deleteProducts() {

    FreightProductLineItem__c[] crateProducts =   [SELECT fprd.Id FROM FreightProductLineItem__c  fprd
                         WHERE fprd.Freight_Calculator__c = :fc.Id ];                    
    
    delete crateProducts;

  }  // End Function delete Products  

    public void CrateProducts(){
      
      Temporary_Crate__c[] crates;
      FreightProductLineItem__c[] fprds = new List<FreightProductLineItem__c>();
      Product2 prd;

         try{
      
            crates = [ SELECT c.Id,
                              c.Type__c,
                              c.Length__c,
                              c.Width__c,
                              c.Height__c,
                              c.FreightProduct_Added__c,
                              c.Volumetric_Weight__c
                              FROM Temporary_Crate__c c 
                              WHERE c.Freight_No__c = :fc.Id 
                               ];
                               
                             


             for (Temporary_Crate__c crt: crates ){

                FreightProductLineItem__c fpl = new FreightProductLineItem__c();
                fpl.Freight_Calculator__c = fc.Id;
                fpl.Product_Code_Physical__c = crt.Type__c;
                fpl.CurrencyIsoCode = 'HKD';

                If ( crt.Type__c == 'Crate') {   
     
                      fpl.Product_Name_Physical__c = 'Custom Crate';  
                      Decimal toround = ( crt.Length__c  *  crt.Width__c *  crt.Height__c ) / 1000000;
                      Decimal rounded = toRound.setScale(2, RoundingMode.HALF_UP);
                      fpl.Price__c = 2800 * rounded; 
                      
                   } else {

                      fpl.Product_Name_Physical__c = 'Manually Made Box';  
                            
                      If ( crt.Length__c  > 200 || crt.Height__c > 200 ) fpl.Price__c = 500;
                      else fpl.Price__c = 250;                              
                   }     

                   crt.FreightProduct_Added__c = TRUE;
                   fprds.add(fpl);                   

                }                  
          
             insert fprds;
             update crates; 
        }catch(Exception e ){
          
        }     
 
  }  // End Crate Products

}  // End Class FC_Helper