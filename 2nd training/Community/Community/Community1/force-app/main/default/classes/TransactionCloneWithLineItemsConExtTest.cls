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
private class TransactionCloneWithLineItemsConExtTest {
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
		artApp__Transaction__c t = new artApp__Transaction__c(Job_Reference__c = j.Id, Payment_to_be_Collected__c = 0); 
		Database.insert(t);
		artApp__Line_Item__c li = new artApp__Line_Item__c(artApp__Transaction__c = t.Id);
		Database.insert(li);
		
		list<Id> rts = new list<Id>(); 
		for (RecordType rt: [select id, Name, DeveloperName, SobjectType
                                        from RecordType
                                        where IsActive = true
                                        and SobjectType = 'artApp__Transaction__c'
                                       ]){
           rts.add(rt.Id);
        }
		
		
		
		Pagereference newPage = Page.TransactionCloneWithLineItems;
        Test.setCurrentPage(newPage);
        newPage.getParameters().put('id',t.id);
        system.assertEquals(t.id, Apexpages.currentPage().getParameters().get('id'));      
        
        ApexPages.StandardController sc = new ApexPages.StandardController(t);
        TransactionCloneWithLineItemsConExt myTest = new TransactionCloneWithLineItemsConExt(sc);
        
        List<SelectOption> rtOptions = myTest.rtOptions;
        if(!rts.IsEmpty()){
        	myTest.rt = rts[0];
        }
        
        myTest.onSave();
        
		
	}    
}