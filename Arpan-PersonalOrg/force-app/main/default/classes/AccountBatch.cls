/*
 * Author : Arpan Gaur
 * Date : 15-09-22
 * Description : Account is created with contact first and last name on those contacts whose parent Account is null
 */
global class AccountBatch implements Database.Batchable<SObject>{
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        System.debug('START');
        String contactList = 'SELECT Id, FirstName, LastName FROM Contact WHERE AccountId = NULL limit 1';
        return Database.getQueryLocator(contactList);
    }
 
    global void execute(Database.BatchableContext BC, List<Contact> contactList){
        System.debug('EXECUTE');
        Map<Id,Account> conatctToAccountMap = new Map<Id,Account>();
        for(Contact con : contactList){
            Account acc = new Account();
            acc.Name = con.FirstName + '__' + con.LastName;
            conatctToAccountMap.put(con.id, acc);
        }
        insert conatctToAccountMap.values();
        
        List<Contact> newcontactList = new List<Contact>();
        for(Contact con : contactList){
            con.AccountId = conatctToAccountMap.get(con.Id).Id;
            newcontactList.add(con);
        }
       
        update contactList;
    }
    
    global void finish(Database.BatchableContext BC) {
        System.debug('Batch Completed');
    }
}