@istest
public class collectorTriggerBatch_test {
    
    public class CollectorMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"payload":{"items":[{"referenceId":"string","type":"CREATE","success":true}],"success":1,"failed":0},"success":true,"message": null}');
            res.setStatusCode(200);
            return res;
        }
    }
    
    static testmethod void dotest(){
        
        List<artApp__Collector__c> collectorInsert_list = new  List<artApp__Collector__c>();
        List<artApp__Collector__c> collectorUpdate_List = new  List<artApp__Collector__c>();
        
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
        
         b.Legal_nature_of_Entity__c = 'Partnership';
        
        collectorUpdate_List.add(b);
        
        
        test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new CollectorMock());
        collectorTriggerBatch batch = new collectorTriggerBatch(collectorInsert_list);
        Database.executeBatch(batch,50);

        test.stopTest();
    }
}