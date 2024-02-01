public class artworkEmailUpdateOnArtistController {
    Public static void updateEmail(list<artApp__Artwork__c> newArtworkRecord){
        set<String> artworkId = new set<String>();
        List<artApp__Artist__c> artistList = new List<artApp__Artist__c>();
        system.debug('check 1');
        for(artApp__Artwork__c arObj : newArtworkRecord){
            system.debug('in for');
            //arObj.artApp__Artist__r.Collector_Email__c = arObj.Collector_Email__c;
            artApp__Artist__c obj = new artApp__Artist__c();
            system.debug('check 2');
            obj.Id = arObj.artApp__Artist__c;
            obj.Collector_Email__c = arObj.Collector_Email__c;
            artistList.add(obj);
            system.debug('check 3');
        }
        update artistList;
        
        //for(artApp__Artist__c artist : [Select Id, Name, Collector_Email__c,(SELECT Id FROM Artworks__r ) From artApp__Artist__c WHERE Id IN:artworkId]){
            
       // }
    }
}