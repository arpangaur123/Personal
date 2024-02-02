public without Sharing class ArtworkTestController {

    @AuraEnabled(cacheable=true) 
    public static List<artApp__Artwork__c> ArtworkRecordsAsPerPortalUser( Integer limitSize, Integer offset) {
        // User u = [Select Id,SelectedColumns__c, Name, Email from User where Id = :UserInfo.getUserId()];
        // String currentEmail = u.Email;
        // System.debug('currentEmai----'+currentEmail);
        List<artApp__Artwork__c> artworkRecords = [SELECT Id, Name, artApp__Artist__r.Name, artApp__Collector__r.Name,artApp__Collector__r.artApp__Email__c,artApp__Collector__r.Id, artApp__Collector__c,Item_No__c, Dimensions__c,Packed_Dimensions__c,Image__c, artApp__Exhibition__c, CreatedById, artApp__Status__c, Location_Status__c FROM artApp__Artwork__c WHERE artApp__Collector__r.artApp__Email__c='yiling@stpi.com.sg'  LIMIT : limitSize Offset :offset];
        system.debug('artworkRecords------'+artworkRecords);
        integer totalRecords = [select count() from artApp__Artwork__c WHERE artApp__Collector__r.artApp__Email__c='yiling@stpi.com.sg'];
        return artworkRecords ;
    }

    @AuraEnabled(cacheable=true) 
    public static List<artApp__Artwork__c> searchRecords( String searchKey, Integer limitSize) {
        //String searchText =  searchKey + '%\'';
        //String query = 'SELECT Id, Name, artApp__Artist__r.Name, artApp__Collector__r.Name,artApp__Collector__r.artApp__Email__c,artApp__Collector__r.Id, artApp__Collector__c,Item_No__c, Dimensions__c,Packed_Dimensions__c,Image__c, artApp__Exhibition__c, CreatedById, artApp__Status__c, Location_Status__c FROM artApp__Artwork__c WHERE artApp__Collector__r.artApp__Email__c=\'yiling@stpi.com.sg\' AND Name like ' + searchText + ' LIMIT ' + limitSize;
        //System.debug('query : ' + query);
        //List<artApp__Artwork__c> artworkRecords = Database.query(query);
        List<artApp__Artwork__c> artworkRecords = [SELECT Id, Name, artApp__Artist__r.Name, artApp__Collector__r.Name,artApp__Collector__r.artApp__Email__c,artApp__Collector__r.Id, artApp__Collector__c,Item_No__c, Dimensions__c,Packed_Dimensions__c,Image__c, artApp__Exhibition__c, CreatedById, artApp__Status__c, Location_Status__c FROM artApp__Artwork__c WHERE artApp__Collector__r.artApp__Email__c='yiling@stpi.com.sg' AND Name like : searchKey LIMIT : limitSize];
        system.debug('artworkRecords------'+artworkRecords);
        integer totalRecords = [select count() from artApp__Artwork__c WHERE artApp__Collector__r.artApp__Email__c='yiling@stpi.com.sg'];
        return artworkRecords ;
    }

}