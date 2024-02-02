public class JobPostingHandler {
    public static void create(){
        Job_Posting__c job = new Job_Posting__c();
        job.Position__c = 'SSc';
        insert job;
    }
}