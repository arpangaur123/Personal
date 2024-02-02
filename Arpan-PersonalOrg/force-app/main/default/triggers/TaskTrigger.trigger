trigger TaskTrigger on Task (before insert, before update) {
    if(Trigger.isBefore){   
        if(Trigger.isInsert){
            TaskHandler.changeDueDateonInsert(trigger.new);
        }
        if(Trigger.isUpdate){
            TaskHandler.changeDueDateonUpdate(trigger.new,Trigger.oldmap);
        }
    }
}