global class UpdateRecordCounterSchedule implements Schedulable
{
    public Integer CurrentDay;
  global void execute(SchedulableContext sc)
  {
     List<Record_Type_Counter__c> rtC = [Select id,Count__c,Name FROM Record_Type_Counter__c];
     
     if( rtC != Null)
     {
       For(Record_Type_Counter__c reC : rtC)
       {
         CurrentDay = System.today().day();
          
          if(CurrentDay == 1 && (reC.Name == 'ArtmoveJP'|| reC.Name == 'Japan Job Reference Count'))
          {
            reC.Count__c = 1;
          }
       }
       
       update rtc;
     }
     
     
  }
}