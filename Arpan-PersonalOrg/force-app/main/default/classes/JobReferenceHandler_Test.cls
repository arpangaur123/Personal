@isTest
public class JobReferenceHandler_Test {
    Static testMethod void doTest(){
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
        opp1.myCounter__c = '8331';
        opp1.Person_In_Charge__c = 'AM';
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
        
        Job_Reference_tgr_Handler.insertJobReftence(jobReferenceList);
    }
}