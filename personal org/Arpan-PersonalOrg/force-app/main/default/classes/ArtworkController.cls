/*
 * Auothor: Arpan Gaur
 * Date:
 * Discreption:
 * ===========================================================================================================
 * Last modifyby               Date                            Discreption
 * Arpan Gaur				   30/07/2023					   Removing "disposed , deliver, Released" words from artwork query as per client request
 * Arpan Gaur 					08/11/1023						Add Item_No__c field in seach query. in "searchRecords" method.
 */

public without Sharing class ArtworkController{
   
    //public string currentEmail;
    @AuraEnabled(cacheable=true) 
    public static ArtworkWrapper ArtworkRecordsAsPerPortalUser( Integer limitSize, Integer offset) {
        User u = [Select Id,SelectedColumns__c, Name, Email from User where Id = :UserInfo.getUserId()];
        String currentEmail = u.Email;
        System.debug('currentEmai----'+currentEmail);
        List<artApp__Artwork__c> artworkRecords = [SELECT Id, Name,Barcode_ID__c, artApp__Artist__r.Name, artApp__Collector__r.Name,artApp__Collector__r.artApp__Email__c,artApp__Collector__r.Id, artApp__Collector__c,Item_No__c, Dimensions__c,Packed_Dimensions__c,Image__c, artApp__Exhibition__c, artApp__Status__c, Location_Status__c FROM artApp__Artwork__c WHERE artApp__Collector__r.artApp__Email__c=:u.Email
                                                  AND (NOT(Internal_Location__r.Name LIKE'%RLSD%' OR Internal_Location__r.Name LIKE '%old%'))
                                                   order by CreatedDate DESC LIMIT : limitSize Offset :offset];
        system.debug('artworkRecords------'+artworkRecords);
        integer totalRecords = [select count() from artApp__Artwork__c WHERE artApp__Collector__r.artApp__Email__c=:u.Email AND (NOT(Internal_Location__r.Name LIKE'%RLSD%' OR Internal_Location__r.Name LIKE '%old%'))];
        return New ArtworkWrapper(totalRecords, artworkRecords);  
    }
    @AuraEnabled(cacheable=true)
    public static List<artApp__Artwork__c> searchRecords( String searchKey, Integer limitSize) {
        User u = [Select Id,SelectedColumns__c, Name, Email from User where Id = :UserInfo.getUserId()];
        String currentEmail = u.Email;
        System.debug('currentEmai----'+currentEmail);
        String searchText = '%' + searchKey + '%';
        //String searchText = '\'%' + searchKey + '%\'';
        //String query = 'SELECT Id, Name, artApp__Artist__r.Name, artApp__Collector__r.Name,artApp__Collector__r.artApp__Email__c,artApp__Collector__r.Id, artApp__Collector__c,Item_No__c, Dimensions__c,Packed_Dimensions__c,Image__c, artApp__Exhibition__c, CreatedById, artApp__Status__c, Location_Status__c FROM artApp__Artwork__c WHERE artApp__Collector__r.artApp__Email__c='+u.Email+' AND Name like ' + searchText + '  LIMIT ' + limitSize;
        //System.debug('query : ' + query);
        List<artApp__Artwork__c> artworkRecords = [SELECT Id, Name,Barcode_ID__c, artApp__Artist__r.Name, artApp__Collector__r.Name,artApp__Collector__r.artApp__Email__c,artApp__Collector__r.Id, artApp__Collector__c,Item_No__c, Dimensions__c,Packed_Dimensions__c,Image__c, artApp__Exhibition__c, CreatedById, artApp__Status__c, Location_Status__c FROM artApp__Artwork__c
                                                   WHERE artApp__Collector__r.artApp__Email__c=:u.Email AND (Name like: searchText or artApp__Artist__r.Name like :searchText or Barcode_ID__c like :searchText or Item_No__c like :searchText)
                                                  AND (NOT( Internal_Location__r.Name LIKE'%RLSD%' OR Internal_Location__r.Name LIKE '%old%')) LIMIT : limitSize];
        system.debug('artworkRecordssearch------'+artworkRecords);
        integer totalRecords = [select count() from artApp__Artwork__c WHERE artApp__Collector__r.artApp__Email__c=:u.Email];
        return artworkRecords ;
    }
    
    public class ArtworkWrapper{
        @AuraEnabled
        public integer totalNoOfRecord {set;get;}
        @AuraEnabled
        Public List<artApp__Artwork__c>  artRecords{set;get;}
        Public ArtworkWrapper(Integer totalNoOfRecord, List<artApp__Artwork__c>  artRecords ){
				this.totalNoOfRecord = totalNoOfRecord;
            	this.artRecords = artRecords;
        }
        
    }   



//or artApp__Artist__r.Name like :searchText
//AND Name Like :newSearchText
//Where artApp__Collector__r.artApp__Email__c =: u.Email
//WHERE artApp__Collector__r.artApp__Email__c='yiling@stpi.com.sg'
//AND (NOT(Internal_Location__r.Name LIKE '%release%' OR Internal_Location__r.Name LIKE '%deliver%' OR Internal_Location__r.Name LIKE '%disposed%' OR Internal_Location__r.Name LIKE '%old%'))
    /*
    //public string currentEmail;
    @AuraEnabled 
    public static ArtworkWrapper ArtworkRecordsAsPerPortalUser( Integer limitSize, Integer offset) {
        User u = [Select Id,SelectedColumns__c, Name, Email,Customer_Collector__c from User where Id = :UserInfo.getUserId()];
        String currentEmail = u.Email;
        System.debug('currentEmai----'+currentEmail);
        //Apex sharing(sharing the records to user who is going to login)
        set<Id> setOfArtistId = new set<Id>();
        List<artApp__Artwork__c> artworkSharingRecords = [SELECT Id, Name, artApp__Artist__c, artApp__Artist__r.Name FROM artApp__Artwork__c WHERE artApp__Collector__r.artApp__Email__c=:u.Email AND artApp__Artist__c != NULL];
        for(artApp__Artwork__c artworkObj: artworkSharingRecords){
            setOfArtistId.add(artworkObj.artApp__Artist__c);
            system.debug('setOfArtistId-----'+artworkObj.artApp__Artist__c);
        }
        system.debug('setOfArtistIdsize-----'+setOfArtistId.Size());
        system.debug('setOfArtistId-----'+setOfArtistId);
        //Reboking the already shared records  
        List<artApp__Artist__Share> artistRecordToBeRevoked = [SELECT Id, UserOrGroupId, Parent.OwnerId FROM artApp__Artist__Share WHERE UserOrGroupId =:u.Id AND Parent.OwnerId !=:u.Id];
        
        //Sharing the new records
        List<artApp__Artist__Share> aartistToBeShare = new List<artApp__Artist__Share>();
        for(artApp__Artist__C artObj : [Select Id, Name From artApp__Artist__C WHERE Id IN:setOfArtistId]){
            artApp__Artist__Share share = new artApp__Artist__Share();
            share.ParentId = artObj.Id;
            share.UserOrGroupId = u.Id;
            share.RowCause = Schema.artApp__Artist__Share.RowCause.Manual;
            share.AccessLevel = 'Edit';
            aartistToBeShare.add(share);    
        }artApp__Artwork__c
        system.debug('artworkToBeShare---'+aartistToBeShare);
        TestDML(artistRecordToBeRevoked, aartistToBeShare);
        
        //---------------------------------------------------quering the specifice records------------------------------------------------------------------------
        List<artApp__Artwork__c> artworkRecords = [SELECT Id, Name, artApp__Artist__r.Name, artApp__Collector__r.Name,artApp__Collector__r.artApp__Email__c,artApp__Collector__r.Id, artApp__Collector__c,Item_No__c, Dimensions__c,Packed_Dimensions__c,Image__c, artApp__Exhibition__c, artApp__Status__c, Location_Status__c FROM artApp__Artwork__c WHERE artApp__Collector__r.artApp__Email__c=:u.Email
                                                   AND (NOT(Internal_Location__r.Name LIKE '%release%' OR Internal_Location__r.Name LIKE '%deliver%' OR Internal_Location__r.Name LIKE '%disposed%' OR Internal_Location__r.Name LIKE'%RLSD%' OR Internal_Location__r.Name LIKE '%old%'))
                                                   order by CreatedDate DESC LIMIT : limitSize Offset :offset];
        system.debug('artworkRecords------'+artworkRecords);
        integer totalRecords = [select count() from artApp__Artwork__c WHERE artApp__Collector__r.artApp__Email__c=:u.Email AND (NOT(Internal_Location__r.Name LIKE '%release%' OR Internal_Location__r.Name LIKE '%deliver%' OR Internal_Location__r.Name LIKE'%RLSD%' OR Internal_Location__r.Name LIKE '%disposed%' OR Internal_Location__r.Name LIKE '%old%'))];
        return New ArtworkWrapper(totalRecords, artworkRecords);  
    }
    //============================================================================================================================================
    public static void TestDML(List<artApp__Artist__Share> artistRecordToBeRevoked, List<artApp__Artist__Share> aartistToBeShare){
        //-------Deleting
        if (!artistRecordToBeRevoked.isEmpty()) {
           delete artistRecordToBeRevoked;
            System.debug('Sharing revoked successfully');
        } else {
            System.debug('No sharing found to revoke');
        }
        //--------Inserting
         if(!aartistToBeShare.isEmpty()){
            upsert aartistToBeShare;
            System.debug('Record sharing successful');
        } else{
            System.debug('Record sharing failed: ');
        }
        
    }
    
    @AuraEnabled(cacheable=true)
    public static List<artApp__Artwork__c> searchRecords( String searchKey, Integer limitSize) {
        User u = [Select Id,SelectedColumns__c, Name, Email from User where Id = :UserInfo.getUserId()];
        String currentEmail = u.Email;
        System.debug('currentEmai----'+currentEmail);
        String searchText = '%' + searchKey + '%';
        //String searchText = '\'%' + searchKey + '%\'';
        //String query = 'SELECT Id, Name, artApp__Artist__r.Name, artApp__Collector__r.Name,artApp__Collector__r.artApp__Email__c,artApp__Collector__r.Id, artApp__Collector__c,Item_No__c, Dimensions__c,Packed_Dimensions__c,Image__c, artApp__Exhibition__c, CreatedById, artApp__Status__c, Location_Status__c FROM artApp__Artwork__c WHERE artApp__Collector__r.artApp__Email__c='+u.Email+' AND Name like ' + searchText + '  LIMIT ' + limitSize;
        //System.debug('query : ' + query);
        List<artApp__Artwork__c> artworkRecords = [SELECT Id, Name, artApp__Artist__r.Name, artApp__Collector__r.Name,artApp__Collector__r.artApp__Email__c,artApp__Collector__r.Id, artApp__Collector__c,Item_No__c, Dimensions__c,Packed_Dimensions__c,Image__c, artApp__Exhibition__c, CreatedById, artApp__Status__c, Location_Status__c FROM artApp__Artwork__c WHERE artApp__Collector__r.artApp__Email__c=:u.Email AND Name like: searchText
                                                   AND (NOT(Internal_Location__r.Name LIKE '%release%' OR Internal_Location__r.Name LIKE '%deliver%' OR Internal_Location__r.Name LIKE'%RLSD%' OR Internal_Location__r.Name LIKE '%disposed%' OR Internal_Location__r.Name LIKE '%old%')) LIMIT : limitSize];
        system.debug('artworkRecordssearch------'+artworkRecords);
        integer totalRecords = [select count() from artApp__Artwork__c WHERE artApp__Collector__r.artApp__Email__c=:u.Email];
        return artworkRecords ;
    }
    
    public class ArtworkWrapper{
        @AuraEnabled
        public integer totalNoOfRecord {set;get;}
        @AuraEnabled
        Public List<artApp__Artwork__c>  artRecords{set;get;}
        Public ArtworkWrapper(Integer totalNoOfRecord, List<artApp__Artwork__c>  artRecords ){
            this.totalNoOfRecord = totalNoOfRecord;
            this.artRecords = artRecords;
        }
        
    }  
*/
}