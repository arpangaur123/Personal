global class ArtistTriggerBatch implements Database.Batchable<sObject>,Database.AllowsCallouts{
    public Set<Id> ArtistIds = new Set<Id>();
    
    global ArtistTriggerBatch (List<artApp__Artist__c> artistList){
        system.debug('artistList>>'+artistList);        
        for(artApp__Artist__c artistObj : artistList){
            ArtistIds.add(artistObj.Id);
        }
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        system.debug('ArtistIds>>>>'+ArtistIds);
        return Database.getQueryLocator([SELECT Id, Name,isActive__c from artApp__Artist__c WHERE Id IN : ArtistIds]);
    }
    
    global void execute(Database.BatchableContext BC, List<artApp__Artist__c> artistList){
        system.debug('artistList>>>'+artistList);
        RFIDIntegrationUtility.RFIDCreateArtist(artistList);
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
    
}