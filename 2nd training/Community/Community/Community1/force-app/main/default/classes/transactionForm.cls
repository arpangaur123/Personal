public class transactionForm {
    public artApp__Transaction__c t {get; private set;}
    public ApexPages.Standardcontroller controller;
    
    id transactionID;
    public transactionForm () {
        transactionID = ApexPages.currentPage().getParameters().get('id');
        t = [SELECT id, RecordType.Name FROM artApp__Transaction__c WHERE id =: transactionID limit 1];
    }
    public transactionForm (ApexPages.StandardController c) {
        controller = c;
        transactionID = c.getRecord().id;
        t = [SELECT id, RecordType.Name FROM artApp__Transaction__c WHERE id =: transactionID limit 1];
    }
    public PageReference attachTransaction() {
        String pageURL = '';
        
        /* Set page definition */
        if (t.RecordType.Name == 'Release Order') {
            pageURL = '/apex/deliveryOrderPDF';
        }
        else if (t.RecordType.Name == 'Collection Order') {
            pageURL = '/apex/collectionOrderPDF';
        }
        else if (t.RecordType.Name == 'Packing List') {
            pageURL = '/apex/packingListPDF';
        }
        
        PageReference pdfPage = new PageReference(pageURL);
        
        /* Set rate reply ID on page defintion */
        pdfPage.getParameters().put('id', t.id);
        
        /* Generate PDF Blob */
        Blob pdfBlob = pdfPage.getContent();
        
        /* Redirect to display PDF page */
        pdfPage.setRedirect(true);
        return pdfPage;
    }/* end of attachTransaction */
    
    /* Test Methods Below */
    static testMethod void test1() {
        artApp__Transaction__c myTransaction = new artApp__Transaction__c (RecordTypeId = '01220000000U2llAAC', Job_Number__c='132', Payment_to_be_Collected__c = 0);
        insert myTransaction;
        transactionForm t = new transactionForm(new ApexPages.Standardcontroller(myTransaction));
    }
    public static testMethod void test2() {
        artApp__Transaction__c myTransaction = new artApp__Transaction__c (RecordTypeId = '01220000000U2llAAC', Job_Number__c='132', Payment_to_be_Collected__c = 0);
        insert myTransaction;

        PageReference pageRef = new PageReference('/apex/deliveryOrderPDF');
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', myTransaction.id);
        
        transactionForm t = new transactionForm();
        //try { t.attachTransaction(); } catch( System.NullPointerException npe) { } 
    }
    public static testMethod void test3() {
        artApp__Transaction__c myTransaction = new artApp__Transaction__c (RecordTypeId = '01220000000U2s4AAC', Job_Number__c='132', Payment_to_be_Collected__c = 0);
        insert myTransaction;

        PageReference pageRef = new PageReference('/apex/collectionOrderPDF');
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', myTransaction.id);
        
        transactionForm t = new transactionForm();
    }
    
}