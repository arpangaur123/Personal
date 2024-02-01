public class artworkTriggerHandler {
    public static void insertArtWork(list<artApp__Artwork__c> listOfartWork){
        system.debug('listOfartWork>>>'+listOfartWork);
        artworkTriggerBatch batch = new artworkTriggerBatch(listOfartWork);
        Database.executeBatch(batch,50);
    }
}