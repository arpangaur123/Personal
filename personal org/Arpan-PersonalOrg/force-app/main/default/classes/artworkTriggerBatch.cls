global class artworkTriggerBatch implements Database.Batchable<sObject>,Database.AllowsCallouts{
    public Set<Id> ArtworkIds = new Set<Id>();
    
    global artworkTriggerBatch (List<artApp__Artwork__c> artworkList){
        for(artApp__Artwork__c artworkObj : artworkList){
            ArtworkIds.add(artworkObj.Id);
        }
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        //system.debug('>>>>'+ArtworkIds);
        //system.debug('?.>>>>'+Database.getQueryLocator([SELECT Id, Name,CurrencyIsoCode,RecordTypeId,myCollector__c,CBarcode_ID__c,Height__c,Length__c,UOM__c,Status__c,Width__c,Job_Reference__c,Date_In__c,Date_Out__c,With_Legs__c,Cycle_Count__c,IPPC_Stamp__c,IsActive__c from Crate__c WHERE Id IN : CrateIds]));
        return Database.getQueryLocator([SELECT Id,Keep_Id__c, SourceRFID__c, Barcode_ID__c,Job_Reference__c,artApp__Collector__c,artApp__Artist__c,Packing_Method__c,Shared_Crate__c,Name,Cycle_Count__c,artApp__Location__c,Internal_Location__c,Date_In__c,Date_Out__c,Crate_Barcode__c,artApp__UOM__c,artApp__Length__c,artApp__Width__c,artApp__Height__c,Packed_Length__c,Packed_Width__c,Packed_Height__c,Crate__c,Item_No__c,IsActive__c from artApp__Artwork__c WHERE Id IN : ArtworkIds]);
    }
    
    global void execute(Database.BatchableContext BC, List<artApp__Artwork__c> artworkList){
        //system.debug('artworkList>>>'+artworkList);
        RFIDIntegrationUtility.RFIDCreateArtwork(artworkList);
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
    
}