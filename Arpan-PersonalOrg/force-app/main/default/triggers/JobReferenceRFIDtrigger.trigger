trigger JobReferenceRFIDtrigger on Job_Reference__c (after insert,After update) {
    if(Trigger.isAfter){
        if (Trigger.isInsert || Trigger.isUpdate){
            Job_Reference_tgr_Handler.insertJobReftence(trigger.new);
        }
    }
}