@isTest
public class FC_Products_ControllerTest {
    static testmethod void FC_Products_Controller(){
        
        Freight_Calculator__c fc = new Freight_Calculator__c();
        fc.Collection_City__c = 'Singapore (SIN airport)';
        fc.Destination_City__c = 'Hong Kong (HKG airport)';
        insert fc;
        
        FreightProductLineItem__c fprod = new FreightProductLineItem__c();
        fprod.Freight_Calculator__c = 'a0N11000003iRwA';
        fprod.CurrencyIsoCode = 'SGD - Singapore Dollar';
        
        PageReference PageRef = Page.FC_ProductsPage;
        test.setCurrentPage(PageRef);
        ApexPages.CurrentPage().getparameters().put('id', fc.id);
        ApexPages.StandardController sc = new ApexPages.standardController(fc);
        
        FC_Products_Controller ctrl = new FC_Products_Controller(sc); 
        ctrl.loadOProducts();
        ctrl.getmheaders();
        ctrl.getoheaders();
        ctrl.getMProducts();
        ctrl.getOProducts();
        ctrl.deleteOptProduct();
        ctrl.Recalculate();
        ctrl.Cancel();
        //getoheaders('Painting Installation','Import','100');
        //FreightProductLineItem__c ctrl = new FreightProductLineItem__c(sc); 
    }

}