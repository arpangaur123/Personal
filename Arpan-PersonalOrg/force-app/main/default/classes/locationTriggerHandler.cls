public class locationTriggerHandler {
    public static void upsertlocation(list<Location__c> LocationList){
        system.debug('LocationList---->'+LocationList);
        locationTriggerBatch batch = new locationTriggerBatch(LocationList);
        Database.executeBatch(batch,50);
    }
}