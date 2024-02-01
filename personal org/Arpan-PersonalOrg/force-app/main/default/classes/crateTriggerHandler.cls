public class crateTriggerHandler {
    public static void upsertCrate(list<Crate__c> CrateList){
        crateTriggerBatch batch = new crateTriggerBatch(CrateList);
        Database.executeBatch(batch,50);
    }
}