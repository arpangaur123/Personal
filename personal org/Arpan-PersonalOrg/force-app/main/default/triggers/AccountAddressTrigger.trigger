trigger AccountAddressTrigger on Account (after insert, before insert , before update) {
    /*if(Trigger.isafter && Trigger.isinsert){
        AccountTriggerHandler.createOpportunity(Trigger.New);
        AccountTriggerHandler.addAccountTeamMamber(Trigger.New);
    }*/
    if(Trigger.isbefore && (Trigger.isinsert || Trigger.isupdate)){
       // AccountTriggerHandler.trailmix(Trigger.new);
    AccountTriggerHandler.Pincode(Trigger.new);
    }
}