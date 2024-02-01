/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class CopyCrateToTransactionConExtTest {

    static testMethod void myUnitTest() {
        Account a = new Account(name='Test Acc');
        Database.insert(a);
        Contact con = new Contact(firstName='Joe', lastName='Doe', 
        accountid=A.id, Email='joe@mail.com', Phone='123', MobilePhone='321', Fax='213');
        Database.insert(con);
        
        
        Opportunity opp = new Opportunity(CloseDate = Date.today(), 
        								  Name = 'Test Opportunity', 
        								  StageName = 'Closed Won',
        								  Estimated_Volume__c = 123,
                                   		  Pack_Date_1__c = Date.today(),
                                          Amount = 22 
        								  );
        Database.insert(opp);
        
        Job_Reference__c j = new Job_Reference__c(Opportunity__c = opp.Id);
		Database.insert(j);
		Crate__c c = new Crate__c(Name = 'TCr', Job_Reference__c = j.Id);
		Database.insert(c);
		artApp__Transaction__c t = new artApp__Transaction__c(Job_Reference__c = j.Id, Payment_to_be_Collected__c = 0); 
		Database.insert(t);
		
		Pagereference newPage = Page.CopyToTransaction;
        Test.setCurrentPage(newPage);
        newPage.getParameters().put('id',j.id);
        system.assertEquals(j.id, Apexpages.currentPage().getParameters().get('id'));      
        
        list<Crate__c> crateList = new list<Crate__c>{c};
        
        ApexPages.StandardSetController sc = new ApexPages.StandardSetController(crateList);
		CopyCrateToTransactionConExt myTest = new CopyCrateToTransactionConExt(sc);
		
		myTest.t.artApp__Transaction__c = t.ID;
		List<CopyCrateToTransactionConExt.CrateWrapper> crates = myTest.getCrates();
		crates[0].isSelected = true;
		List<CopyCrateToTransactionConExt.CrateWrapper> selectedCrates = myTest.selectedCrates;
		
		myTest.addSelected();
		myTest.copyCrates();
		
		artApp__Collector__c col = new artApp__Collector__c(Name = 'TestJoe');
        Database.insert(col);	
        newPage.getParameters().put('id',col.id);
        CopyCrateToTransactionConExt myTest2 = new CopyCrateToTransactionConExt(sc);
		
    }
}