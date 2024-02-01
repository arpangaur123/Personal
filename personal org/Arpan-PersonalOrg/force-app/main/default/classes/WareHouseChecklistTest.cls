@isTest 
private class WareHouseChecklistTest {
    @testSetup static void methodName() {
        Master_Checklist_Item__c mci = new Master_Checklist_Item__c();
        mci.Header__c='Test Header';
        mci.Item__c='Question?';
        mci.Sequence_No__c=10;
        mci.IsActive__c=True;
        insert mci;
        
        Warehouse_Detail__c wd = new Warehouse_Detail__c();
        wd.Name='WareHouse Test';
        insert wd;
        
    }
    
    static testMethod void validateAttachment(){
        test.startTest();
        List<Master_Checklist_Item__c> chckItem = [Select Id from Master_Checklist_Item__c where IsActive__c=True];
        List<Warehouse_Detail__c> wdetail = [Select Id from Warehouse_Detail__c where Name='WareHouse Test'];
        WareHouseChecklist.fetchChecklistItems();
        String json = '[{"id":"'+chckItem[0].id+'","picklist":"Yes","remarks": "Test Remarks"}]';
        WareHouseChecklist.saveRec(json,wdetail[0].Id,'Test User');
        test.stopTest();
    }
}