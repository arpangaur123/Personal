public class AccountTriggerHandler {
    //Create an opportunity when  account is created
    public static void createOpportunity(list<account> accList){
        //set<id> accountId = new set<id>();
        list<Opportunity> oppList = new list<Opportunity>();
        list<account> newAcc = [SELECT id, name from account];
        // for(account accId:newAcc){
        //    accountId.add(accId.Id);
        //}
        //system.debug(accountId);
        for(account accRecord:accList){
            Opportunity opp = new Opportunity();
            opp.Name = 'gaur opp';
            opp.StageName= 'prospecting';
            opp.CloseDate = date.today()+5;
            opp.AccountId = accRecord.Id;
            system.debug(opp.AccountId);
            oppList.add(opp);
        }
        
        if(oppList != Null){
            insert oppList; 
        }
        
        
        
    }
    
    public static void addAccountTeamMamber(list<account> accTeam){
        Id userId = userinfo.getUserId();
        //User us =[SELECT Id, Name, Email, Profile.Name, UserRole.Name FROM User where Id=:userId ];
        user us = [ select Id, Name ,Email from user where 	Alias = 'agaur' limit 1];
        List<AccountTeamMember> team = new List<AccountTeamMember>();
        for(account accRecord:accTeam){
            if(accRecord.Ownership == 'Private'){
                AccountTeamMember accTeamM = new AccountTeamMember();
                accTeamM.AccountId = accRecord.Id;
                accTeamM.UserId = us.Id;
                accTeamM.TeamMemberRole = 'Account Manager';
                accTeamM.AccountAccessLevel = 'Read';
                team.add(accTeamM);
            }
        }
        if( team != Null){
            insert team;  
        }
        
    }
    public static void trailmix(List<Account> newList){
       system.debug('call out');
        for(Account acc:newList){
            system.debug('call in ');
            if (acc.Match_Billing_Address__c == true){
                system.debug('call');
                acc.BillingPostalCode = acc.ShippingPostalCode;
            }
        }
    }
    Public static void Pincode(List<Account> newList){
       // List<MS_Pincode__c> msPincodeList = [SELECT Id, Name, Pincode__c, City__c FROM MS_Pincode__c];
       set<Decimal> BillingPostalCodeSet = new set<Decimal>();
        Map<Decimal, string> pincodeMap = new Map<Decimal, string>();
       
        for(Account acc : newList ){
            if(acc.BillingPostalCode != Null){
                BillingPostalCodeSet.add(Decimal.valueOf(acc.BillingPostalCode) );
                     //acc.BillingCity = pincodeMap.get(Decimal.valueOf(acc.BillingPostalCode) );
            }
        }
        if(!BillingPostalCodeSet.isEmpty()){
            List<MS_Pincode__c> msData = [SELECT Id, Name, Pincode__c, City__c FROM MS_Pincode__c where Pincode__c IN: BillingPostalCodeSet];
            for(MS_Pincode__c msId : msData ){
                pincodeMap.put(msId.Pincode__c, msId.City__c);
            }
        }
        for(Account acc : newList ){
            if(acc.BillingPostalCode != Null){
                //BillingPostalCodeSet.add(Decimal.valueOf(acc.BillingPostalCode) );
                     acc.BillingCity = pincodeMap.get(Decimal.valueOf(acc.BillingPostalCode) );
            }
        }
         
    }

}