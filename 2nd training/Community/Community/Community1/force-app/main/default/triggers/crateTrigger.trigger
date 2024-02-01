trigger crateTrigger on Crate__c (after update) {    
    Set<Id> setCrateIds = new Set<Id>();
    for(Crate__c crate : trigger.new){
        if(crate.Location__c != null){
            if(crate.Location__c != trigger.oldmap.get(crate.Id).Location__c){
                setCrateIds.add(crate.Id);
            }
        }
    }
    if(setCrateIds.size() > 0){
        //Code added by jatin singh at 25 Feb 2022
			Database.executeBatch(new crateTriggerHelperBatch(setCrateIds), 50);
        //Code added by jatin singh at 25 Feb 2022
        
        //old code
        	//update([Select Id From artApp__Artwork__c Where Crate__c IN:setCrateIds]);
    }
}