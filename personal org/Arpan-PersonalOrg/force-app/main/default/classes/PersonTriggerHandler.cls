public class PersonTriggerHandler {
    public static void beforeinsertt(list<Person__c> newrecords){
        for(Person__c Per:newrecords){
            Per.Health_Status__c='Green';
            Per.Status_Update_Date__c = Date.today();
            per.TokenNo__c = Per.Mobile__c;
        }
        
    }
}