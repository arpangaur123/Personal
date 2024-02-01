trigger Person_Trigger on Person__c (before insert, before update, before delete) {
    if(trigger.isbefore){
        if(trigger.isinsert || trigger.isupdate){
         	 PersonTriggerHandler.beforeinsertt(trigger.new);
        }
    }
}