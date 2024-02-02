trigger collectorTrigger on artApp__Collector__c (after insert,after update) {
    if(Trigger.isAfter){
        if (Trigger.isInsert || Trigger.isUpdate){
             collectorTriggerHandler.upsertcollector(trigger.new);
    	}
    }
}