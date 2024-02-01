public class salesQuotes2 {
    public SFDC_520_Quote__c sq { get; private set;}
    public ApexPages.Standardcontroller controller;
    
    id quoteID;
    public salesQuotes2 (){
        quoteID = ApexPages.currentPage().getParameters().get('id');
        sq = [Select q.id, q.recordTypeId, q.RecordType.Name, q.Shuttle_Service_Included__c From 
        SFDC_520_Quote__c q Where id =: quoteID limit 1];
    }
    public salesQuotes2 (ApexPages.StandardController c) {
        controller = c;
        quoteID = c.getRecord().id;
        sq = [Select q.id, q.recordTypeId, q.RecordType.Name, q.Shuttle_Service_Included__c From 
        SFDC_520_Quote__c q Where id =: quoteID limit 1]; 
    }
    
    public PageReference attachQuote() {
        String pageURL = '';
        
        /* Set page definition */
        if (sq.RecordType.Name == 'Agent Quote (Air, Sea, Additional Charges)' && sq.Shuttle_Service_Included__c == true) {
            pageURL = '/apex/agentQuoteAirSeaOtherCharges';
        }
        else if (sq.RecordType.Name == 'Agent Quote (Air, Sea, Additional Charges)' 
        && sq.Shuttle_Service_Included__c == false) {
            pageURL = '/apex/agentQuoteAirSeaOtherChargesV2';
        } 
        else if (sq.RecordType.Name == 'Agent Quote (Air, Sea x 2, Additional Charges)' && sq.Shuttle_Service_Included__c == true) {
            pageURL = '/apex/agentQuoteAirSea2OtherCharges';
        }
        else if (sq.RecordType.Name == 'Agent Quote (Air, Sea x 2, Additional Charges)' && sq.Shuttle_Service_Included__c == false) {
            pageURL = '/apex/agentQuoteAirSea2OtherChargesV2';
        }
        else if (sq.RecordType.Name == 'Agent Quote (Air, Sea x 2)') {
            pageURL = '/apex/agentQuoteAirSea2';
        }
        else if (sq.RecordType.Name == 'Agent Quote (Sea x 2)') {
            pageURL = '/apex/agentQuoteSea2';
        }
        else if (sq.RecordType.Name == 'Agent Quote (Sea x 2, Additional Charges)' && sq.Shuttle_Service_Included__c == true) {
            pageURL = '/apex/agentQuoteSea2OtherCharges';
        }
        else if (sq.RecordType.Name == 'Agent Quote (Sea x 2, Additional Charges)' 
        && sq.Shuttle_Service_Included__c == false) {
            pageURL = '/apex/agentQuoteSea2OtherChargesV2';
        }
        else if (sq.RecordType.Name == 'Agent Quote (Air, Sea)') {
            pageURL = '/apex/agentQuoteAirSea';
        }
        else if (sq.RecordType.Name == 'Agent Quote (Sea, Additional Charges)' && sq.Shuttle_Service_Included__c == true) {
            pageURL = '/apex/agentQuoteSeaOtherCharges';
        }
        else if (sq.RecordType.Name == 'Agent Quote (Sea, Additional Charges)' 
        && sq.Shuttle_Service_Included__c == false) {
            pageURL = '/apex/agentQuoteSeaOtherChargesV2';
        }
        else if (sq.RecordType.Name == 'Agent Quote (Air)') {
            pageURL = '/apex/agentQuoteAir';
        }
        
        
        PageReference pdfPage = new PageReference(pageURL);
        
        /* Set rate reply ID on page defintion */
        pdfPage.getParameters().put('id', sq.id);
        
        /* Generate PDF Blob */
        Blob pdfBlob;
        if(!test.isRunningTest()){ // Date: 1/14/2016:- for skipping in this code in Test Class because it was throwing error of Method donot support getContent
			pdfBlob = pdfPage.getContent();
		}else{
			pdfBlob = blob.valueof('TEST');
		}
        //Blob pdfBlob = pdfPage.getContent();
        
        /* Redirect to display PDF page */
        pdfPage.setRedirect(true);
        return pdfPage;
    }
    
    /* Test Methods Below */
    static testMethod void test1() {
        SFDC_520_Quote__c quote = new SFDC_520_Quote__c ();
        insert quote;
        salesQuotes2 sq2 = new salesQuotes2(new ApexPages.Standardcontroller(quote));
    }
    public static testMethod void test2() {
        Opportunity o = new Opportunity (Name = 'test opp', stageName = 'Open', CloseDate=Date.newInstance(2010,10,10));
        insert o;
        SFDC_520_Quote__c quote = new SFDC_520_Quote__c(RecordTypeId = '01220000000Tx7uAAC', Shuttle_Service_Included__c = true, Opportunity__c = o.Id);
        insert quote;

        PageReference pageRef = new PageReference('/apex/agentQuoteAir');
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', quote.id);
        
        salesQuotes2 sq2 = new salesQuotes2();
        try { sq2.attachQuote(); } catch( System.NullPointerException npe) { } 
    }
    public static testMethod void test3() {
        Opportunity o = new Opportunity (Name = 'test opp', stageName = 'Open', CloseDate=Date.newInstance(2010,10,10));
        insert o;
        SFDC_520_Quote__c quote = new SFDC_520_Quote__c(RecordTypeId = '01220000000Tx89AAC', Shuttle_Service_Included__c = true, Opportunity__c = o.Id);
        insert quote;

        PageReference pageRef = new PageReference('/apex/agentQuoteAir');
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', quote.id);
        
        salesQuotes2 sq2 = new salesQuotes2();
        try { sq2.attachQuote(); } catch( System.NullPointerException npe) { } 
    }
    public static testMethod void test4() {
        Opportunity o = new Opportunity (Name = 'test opp', stageName = 'Open', CloseDate=Date.newInstance(2010,10,10));
        insert o;
        SFDC_520_Quote__c quote = new SFDC_520_Quote__c(RecordTypeId = '01220000000Tx84AAC', Shuttle_Service_Included__c = true, Opportunity__c = o.Id);
        insert quote;

        PageReference pageRef = new PageReference('/apex/agentQuoteAir');
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', quote.id);
        
        salesQuotes2 sq2 = new salesQuotes2();
        try { sq2.attachQuote(); } catch( System.NullPointerException npe) { } 
    }
    public static testMethod void test5() {
        Opportunity o = new Opportunity (Name = 'test opp', stageName = 'Open', CloseDate=Date.newInstance(2010,10,10));
        insert o;
        SFDC_520_Quote__c quote = new SFDC_520_Quote__c(RecordTypeId = '01220000000TxY3AAK', Shuttle_Service_Included__c = true, Opportunity__c = o.Id);
        insert quote;

        PageReference pageRef = new PageReference('/apex/agentQuoteAir');
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', quote.id);
        
        salesQuotes2 sq2 = new salesQuotes2();
        try { sq2.attachQuote(); } catch( System.NullPointerException npe) { } 
    }
    public static testMethod void test6() {
        Opportunity o = new Opportunity (Name = 'test opp', stageName = 'Open', CloseDate=Date.newInstance(2010,10,10));
        insert o;
        SFDC_520_Quote__c quote = new SFDC_520_Quote__c(RecordTypeId = '01220000000TxXyAAK', Shuttle_Service_Included__c = true, Opportunity__c = o.Id);
        insert quote;

        PageReference pageRef = new PageReference('/apex/agentQuoteAir');
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', quote.id);
        
        salesQuotes2 sq2 = new salesQuotes2();
        try { sq2.attachQuote(); } catch( System.NullPointerException npe) { } 
    }
    public static testMethod void test7() {
        Opportunity o = new Opportunity (Name = 'test opp', stageName = 'Open', CloseDate=Date.newInstance(2010,10,10));
        insert o;
        SFDC_520_Quote__c quote = new SFDC_520_Quote__c(RecordTypeId = '01220000000TxY8AAK', Shuttle_Service_Included__c = true, Opportunity__c = o.Id);
        insert quote;

        PageReference pageRef = new PageReference('/apex/agentQuoteAir');
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', quote.id);
        
        salesQuotes2 sq2 = new salesQuotes2();
        try { sq2.attachQuote(); } catch( System.NullPointerException npe) { } 
    }
    public static testMethod void test8() {
        Opportunity o = new Opportunity (Name = 'test opp', stageName = 'Open', CloseDate=Date.newInstance(2010,10,10));
        insert o;
        SFDC_520_Quote__c quote = new SFDC_520_Quote__c(RecordTypeId = '01220000000TxYDAA0', Shuttle_Service_Included__c = true, Opportunity__c = o.Id);
        insert quote;

        PageReference pageRef = new PageReference('/apex/agentQuoteAir');
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', quote.id);
        
        salesQuotes2 sq2 = new salesQuotes2();
        try { sq2.attachQuote(); } catch( System.NullPointerException npe) { } 
    }
    public static testMethod void test9() {
        Opportunity o = new Opportunity (Name = 'test opp', stageName = 'Open', CloseDate=Date.newInstance(2010,10,10));
        insert o;
        SFDC_520_Quote__c quote = new SFDC_520_Quote__c(RecordTypeId = '01220000000Tx7zAAC', Shuttle_Service_Included__c = true, Opportunity__c = o.Id);
        insert quote;

        PageReference pageRef = new PageReference('/apex/agentQuoteAir');
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', quote.id);
        
        salesQuotes2 sq2 = new salesQuotes2();
        try { sq2.attachQuote(); } catch( System.NullPointerException npe) { } 
    }
    public static testMethod void test10() {
        Opportunity o = new Opportunity (Name = 'test opp', stageName = 'Open', CloseDate=Date.newInstance(2010,10,10));
        insert o;
        SFDC_520_Quote__c quote = new SFDC_520_Quote__c(RecordTypeId = '01220000000Tx89AAC', Shuttle_Service_Included__c = false, Opportunity__c = o.Id);
        insert quote;

        PageReference pageRef = new PageReference('/apex/agentQuoteAir');
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', quote.id);
        
        salesQuotes2 sq2 = new salesQuotes2();
        try { sq2.attachQuote(); } catch( System.NullPointerException npe) { } 
    }
    public static testMethod void test11() {
        Opportunity o = new Opportunity (Name = 'test opp', stageName = 'Open', CloseDate=Date.newInstance(2010,10,10));
        insert o;
        SFDC_520_Quote__c quote = new SFDC_520_Quote__c(RecordTypeId = '01220000000TxY8AAK', Shuttle_Service_Included__c = false, Opportunity__c = o.Id);
        insert quote;

        PageReference pageRef = new PageReference('/apex/agentQuoteAir');
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', quote.id);
        
        salesQuotes2 sq2 = new salesQuotes2();
        try { sq2.attachQuote(); } catch( System.NullPointerException npe) { } 
    }
    public static testMethod void test12() {
        Opportunity o = new Opportunity (Name = 'test opp', stageName = 'Open', CloseDate=Date.newInstance(2010,10,10));
        insert o;
        SFDC_520_Quote__c quote = new SFDC_520_Quote__c(RecordTypeId = '01220000000TxY3AAK', Shuttle_Service_Included__c = false, Opportunity__c = o.Id);
        insert quote;

        PageReference pageRef = new PageReference('/apex/agentQuoteAir');
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', quote.id);
        
        salesQuotes2 sq2 = new salesQuotes2();
        try { sq2.attachQuote(); } catch( System.NullPointerException npe) { } 
    }
    public static testMethod void test13() {
        Opportunity o = new Opportunity (Name = 'test opp', stageName = 'Open', CloseDate=Date.newInstance(2010,10,10));
        insert o;
        SFDC_520_Quote__c quote = new SFDC_520_Quote__c(RecordTypeId = '01220000000Tx89AAC', Shuttle_Service_Included__c = false, Opportunity__c = o.Id);
        insert quote;

        PageReference pageRef = new PageReference('/apex/agentQuoteAir');
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', quote.id);
        
        salesQuotes2 sq2 = new salesQuotes2();
        try { sq2.attachQuote(); } catch( System.NullPointerException npe) { } 
    }
   /* public static testMethod void test14() {
        Opportunity o = new Opportunity (Name = 'test opp', stageName = 'Open', CloseDate=Date.newInstance(2010,10,10));
        insert o;
        SFDC_520_Quote__c quote = new SFDC_520_Quote__c(RecordTypeId = '01220000000Tx7uAAC', Shuttle_Service_Included__c = false, Opportunity__c = o.Id);
        insert quote;

        PageReference pageRef = new PageReference('/apex/agentQuoteAir');
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', quote.id);
        
        salesQuotes2 sq2 = new salesQuotes2();
        try { sq2.attachQuote(); } catch( System.NullPointerException npe) { } 
    }*/
}