global class locationTriggerBatch implements Database.Batchable<sObject>,Database.AllowsCallouts{
    public Set<Id> LocationIds = new Set<Id>();
    
    global locationTriggerBatch (List<Location__c> locationList){
        system.debug('locationList>>'+locationList);        
        for(Location__c locationObj : locationList){
            LocationIds.add(locationObj.Id);
        }
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        system.debug('LocationIds>>>>'+LocationIds);
        return Database.getQueryLocator([SELECT Id, Name,isActive__c from Location__c WHERE Id IN : LocationIds]);
    }
    
    global void execute(Database.BatchableContext BC, List<Location__c> locationList){
        system.debug('locationList>>>'+locationList);
        RFIDIntegrationUtility.RFIDCreateLocation(locationList);
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
    
}