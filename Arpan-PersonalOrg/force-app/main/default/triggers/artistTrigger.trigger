trigger artistTrigger on artApp__Artist__c (after insert, after update) {
    if(Trigger.isAfter){
        if (Trigger.isInsert || Trigger.isUpdate){
            artistTriggerHandler.upsertArtist(trigger.new);  
        }
    }
 
}