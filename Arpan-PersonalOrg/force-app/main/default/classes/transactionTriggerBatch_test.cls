@isTest
public class transactionTriggerBatch_test {
    static testmethod void dotest(){
        
        List<artApp__Transaction__c> Tran_List = new List<artApp__Transaction__c>();
        
        Id accRTid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Artmove').getRecordTypeId();
        Account acc1 = new Account();
        acc1.Name = 'Montjoie Art Transactions';
        acc1.Type = 'Consultant/Dealer';
        acc1.RecordTypeId = accRTid;
        acc1.BillingStreet = '30 Avenue de la Republique';
        acc1.BillingCity = 'Neauphle Le Chateau';
        acc1.BillingPostalCode = '78640';
        acc1.BillingCountry = 'France';
        acc1.Phone = '+33 316 430 594';
        acc1.CurrencyIsoCode = 'SGD';
        insert acc1;
        
        
        
        Id  conRTid = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Artmove').getRecordTypeId();
        Contact con1 = new Contact();
        con1.AccountId = acc1.Id;
        con1.LastName = 'Laurent';
        con1.FirstName = 'Raoul';
        con1.RecordTypeId = conRTid;
        con1.MailingStreet = '30 Avenue de la Republique';
        con1.MailingCity = 'Neauphle Le Chateau';
        con1.MailingPostalCode = '78640';
        con1.MailingCountry = 'France';
        con1.Phone = '+33 316 430 594';
        con1.Email = 'raoullaurent-mat@wanadoo.fr';
        con1.CurrencyIsoCode = 'SGD';
        con1.Do_you_own_a_car__c = 'No';
        con1.Category__c = 'Carpenter';
        con1.Any_Relative_Acquaintance_in_Helutrans__c = 'No';
        con1.Personal_Character_References__c = 'Name';
        insert con1;
        
        Id artTranRTid = Schema.SObjectType.artApp__Transaction__c.getRecordTypeInfosByName().get('Release Order').getRecordTypeId();
        artApp__Transaction__c artTran1 = new artApp__Transaction__c();
        artTran1.CurrencyIsoCode = 'SGD';
        artTran1.RecordTypeId = artTranRTid;
        artTran1.artApp__Date__c = system.today();
        artTran1.artApp__Payment_Term__c = 'Prepay';
        artTran1.artApp__Shipping_Method__c = 'Customer Pickup';
        artTran1.artApp__Shipping_Term__c = 'FOB Origin';
        artTran1.Released_to__c = 'na';
        artTran1.Service_AddressHK__c = 'Helu-Trans HK Warehouse at GG / CHS / SC';
        artTran1.Payment_to_be_Collected__c = 10000;
        artTran1.Assigned_to__c = con1.id;
        Tran_List.add(artTran1);
        insert Tran_List;
        
        Id  locRTid = Schema.SObjectType.Location__c.getRecordTypeInfosByName().get('Artmove').getRecordTypeId();
        Location__c location1 = new Location__c();
        location1.Name = 'testlocation2';
        location1.CurrencyIsoCode = 'SGD';
        location1.RecordTypeId = locRTid;
        insert location1;
        
        
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
        insert crate1;
        
        
        
        Crate_Line_Item__c CLI1 = new Crate_Line_Item__c();
        CLI1.CurrencyIsoCode = 'SGD';
        CLI1.Crate__c = crate1.id;
        CLI1.Transaction__c = artTran1.id ;
        insert CLI1;
        
        artApp__Artist__c artist1 = new artApp__Artist__c();
            artist1.Name = 'Vincent Van Gogh';
            artist1.CurrencyIsoCode = 'SGD';
            artist1.artApp__Currency__c = 'USD';
            artist1.artApp__Status__c = 'Active';
            artist1.isActive__c = true;
        insert artist1;
        
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
        
        artWork1.Location_Check__c = 'OK';
        artWork1.Storage_Location_not_Contains__c = true;
        artWork1.SourceRFID__c = true;
        artWork1.IsActive__c = true;
        insert artWork1;
        
        
        Id artLI_RTid = Schema.SObjectType.artApp__Line_Item__c.getRecordTypeInfosByName().get('Line Item').getRecordTypeId();
        artApp__Line_Item__c ALI1 = new artApp__Line_Item__c();
        ALI1.CurrencyIsoCode = 'SGD';
        ALI1.RecordTypeId = artLI_RTid;
        ALI1.artApp__Artwork__c = artWork1.id;
        ALI1.artApp__Transaction__c = artTran1.id;
        ALI1.artApp__Type__c = 'Line Item';
        ALI1.CrateN__c = crate1.id;
        insert ALI1;
        
        
        
        
        transactionTriggerBatch batch = new transactionTriggerBatch(Tran_List);
        Database.executeBatch(batch,50);
    }
}