@istest
public class CartonFabricationPageControllerTest {
    public static testmethod void mytest2(){
        Carton_Fabrication__c cb=new Carton_Fabrication__c();
        cb.Required_Date__c=system.Today();
        //cb.name='TestName';
        insert cb;
        
        CrateInstructionLineItem__c cli=new CrateInstructionLineItem__c();
        
        cli.Carton_Fabrication__c=cb.id;
        insert cli;
        
          ApexPages.StandardController sc = new ApexPages.StandardController(cb);
        CartonFabricationPageController cpc=new CartonFabricationPageController(sc);
        
        PageReference pageRef = Page.cartonfabricationpage;
       
        Test.setCurrentPage(pageRef);
        CrateInstructionLineItemDetailController cic=new CrateInstructionLineItemDetailController();
    cic.languageCode='0001';
    }

}