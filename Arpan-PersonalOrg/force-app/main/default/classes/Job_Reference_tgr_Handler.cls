public class Job_Reference_tgr_Handler {
    public static void insertJobReftence(list<Job_Reference__c> listOfJobReftence){
        jobReferenceTriggerBatch batch = new jobReferenceTriggerBatch(listOfJobReftence);
        Database.executeBatch(batch,50);
    }
}