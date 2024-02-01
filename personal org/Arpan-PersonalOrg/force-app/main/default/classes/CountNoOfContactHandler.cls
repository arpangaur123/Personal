public class CountNoOfContactHandler {
    Public static void getContactOnInsert(List<Contact> newContactList ){
        Set<Id> accountIdSet = new Set<Id>();
        system.debug('insert');
        for(Contact con : newContactList){
            if(con.accountId != NULL){
                accountIdSet.add(con.accountId);
            }
        }
        if(!accountIdSet.IsEmpty()){
            accountUpdate(accountIdSet);
        }
    }
    Public static void getContactOnUpdate(List<Contact> newContactList, map<Id,contact> idToContactOldMap){
        Set<Id> accountIdSet = new Set<Id>();
        for(Contact con : newContactList){
            if(con.accountId != NULL && con.accountId != idToContactOldMap.get(con.Id).AccountId ){
                accountIdSet.add(con.accountId);
                accountIdSet.add(idToContactOldMap.get(con.Id).AccountId);
            }
        }
        if(!accountIdSet.IsEmpty()){
            accountUpdate(accountIdSet);
        }
    }
    public static void getContactOnDelete(List<Contact> oldContactList){
        Set<Id> accountIdSet = new Set<Id>();
        for(Contact con : oldContactList){
                accountIdSet.add(con.accountId);
        }
        if(!accountIdSet.IsEmpty()){
            accountUpdate(accountIdSet);
        }
    }
    
    public static void accountUpdate(set<Id> accountIdSet){
           system.debug('accountUpdate');
        Map<Id, List<Contact>> accountIdToContactMap = new Map<Id, List<Contact>>();
        List<Account> accountList = new List<Account>();
        for(Contact con : [SELECT Id, Name, AccountId 
                           FROM Contact 
                           where AccountId IN : accountIdSet ]){
            if(accountIdToContactMap.ContainsKey(con.AccountId)){
                accountIdToContactMap.get(con.AccountId).add(con);
            }
            else{
                List<Contact> contactList = new List<Contact>();
                contactList.add(con);
                accountIdToContactMap.put(con.AccountId,contactList);
            }
        }
        for(Account acc : [SELECT Id, Name FROM Account WHERE Id IN:accountIdSet]){
            Account accoun = new Account();
            accoun.Id = acc.Id;
            accoun.Count_Contact__c = accountIdToContactMap.get(acc.Id).size();
            accountList.add(accoun);
        }
        if(!accountList.IsEmpty()){
            update accountList;
        }
    }
}