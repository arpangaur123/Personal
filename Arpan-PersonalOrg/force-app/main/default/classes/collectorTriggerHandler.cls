public class collectorTriggerHandler {
    public static void upsertcollector(list<artApp__Collector__c> CollectorList){
        collectorTriggerBatch batch = new collectorTriggerBatch(CollectorList);
        Database.executeBatch(batch,50);
    }
}