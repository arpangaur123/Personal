@istest
    public class UpdateRecordCounterScheduleTest{
    
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    
    static testMethod void updatecounter(){
         Test.startTest();
         
        Record_Type_Counter__c recount=new Record_Type_Counter__c();
        recount.name='ArtmoveJP';
        recount.CurrencyIsoCode='SGD';
        recount.Count__c=4;
        insert recount;
        
        UpdateRecordCounterSchedule  sh1 = new UpdateRecordCounterSchedule();
        String sch = '0 0 23 * * ?'; 
        system.schedule('Test Territory Check', sch, sh1);
        
         Test.stopTest();
        
         }
    
}