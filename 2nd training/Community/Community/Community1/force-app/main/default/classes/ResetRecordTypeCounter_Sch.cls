global class ResetRecordTypeCounter_Sch implements Schedulable {
   global void execute(SchedulableContext sc) {
      ResetRecordTypeCounter_btch b = new ResetRecordTypeCounter_btch(); 
      database.executebatch(b);
   }
}