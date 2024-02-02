public class OpportunityHandlerClass {
    
    public static void change_Close_Date(list<Opportunity> oppList){
        System.debug('in call');
        for(Opportunity opp: OppList){
            // opp.StageName = 'Qualification';
            opp.CloseDate = date.today() + 15 ;
            opp.Type = 'New Customer';
            
        }
    } 
    // this trigger ristricts to create more than 5 opportunity for single account
    public static void countNoOpportunity(List<Opportunity> oppNewList){
        //storing account id in set while creating opportunity 
        set<id> setOfAccountId = new set<id>();
        for(Opportunity opp : oppNewList){
            if(opp.AccountId != Null ){
                setOfAccountId.add(opp.AccountId);
            }
        }
        // fatching no. of opportunity W.R.T account
        Map<id,integer> accMapId = new Map<id,integer>();
        list<Account> oppList1 = [SELECT id, name, (SELECT id, name from Opportunities) from Account where id In:setOfAccountId ];
        for(Account acc : oppList1){
            integer countOpp = acc.Opportunities.size();
            accMapId.put(acc.Id, countOpp); //put no. of opportunity as value in map which is associatewith id as key 
        }
        for(Opportunity c: oppNewList){
            if(c.AccountId != Null){
                integer count = accMapId.get(c.AccountId);
                if(count>=5){
                    c.adderror('It is not possible to create more than 5 opportunity on same account');
                }
            }
        }
        
    }
    
    
    //When an oppoutunity is created, 
    //apportunity should be share with a user only when OWD is private.
    public static void shareOpp(list<Opportunity> newOpp){
        user us = [SELECT id FROM user WHERE (alias = 'nlark' and IsActive = true)];
        List<Opportunityshare> oppShareList = new List<Opportunityshare>();
        for(Opportunity op:newOpp){
            if(op.StageName=='closed won'){
                opportunityShare os = new opportunityShare();
                os.OpportunityId = op.Id;
                os.UserOrGroupId = us.Id;
                os.OpportunityAccessLevel = 'read';
                os.RowCause = 'manual';
                oppShareList.add(os);
                system.debug(os);
            }
        }
        if(oppShareList!= Null){
            insert oppShareList;
        }
        
    }
    
    public static void updatAlleOppStage(List<Opportunity> newList){
        list<opportunity> oppUpdate = new list<opportunity>();
        List<opportunity> oppList = [SELECT id,	StageName from opportunity ];
        system.debug('call in');
        for (opportunity opp:oppList){
            if(opp.StageName!='prospecting'){
                opp.StageName='prospecting'; 
                oppUpdate.add(opp); 
            }
        }      
        update oppUpdate;
    }
    
    public static void createTask(List<Opportunity> newList){
        List<Task> taskList = new List<Task>();
        contact con = [SELECT id FROM contact order by name  limit 1];
        user u = [SELECT id FROM user  limit 1];
        
        //system.debug('call out');
        for(Opportunity opp:newList){
            //system.debug('call in');
            if(opp.StageName == 'Closed won'){
                Task t = new Task();
                t.WhoId = con.id;
                t.OwnerId = u.id;
                t.Status = 'Completed';
                t.Priority = 'Normal';
                t.Subject = 'Follow Up Test Task';
                t.WhatId = opp.Id;
                taskList.add(t);
            }
        }
        if(taskList != NULL){
            insert taskList;   
        }
    }
    
    
    public static void countNoOppOnAccount(list<Opportunity> oppNewList, List<Opportunity> oppOldList){
        set<id> listOfAccountId = new set<id>();
        system.debug('call 1');
        if(trigger.isAfter){
            if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete){
                system.debug('call 2');
                for(Opportunity Opp:oppNewList){
                    if(opp.AccountId != NULL){
                        listOfAccountId.add(opp.AccountId); 
                    }
                }
            }
            
            if(Trigger.isUpdate || Trigger.isdelete){
                system.debug('call 3');
                for(Opportunity Opp:oppOldList){
                    if(opp.AccountId != NULL){
                        listOfAccountId.add(opp.AccountId);
                    }
                }
                
            }
        } 
        decimal  amount = 0;
        List<Account> accList = new List<Account>();
        list<Account> oppList2 = [SELECT id, name, (SELECT id, name,Amount from Opportunities) from Account where id In:listOfAccountId ];
        
        for(Account acc:oppList2){
            system.debug('call 4');
            if(acc.Opportunities.size() != 0){
                system.debug('Opportunities.size() =='+ acc.Opportunities.size() );
                acc.NoOfOpp__c = acc.Opportunities.size();                
            }
            
            else{
                acc.NoOfOpp__c = 0;
            }
            
            for(opportunity opp:acc.Opportunities){
                system.debug('call amount ');
                amount = amount + opp.amount  ;
            
            }
            acc.OppAmountSum__c = amount;
            
            if(acc != Null){
                accList.add(acc);  
            }           
        }
        if(accList != NULL){
            update accList;
        }
        
    }
}