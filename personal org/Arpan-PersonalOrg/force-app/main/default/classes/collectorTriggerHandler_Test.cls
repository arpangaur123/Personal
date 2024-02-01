@isTest
public class collectorTriggerHandler_Test {

    
    static testmethod void dotest(){
        
        List<artApp__Collector__c> collectorInsert_list = new  List<artApp__Collector__c>();
        List<artApp__Collector__c> collectorUpdate_List = new  List<artApp__Collector__c>();
        artApp__Collector__c a = new artApp__Collector__c();
        a.Name = 'Archduke Leopold William';
        a.CurrencyIsoCode = 'SGD';
        a.RecordTypeId = '01220000000TzOSAA0';
        a.Legal_nature_of_Entity__c = 'Company';
        a.Invoice_Type__c = 'E-Invoice';
        collectorInsert_list.add(a) ;
        
        artApp__Collector__c b = new artApp__Collector__c();
        b.Name = 'Kings Philip III';
        b.CurrencyIsoCode = 'SGD';
        b.RecordTypeId = '01220000000TzOSAA0';
        b.Legal_nature_of_Entity__c = 'Company';
        b.Invoice_Type__c = 'E-Invoice';
        collectorInsert_list.add(b) ;
        
        insert collectorInsert_list;
    }
}