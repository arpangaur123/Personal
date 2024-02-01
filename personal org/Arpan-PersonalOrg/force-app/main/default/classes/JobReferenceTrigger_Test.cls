@isTest
public class JobReferenceTrigger_Test {
    @isTest
    public Static void doTest(){
        List<Job_Reference__c> jobReferenceList = new List<Job_Reference__c>();
        list<Opportunity> oppList = new list<Opportunity>();
        
        list<Record_Type_Counter__c> RT_count_list = new list<Record_Type_Counter__c>();
        
        
        
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
        
        id oppRD_id1 =  Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Inbound').getRecordTypeId();
        id oppRD_id2 =  Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Artmove').getRecordTypeId();
        id oppRD_id3 =  Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('HTTR').getRecordTypeId();
        id oppRD_id4 =  Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('ArtmoveHK').getRecordTypeId();
        id oppRD_id5 =  Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('ArtmoveSH').getRecordTypeId();
        id oppRD_id6 =  Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('ArtmoveBJ').getRecordTypeId();
        id oppRD_id7 =  Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('ArtmoveFP').getRecordTypeId();
        //id oppRD_id8 =  Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('HHG IM').getRecordTypeId();
        //id oppRD_id9 =  Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('HHG LM').getRecordTypeId();
        //id oppRD_id10 =  Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('HHG WA').getRecordTypeId();
        //id oppRD_id11 =  Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('HHG OM').getRecordTypeId();
        id oppRD_id12 =  Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('TPR').getRecordTypeId();
        
        
        Opportunity opp1 = new Opportunity();
        opp1.AccountId = acc1.id;
        opp1.RecordTypeId = oppRD_id1;
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
        oppList.add(opp1);
        
        Opportunity opp2 = new Opportunity 
            (recordtypeid = oppRD_id2, CloseDate = Date.newInstance(2009, 11, 01), 
             Name = 'Test opp2', StageName = 'Closed Won', Billing_Currency__c = 'USD',
            Estimated_Volume__c = 23,Pack_Date_1__c = System.today(),Amount = 12);
        oppList.add(opp2); 
        
        Opportunity opp3 = new Opportunity 
            (recordtypeid = oppRD_id3, CloseDate = Date.newInstance(2009, 11, 01), 
             Name = 'Test opp3', StageName = 'Closed Won', Billing_Currency__c = 'USD',
            Estimated_Volume__c = 23,Pack_Date_1__c = System.today(),Amount = 12);
        oppList.add(opp3);
        
        Opportunity opp4 = new Opportunity 
            (recordtypeid = oppRD_id4, CloseDate = Date.newInstance(2009, 11, 01), 
             Name = 'Test opp4', StageName = 'Closed Won', Billing_Currency__c = 'USD',
            Estimated_Volume__c = 23,Pack_Date_1__c = System.today(),Amount = 12);        
        oppList.add(opp4);
        
        Opportunity opp5 = new Opportunity 
            (recordtypeid = oppRD_id5, CloseDate = Date.newInstance(2009, 11, 01), 
             Name = 'Test opp5', StageName = 'Closed Won', Billing_Currency__c = 'USD',
            Estimated_Volume__c = 23,Pack_Date_1__c = System.today(),Amount = 12);        
        oppList.add(opp5);
        
        Opportunity opp6 = new Opportunity 
            (recordtypeid = oppRD_id6, CloseDate = Date.newInstance(2009, 11, 01), 
             Name = 'Test opp6', StageName = 'Closed Won', Billing_Currency__c = 'USD',
            Estimated_Volume__c = 23,Pack_Date_1__c = System.today(),Amount = 12);        
        oppList.add(opp6);
        
        Opportunity opp7 = new Opportunity 
            (recordtypeid = oppRD_id7, CloseDate = Date.newInstance(2009, 11, 01), 
             Name = 'Test opp7', StageName = 'Closed Won', Billing_Currency__c = 'USD',
            Estimated_Volume__c = 23,Pack_Date_1__c = System.today(),Amount = 12);        
        oppList.add(opp7);
        
        
        Opportunity opp8 = new Opportunity 
            (recordtypeid = oppRD_id12, CloseDate = Date.newInstance(2009, 11, 01), 
             Shipment_Details__c ='IM Door to Door',Name = 'Test opp8',
             StageName = 'Closed Won', Billing_Currency__c = 'USD',
            Estimated_Volume__c = 23,Pack_Date_1__c = System.today(),Amount = 12);        
        oppList.add(opp8);
        
        Opportunity opp9 = new Opportunity 
            (recordtypeid = oppRD_id12, CloseDate = Date.newInstance(2009, 11, 01),
             Shipment_Details__c ='Local Move',
             Name = 'Test opp9', StageName = 'Closed Won', Billing_Currency__c = 'USD',
            Estimated_Volume__c = 23,Pack_Date_1__c = System.today(),Amount = 12);        
        oppList.add(opp9);
        
        Opportunity opp10 = new Opportunity 
            (recordtypeid = oppRD_id12, CloseDate = Date.newInstance(2009, 11, 01),
             Shipment_Details__c ='Warehousing',
             Name = 'Test opp10', StageName = 'Closed Won', Billing_Currency__c = 'USD',
            Estimated_Volume__c = 23,Pack_Date_1__c = System.today(),Amount = 12);        
        oppList.add(opp10);
        
        Opportunity opp11 = new Opportunity 
            (recordtypeid = oppRD_id12, CloseDate = Date.newInstance(2009, 11, 01),
             Shipment_Details__c ='Origin Services',
             Name = 'Test opp11', StageName = 'Closed Won', Billing_Currency__c = 'USD',
            Estimated_Volume__c = 23,Pack_Date_1__c = System.today(),Amount = 12);        
        oppList.add(opp11);
        
        Opportunity opp12 = new Opportunity 
            (recordtypeid = oppRD_id12, CloseDate = Date.newInstance(2009, 11, 01),
             Shipment_Details__c ='Office Move',
             Name = 'Test opp12', StageName = 'Closed Won', Billing_Currency__c = 'USD',
            Estimated_Volume__c = 23,Pack_Date_1__c = System.today(),Amount = 12);        
        oppList.add(opp12);
        
        insert oppList;
        
        
       /* id collRT_id =  Schema.SObjectType.artApp__Collector__c.getRecordTypeInfosByName().get('Institutional').getRecordTypeId();
        
        artApp__Collector__c collector1 = new artApp__Collector__c();
        collector1.Name = 'test321';
        collector1.CurrencyIsoCode = 'SGD';
        collector1.RecordTypeId = collRT_id;
        collector1.artApp__Contact_Last_Name__c = 'test';
        collector1.Legal_nature_of_Entity__c = 'Company';
        collector1.Invoice_Type__c = 'E-Invoice';
        insert collector1;*/
        
        Record_Type_Counter__c RT_counter1 = new Record_Type_Counter__c();
        RT_counter1.Name = 'Inbound';
        RT_counter1.CurrencyIsoCode = 'SGD';
        RT_counter1.Count__c = 905;
        RT_counter1.Description__c = 'Reset last day of Month to 100';
        RT_counter1.Frequency__c = 'Monthly';
        RT_counter1.Initial_Counter__c = 100;
        RT_counter1.Object_Name__c = 'Opportunity';
        RT_count_list.add(RT_counter1);
        
        Record_Type_Counter__c RT_counter2 = new Record_Type_Counter__c();
        RT_counter2.Name = 'Artmove';
        RT_counter2.CurrencyIsoCode = 'SGD';
        RT_counter2.Count__c = 905;
        RT_counter2.Description__c = 'Reset last day of Month to 100';
        RT_counter2.Frequency__c = 'Monthly';
        RT_counter2.Initial_Counter__c = 100;
        RT_counter2.Object_Name__c = 'Opportunity';
        RT_count_list.add(RT_counter2); 
        
        Record_Type_Counter__c RT_counter3 = new Record_Type_Counter__c();
        RT_counter3.Name = 'HTTR';
        RT_counter3.CurrencyIsoCode = 'SGD';
        RT_counter3.Count__c = 905;
        RT_counter3.Description__c = 'Reset last day of Month to 100';
        RT_counter3.Frequency__c = 'Monthly';
        RT_counter3.Initial_Counter__c = 100;
        RT_counter3.Object_Name__c = 'Opportunity';
        RT_count_list.add(RT_counter3); 
        
        Record_Type_Counter__c RT_counter4 = new Record_Type_Counter__c();
        RT_counter4.Name = 'ARTMOVEHK';
        RT_counter4.CurrencyIsoCode = 'SGD';
        RT_counter4.Count__c = 905;
        RT_counter4.Description__c = 'Reset last day of Month to 100';
        RT_counter4.Frequency__c = 'Monthly';
        RT_counter4.Initial_Counter__c = 100;
        RT_counter4.Object_Name__c = 'Opportunity';
        RT_count_list.add(RT_counter4); 
        
        Record_Type_Counter__c RT_counter5 = new Record_Type_Counter__c();
        RT_counter5.Name = 'ARTMOVESH';
        RT_counter5.CurrencyIsoCode = 'SGD';
        RT_counter5.Count__c = 905;
        RT_counter5.Description__c = 'Reset last day of Month to 100';
        RT_counter5.Frequency__c = 'Monthly';
        RT_counter5.Initial_Counter__c = 100;
        RT_counter5.Object_Name__c = 'Opportunity';
        RT_count_list.add(RT_counter5); 
        
        Record_Type_Counter__c RT_counter6 = new Record_Type_Counter__c();
        RT_counter6.Name = 'ARTMOVEBJ';
        RT_counter6.CurrencyIsoCode = 'SGD';
        RT_counter6.Count__c = 905;
        RT_counter6.Description__c = 'Reset last day of Month to 100';
        RT_counter6.Frequency__c = 'Monthly';
        RT_counter6.Initial_Counter__c = 100;
        RT_counter6.Object_Name__c = 'Opportunity';
        RT_count_list.add(RT_counter6); 
        
        Record_Type_Counter__c RT_counter7 = new Record_Type_Counter__c();
        RT_counter7.Name = 'ARTMOVEFP';
        RT_counter7.CurrencyIsoCode = 'SGD';
        RT_counter7.Count__c = 905;
        RT_counter7.Description__c = 'Reset last day of Month to 100';
        RT_counter7.Frequency__c = 'Monthly';
        RT_counter7.Initial_Counter__c = 100;
        RT_counter7.Object_Name__c = 'Opportunity';
        RT_count_list.add(RT_counter7); 
        
        Record_Type_Counter__c RT_counter8 = new Record_Type_Counter__c();
        RT_counter8.Name = 'HHG IM';
        RT_counter8.CurrencyIsoCode = 'SGD';
        RT_counter8.Count__c = 905;
        RT_counter8.Description__c = 'Reset last day of Month to 100';
        RT_counter8.Frequency__c = 'Monthly';
        RT_counter8.Initial_Counter__c = 100;
        RT_counter8.Object_Name__c = 'Opportunity';
        RT_count_list.add(RT_counter8); 
        
        Record_Type_Counter__c RT_counter9 = new Record_Type_Counter__c();
        RT_counter9.Name = 'HHG LM';
        RT_counter9.CurrencyIsoCode = 'SGD';
        RT_counter9.Count__c = 905;
        RT_counter9.Description__c = 'Reset last day of Month to 100';
        RT_counter9.Frequency__c = 'Monthly';
        RT_counter9.Initial_Counter__c = 100;
        RT_counter9.Object_Name__c = 'Opportunity';
        RT_count_list.add(RT_counter9); 
        
        Record_Type_Counter__c RT_counter10 = new Record_Type_Counter__c();
        RT_counter10.Name = 'HHG WA';
        RT_counter10.CurrencyIsoCode = 'SGD';
        RT_counter10.Count__c = 905;
        RT_counter10.Description__c = 'Reset last day of Month to 100';
        RT_counter10.Frequency__c = 'Monthly';
        RT_counter10.Initial_Counter__c = 100;
        RT_counter10.Object_Name__c = 'Opportunity';
        RT_count_list.add(RT_counter10); 
        
        Record_Type_Counter__c RT_counter11 = new Record_Type_Counter__c();
        RT_counter11.Name = 'HHG OS';
        RT_counter11.CurrencyIsoCode = 'SGD';
        RT_counter11.Count__c = 905;
        RT_counter11.Description__c = 'Reset last day of Month to 100';
        RT_counter11.Frequency__c = 'Monthly';
        RT_counter11.Initial_Counter__c = 100;
        RT_counter11.Object_Name__c = 'Opportunity';
        RT_count_list.add(RT_counter11); 
        
        
        
        Record_Type_Counter__c RT_counter12 = new Record_Type_Counter__c();
        RT_counter12.Name = 'HHG OM';
        RT_counter12.CurrencyIsoCode = 'SGD';
        RT_counter12.Count__c = 905;
        RT_counter12.Description__c = 'Reset last day of Month to 100';
        RT_counter12.Frequency__c = 'Monthly';
        RT_counter12.Initial_Counter__c = 100;
        RT_counter12.Object_Name__c = 'Opportunity';
        RT_count_list.add(RT_counter12); 
        
        insert RT_count_list;
        
        
        
        Job_Reference__c job_reference1 = new Job_Reference__c();
        job_reference1.Name = 'job 321';
        job_reference1.CurrencyIsoCode = 'SGD';
        job_reference1.unique__c = 'job 321';
        job_reference1.Opportunity__c = opp1.id;
        job_reference1.Account__c = acc1.id;
        
        //job_reference1.Client_Account__c = collector1.id;
        job_reference1.Client_s__c = 'test321';
        job_reference1.ATA_Time__c = 'hrs';
        job_reference1.ATD_Time_24hrs__c = 'hrs';
        job_reference1.ETA_Time_24hrs__c = 'hrs';
        job_reference1.ETD_Time_24hrs__c = 'hrs';
        job_reference1.Item_Type__c = 'Fragile (Incl. Jewelry)';
        job_reference1.Item_Type2__c = 'Non-Fragile';
        job_reference1.Item_Type3__c = 'Non-Fragile';
        job_reference1.Status__c = 'New Job';
        jobReferenceList.add(job_reference1);
        
         Job_Reference__c jr2 = new Job_Reference__c(Opportunity__c  = opp12.Id);
        jobReferenceList.add(jr2);
        
       Job_Reference__c jr3 = new Job_Reference__c(Opportunity__c  = opp2.Id);
        jobReferenceList.add(jr3); 
        
        Job_Reference__c jr4 = new Job_Reference__c(Opportunity__c  = opp3.Id);
        jobReferenceList.add(jr4);
        
        Job_Reference__c jr5 = new Job_Reference__c(Opportunity__c  = opp4.Id);
        jobReferenceList.add(jr5);
        
        Job_Reference__c jr6 = new Job_Reference__c(Opportunity__c  = opp5.Id);
        jobReferenceList.add(jr6);
        
        Job_Reference__c jr7 = new Job_Reference__c(Opportunity__c  = opp6.Id);
        jobReferenceList.add(jr7);
        
        Job_Reference__c jr8 = new Job_Reference__c(Opportunity__c  = opp7.Id);
        jobReferenceList.add(jr8);
        
        Job_Reference__c jr9 = new Job_Reference__c(Opportunity__c  = opp8.Id);
        jobReferenceList.add(jr9);
        
        
        Job_Reference__c jr10 = new Job_Reference__c(Opportunity__c  = opp9.Id);
        jobReferenceList.add(jr10);
        
        Job_Reference__c jr11 = new Job_Reference__c(Opportunity__c  = opp10.Id);
        jobReferenceList.add(jr11);
        
        Job_Reference__c jr12 = new Job_Reference__c(Opportunity__c  = opp11.Id);
        jobReferenceList.add(jr12);
        
        insert jobReferenceList;
        
                
        
    }
}