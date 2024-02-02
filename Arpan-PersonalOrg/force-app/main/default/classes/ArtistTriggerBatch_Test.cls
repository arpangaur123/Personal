@isTest
public class ArtistTriggerBatch_Test {
    
    public class artistMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"payload":{"items":[{"referenceId":"string","type":"CREATE","success":true}],"success":1,"failed":0},"success":true,"message": null}');
            res.setStatusCode(200);
            return res;
        }
    }
    
    static testmethod void dotest(){
        
        List<artApp__Artist__c> artist_list = new List<artApp__Artist__c>();
        artApp__Artist__c a = new artApp__Artist__c();
        a.Name = 'Haegue Yang';
        a.CurrencyIsoCode = 'SGD';
        a.artApp__Currency__c = 'USD';
        a.artApp__Status__c = 'Active';
        a.Collector_Email__c = 'stpi@helutrans.com';
        artist_list.add(a);
        
        artApp__Artist__c b = new artApp__Artist__c();
        b.Name = 'Wang Guang-Yi';
        b.CurrencyIsoCode = 'HKD';
        b.artApp__Currency__c = 'USD';
        b.artApp__Status__c = 'Active';
        artist_list.add(b);
        
        insert artist_list;
        
        test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new artistMock());
        ArtistTriggerBatch batch = new ArtistTriggerBatch(artist_list);
        Database.executeBatch(batch,50);
        
        test.stopTest();
    }
}