global class transactionTriggerBatch implements Database.Batchable<sObject>,Database.AllowsCallouts{
    public Set<Id> TransactionIds = new Set<Id>();
    
    global transactionTriggerBatch (List<artApp__Transaction__c> transactionList){
        system.debug('transactionList>>'+transactionList);        
        for(artApp__Transaction__c transactionObj : transactionList){
            TransactionIds.add(transactionObj.Id);
        }
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        system.debug('TransactionIds>>>>'+TransactionIds);
        return Database.getQueryLocator([SELECT Id, Name,Crate__r.Id,Crate__r.Name from artApp__Transaction__c WHERE Id IN : TransactionIds]);
    }
    
    global void execute(Database.BatchableContext BC, List<artApp__Transaction__c> transactionList){
        system.debug('transactionList>>>'+transactionList);
        
        //List <Crate_Line_Item__c> crateLineList = [SELECT Id, Crate_ID_barcode__c,Transaction__c from Crate_Line_Item__c WHERE Transaction__c IN : TransactionIds];
        //List <artApp__Line_Item__c> artworkLineList = [SELECT Id, Barcode_ID__c,artApp__Transaction__c from artApp__Line_Item__c WHERE artApp__Transaction__c IN : TransactionIds];
        List <Crate_Line_Item__c> crateLineList = [SELECT Id, Crate_ID_barcode__c,Transaction__c,Crate__c from Crate_Line_Item__c WHERE Transaction__c IN : TransactionIds];
        List <artApp__Line_Item__c> artworkLineList = [SELECT Id, Barcode_ID__c,artApp__Transaction__c,artApp__Artwork__c from artApp__Line_Item__c WHERE artApp__Transaction__c IN : TransactionIds];
        
        Map<String,List<Crate_Line_Item__c>> crateLineMap = new Map<String,List<Crate_Line_Item__c>>();
        Map<String,List<artApp__Line_Item__c>> artworkLineMap = new Map<String,List<artApp__Line_Item__c>>();
        
        for(artApp__Transaction__c transObj : transactionList){
        	List <artApp__Line_Item__c> tempArtworkLineList = new List<artApp__Line_Item__c>();
            List <Crate_Line_Item__c> tempCrateLineList = new List<Crate_Line_Item__c>();
            
            for(Crate_Line_Item__c crateObj : crateLineList){
                if(transObj.Id == crateObj.Transaction__c){
                    tempCrateLineList.add(crateObj);
                }
            }
            crateLineMap.put(transObj.Id,tempCrateLineList);
            
            for(artApp__Line_Item__c artWorkObj : artworkLineList){
                if(transObj.Id == artWorkObj.artApp__Transaction__c){
                    tempArtworkLineList.add(artWorkObj);
                }
            }
            artworkLineMap.put(transObj.Id,tempArtworkLineList);
            
            //RFIDIntegrationUtility.RFIDCreateTransaction(transactionList);
            RFIDIntegrationUtility.RFIDCreateTransaction(transactionList,crateLineMap,artworkLineMap);
        }
        
        
        
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
    
}