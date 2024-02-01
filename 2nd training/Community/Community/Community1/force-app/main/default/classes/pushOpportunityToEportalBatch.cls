global class pushOpportunityToEportalBatch implements Database.Batchable<sObject>,Database.AllowsCallouts{
    set<Id> oppIdSet;
    global pushOpportunityToEportalBatch(set<ID> oppSet) {
        oppIdSet = oppSet;
    }
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator([SELECT Id,Account.Name,Quote_test_sfdc__c from Opportunity where Id IN:oppIdSet]);
    }
    global void execute(Database.BatchableContext BC, List<Opportunity> opplst) {
        PortalAPIUtility.pushOpportunity(opplst);
    }
    global void finish(Database.BatchableContext BC) {
        
    }
}