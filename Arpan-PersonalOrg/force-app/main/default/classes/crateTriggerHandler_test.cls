@istest
public class crateTriggerHandler_test {
	static testmethod void dotest(){
        
        List<crate__c> crateIns_list = new List<crate__c>();
        List<crate__c> crateUp_list = new List<crate__c>();
        
        Id  locRTid = Schema.SObjectType.Location__c.getRecordTypeInfosByName().get('Artmove').getRecordTypeId();
        Location__c location1 = new Location__c();
        location1.Name = 'testlocation1';
        location1.CurrencyIsoCode = 'SGD';
        location1.RecordTypeId = locRTid;
        insert location1;
        
        
        Location__c location2 = new Location__c();
        location2.Name = 'testlocation2';
        location2.CurrencyIsoCode = 'SGD';
        location2.RecordTypeId = locRTid;
        insert location2;
        
        Id artColl_RTid = Schema.SObjectType.artApp__Collector__c.getRecordTypeInfosByName().get('Institutional').getRecordTypeId();
        artApp__Collector__c artColl1 = new artApp__Collector__c();
        artColl1.Name = 'Archduke Leopold William';
        artColl1.CurrencyIsoCode = 'SGD';
        artColl1.RecordTypeId = artColl_RTid;
        artColl1.Legal_nature_of_Entity__c = 'Company';
        artColl1.Invoice_Type__c = 'E-Invoice';
        insert artColl1 ;
        
        Id crate_RTid = Schema.SObjectType.Crate__c.getRecordTypeInfosByName().get('AMCrates').getRecordTypeId();
        Crate__c crate1 = new Crate__c();
        crate1.Name = 'CR230831003';
        crate1.CurrencyIsoCode = 'SGD';
        crate1.RecordTypeId = crate_RTid;
        crate1.myCollector__c = artColl1.id;
        crate1.CBarcode_ID__c = 'CR230831003';
        crate1.Height__c = 10;
        crate1.Length__c = 2;
        crate1.UOM__c = 'cm';
        crate1.Status__c = 'Loaded';
        crate1.Location__c = location1.id;
        crate1.Width__c = 5;       
        crate1.With_Legs__c = 'Yes';
        crate1.IPPC_Stamp__c = 'Yes';
        crate1.IsActive__c = true;
        crate1.SourceRFID__c = true;
        crateIns_list.add(crate1);
        insert crate1;
        
        
         crateTriggerHandler.upsertCrate(crateIns_list);
        
        crate1.Location__c =location2.id;
        update crate1;
    }
}