/* Date: 07/12/2022
 * Account status must be 'True' if all the associate opportunites stages are 'closed Won' other wise it should be False
 * 
 */

public class OpportunityHandler {
    public static void updateStatusOfAccount(List<Opportunity> newOppList){
        system.debug('deletelist'+ newOppList);
        List<Account> accountsToUpdate = new List<Account>();
        set<Id> setOfAccountId = new set<Id>();
        for(opportunity opp : newOppList){
            if(opp.AccountId!= NULL){
                setOfAccountId.add(opp.AccountId);
            }
        }
        for(Account acc : [SELECT Id, Name, Status__c, (SELECT Id, Name From Opportunities  WHERE stageName != 'Closed Won') From Account WHERE Id IN:setOfAccountId]){
           	system.debug('accountopportunities'+ acc.opportunities.size());
            if(acc.Opportunities.size()>0){
                acc.Status__c = 'False';
                accountsToUpdate.add(acc);
            }
            else{
                acc.Status__c = 'True';
                accountsToUpdate.add(acc);
            }
        }
        if(!accountsToUpdate.isEmpty()){
            update accountsToUpdate;
        }
    }
}