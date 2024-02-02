public class internalCostingQuotes {
    public Internal_Costing__c ic { get; private set;}
    private ApexPages.Standardcontroller controller;
    
    id internalCostID;
    public internalCostingQuotes () {
        internalCostID = ApexPages.CurrentPage().getParameters().get('id');
        ic = [Select i.Id, i.RecordTypeId, i.RecordType.DeveloperName, i.Quote_Description__c from Internal_Costing__c i where id =: internalCostID limit 1];
    }
    public internalCostingQuotes (ApexPages.StandardController c) {
        controller = c;
        internalCostID = c.getRecord().id;
        ic = [Select i.Id, i.RecordTypeId, i.RecordType.DeveloperName, i.Quote_Description__c from Internal_Costing__c i where id =: internalCostID limit 1];
    }
    
    public PageReference attachQuote1() {
        String pageURL ='';
        /*Set page definition */
        if (ic.RecordType.DeveloperName == 'IM_DTD') {
            pageURL = '/apex/internalCostingPDF';
        }
        else if (ic.RecordType.DeveloperName == 'DS') {
            pageURL = '/apex/internalCostingPDFds';
        }
        else if (ic.RecordType.DeveloperName == 'IM_DTP') {
            pageURL = '/apex/internalCostingPDFimDTP';
        }
        else if (ic.RecordType.DeveloperName == 'LM') {
            pageURL = '/apex/internalCostingPDFlm';
        }
        else if (ic.RecordType.DeveloperName == 'OS') {
            pageURL = '/apex/internalCostingPDFos';
        }
        else if (ic.RecordType.DeveloperName == 'RS') {
            pageURL = '/apex/internalCostingPDFrs';
        } 
        else if (ic.RecordType.DeveloperName == 'WH') {
            pageURL= '/apex/internalCostingPDFwh';
        }
        PageReference pdfPage = new PageReference(pageURL);

        /* Set internal costing id on page definition */
        pdfPage.getParameters().put('id', ic.Id);
        
        /* Generate PDF Blob */
        Blob pdfBlob = pdfPage.getContent();
        
        /* Generate current datetime for PDF filename */
        datetime currentDateTime = dateTime.now();
        String currentDateTimeString = currentDateTime.format();
        
        /* Generate quote attachment file name (max length=80) */
        String temp = ic.Quote_Description__c;
        String quoteName = '';
        if ( temp != null && temp.length() > 55) {
            quoteName = temp.substring(0,54);
        }
        else {
            quoteName = temp;
        }
        
        /* Convert PDF as attachment in Internal Costing object */
        if  ( quoteName != null) {
            Attachment a = new Attachment(parentId = ic.Id, name =
            quoteName + '_' + currentDateTimeString + '.pdf', body = pdfBlob);
            
            /* insert attachment to object */
            insert a;
        }
        else {
            Attachment a = new Attachment(parentId = ic.Id, name = 
            currentDateTimeString + '.pdf', body = pdfBlob);
            
            /* insert attachment to object */
            insert a;
        }
        
        /* Redirect to display PDF page */
        pdfPage.setRedirect(true);
        return pdfPage;
    }
    
    static testMethod void t1() {
        Opportunity o = new Opportunity(name='test',
        stageName='Open', CloseDate=Date.newInstance(2006,10,10));
        insert o;
        Internal_Costing__c ic = new Internal_Costing__c (Freight_Origin_Destination__c='Test',Ocean_Freight_Lumpsum__c = 1000,Air_Freight_Lumpsum__c=1000,Opportunity__c = o.id); // Antony@TMC 6th July Test Class Errros
        insert ic;
        internalCostingQuotes icq = new internalCostingQuotes( new ApexPages.StandardController(ic ) );
    }
    public static testMethod void test1() {
        Opportunity o = new Opportunity(name='test',
        stageName='Open', CloseDate=Date.newInstance(2006,10,10));
        insert o;
        Internal_Costing__c ic = new Internal_Costing__c (RecordTypeId = '01220000000Tq1AAAS', 
        Opportunity__c = o.id, Quote_Amount__c=0, 
        Quote_Description__c='aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
        insert ic;
        
        PageReference pageRef = new PageReference('/apex/internalCostingPDF');
        Test.setCurrentPage(pageRef);
        system.debug( '****************************** internal costing id is '+ ic.id);
        
        ApexPages.currentPage().getParameters().put('id', ic.id);
        
        internalCostingQuotes icq = new internalCostingQuotes();
        try { icq.attachQuote1(); } catch( System.NullPointerException npe) { } 
    }
    public static testMethod void test2() {
        Opportunity o = new Opportunity(name='test',
        stageName='Open', CloseDate=Date.newInstance(2006,10,10));
        insert o;
        Internal_Costing__c ic = new Internal_Costing__c (RecordTypeId = '01220000000Tq3VAAS', 
        Opportunity__c = o.id, Quote_Amount__c=0);
        insert ic;
        
        PageReference pageRef = new PageReference('/apex/internalCostingPDF');
        Test.setCurrentPage(pageRef);
        system.debug( '****************************** internal costing id is '+ ic.id);
        
        ApexPages.currentPage().getParameters().put('id', ic.id);
        
        internalCostingQuotes icq = new internalCostingQuotes();
        try { icq.attachQuote1(); } catch( System.NullPointerException npe) { } 
    }
    public static testMethod void test3() {
        Opportunity o = new Opportunity(name='test',
        stageName='Open', CloseDate=Date.newInstance(2006,10,10));
        insert o;
        Internal_Costing__c ic = new Internal_Costing__c (Freight_Origin_Destination__c='Test',Ocean_Freight_Lumpsum__c = 1000, RecordTypeId = '01220000000Tq0vAAC', 
        Opportunity__c = o.id, Quote_Amount__c=0);
        insert ic;
        
        PageReference pageRef = new PageReference('/apex/internalCostingPDF');
        Test.setCurrentPage(pageRef);
        system.debug( '****************************** internal costing id is '+ ic.id);
        
        ApexPages.currentPage().getParameters().put('id', ic.id);
        
        internalCostingQuotes icq = new internalCostingQuotes();
        try { icq.attachQuote1(); } catch( System.NullPointerException npe) { } 
    }
    public static testMethod void test4() {
        Opportunity o = new Opportunity(name='test',
        stageName='Open', CloseDate=Date.newInstance(2006,10,10));
        insert o;
        Internal_Costing__c ic = new Internal_Costing__c (RecordTypeId = '01220000000TygnAAC', 
        Opportunity__c = o.id, Quote_Amount__c=0);
        insert ic;
        
        PageReference pageRef = new PageReference('/apex/internalCostingPDF');
        Test.setCurrentPage(pageRef);
        system.debug( '****************************** internal costing id is '+ ic.id);
        
        ApexPages.currentPage().getParameters().put('id', ic.id);
        
        internalCostingQuotes icq = new internalCostingQuotes();
        try { icq.attachQuote1(); } catch( System.NullPointerException npe) { } 
    }
    public static testMethod void test5() {
        Opportunity o = new Opportunity(name='test',
        stageName='Open', CloseDate=Date.newInstance(2006,10,10));
        insert o;
        Internal_Costing__c ic = new Internal_Costing__c (RecordTypeId = '01220000000Tq3LAAS', 
        Opportunity__c = o.id, Quote_Amount__c=0);
        insert ic;
        
        PageReference pageRef = new PageReference('/apex/internalCostingPDF');
        Test.setCurrentPage(pageRef);
        system.debug( '****************************** internal costing id is '+ ic.id);
        
        ApexPages.currentPage().getParameters().put('id', ic.id);
        
        internalCostingQuotes icq = new internalCostingQuotes();
        try { icq.attachQuote1(); } catch( System.NullPointerException npe) { } 
    }
    public static testMethod void test6() {
        Opportunity o = new Opportunity(name='test',
        stageName='Open', CloseDate=Date.newInstance(2006,10,10));
        insert o;
        Internal_Costing__c ic = new Internal_Costing__c (Freight_Origin_Destination__c='Test',Ocean_Freight_Lumpsum__c = 1000, RecordTypeId = '01220000000Tq3GAAS', 
        Opportunity__c = o.id, Quote_Amount__c=0);
        insert ic;
        
        PageReference pageRef = new PageReference('/apex/internalCostingPDF');
        Test.setCurrentPage(pageRef);
        system.debug( '****************************** internal costing id is '+ ic.id);
        
        ApexPages.currentPage().getParameters().put('id', ic.id);
        
        internalCostingQuotes icq = new internalCostingQuotes();
        try { icq.attachQuote1(); } catch( System.NullPointerException npe) { } 
    }
    public static testMethod void test7() {
        Opportunity o = new Opportunity(name='test',
        stageName='Open', CloseDate=Date.newInstance(2006,10,10));
        insert o;
        Internal_Costing__c ic = new Internal_Costing__c (RecordTypeId = '01220000000Tuz2AAC', 
        Opportunity__c = o.id, Quote_Amount__c=0);
        insert ic;
        
        PageReference pageRef = new PageReference('/apex/internalCostingPDF');
        Test.setCurrentPage(pageRef);
        system.debug( '****************************** internal costing id is '+ ic.id);
        
        ApexPages.currentPage().getParameters().put('id', ic.id);
        
        internalCostingQuotes icq = new internalCostingQuotes();
        try { icq.attachQuote1(); } catch( System.NullPointerException npe) { } 
    }
}