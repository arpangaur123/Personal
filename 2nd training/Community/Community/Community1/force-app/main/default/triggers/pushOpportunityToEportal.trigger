/*
Author : Uzair
Date : 12th May 2020
Description : trigger to call Calloutclass which push opportunity info to eportal
*/
trigger pushOpportunityToEportal on Opportunity (after update) {
    
    
    //if(trigger.isAfter && trigger.isInsert)
        //Database.executeBatch(new pushOpportunityToEportalBatch(trigger.newMap.keyset()), 1);
    
    if(checkRecursion.run){
        if(trigger.isAfter && trigger.isUpdate)
            pushOpportunityToEportalHelper.pushOpportunityStatus();
        checkRecursion.run = false;
    }
    
}