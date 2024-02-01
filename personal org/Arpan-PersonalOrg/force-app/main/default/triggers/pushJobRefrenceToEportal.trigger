trigger pushJobRefrenceToEportal on Job_Reference__c (after insert) {

    if(trigger.isAfter && trigger.isInsert){
        set<Id> jobrefIdSet = new set<Id>();
        for(Job_Reference__c job : trigger.new){
            if(job.Opportunity__c!=null)
                jobrefIdSet.add(job.id);
        }
        
        if(jobrefIdSet!=null && jobrefIdSet.size() > 0){
            //Database.executeBatch(new pushJobReferenceToEportalBatch(jobrefIdSet), 1);
            }
    }
}