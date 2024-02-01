@isTest
public class FC_Crates_ControllerTest {
    static testmethod void FC_Crates_ControllerTest(){
        Freight_Calculator__c fc = new Freight_Calculator__c();
        fc.Collection_City__c = 'Singapore (SIN airport)';
        fc.Destination_City__c = 'Hong Kong (HKG airport)';
        insert fc;
        
        Temporary_Artwork__c art = new Temporary_Artwork__c();
        art.Freight_No__c = fc.Id;
        art.Length__c =100;
        art.Breadth__c = 50;
        art.Height__c = 20;
        art.Chargeable_Weight__c = 12;
        insert art;
        
        FreightCalc_Airfreight__c fa = new FreightCalc_Airfreight__c();
        fa.Name = 'Custom_Settings';
        fa.Airport_Name__c = 'Singapore (SIN airport)';//Hong Kong (HKG airport)';
        fa.Weight__c = 15;
        fa.Price__c = 100;
        insert fa;
        
        PageReference PageRef = Page.FreightCalc_CratesPage; 
        test.setCurrentPage(PageRef);
        ApexPages.CurrentPage().getparameters().put('id', fc.id);
        ApexPages.StandardController sc = new ApexPages.standardController(fc);
        
        FC_Crates_Controller ctrl = new FC_Crates_Controller(sc); 
        ctrl.newCrate();
        ctrl.saveCrates();
        ctrl.deleteCrate();
        ctrl.getCrates();
        ctrl.Back();
        ctrl.Cancel();
        ctrl.getheaders();
        ctrl.GoProductsPage();
    }
}