@isTest
public class ArtworkControllerTest {
    
    @testSetup static void SetUp(){
        
        //Creating Collector record
        artApp__Collector__c collectorObj = new artApp__Collector__c();
        collectorObj.Name = 'CollectorName';
        collectorObj.artApp__Email__c = 'yiling@stpi.com.sg';
        Insert collectorObj;
        
        //Creating Artist Record
        for(integer i=0; i<=3; i++){
            artApp__Artist__c  artistObj = New artApp__Artist__c();
            artistObj.Name = 'ArtistName'+i;
            insert artistObj;
        }
        
        
        //Creating Artwork Record
      
        artApp__Collector__c collector = [SELECT Id, artApp__Email__c FROM artApp__Collector__c LIMIT 1];
        artApp__Artist__c artist = [SELECT Id, Name From artApp__Artist__c LIMIT 1];
        for(integer i=0; i<=3; i++){
        artApp__Artwork__c artObj = New artApp__Artwork__c();
        artObj.Name = 'ArtworkName'+i ;
        artObj.artApp__Collector__c = collector.Id;
        artObj.artApp__Artist__c = artist.Id;
        artObj.Item_No__c = '223' ;
        artObj.artApp__Status__c = 'Available';
        artObj.Location_Status__c = 'Released';
        insert artObj;
        }
        
    }
    @isTest
    Public Static void ArtworkRecordsAsPerPortalUser_test(){
        Test.startTest();
        ArtworkController.ArtworkRecordsAsPerPortalUser(1, 0);
        Test.stopTest();
    }
    
    @isTest
    Public Static void searchRecords_Test(){
        Test.startTest();
        ArtworkController.searchRecords('ArtworkName', 1);
        Test.stopTest();
    }
}