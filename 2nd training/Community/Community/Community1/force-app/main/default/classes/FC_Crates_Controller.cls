public class FC_Crates_Controller {

    // Constructor
     public FC_Crates_Controller(ApexPages.StandardController controller) {
          this.fc = (Freight_Calculator__c)controller.getSubject();
          loadCrates();   
          m_sc = controller;   
     }

     //Independent LoadCrates function
     private void loadCrates() {
        this.crates = [SELECT  
            crates.Id, 
            crates.Type__c ,
            crates.Length__c ,
            crates.Width__c ,
            crates.Height__c   
          FROM 
          Temporary_Crate__c crates
          WHERE 
          crates.Freight_No__c = :fc.id ];
     }

     // Action Method called from page button
     public pagereference saveCrates() { 
        upsert this.crates;
        return null;
     }
 
      // Action Method called from page button
     public pagereference newCrate() { 
      Temporary_Crate__c crate = new Temporary_Crate__c();
      crate.Freight_No__c =this.fc.id; 
      crates.add (crate);
      return null;
     }
 
    // Action Method called from page button
     public pagereference deleteCrate() { 
      string crateId = ApexPages.CurrentPage().getParameters().get('deleteId');
      try{
          for(Temporary_Crate__c crt :[SELECT crates.Id FROM Temporary_Crate__c crates 
                                    WHERE  crates.Freight_No__c = :fc.id ]){
                If (crateId == crt.Id) delete crt;
          }
       }catch(Exception e){
       }   
      loadCrates();
      return null;
     }

     //custom Back function to go back to Artworks Page
     public pagereference Back(){
         PageReference artworksPage = Page.FC_Artworks_Page; 
         artworksPage.getParameters().put('Id',fc.Id);
         return  artworksPage;      
     }

     public pagereference Cancel(){
        return null;
     }

     public pagereference GoProductsPage(){
        saveCrates();
        FC_Helper fc_help = new FC_Helper(fc.Id);
        //fc_help.deleteProducts();
        //fc_help.CrateProducts();
        fc_help.insertProducts('CratePage');
        PageReference productsPage = Page.FC_ProductsPage;
        productsPage.getParameters().put('Id',fc.Id);
        return  productsPage; 
     }

     // public Getter to provide table headers 
     public string[] getheaders(){
      return new string [] {'','Crate Type','Length','Breadth', 'Height'};
     }

     // public Getter method to retrive Artwork records
     public Temporary_Crate__c[] getCrates(){ 
      return this.crates; 
     }

// class variables
 private Freight_Calculator__c fc;
 private Temporary_Crate__c[] crates ;     
 ApexPages.standardController m_sc = null;
}