@isTest
public class pushOpportunityToEportalHelperTest {

    @isTest
    public static void run(){
        
         Account a = new Account(name='Tan Enterprise');
    insert a;
    Contact c = new Contact(firstName='Ken', lastName='LEE', 
                            accountid=A.id, Email='lim@myMail.com', Phone='777', MobilePhone='111', Fax='222');
    insert c;
        
            Id devRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Artmove').getRecordTypeId();

        Set<Id> OppIdSet = new Set<Id>();
    
    Opportunity opp = new Opportunity();
        opp.recordtypeid = devRecordTypeId;
                opp.Push_Lost_Cancelled_Status__c  = false;
                opp.Push_Opportunity_Info__c=false;
                opp.CloseDate = Date.newInstance(2009, 11, 01); 
                 opp.Name = 'Test Opportunity';
                opp.StageName = 'Survey';
                opp.Billing_Currency__c = 'SGD';
                 opp.ETA__c = Date.newInstance(2011, 04, 29);
                opp.ETD__c = Date.newInstance(2010, 04, 20);
                opp.AccountId=a.id;
                opp.Actual_Volume_cuft__c=12;
        
    insert opp;
        
        
        opp.StageName = 'Cancelled';
        update opp;
        
        
      
        
    }
}