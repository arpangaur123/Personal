public class MsPincodeHandler {
    public static void cityUpdate(){
        Map<string, String> msPinCodeDataMap = new Map<string, String>();
        for(Ms_Pincode__c pincode : (List<Ms_Pincode__c>)Trigger.new ){
            if(trigger.isUpdate && !(pincode.City__c.equals(((map<id,Ms_Pincode__c>) trigger.OldMap).get(pincode.id) ))){
                msPinCodeDataMap.put(string.valueOf( pincode.Pincode__c) , pincode.City__c);
            }   
        }
        List<Account> accountsToBeUpdated = new List<Account>();
        for(Account acc : [SELECT Id,BillingPostalCode,  BillingCity  FROM Account WHERE BillingPostalCode IN: msPinCodeDataMap.keySet()]){
            Account accObj = new Account();
            accObj.id= acc.Id;
            accObj.BillingCity= msPinCodeDataMap.get(acc.BillingPostalCode);
            accountsToBeUpdated.add(accObj);
        }
        update accountsToBeUpdated;
        
    }
}