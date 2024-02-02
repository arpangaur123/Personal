global class jobReferenceTriggerBatch implements Database.Batchable<sObject>,Database.AllowsCallouts{
    public Set<Id> jobReferenceIds = new Set<Id>();
    
    global jobReferenceTriggerBatch (List<Job_Reference__c> jobReferenceList){
        for(Job_Reference__c jobReferenceObj : jobReferenceList){
            jobReferenceIds.add(jobReferenceObj.Id);
        }
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id, Name,isActive__c from Job_Reference__c WHERE Id IN : jobReferenceIds]);
    }
    
    global void execute(Database.BatchableContext BC, List<Job_Reference__c> jobReferenceList){
        RFIDIntegrationUtility.RFIDCreateJobReference(jobReferenceList);
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
    
}