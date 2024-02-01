trigger updateRateReply on Rate_Reply__c (before insert, before update) {
	
	Rate_Reply__c rr = trigger.new[0];
	
	Contact c = [SELECT Id, AccountId, Account.Name, Name, Email 
	FROM Contact WHERE Id =: rr.Agent_Name__c limit 1];
		
	System.debug(' AGENT NAME =================================== ' + rr.Agent_Name__c);
	System.debug(' CONTACT ID =================================== ' + c.Id);
	
	rr.Agent_Email__c = c.Email;
	rr.Company__c = c.Account.Name;
	
}