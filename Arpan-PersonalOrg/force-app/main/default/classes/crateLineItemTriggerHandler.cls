public class crateLineItemTriggerHandler {
	public static void upsertTransaction(list<Crate_Line_Item__c> CrateLineItemList){
        List<artApp__Transaction__c> TransactionList = new List<artApp__Transaction__c>();
        
        for(Crate_Line_Item__c CrateLineItemObj : CrateLineItemList){
            artApp__Transaction__c TransObj = new artApp__Transaction__c();
            TransObj.Id = CrateLineItemObj.Transaction__c;
            TransactionList.add(TransObj);
        }
        
        transactionTriggerBatch batch = new transactionTriggerBatch(TransactionList);
        Database.executeBatch(batch,50);
    }
}