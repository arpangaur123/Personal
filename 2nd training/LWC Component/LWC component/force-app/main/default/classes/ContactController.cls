public with sharing class ContactController {
    @AuraEnabled(cacheable=true) 
    public static List<Contact> fetchingContactRecords(){
        List<Contact> ConList = [ SELECT  Name, Email,Phone FROM Contact ];
        System.debug('List : ' + ConList);
        return ConList;
        
    }
}
