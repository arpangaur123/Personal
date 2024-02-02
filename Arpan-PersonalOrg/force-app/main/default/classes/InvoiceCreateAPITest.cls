@IsTest
public class InvoiceCreateAPITest {
    @testsetup
    static void setupmethod(){
        
        Account a = new Account(name='Tan Enterprise');
        insert a;
        Contact c = new Contact(firstName='Ken', lastName='LEE', 
                                accountid=A.id, Email='lim@myMail.com', Phone='777', MobilePhone='111', Fax='222');
        insert c;
        
        
        
        Id devRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Artmove').getRecordTypeId();
        Opportunity opp = new Opportunity 
            (recordtypeid = devRecordTypeId, CloseDate = Date.newInstance(2009, 11, 01), 
             Name = 'Test Opportunity', StageName = 'Survey', Billing_Currency__c = 'SGD', 
             ETA__c = Date.newInstance(2011, 04, 29), ETD__c = Date.newInstance(2010, 04, 20),AccountId=a.id,Actual_Volume_cuft__c=12);
        insert opp;
        
        Costing_Sheet__c cos = new Costing_Sheet__c(Costing_Sheet_Id__c='123aws',Revision_ID__c='',Opportunity__c=opp.id);
        insert cos;
        
        opp.Approved_Costing_Sheet__c = cos.id;
        opp.StageName = 'Closed Won';
        update opp;
        
        Job_Reference__c jr = new Job_Reference__c(Opportunity__c  = opp.Id ,name='jatin');
        insert jr;
        
    }
    static testmethod void method1(){
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        Opportunity opp = [SELECT Id from Opportunity LIMIT 1];        
        req.requestURI = '/services/apexrest/eportalApi/InvoiceCreateAPI';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueof('[{ "JobReferenceID" : "'+[SELECT Id from Job_Reference__c LIMIT 1].Id+'", "InvoiceID" : "HK180400143", "AccountName" : "Tan Enterprise", "InvoiceDate" : "2020-04-13", "JobSubTotal" : "10", "InvoiceTotalAmount" : "786", "Revenue" : "586", "invoicepdflink" : "https://docs.google.com" }]');
        RestContext.request = req;
        RestContext.response = res;
        InvoiceCreateAPI.createInvoice();
        
        req.requestBody = Blob.valueof('');
        RestContext.request = req;
        RestContext.response = res;
        InvoiceCreateAPI.createInvoice();
        
    }
}