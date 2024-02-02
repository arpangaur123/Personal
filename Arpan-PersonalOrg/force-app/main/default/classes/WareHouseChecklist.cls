/**
* Author: Nitin
* CreatedDate: 19/04/2021
* Description: Below apex code is used to retrieve the Checklist Questions & Save the responses for the corresponding questions
**/ 

public class WareHouseChecklist {
    
    @AuraEnabled
    public static List<Master_Checklist_Item__c> fetchChecklistItems(String wareHouseLoc){
        List<Master_Checklist_Item__c> chckItem = [Select Id,Header__c,Item__c,Sequence_No__c,Mandatory__c,Warehouse_Location__c from Master_Checklist_Item__c where IsActive__c=True and Warehouse_Location__c includes (:wareHouseLoc) ORDER BY Sequence_No__c ASC];
        return chckItem;
    }
    @AuraEnabled
    public static String saveRec(String masterAnswers,String WarehouseDetails,String InspectedBy,String frequencyPicklist){
        String recordId;
        try{
            if(String.isNotBlank(masterAnswers)){
                Map<Id,Master_Checklist_Item__c> ChecklistItemMap = new Map<Id,Master_Checklist_Item__c>([Select Id,Header__c,Item__c,Sequence_No__c from Master_Checklist_Item__c where IsActive__c=True]);
                List<inspectionAnswers> answers =(List<inspectionAnswers>)System.JSON.deserialize(masterAnswers, List<inspectionAnswers>.class);
                List<Warehouse_Daily_Checklist_Item__c> wdciList = new List<Warehouse_Daily_Checklist_Item__c>();
                List<Warehouse_Daily_CheckList__c> wdcList = new List<Warehouse_Daily_CheckList__c>();
                String WarehouseDailyCheckList;
                if(answers.size()>0 && String.isNotBlank(WarehouseDetails)){
                    Warehouse_Daily_CheckList__c wdc = new Warehouse_Daily_CheckList__c();
                    wdc.Warehouse_Detail__c=WarehouseDetails;
                    wdc.Inspected_By__c=InspectedBy;
                    wdc.Inspection_Date__c=system.now();
                    //system.debug('>>>29'+frequencyPicklist);
                    wdc.Frequency__c = frequencyPicklist;
                    wdcList.add(wdc);
                    List<Database.SaveResult> insertResults = Database.insert(wdcList, false);
                    for (Database.SaveResult sr : insertResults) {
                        if (sr.isSuccess()) {
                            WarehouseDailyCheckList=sr.getId();
                        }
                    }
                    if(String.isNotBlank(WarehouseDailyCheckList)){
                        for(inspectionAnswers ins : answers){
                            if(String.isNotBlank(ins.picklist) || String.isNotBlank(ins.remarks)){
                                Warehouse_Daily_Checklist_Item__c wdci = new Warehouse_Daily_Checklist_Item__c();
                                wdci.Warehouse_Daily_CheckList__c=WarehouseDailyCheckList;
                                wdci.Master_Checklist_Item__c=ins.Id;
                                wdci.Answer__c=ins.picklist;
                                wdci.Remarks__c=ins.remarks;
                                wdci.Points_Areas_to_be_checked__c= ChecklistItemMap.size() > 0 && ChecklistItemMap.containsKey(ins.Id) ? ChecklistItemMap.get(ins.Id).Item__c : '';
                                wdciList.add(wdci);
                            }
                        }
                        if(wdciList.size()>0){
                            List<Database.SaveResult> insertChckListItems = Database.insert(wdciList, false);
                            recordId=WarehouseDailyCheckList;
                        }
                    }
                }
           }
        }catch(exception e){
            system.debug('mes=====>'+e.getMessage());
            recordId=e.getMessage();
        }
        return recordId;
    }
    
    //Wrapper class created to Store Master Checklist Item Id, Warehouse Daily Checklist Item Answer(Picklist) & Warehouse Daily Checklist Item Remarks
    public class inspectionAnswers {
        public String id;
        public String picklist;
        public String remarks;
    }
}