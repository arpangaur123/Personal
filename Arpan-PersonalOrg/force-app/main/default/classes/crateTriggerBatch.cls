global class crateTriggerBatch implements Database.Batchable<sObject>,Database.AllowsCallouts{
    public Set<Id> CrateIds = new Set<Id>();
    
    global crateTriggerBatch (List<Crate__c> crateList){
        system.debug('crateList>>'+crateList);        
        for(Crate__c crateObj : crateList){
            CrateIds.add(crateObj.Id);
        }
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        system.debug('CrateIds>>>>'+CrateIds);
        //system.debug('?.>>>>'+Database.getQueryLocator([SELECT Id, Name,CurrencyIsoCode,RecordTypeId,myCollector__c,CBarcode_ID__c,Height__c,Length__c,UOM__c,Status__c,Width__c,Job_Reference__c,Date_In__c,Date_Out__c,With_Legs__c,Cycle_Count__c,IPPC_Stamp__c,IsActive__c from Crate__c WHERE Id IN : CrateIds]));
        return Database.getQueryLocator([SELECT Id,Keep_Id__c, SourceRFID__c,Name,CurrencyIsoCode,Location__c,RecordTypeId,myCollector__c,CBarcode_ID__c,Height__c,Length__c,UOM__c,Status__c,Width__c,Job_Reference__c,Date_In__c,Date_Out__c,With_Legs__c,Cycle_Count__c,IPPC_Stamp__c,IsActive__c from Crate__c WHERE Id IN : CrateIds]);
    }
    
    global void execute(Database.BatchableContext BC, List<Crate__c> crateList){
        system.debug('crateList>>>'+crateList);
        RFIDIntegrationUtility.RFIDCreateCrate(CrateList);
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
    
}