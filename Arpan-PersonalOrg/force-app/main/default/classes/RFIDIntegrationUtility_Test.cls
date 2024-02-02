@isTest
public class RFIDIntegrationUtility_Test {
    
    public class RFIDartistMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"payload":{"items":[],"success":1,"failed":0},"success":true,"message":null}');
            res.setStatusCode(200);
            return res;
        }
    }
    
    public class RFIDArtworkMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"payload":{"items":[],"success":1,"failed":0},"success":true,"message":null}');
            res.setStatusCode(200);
            return res;
        }
    }
    
    public class RFIDcrateMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"payload":{"items":[],"success":1,"failed":0},"success":true,"message":null}');
            res.setStatusCode(200);
            return res;
        }
    }
    
    
    Static testmethod void crateListTest(){
        List<crate__c> crate_list = new List<crate__c>();
        
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
        crate_list.add(crate1);
        insert crate1;
        
        
        RFIDIntegrationUtility.RFIDCreateCrate(crate_list);
        
        test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new RFIDcrateMock());
        RFIDIntegrationUtility.RFIDCreateCrate(crate_list);
        
        test.stopTest();
    }
    
    Static testmethod void ArtworkListTest(){
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
        
        list<artApp__Artwork__c> artwork_list = new list<artApp__Artwork__c>();
        
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
        artwork_list.add(artWork1);
        insert artwork_list;
        
        
        
        test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new RFIDArtworkMock());
        RFIDIntegrationUtility.RFIDCreateArtwork(artwork_list);
        
        test.stopTest();
    }
    
    Static testmethod void RFIDCreateLocationTest(){
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
        
        
        test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new RFIDArtworkMock());
        RFIDIntegrationUtility.RFIDCreateLocation(loc_list);
        
        test.stopTest();
    }
    
    Static testmethod void RFIDCreateCollectorTest(){
        
        List<artApp__Collector__c> collectorInsert_list = new  List<artApp__Collector__c>();
        
        Id RTid = Schema.SObjectType.artApp__Collector__c.getRecordTypeInfosByName().get('Institutional').getRecordTypeId();
        
        artApp__Collector__c a = new artApp__Collector__c();
        a.Name = 'Archduke Leopold William';
        a.CurrencyIsoCode = 'SGD';
        a.RecordTypeId = RTid;
        a.Legal_nature_of_Entity__c = 'Company';
        a.Invoice_Type__c = 'E-Invoice';
        collectorInsert_list.add(a) ;
        
        artApp__Collector__c b = new artApp__Collector__c();
        b.Name = 'Kings Philip III';
        b.CurrencyIsoCode = 'SGD';
        b.RecordTypeId = RTid;
        b.Legal_nature_of_Entity__c = 'Company';
        b.Invoice_Type__c = 'E-Invoice';
        collectorInsert_list.add(b) ;
        
        insert collectorInsert_list;
        
        RFIDIntegrationUtility.RFIDCreateCollector(collectorInsert_list);
    }
    
    Static testmethod void RFIDCreateArtistTest(){
        
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
        
        Test.setMock(HttpCalloutMock.class, new RFIDartistMock());
        RFIDIntegrationUtility.RFIDCreateArtist(artist_list);
        
        test.stopTest();
        
        
        
    }
    
    Static testmethod void RFIDCreateTransactionTest(){
        
        Map<String,List<Crate_Line_Item__c>> crateLineMap = new Map<String,List<Crate_Line_Item__c>>();
        Map<String,List<artApp__Line_Item__c>> artworkLineMap = new Map<String,List<artApp__Line_Item__c>>();
        
        List<artApp__Transaction__c> Tran_List = new List<artApp__Transaction__c>();
        
        List <Crate_Line_Item__c> tempCrateLineList = new List<Crate_Line_Item__c>();
        List <artApp__Line_Item__c> tempArtworkLineList = new List<artApp__Line_Item__c>();
        
        
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
        tempCrateLineList.add(CLI1);
        crateLineMap.put(artTran1.id,tempCrateLineList);
        
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
        
        tempArtworkLineList.add(ALI1);
        artworkLineMap.put(artTran1.id,tempArtworkLineList);
        
        
        RFIDIntegrationUtility.RFIDCreateTransaction(Tran_List,crateLineMap,artworkLineMap);
        
    }
    
    Static testmethod void RFIDCreateJobReferenceTest(){
        
        List<Job_Reference__c> jobReferenceList = new List<Job_Reference__c>();
        
        id accRT_id =  Schema.SObjectType.Account.getRecordTypeInfosByName().get('Artmove').getRecordTypeId();
        
        Account acc1 = new Account();
        acc1.Name = 'Singapore Tyler Print Institute';
        acc1.Type = 'Institution';
        acc1.RecordTypeId = accRT_id;
        acc1.BillingStreet = '41 Robertson Quay';
        acc1.BillingPostalCode = '238236';
        acc1.BillingCountry = 'Singapore';
        acc1.ShippingPostalCode = '238236';
        acc1.ShippingCountry = 'Singapore';
        acc1.Phone = '+65 63363663 x x 111';
        acc1.Fax = '+65 63363553';
        acc1.Website = 'www.stpi.com.sg';
        acc1.CurrencyIsoCode = 'SGD';
        
        acc1.Terms__c = '30 Days';
        
        insert acc1;
        
        id oppRT_id =  Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Artmove').getRecordTypeId();
        
        Opportunity opp1 = new Opportunity();
        opp1.AccountId = acc1.id;
        opp1.RecordTypeId = oppRT_id;
        opp1.Name = 'test';
        opp1.StageName = 'Closed Won';
        opp1.Amount = 12;
        opp1.Probability = 100;
        opp1.CloseDate = system.today()+30;
        opp1.LeadSource = 'ARTIM';
        //opp1.ForecastCategoryName = 'Survey';
        opp1.CurrencyIsoCode = 'SGD';
        opp1.Survey_Country__c = 'SG';
        opp1.Pack_Date_1__c = System.today();
        opp1.Shipment_Details__c = '3rd Country Move';
        opp1.Destination_Country__c = 'Singapore';
        opp1.Estimated_Volume__c = 23;
        opp1.Billing_done__c = 'No';
        opp1.OB_Job_Number__c = '/23/8331/';
        opp1.Person_In_Charge__c = 'LY';
        opp1.myCounter__c = '8331';
        //opp1.BookingAgent2__c = '00120000003zwfNAAQ';
        opp1.Quote_Currency__c = 'USD';
        opp1.Rate_Reply_Inclusion__c = '-Normal import customs clearanceBR()-Normal port feesBR()-One time delivery to residence with normal accessBR()-Unpacking, unwrapping and setting upBR()-One time collection of debris';
        opp1.Container_Booked__c = 'No';       
        opp1.Payment_Terms__c = 'Immediate';
        opp1.Shipment_DetailsT__c = 'IM';
        opp1.User_Initials__c = 'MC';
        opp1.HHG_Initials__c = 'AK/MB';
        opp1.HHG_InitialsT__c = 'AK/MB';
        opp1.SAMAssign__c = 'HT';
        opp1.Sales_Person__c = 'IN';
        opp1.Quote_Mode__c = 'WA';
        opp1.QuoteCounter__c = '8362';
        opp1.Quote_ModeT__c = 'WA';
        opp1.HHG_InitialsTQuote__c = 'AK/MB';
        opp1.Quote_Number_Search__c = '23088362IN';
        insert opp1;
        
        id collRT_id =  Schema.SObjectType.artApp__Collector__c.getRecordTypeInfosByName().get('Institutional').getRecordTypeId();
        
        artApp__Collector__c collector1 = new artApp__Collector__c();
        collector1.Name = 'test321';
        collector1.CurrencyIsoCode = 'SGD';
        collector1.RecordTypeId = collRT_id;
        collector1.artApp__Contact_Last_Name__c = 'test';
        collector1.Legal_nature_of_Entity__c = 'Company';
        collector1.Invoice_Type__c = 'E-Invoice';
        insert collector1;
        
        Job_Reference__c job_reference1 = new Job_Reference__c();
        job_reference1.Name = 'job 321';
        job_reference1.CurrencyIsoCode = 'SGD';
        job_reference1.unique__c = 'job 321';
        job_reference1.Opportunity__c = opp1.id;
        job_reference1.Account__c = acc1.id;
        
        job_reference1.Client_Account__c = collector1.id;
        job_reference1.Client_s__c = 'test321';
        job_reference1.ATA_Time__c = 'hrs';
        job_reference1.ATD_Time_24hrs__c = 'hrs';
        job_reference1.ETA_Time_24hrs__c = 'hrs';
        job_reference1.ETD_Time_24hrs__c = 'hrs';
        job_reference1.Item_Type__c = 'Fragile (Incl. Jewelry)';
        job_reference1.Item_Type2__c = 'Non-Fragile';
        job_reference1.Item_Type3__c = 'Non-Fragile';
        job_reference1.Status__c = 'New Job';
        insert job_reference1;
        
        jobReferenceList.add(job_reference1);
        
        RFIDIntegrationUtility.RFIDCreateJobReference(jobReferenceList);
    }
}