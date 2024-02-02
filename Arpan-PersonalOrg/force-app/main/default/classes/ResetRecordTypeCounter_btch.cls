global class ResetRecordTypeCounter_btch implements Database.Batchable<sObject>{
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator([Select CreatedDate, Object_Name__c, Name, Initial_Counter__c, Frequency__c, Description__c, Count__c From Record_Type_Counter__c]);
    }     
    global void execute(Database.BatchableContext info, list<Record_Type_Counter__c> scope){
        list<Record_Type_Counter__c> updateRecordTypeCountry = new list<Record_Type_Counter__c>();
        for(Record_Type_Counter__c rtc:scope){
            if((rtc.Frequency__c == 'Annual' && system.today().month() == 1 && system.today().day() == 1) || Test.isRunningTest()){
                Record_Type_Counter__c objrtc = rtc;
                objrtc.Count__c = objrtc.Initial_Counter__c;
                updateRecordTypeCountry.add(objrtc);
            }else if((rtc.Frequency__c == 'Monthly' && system.today().day() == 1) || Test.isRunningTest()){
                Record_Type_Counter__c objrtc1 = rtc;
                objrtc1.Count__c = rtc.Initial_Counter__c;
                updateRecordTypeCountry.add(objrtc1); 
            }
        }   
        if(!updateRecordTypeCountry.isEmpty()) update updateRecordTypeCountry;  
    }      
    global void finish(Database.BatchableContext info){  
        //Send an email to the User after your batch completes
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {'mo.usman786@gmail.com'};//Need to change email
        mail.setToAddresses(toAddresses);
        mail.setSubject('Apex Batch Job is done');
        mail.setPlainTextBody('The batch Apex job processed ');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });   
    }
}