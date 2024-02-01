trigger MsPincodeTrigger on MS_Pincode__c (After insert , After Update) {
    if(Trigger.isafter && (Trigger.isUpdate || trigger.isinsert)){
        MsPincodeHandler.cityUpdate();
    } 
    
}