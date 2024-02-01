trigger crateLineItemTrigger on Crate_Line_Item__c (after update , after insert) {
	//Code added by jatin singh
    if(Trigger.isAfter){
        if (Trigger.isInsert || Trigger.isUpdate){
        	crateLineItemTriggerHandler.upsertTransaction(trigger.new);
    	}
    }
}