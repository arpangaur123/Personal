@isTest
public class ArtworkHelperTest {
    @isTest
    static void testUpdateLocationStatusOnInsert() {
        // Create test data
        
        ArtworkHelper.isExecute = true;
        List<artApp__artwork__c> newArtworkList = new List<artApp__artwork__c>();
        Location__c testLocation = new Location__c(Name = 'release');
        insert testLocation;
        Location__c testLocation2 = new Location__c(Name = 'location2');
        insert testLocation2;
        //create Artist record
        artApp__artist__c testArtist = new artApp__artist__c(Name = 'Test artist');
        insert testArtist;
        // Create a test artwork record that meets the conditions for 'In Helutrans' location status
        artApp__artwork__c testArtwork1 = new artApp__artwork__c(
            Name = 'Test Artwork 1',
            artApp__Artist__c = testArtist.Id,
            Internal_Location__c = testLocation2.Id
        );
        insert testArtwork1;
        
        testArtwork1.Location_Status__c = 'Released';
        ArtworkHelper helper = new ArtworkHelper();
        ArtworkHelper.isExecute = true;
        helper.profileName = 'Customer Community Plus User Clone';
        update testArtwork1;
        system.debug('insert'+testArtwork1);
    }
    
    @isTest
    static void testUpdateLocationStatusOnUpdate(){
        
        // Create test data
        List<artApp__artwork__c> newArtworkList = new List<artApp__artwork__c>();
        Map<Id, artApp__artwork__c> oldMap = new Map<Id, artApp__artwork__c>();
        Location__c testLocation1 = new Location__c(Name = 'location1 release');
        insert testLocation1;
        Location__c testLocation2 = new Location__c(Name = 'location2 release');
        insert testLocation2;
        //create Artist record
        artApp__artist__c testArtist1 = new artApp__artist__c(Name = 'Test artist1');
        insert testArtist1;
        
        // Create a test artwork record that meets the conditions for 'In Helutrans' location status
        artApp__artwork__c testArtwork1 = new artApp__artwork__c(
            Name = 'Test Artwork 1',
            artApp__Artist__c = testArtist1.Id,
            Internal_Location__c = testLocation1.Id,
            Location_Status__c = 'In Helutrans'
        );
        insert testArtwork1;
        artApp__artwork__c artworkToBeUpdate = [SELECT Id, Name,Internal_Location__c,Location_Status__c From artApp__artwork__c limit 1];
        artworkToBeUpdate.Location_Status__c = 'Released';
        artworkToBeUpdate.Internal_Location__c = testLocation2.Id;
        artworkToBeUpdate.Item_No__c = '93473';
        newArtworkList.add(artworkToBeUpdate);
        update newArtworkList;
        oldMap.put(testArtwork1.Id, testArtwork1);
        ArtworkHelper helper = new ArtworkHelper();
        Test.startTest();
        helper.profileName = 'Customer Community Plus User Clone';
        helper.updateLocationStatusOnUpdate(newArtworkList, oldMap);
        Test.stopTest();
        
    }
    
}