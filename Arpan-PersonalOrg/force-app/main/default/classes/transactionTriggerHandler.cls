public class transactionTriggerHandler {
    public static void upsertTransaction(list<artApp__Transaction__c> TransactionList){
        transactionTriggerBatch batch = new transactionTriggerBatch(TransactionList);
        Database.executeBatch(batch,50);
    }
}