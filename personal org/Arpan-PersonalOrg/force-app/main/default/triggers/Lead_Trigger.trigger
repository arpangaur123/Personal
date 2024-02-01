trigger Lead_Trigger on Lead (before update, before insert,after insert) {
    if(trigger.isbefore &&(Trigger.isinsert || Trigger.isupdate)){
        LeadTriggerHandler.checkDuplicateEmail(Trigger.new);
    }
    if(Trigger.isafter && Trigger.isinsert){
        LeadTriggerHandler.sendEmial(Trigger.new);
    }
}