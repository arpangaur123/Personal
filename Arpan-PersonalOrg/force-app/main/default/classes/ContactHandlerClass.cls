public class ContactHandlerClass {
    public static void countContactsOnAccount(boolean isAfter,boolean isInsert,boolean isUpdate,boolean isUndelete, boolean isdelete, list<Contact> conNewList, List<Contact> conOldList){
        set<id>setOfAccId = new set<id>();
        if(isAfter){
            if(isInsert || isUpdate || isUndelete){
                for(Contact con:conNewList){
                    if(con.accountId != null){
                        setOfAccId.add(con.accountId);
                    }
                }
            }
            if(isUpdate || isdelete){
                for(Contact con:conOldList){
                    if(con.accountId != null){
                        setOfAccId.add(con.accountId);
                    }
                }
            }
        }
        if(setOfAccId.size()>0){
            list<contact>listCon = new list<contact>();
            list<account>listAccountToUpdate = new list<account>();
            for(Account acc:[select id,name,Active_contact__c,(select id,name,Active_status__c from Contacts)From Account WHERE ID IN:setOfAccId]){ 
                for(Contact con:acc.contacts){
                    if(con.Active_status__c == True){
                        listCon.add(con);
                    }
                }
                acc.Active_contact__c=listCon.size();
                listAccountToUpdate.add(acc);
            }
            if(listAccountToUpdate.size()>0){
                update listAccountToUpdate;
            }
        }
    }
    
    public static void contactList(List<Contact> conList){
        set<id> accId = new set<id>();
        for(Contact conObj:conList){
            //fatching account id 
            accId.add(conObj.AccountId); 
        }
        //list of all contacts with respect to account
        map<id,integer> mapOfAccountId = new map<id,integer>();
        //List<Account> accList =[SELECT id , name, (SELECT id,name from contacts) from Account Where id In : accId];
        for(Account accObj:[SELECT id , name, (SELECT id,name from contacts) from Account Where id In : accId]){
            integer count = accObj.contacts.size();
            //system.debug(accObj.contacts.size());
            //system.debug(accObj.contacts);
            
            mapOfAccountId.put(accObj.Id, count);
        }
        System.debug('map>> '+mapOfAccountId);
        for(Contact conObj:conList){
            integer count= mapOfAccountId.get(conObj.AccountId);
            if(count>=2){
                System.debug('con>> '+conObj);
                conObj.adderror('we can not create more than 2 contact');
            }
        }
    }
    
    public static void countNoOfCon(List<Contact> newConList , List<Contact> oldConList){
        set<id> accId = new set<id>();
        list<Account> accList1 = new list<Account>();       
        for(contact con:newConList){
            if(con.AccountId != Null){
                accId.add(con.AccountId);
            }
            
        }
        
        for(contact con:oldConList){
            if(con.AccountId != Null){
                accId.add(con.AccountId);
            }
            
            list<Account> accList = [ SELECT id, name, (SELECT id,name from Contacts) from Account WHERE id IN:accId];
            for(Account acc: accList){
                acc.Count_Contact__c = acc.Contacts.size();
                accList1.add(acc);
            }
            update accList1;
        }
    }
}