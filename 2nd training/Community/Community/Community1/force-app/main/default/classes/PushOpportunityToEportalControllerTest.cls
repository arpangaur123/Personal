@IsTest
public class PushOpportunityToEportalControllerTest {
    @testsetup
    static void setupmethod(){
        
        Account a = new Account(name='Tan Enterprise');
        insert a;
        Contact c = new Contact(firstName='Ken', lastName='LEE', 
                                accountid=A.id, Email='lim@myMail.com', Phone='777', MobilePhone='111', Fax='222');
        insert c;
        
        
        
        Id devRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Artmove').getRecordTypeId();
        Opportunity opp = new Opportunity 
            (recordtypeid = devRecordTypeId,Push_Lost_Cancelled_Status__c  = false, Push_Opportunity_Info__c=false,CloseDate = Date.newInstance(2009, 11, 01), 
             Name = 'Test Opportunity', StageName = 'Survey', Billing_Currency__c = 'SGD', 
             ETA__c = Date.newInstance(2011, 04, 29), ETD__c = Date.newInstance(2010, 04, 20),AccountId=a.id,Actual_Volume_cuft__c=12);
        insert opp;
        
        Opportunity opp2 = new Opportunity 
            (recordtypeid = devRecordTypeId,Push_Lost_Cancelled_Status__c = false, Push_Opportunity_Info__c=true,CloseDate = Date.newInstance(2009, 11, 01), 
             Name = 'Test Opportunity12', StageName = 'Closed Lost',Reason_Lost__c='Price not competitive.', Billing_Currency__c = 'SGD', 
             ETA__c = Date.newInstance(2011, 04, 29), ETD__c = Date.newInstance(2010, 04, 20),AccountId=a.id,Actual_Volume_cuft__c=12);
        insert opp2;
        
        OpportunityContactRole oppcontrole = new OpportunityContactRole();
        oppcontrole.ContactId = c.id;
        oppcontrole.OpportunityId = opp.id;
        insert oppcontrole;
        
        Costing_Sheet__c cos = new Costing_Sheet__c(Costing_Sheet_Id__c='123aws',Revision_ID__c='',Opportunity__c=opp.id);
        insert cos;
        
        opp.Approved_Costing_Sheet__c = cos.id;
        opp.StageName = 'Closed Won';
        update opp;
        
        Job_Reference__c jr = new Job_Reference__c(Opportunity__c  = opp.Id ,name='jatin');
        insert jr;
        
        
        insert new Swagger_Credential__c(Name='SwaggerToken',End_Point__c='	http://202.55.79.254:8080/api',Email__c='epadmin@helutrans.com');
        
    }
    static testmethod void method1(){
        
       // Test.setMock(HttpCalloutMock.class, new HttpSwaggerMockclass('{"token":"jmiscmswicwi","status":"Success"}'));
        PushOpportunityToEportalController.apiCallout([SELECT Id from Opportunity LIMIT 1].Id+'','Interaction1');
    }
    
    static testmethod void method6(){
        Opportunity opp = [SELECT Id,Push_Opportunity_Info__c from Opportunity LIMIT 1];
        opp.Push_Opportunity_Info__c = true;
        opp.StageName = 'Cancelled';
        update opp;
     //   Test.setMock(HttpCalloutMock.class, new HttpSwaggerMockclass('{"token":"jmiscmswicwi","status":"Success"}'));
        PushOpportunityToEportalController.apiCallout([SELECT Id from Opportunity LIMIT 1].Id+'','Interaction3A');
        PushInfoToEportalJavasript.apiCallout([SELECT Id from Opportunity LIMIT 1].Id+'','Interaction3A');
    }
    static testmethod void method2(){
        
        //  Test.setMock(HttpCalloutMock.class, new HttpSwaggerMockclass('{"token":"jmiscmswicwi","status":"Success"}'));
        
        Opportunity opp = [SELECT Id,Push_Opportunity_Info__c from Opportunity LIMIT 1];
        opp.Push_Opportunity_Info__c = true;
        opp.StageName = 'Costing';
         opp.Push_Lost_Cancelled_Status__c = true;
        update opp;
        PushOpportunityToEportalController.apiCallout([SELECT Id from Opportunity LIMIT 1].Id+'','Interaction1');
        
        
    }
    static testmethod void method3(){
        
        Opportunity opp = [SELECT Id,Push_Opportunity_Info__c from Opportunity LIMIT 1];
        opp.Push_Opportunity_Info__c = true;
        opp.StageName = 'Costing';
        opp.Push_Lost_Cancelled_Status__c = true;
        update opp;
        
      //  Test.setMock(HttpCalloutMock.class, new HttpSwaggerMockclass('{"token":"jmiscmswicwi","status":"Success"}'));
        PushOpportunityToEportalController.apiCallout([SELECT Id from Opportunity LIMIT 1].Id+'','Interaction3A');
    }
    static testmethod void method4(){
        
          Opportunity opp = [SELECT Id,Push_Opportunity_Info__c from Opportunity LIMIT 1];
        opp.Push_Opportunity_Info__c = true;
        opp.StageName = 'Costing';
        update opp;
        
       // Test.setMock(HttpCalloutMock.class, new HttpSwaggerMockclass('{"token":"jmiscmswicwi","status":"Success"}'));
        PushOpportunityToEportalController.apiCallout([SELECT Id from Opportunity LIMIT 1].Id+'','Interaction3A');
    }
    
}