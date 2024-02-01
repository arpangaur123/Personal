global class pushJobReferenceToEportalBatch implements Database.Batchable<sObject>,Database.AllowsCallouts{
   set<Id> JobIdSet;
    global pushJobReferenceToEportalBatch(set<ID> jobSet) {
        JobIdSet = jobSet;
    }
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator([SELECT Id,Opportunity__c,Opportunity__r.Push_Opportunity_Info__c,Name,Status__c,Client_Account__c,ExhibitionN__c,Push_Job_Info__c,Opportunity__r.Approved_Costing_Sheet__c,Opportunity__r.Approved_Costing_Sheet__r.Costing_Sheet_Id__c,Opportunity__r.Approved_Costing_Sheet__r.Revision_ID__c from Job_Reference__c where Id IN:JobIdSet]);
    }
    global void execute(Database.BatchableContext BC, List<Job_Reference__c> jbReflst) {
        PortalAPIUtility.pushJobReference(jbReflst);
    }
    global void finish(Database.BatchableContext BC) {
        
    }
}