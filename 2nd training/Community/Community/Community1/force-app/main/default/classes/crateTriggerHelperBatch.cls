//This class created by jatin singh at 25 Feb 2022

global class crateTriggerHelperBatch implements Database.Batchable<Sobject> 
{
    Set<Id> setCrateIds = new Set<Id>(); 
    
    public crateTriggerHelperBatch(Set<Id> CrateIds){
        setCrateIds = CrateIds;
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([Select Id From artApp__Artwork__c Where Crate__c IN:setCrateIds]);
    }

    global void execute(Database.BatchableContext bc, List<artApp__Artwork__c> artList){
        if(artList.size() > 0){
			update(artList);                   
        }
    }

    global void finish(Database.BatchableContext bc){
    	
    }
}