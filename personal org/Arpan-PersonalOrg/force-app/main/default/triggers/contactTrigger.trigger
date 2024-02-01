trigger contactTrigger on Contact (after insert,after update,after undelete,after delete, before insert) {
    
    if(Trigger.isafter){
        if(Trigger.isinsert){
          CountNoOfContactHandler.getContactOnInsert(Trigger.new);
        }
        if(Trigger.isupdate){
            CountNoOfContactHandler.getContactOnUpdate(Trigger.new,Trigger.oldmap);
        }
        if(Trigger.isdelete){
           CountNoOfContactHandler.getContactOnDelete(Trigger.old); 
        }
    }
    
    
    
    
        //ContactHandlerClass.countContactsOnAccount(Trigger.isAfter,Trigger.isInsert, Trigger.isUpdate,Trigger.isUndelete, Trigger.isdelete,  Trigger.new , Trigger.old);
    if(Trigger.isbefore && Trigger.isinsert){
        //ContactHandlerClass.contactList(trigger.new);
    }
    // if(trigger.isafter && (trigger.isinsert || trigger.isupdate || trigger.isdelete)){
    // ContactHandlerClass.countNoOfCon(trigger.new,trigger.old);
    // }
}