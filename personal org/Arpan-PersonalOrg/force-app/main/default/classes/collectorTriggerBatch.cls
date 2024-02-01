global class collectorTriggerBatch implements Database.Batchable<sObject>,Database.AllowsCallouts{
    public Set<Id> CollectorIds = new Set<Id>();
    
    global collectorTriggerBatch (List<artApp__Collector__c> collectorList){
        system.debug('collectorList>>'+collectorList);        
        for(artApp__Collector__c collectorObj : collectorList){
            CollectorIds.add(collectorObj.Id);
        }
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        system.debug('CollectorIds>>>>'+CollectorIds);
        return Database.getQueryLocator([SELECT Id, Name,isActive__c from artApp__Collector__c WHERE Id IN : CollectorIds]);
    }
    
    global void execute(Database.BatchableContext BC, List<artApp__Collector__c> collectorList){
        system.debug('collectorList>>>'+collectorList);
        RFIDIntegrationUtility.RFIDCreateCollector(collectorList);
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
    
}