@isTest
public class locationTriggerHandler_Test {
    static testmethod void dotest(){
        
        list<Location__c> Loc_list = new list<Location__c>();
        Id  locRTid = Schema.SObjectType.Location__c.getRecordTypeInfosByName().get('Artmove').getRecordTypeId();
        Location__c location1 = new Location__c();
        location1.Name = 'testlocation2';
        location1.CurrencyIsoCode = 'SGD';
        location1.RecordTypeId = locRTid;
        Loc_list.add(location1);
        
        
        
        Location__c location2 = new Location__c();
        location2.Name = 'ATL-1010020';
        location2.CurrencyIsoCode = 'SGD';
        location2.RecordTypeId = locRTid;
        location2.Storage_Facility__c = 'ATL, Hong Kong';
        Loc_list.add(location2);
        insert loc_list;
        
        locationTriggerHandler.upsertlocation(loc_list);
    }
}