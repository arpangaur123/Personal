@istest
public class artworkTriggerHandler_Test {
    static testMethod void dotest(){
        Id artColl_RTid = Schema.SObjectType.artApp__Collector__c.getRecordTypeInfosByName().get('Institutional').getRecordTypeId();
        artApp__Collector__c artColl1 = new artApp__Collector__c();
        artColl1.Name = 'Archduke Leopold William';
        artColl1.CurrencyIsoCode = 'SGD';
        artColl1.RecordTypeId = artColl_RTid;
        artColl1.Legal_nature_of_Entity__c = 'Company';
        artColl1.Invoice_Type__c = 'E-Invoice';
        insert artColl1 ;
        
        artApp__Artist__c artist1 = new artApp__Artist__c();
        artist1.Name = 'Vincent Van Gogh';
        artist1.CurrencyIsoCode = 'SGD';
        artist1.artApp__Currency__c = 'USD';
        artist1.artApp__Status__c = 'Active';
        artist1.isActive__c = true;
        insert artist1;
        
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
        //crate1.Location__c = location1.id;
        crate1.Width__c = 5;       
        crate1.With_Legs__c = 'Yes';
        crate1.IPPC_Stamp__c = 'Yes';
        crate1.IsActive__c = true;
        crate1.SourceRFID__c = true;
        insert crate1;
        
        Id loc_RTid1 = Schema.SObjectType.Location__c.getRecordTypeInfosByName().get('HHG').getRecordTypeId();
        Location__c locationObj1 = new Location__c();
        locationObj1.Name = '#02-02E-1001010';
        locationObj1.CurrencyIsoCode = 'SGD';
        locationObj1.RecordTypeId = loc_RTid1;
        locationObj1.Storage_Facility__c = 'CityCentre Storage, Singapore';
        insert locationObj1;
        
        Location__c locationObj2 = new Location__c();
        locationObj2.Name = 'MT-released';
        locationObj2.CurrencyIsoCode = 'HKD';
        locationObj2.RecordTypeId = loc_RTid1;
        locationObj2.Storage_Facility__c = 'Mapletree, Hong Kong';
        insert locationObj2;
        
        
        list<artApp__Artwork__c> artwork_list = new list<artApp__Artwork__c>();
        list<artApp__Artwork__c> artwork_up_list = new list<artApp__Artwork__c>();
        
        Id artWork_RTid = Schema.SObjectType.artApp__Artwork__c.getRecordTypeInfosByName().get('Unique Art').getRecordTypeId();
        artApp__Artwork__c artWork1 = new artApp__Artwork__c();
        artWork1.Name = 'Sleek Metal Mouse';
        artWork1.CurrencyIsoCode = 'SGD';
        artWork1.RecordTypeId = artWork_RTid;
        artWork1.artApp__Artist__c = artist1.id;
        artWork1.artApp__Collector__c = artColl1.id;
        artWork1.artApp__Height__c = 422;
        artWork1.artApp__Length__c = 914;
        artWork1.artApp__Location__c = 'Collector';
        artWork1.artApp__Status__c = 'Un-Available';
        artWork1.artApp__UOM__c = 'inches';
        artWork1.artApp__Update_Edition_Members__c = true;
        artWork1.artApp__Width__c = 947;
        artWork1.Barcode_ID__c = 'SG230831009';
        artWork1.Date_In__c = system.today()-30;
        artWork1.Barcode__c = 'code128';
        artWork1.Packed_Width__c = 955;
        artWork1.Packed_Height__c = 870;
        artWork1.Packed_Length__c = 247;
        artWork1.Empty_crate_stored__c = 'NO';
        artWork1.Crate__c = crate1.id;
        artWork1.Crate_Barcode__c = 'CR230831003';
        artWork1.Packing_Method__c = 'Shrink wrap';
        artWork1.Shared_Crate__c = 'p';
        artWork1.UOM_Wt__c = 'KG';
        
        artwork1.Internal_Location__c = locationObj1.id;
        artWork1.Location_Check__c = 'OK';
        artWork1.Storage_Location_not_Contains__c = true;
        artWork1.SourceRFID__c = false;
        artWork1.IsActive__c = true;
        artwork_list.add(artWork1);
        insert artwork_list;
        
        artwork1.Internal_Location__c = locationObj2.id;
        
        
        artwork_up_list.add(artWork1);
        update artwork_up_list;
        
    }
}