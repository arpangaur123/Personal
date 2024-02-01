trigger transactionTrigger on artApp__Transaction__c (after insert,after update){
    if(Trigger.isAfter){
        if (Trigger.isInsert || Trigger.isUpdate){
            list<artApp__Transaction__c> RFIDTran_list = new list<artApp__Transaction__c>();
            
            string RecordType1 = System.Label.Ignore_Recordtype_for_Transcation_1;
            string RecordType2 = System.Label.Ignore_Recordtype_for_Transcation_2;
            
            Id receiveOrderid = Schema.SObjectType.artApp__Transaction__c.getRecordTypeInfosByName().get(RecordType1).getRecordTypeId();
            Id collectionOrderid = Schema.SObjectType.artApp__Transaction__c.getRecordTypeInfosByName().get(RecordType2).getRecordTypeId();
            for(artApp__Transaction__c obj : trigger.new){
                if(obj.recordtypeid != receiveOrderid && obj.recordtypeid != collectionOrderid ){
                    RFIDTran_list.add(obj);
                }
            }
            if(RFIDTran_list.size() > 0){
                transactionTriggerHandler.upsertTransaction(RFIDTran_list);
            }
        }
    }
}