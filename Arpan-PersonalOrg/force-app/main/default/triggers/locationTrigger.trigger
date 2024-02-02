trigger locationTrigger on Location__c (before insert,After insert,After update) {
    if(Trigger.isAfter){
        if (Trigger.isInsert || Trigger.isUpdate){
             locationTriggerHandler.upsertlocation(trigger.new);  
    	}
    }
}