public class SyncArtworkCtrl {

      @auraEnabled
    public static Boolean getArtAppCount(String sobjectId){
        List<artApp__Artwork__c> ArtAppList = [select id from artApp__Artwork__c where Crate__c =: sobjectId];
        if(ArtAppList != null && ArtAppList.size() >0){
            return true;
        }
        return false;
    }
}