global class pushOpportunityStatusToEportalBatch implements Database.Batchable<sObject>,Database.AllowsCallouts{
    set<Id> oppIdSet;
    global pushOpportunityStatusToEportalBatch(set<ID> oppSet) {
        oppIdSet = oppSet;
    }
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator([SELECT Id,Quote_test_sfdc__c,Reason_for_Cancelled__c,StageName,Reason_Lost__c from Opportunity where Id IN:oppIdSet]);
    }
    global void execute(Database.BatchableContext BC, List<Opportunity> opplst) {
        PortalAPIUtility.pushStatus(opplst);
    }
    global void finish(Database.BatchableContext BC) {
        
    }
}