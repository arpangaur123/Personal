@IsTest
public class CostingApiControllerTest {
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
             ETA__c = Date.newInstance(2011, 04, 29), ETD__c = Date.newInstance(2010, 04, 20),AccountId=a.id);
        insert opp;
        
    }
    static testmethod void method1(){
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        Opportunity opp = [SELECT Id from Opportunity LIMIT 1];        
        req.requestURI = '/services/apexrest/eportalApi/createCosting';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueof('{ "OppInfo": [ { "Id": "'+opp.id+'", "QuotoNo": "PR1910839IN", "QuoteStatus": "New", "QuoteLink": "https://docs.google.co", "Costing": [{ "CostingId": "999", "CostingLink ": "https://docs.google.com", "Categories": [{ "Id": "456", "Description": "Test", "Currency": "EUR", "Amount": "1000", "Cost" : "20" }, { "Id": "345", "Description ": "Test", "Currency": "EUR", "Amount": "500", "Cost" : "10" }, { "Id": "436", "Description": "Test", "Currency": "EUR", "Amount": "600", "Cost" : "15" } ] }, { "CostingId": "123", "CostingLink": "https://docs.google.co", "Categories": [{ "Id": "345", "Description": "Testing", "Currency": "EUR", "Amount": "123", "Cost" : "45" }, { "Id": "786", "Description": "Test", "Currency": "EUR", "Amount": "123", "Cost" : "67" }, { "Id": "345", "Description": "Test3", "Currency": "EUR", "Amount": "123", "Cost" : "98" } ] } ] } ], "Status": "Success", "Message": "" }');
        RestContext.request = req;
        RestContext.response = res;
        CostingApiController.doCreateRecords();
       
    }
    static testmethod void method2(){
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        Opportunity opp = [SELECT Id from Opportunity LIMIT 1];        
        req.requestURI = '/services/apexrest/eportalApi/createCosting';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueof('{ "Opp": [ { "Id": "'+opp.id+'", "QuotoNo": "PR1910839IN", "QuoteStatus": "New", "QuoteLink": "https://docs.google.co", "Costing": [{ "CostingId": "999", "CostingLink ": "https://docs.google.com", "Categories": [{ "Id": "456", "Description": "Test", "Currency": "EUR", "Amount": "1000", "Cost" : "20" }, { "Id": "345", "Description ": "Test", "Currency": "EUR", "Amount": "500", "Cost" : "10" }, { "Id": "436", "Description": "Test", "Currency": "EUR", "Amount": "600", "Cost" : "15" } ] }, { "CostingId": "123", "CostingLink": "https://docs.google.co", "Categories": [{ "Id": "345", "Description": "Testing", "Currency": "EUR", "Amount": "123", "Cost" : "45" }, { "Id": "786", "Description": "Test", "Currency": "EUR", "Amount": "123", "Cost" : "67" }, { "Id": "345", "Description": "Test3", "Currency": "EUR", "Amount": "123", "Cost" : "98" } ] } ] } ], "Status": "Success", "Message": "" }');
        RestContext.request = req;
        RestContext.response = res;
        CostingApiController.doCreateRecords();
        
        req.requestBody = Blob.valueof('');
        RestContext.request = req;
        RestContext.response = res;
        CostingApiController.doCreateRecords();
       
    }
}