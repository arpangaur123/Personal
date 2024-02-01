public class artistTriggerHandler {
    public static void upsertArtist(list<artApp__Artist__c> ArtistList){
        ArtistTriggerBatch batch = new ArtistTriggerBatch(ArtistList);
        Database.executeBatch(batch,50);
    }
}