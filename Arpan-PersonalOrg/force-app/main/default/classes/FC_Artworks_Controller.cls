public class FC_Artworks_Controller {
 
ApexPages.StandardController fc_controller;
public decimal sumOfCW{get;set;}
  // Constructor
 public FC_Artworks_Controller(ApexPages.StandardController controller) {
      
//      this.fc = (Freight_Calculator__c)controller.getSubject();
     fc_controller = controller;
     this.fc = (Freight_Calculator__c)fc_controller.getSubject();
      loadArtworks();                                                                                                                                                                                                                                   
      m_sc = controller;   
 }
 
  // Action Method called from page button
 public pagereference saveArtworks() { 
      sumOfCW = 0.0;
      for(Temporary_Artwork__c a:this.artworks){
      
          a.CurrencyIsoCode = 'HKD';
          
          if(a.Chargeable_Weight__c == null || a.Chargeable_Weight__c == 0){
          
              Decimal h = a.Height__c;
              Decimal l = a.Breadth__c;
              Decimal b = a.Length__c;          
          
              if(h != null && l != null && b != null){
                  a.Chargeable_Weight__c = h*l*b;
              }else if(h != null && l != null){
                  a.Chargeable_Weight__c = h*l;
              }else if(b != null && l != null){
                  a.Chargeable_Weight__c = l*b;
              }else if(b != null && h != null){
                  a.Chargeable_Weight__c = h*b;
              }else if(b != null){
                  a.Chargeable_Weight__c = b;
              }else if(h != null){
                  a.Chargeable_Weight__c = h;
              }else if(l != null){
                  a.Chargeable_Weight__c = l;
              } 
              if(a.Chargeable_Weight__c != null){
                  a.Chargeable_Weight__c = a.Chargeable_Weight__c/6000;                     
                  a.Chargeable_Weight__c = a.Chargeable_Weight__c.setScale(2);                   
              }                
          }    
          
          sumOfCW  += ((a.Chargeable_Weight__c !=null)?a.Chargeable_Weight__c:0.0);   
          if(sumOfCW > 500){
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Sum of all Chargeable Weight is more than 500.'));
              return null;
          }   
      }
      upsert this.artworks;
     // fc_controller.reset();
      //fc_controller.addFields(new LIST<String> {'Id'});
     // PageReference curPage = ApexPages.CurrentPage();
      //curPage.setRedirect(TRUE);
      return null;
 }
 
  // Action Method called from page button
 public pagereference newArtwork() { 
  Temporary_Artwork__c artwork = new Temporary_Artwork__c();
  artwork.Freight_No__c =this.fc.id; 
  artwork.CurrencyIsoCode = 'HKD';
  artworks.add (artwork);
  return null;
 }
 
// Action Method called from page button
 public pagereference deleteArtwork() { 
  string artworkID = ApexPages.CurrentPage().getParameters().get('deleteId');
  try{
    for(Temporary_Artwork__c art :[SELECT arts.Id FROM Temporary_Artwork__c arts 
                                WHERE  arts.Freight_No__c = :fc.id ]){
        If (artworkID == art.Id) delete art;
    }
  }catch(Exception e){
  
  }  
  loadArtworks();
  return null;
 }

 public pagereference Cancel(){
    return m_sc.cancel();
 }

 public pagereference GoProductsPage(){
  this.saveArtworks();
  Temporary_Artwork__c[] artworks = getArtworks();
  if(artworks.size() <= 0 ){    
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'There are no artworks created to go forward.'));
      return null;
  }else if(sumOfCW > 500){
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Sum of all Chargeable Weight is more than 500.'));
      return null;
  }else{
      FC_Helper fc_helper =  new FC_Helper(fc.Id); 
      //fc_helper.deleteProducts();
      fc_helper.insertProducts('ArtworksPage');
         
      PageReference productsPage = Page.FC_ProductsPage;
      productsPage.getParameters().put('Id',fc.Id);
      return  productsPage;
  }
  return null; 
}

 public pagereference GoCratePage(){
  this.saveArtworks();
  Temporary_Artwork__c[] artworks = getArtworks();
  if(artworks.size() <= 0 ){    
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'There are no artworks created to go forward.'));
      return null;
  }else if(sumOfCW > 500){
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Sum of all Chargeable Weight is more than 500.'));
      return null;
  }else{     
      FC_Helper fc_helper = new FC_Helper(fc.Id); 
      fc_helper.refreshCrate();
      PageReference cratePage = Page.FreightCalc_CratesPage;
      cratePage.getParameters().put('Id',fc.Id);
      return  cratePage;
  }
  return null;
 }

  // public Getter to provide table headers 
 public string[] getheaders(){
  return new string [] {'','Type','Length','Breadth', 'Height','Chargeable Weight','Declared Value'};
 }

 // public Getter method to retrive Artwork records
 public Temporary_Artwork__c[] getArtworks(){ 
  return this.artworks; 
 }

 // single internal method to load Artworks
 private void loadArtworks() {
    this.artworks = [SELECT  
        artworks.Id, 
        artworks.Type__c ,
        artworks.Length__c ,
        artworks.Breadth__c ,
        artworks.Height__c ,
        artworks.Chargeable_Weight__c,
        artworks.Declared_Value__c
      FROM 
      Temporary_Artwork__c artworks
      WHERE 
      artworks.Freight_No__c = :fc.id ];
 }

// class variables
 private Freight_Calculator__c fc;
 private Temporary_Artwork__c[] artworks ;    
 ApexPages.standardController m_sc = null;
}