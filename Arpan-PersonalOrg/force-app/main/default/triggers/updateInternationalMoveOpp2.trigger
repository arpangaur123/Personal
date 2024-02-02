trigger updateInternationalMoveOpp2 on Opportunity (before update) {
	
	opportunity o=trigger.new[0];
	
	try{
		/* Get Destination Agent Contact Details */
		OpportunityContactRole agentContact = 
	    [SELECT Contact.Name, Contact.Email, Contact.Phone, Contact.Fax,
	    Contact.MobilePhone FROM OpportunityContactRole WHERE OpportunityId =: o.Id 
	    AND Role = 'Destination Agent' limit 1];
	    
	    /* Update Destination Agent Contact Details */
	    o.Contact_Person_TEL__c = agentContact.Contact.Phone;
	    o.Contact_Person_FAX__c = agentContact.Contact.Fax;
	    o.Contact_Person__c = agentContact.Contact.Name;
	    o.Contact_Person_Email__c = agentContact.Contact.Email;
	    /* o.Contact_Person_DID__c = agentContact.Contact.MobilePhone; */
	    
	    /* Get Booking Agent Contact Details */
		OpportunityContactRole agentContact2 = 
	    [SELECT Contact.Name, Contact.Email, Contact.Phone, Contact.Fax,
	    Contact.MobilePhone FROM OpportunityContactRole WHERE OpportunityId =: o.Id 
	    AND Role = 'Booker' limit 1];
	    
	    /* Update Booking Agent Contact Details */
	    o.Booker_TEL__c = agentContact2.Contact.Phone;
	    o.Booker_FAX__c = agentContact2.Contact.Fax;
	    o.Booker_Contact__c = agentContact2.Contact.Name;
	    o.Booker_Email__c = agentContact2.Contact.Email;
	    
	} catch (System.QueryException e) {
		System.debug('Opportunity Contact Role (Agent Contact) Query Issue: =============================================' + e);
	}
	
}