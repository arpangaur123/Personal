@isTest
public class artistTriggerHandler_Test {
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
        
    }
}