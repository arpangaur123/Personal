@isTest
private class createNewAccNConTest{
    static testMethod void myUnitTest() {
        artApp__Collector__c coll = new artApp__Collector__c();
        coll.Name = 'Testv1';
        coll.RecordTypeId = Schema.SObjectType.artApp__Collector__c.getRecordTypeInfosByName().get('HTTR').getRecordTypeId();
        coll.artApp__Email__c = 'testv1@mail.com';
        insert coll;
        
        artApp__Collector__c coll2 = new artApp__Collector__c();
        coll2.Name = 'Testv2';
        coll2.RecordTypeId = Schema.SObjectType.artApp__Collector__c.getRecordTypeInfosByName().get('Artspace').getRecordTypeId();
        Coll2.artApp__Contact_First_Name__c = 'FName';
        Coll2.artApp__Contact_Last_Name__c = 'LName';
        coll2.artApp__Email__c = 'testv2@mail.com';
        insert coll2;
    }
}