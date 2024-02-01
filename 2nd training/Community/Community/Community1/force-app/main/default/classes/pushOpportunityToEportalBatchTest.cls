@isTest
public class pushOpportunityToEportalBatchTest {

    @isTest
    public static void run(){
        
        Account a = new Account(name='Tan Enterprise');
        insert a;
        Contact c = new Contact(firstName='Ken', lastName='LEE', 
                                accountid=A.id, Email='lim@myMail.com', Phone='777', MobilePhone='111', Fax='222');
        insert c;
        
        Set<Id> IdofOpp = new Set<Id>();
        
        Id devRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Artmove').getRecordTypeId();
        Opportunity opp = new Opportunity 
            (recordtypeid = devRecordTypeId,Push_Lost_Cancelled_Status__c  = false, Push_Opportunity_Info__c=false,CloseDate = Date.newInstance(2009, 11, 01), 
             Name = 'Test Opportunity', StageName = 'Survey', Billing_Currency__c = 'SGD', 
             ETA__c = Date.newInstance(2011, 04, 29), ETD__c = Date.newInstance(2010, 04, 20),AccountId=a.id,Actual_Volume_cuft__c=12);
        insert opp;
        IdofOpp.add(opp.id);
        Test.startTest();
        pushOpportunityToEportalBatch PushObj = new pushOpportunityToEportalBatch(IdofOpp);
        DataBase.executeBatch(PushObj); 
        Test.stopTest();
    }
}