public with sharing class FC_Products_Controller {

    // Constructor
    public FC_Products_Controller(ApexPages.StandardController controller) {
      this.fc = (Freight_Calculator__c)controller.getSubject();
      loadMProducts(); 
      loadOProducts();  
      m_sc = controller;   
    }

     // public Getter to provide table headers 
     public string[] getmheaders(){
      return new string [] {'Product Name','Product Code','Price'}; 
     }

     // public Getter to provide table headers 
     public string[] getoheaders(){
      return new string [] {'','Product Name','Product Code','Price'}; 
     }

     // public Getter method to retrive Mandatory products 
     public FreightProductLineItem__c[] getMProducts(){ 
      return this.mproducts; 
     }

     // public Getter method to retrive Optional products 
     public FreightProductLineItem__c[] getOProducts(){ 
      return this.oproducts; 
     }

     public pagereference deleteOptProduct() {
        string deleteID = ApexPages.CurrentPage().getParameters().get('deleteId');
        for(FreightProductLineItem__c opt :[SELECT oproducts.Id FROM FreightProductLineItem__c oproducts
                                WHERE  oproducts.Freight_Calculator__c = :fc.id ]){
            If (deleteID == opt.Id) delete opt;
        }
        loadOProducts();
        pageReference pr = new pagereference('/apex/fc_productspage?Id='+ApexPages.CurrentPage().getParameters().get('Id'));
        pr.setRedirect(true);
        return pr;
     }

     // public method to Exit
     public pagereference Cancel(){
      return m_sc.cancel();
     }

     public pagereference Recalculate(){
        return null;
     }

    // Load Mandatory Products
    public void loadMProducts(){
        this.mproducts = [SELECT 
                prod.Product_Name__c ,
                prod.Product_Code__c ,
                prod.Price__c   
              FROM 
              FreightProductLineItem__c prod 
              WHERE 
              prod.Freight_Calculator__c = :fc.id and prod.Optional__c = false];
    }

    // Load Optional Products
    public void loadOProducts(){
        this.oproducts = [SELECT prod.Id, 
                prod.Product_Name__c ,
                prod.Product_Code__c ,
                prod.Price__c   
              FROM 
              FreightProductLineItem__c prod 
              WHERE 
              prod.Freight_Calculator__c = :fc.id and prod.Optional__c = true];
    }

    // Class Variables
    private Freight_Calculator__c fc;
    private FreightProductLineItem__c[] mproducts ;     // Mandatory Products based on Origin & Crate Types
    private FreightProductLineItem__c[] oproducts ;     // Optional Products based on Origin
    ApexPages.standardController m_sc = null;
}