@isTest
public class PushJobReferenceToEportalControllerTest {

    @isTest
    public static void run(){
    Account a = new Account(name='Tan Enterprise');
    insert a;
    Contact c = new Contact(firstName='Ken', lastName='LEE', 
                            accountid=A.id, Email='lim@myMail.com', Phone='777', MobilePhone='111', Fax='222');
    insert c;
        
            Id devRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Artmove').getRecordTypeId();

    
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
        
        system.debug('opp'+opp);
    
   Costing_Sheet__c cos = new Costing_Sheet__c(Costing_Sheet_Id__c='123aws',Revision_ID__c='',Opportunity__c=opp.id);
    insert cos;
        system.debug('cos'+cos.Costing_Sheet_Id__c+'>>'+cos.Opportunity__c);
        
        opp.Approved_Costing_Sheet__c = cos.Id;
        update opp;
        system.debug('opp.Approved_Costing_Sheet__c'+opp.Approved_Costing_Sheet__c);
    
        opp.StageName = 'Closed Won';
        update opp;
    
    OpportunityContactRole oppcontrole = new OpportunityContactRole();
    oppcontrole.ContactId = c.id;
    oppcontrole.OpportunityId = opp.id;
    insert oppcontrole;
    
  
    
   
    
    Job_Reference__c jr = new Job_Reference__c();
     jr.Opportunity__c = opp.id;
        jr.Name = 'Ram Avtar';
    insert jr;
        
        system.debug('name'+jr.Name+'oop'+jr.Opportunity__c);
        system.debug('opp'+jr.Opportunity__c+'??'+jr.Opportunity__r.Approved_Costing_Sheet__c+'//'+jr.Opportunity__r.Approved_Costing_Sheet__r.Costing_Sheet_Id__c);
        
        PushJobReferenceToEportalController.apiPushInfo(jr.Id);
        jr.Push_Job_Info__c = true;
        update jr;
        PushJobReferenceToEportalController.apiPushInfo(jr.Id);
        PushJobReferenceToEportalJavasript.apiCallout(jr.Id);
        opp.Push_Opportunity_Info__c=true;
        update opp;
        PushJobReferenceToEportalController.apiPushInfo(jr.Id);
        jr.Push_Job_Info__c = false;
        update jr;
        
         PushJobReferenceToEportalController.apiPushInfo(jr.Id);
    }
    
    @isTest
    public static void run2(){
        
        
         Account a = new Account(name='Tan Enterprise');
    insert a;
    Contact c = new Contact(firstName='Ken', lastName='LEE', 
                            accountid=A.id, Email='lim@myMail.com', Phone='777', MobilePhone='111', Fax='222');
    insert c;
        PushJobReferenceToEportalController.apiPushInfo(a.Id);
    }
    
   
}