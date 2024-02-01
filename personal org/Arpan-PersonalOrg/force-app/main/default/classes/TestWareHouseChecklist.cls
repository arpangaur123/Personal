@isTest
public class TestWareHouseChecklist {
    @isTest
    public static void fetchChecklistItems(){
        Master_Checklist_Item__c mci = new Master_Checklist_Item__c();
        mci.Header__c = 'VISITOR ENTRANCE AREA / LOADING AREA';
        mci.Item__c = 'item';
        mci.Sequence_No__c = 20;
        mci.Mandatory__c = True;
        mci.Warehouse_Location__c = 'China';
        mci.IsActive__c = True;
        insert mci;
        
        Warehouse_Detail__c wd = new Warehouse_Detail__c();
        wd.Warehouse_Location__c = 'Singapore';
        insert wd;
        
        List<WareHouseChecklist.inspectionAnswers> wrapperList = new List<WareHouseChecklist.inspectionAnswers>();
        
        WareHouseChecklist.inspectionAnswers answers = new WareHouseChecklist.inspectionAnswers();
        answers.id = mci.Id;
        answers.picklist = 'Yes';
        answers.remarks = 'None';
        wrapperList.add(answers);
        String var = JSON.serialize(wrapperList); 
        //String var = 'id: \"'+mci.id +'\" \npicklist: \"Yes\" \nremarks: \"3\"';
   		Test.startTest();
        WareHouseChecklist.fetchChecklistItems('China');
        //public static String saveRec(String masterAnswers,String WarehouseDetails,String InspectedBy,String frequencyPicklist)
        WareHouseChecklist.saveRec(var, wd.Id, '1', 'Daily');
        Test.stopTest();
    }
}