/**
 * Email services are automated processes that use Apex classes
 * to process the contents, headers, and attachments of inbound
 * email.
 */
 
Global class unsubscribe implements Messaging.inboundEmailHandler{

Global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, 
							Messaging.InboundEnvelope env ) {

// Create an inboundEmailResult object for returning 
// the result of the email service.
Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
 
// Create contact and lead lists to hold all the updated records.
List<Contact> lc = new List <contact>();
List<Lead> ll = new List <lead>();
 
// Convert the subject line to lower case so the program can match on lower case.
String mySubject = email.subject.toLowerCase();

// The search string used in the subject line.
String s = 'unsubscribe';
String undeliver1 = 'undeliverable';
String undeliver2 = 'failure';
String undeliver3 = 'returned mail';

// Initialize variables
String frontEmail = '';
String endEmail = '';
String emailAdd;
String plainTextMail = email.plainTextBody;
Integer counter;
 
// Check the variable to see if the word "unsubscribe" was found in the subject line. 
Boolean unsubMe;
// Look for the word "unsubcribe" in the subject line. 
// If it is found, return true; otherwise, return false.
unsubMe = mySubject.contains(s);
 
 // If unsubscribe is found in the subject line, enter the IF statement.
 if (unsubMe == true) {
 	
 	try {
 		
 	// Look up all contacts with a matching email address.
 		
	 for (Contact c : [Select Id, Name, Email, HasOptedOutOfEmail
						From Contact
						Where Email = :env.fromAddress
						And hasOptedOutOfEmail = false
						Limit 100]) {
						
	// Add all the matching contacts into the list.	
							c.hasOptedOutOfEmail = true;
							lc.add(c);					               
	}	 
		// Update all of the contact records.
  		update lc;
 			}
 	catch (System.QueryException e) {
		System.debug('Contact Query Issue: ' + e);
		} 	

 	try {
 		// Look up all leads matching the email address.
	 for (Lead l : [Select Id, Name, Email, HasOptedOutOfEmail
						From Lead
						Where Email = :env.fromAddress
						And isConverted = false
						And hasOptedOutOfEmail = false
						Limit 100]) {
							
		// Add all the leads to the list.		
                l.hasOptedOutOfEmail = true;
				ll.add(l);
					           
           System.debug('Lead Object: ' + l);   
	}	 
		// Update all lead records in the query.
		update ll;
		}

 	catch (System.QueryException e) {
		System.debug('Lead Query Issue: ' + e);
		} 	

	System.debug('Found the unsubscribe word in the subject line.');
 } 
 
 // Enter here if email is bounced or undelivered
 else if (mySubject.contains(undeliver1) || mySubject.contains(undeliver2) 
 || mySubject.contains(undeliver3)) {
 	
 	if (plainTextMail.length() > 1001) {
 		plainTextMail = plainTextMail.substring(0, 999);
 	}

 	// Retrieve email address from undelivered email body
 	if (plainTextMail.contains('@')) {
 		
 		List<String> emailString2 = plainTextMail.split('\n');
 		List<String> tempString = new List<String> () ;
 		List<String> emailString = new List<String>();
 		
 		String a;
 		Integer z, y;
 		for (z=0; z<emailString2.size(); z++) {
 			a = emailString2.get(z);
 			tempString = a.split(' ');
 			for (y=0; y<tempString.size(); y++) {
 				emailString.add (tempString.get(y));
 			}// end of inner FOR loop
 			tempString.clear();
 		}// end of outer FOR loop
 		
 		//Loop to retrieve email address from email body
 		emailAdd = 'start';
 		counter = 0;
 		while (!emailAdd.contains('@') && emailString.size() != 0) {
 			emailAdd = emailString.get(counter);
 			counter++;
 		}
 		
 	} // end of if statement

 	System.debug('Email Address Retrieved from Email Body -------------------------------------- ' + emailAdd);
 	
 	//Update email address in Salesforce
	try {
 		// Look up all leads matching the email address.
	 for (Lead l : [Select Id, Name, Email, HasOptedOutOfEmail
						From Lead
						Where Email =: emailAdd
						And isConverted = false
						And hasOptedOutOfEmail = false
						Limit 100]) {
		// Add all the leads to the list.		
                l.Email = 'tba@tba.com';
				ll.add(l);
					           
           System.debug('Display Updated Lead Object: ' + l);   
	}	 
		// Update all lead records in the query.
		update ll;
		}

 	catch (System.QueryException e) {
		System.debug('Lead Query Issue: ' + e);
		}
	
	try {
 	// Look up all contacts with a matching email address.
	 for (Contact c : [Select Id, Name, Email, HasOptedOutOfEmail
						From Contact
						Where Email =: emailAdd
						And hasOptedOutOfEmail = false
						Limit 100]) {
						
	// Add all the matching contacts into the list.	
						c.Email = 'tba@tba.com';
						lc.add(c);					               
	}	 
		// Update all of the contact records.
  		update lc;
 			}
 	catch (System.QueryException e) {
		System.debug('Contact Query Issue: ' + e);
		}
 }
 else {
 	System.debug('No unsubscribe word found in the subject line.' );
 }
 
   //Create a new Outbound email message object
  if (unsubMe == true) {
  	Messaging.Singleemailmessage mail = new Messaging.Singleemailmessage();
  	
  	//Strings to hold email address for the TO and BCC list
  	String[] toAddress = new String[] {env.fromAddress};
  	String[] bccAddress = new String[] {'regionalmarketing@helutrans.com.sg'};
  	
  	//Assign email addresses to the mail object
  	mail.setToAddresses(toAddress);
  	mail.setBccAddresses(bccAddress);
  	
  	//Set reply-To email address
  	mail.setReplyTo('regionalmarketing@helutrans.com.sg');
  	
  	//Set the email display name
  	mail.setSenderDisplayName('Helu-Trans Marketing Team');
  	
  	// Set email subject line
  	mail.setSubject('Mailing List Unsubscription Successful');
  	
  	//Do not BCC email to sender (the email address of the person executing this Apex code)
  	mail.setBccSender(false);
  	
  	//Get Lead client name
  	String nameLead = '';
  	if (ll.size()> 0) {
	  	nameLead = [Select Id, Name FROM Lead Where Email = :env.fromAddress limit 1].name;
  	}
  	
  	//Get Contact client name
  	String nameContact = '';
  	if (lc.size()> 0) {
	  	nameContact = [Select Id, Name FROM Contact Where Email = :env.fromAddress limit 1].name;
  	}
  	
  	//Set plain text email body content
  	mail.setPlainTextBody('You have successfully unsubscribed from our events mailing list.');

  	//Set HTML email body content
  	if (!nameLead.equals('')) {
  		mail.setHtmlBody('Hi ' + nameLead + ',<br><br>' + 
  		'You have successfully unsubscribed from our events mailing list.' + 
  		'<br><br>Regards, <br><br>' + 'Helu-Trans Regional Marketing Team');
  	}
  	
  	if (!nameContact.equals('')) {
  		mail.setHtmlBody('Hi ' + nameContact + ',<br><br>' + 
  		'You have successfully unsubscribed from our events mailing list.' + 
  		'<br><br>Regards, <br><br>' + 'Helu-Trans Regional Marketing Team');
  	}
  	
  	//Send the email created
  	Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
 }
 
// Return True and exit.
// True confirms program is complete and no emails 
// should be sent to the sender of the unsubscribe request. 
result.success = true;
return result;
 
} //end of handleInboundEmail	
	
	// The following test methods provide adequate code coverage.
	// There are two methods, one that does the testing
	// with a valid "unsubscribe" in the subject line
	// and one the does not contain "unsubscribe" in the
	// subject line.
	
static testMethod void testUnsubscribe() {

// Create a new email and envelope object.
   Messaging.InboundEmail email = new Messaging.InboundEmail() ;
   Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();

// Create a new test lead and insert it in the test method.
   Lead l = new lead(firstName='John', 
   			lastName='SMITH',
   			Company='Salesforce', 
   			Email='user@acme.com', 
   			HasOptedOutOfEmail=false);
   insert l;

// Create a new test contact and insert it in the test method.
   Contact c = new Contact(firstName='John', 
   				lastName='SMITH', 
   				Email='user@acme.com', 
   				HasOptedOutOfEmail=false);
   insert c;
   
   // Test with the subject that matches the unsubscribe statement.
   email.subject = 'test unsubscribe test';
   env.fromAddress = 'user@acme.com';
   
   // Call the class and test it with the data in the testMethod.
   unsubscribe unsubscribeObj = new unsubscribe();
   unsubscribeObj.handleInboundEmail(email, env );					
   }
 
static testMethod void testUnsubscribe2() {

// Create a new email and envelope object.
   Messaging.InboundEmail email = new Messaging.InboundEmail();
   Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();

// Create a new test lead and insert it in the test method.        
   Lead l = new lead(firstName='John', 
   			lastName='SMITH',
   			Company='Salesforce', 
   			Email='user@acme.com', 
   			HasOptedOutOfEmail=false);
   insert l;

// Create a new test contact and insert it in the test method.    
   Contact c = new Contact(firstName='John', 
   				lastName='SMITH', 
   				Email='user@acme.com', 
   				HasOptedOutOfEmail=false);
   insert c;
   
   // Test with a subject that does not contain "unsubscribe."
   email.subject = 'test';
   env.fromAddress = 'user@acme.com';

   // Call the class and test it with the data in the test method.
   unsubscribe unsubscribeObj = new unsubscribe();
   unsubscribeObj.handleInboundEmail(email, env );						
   }    
   
   static testMethod void testUnsubscribe3() {
	
	// Create a new email and envelope object
	Messaging.InboundEmail email = new Messaging.InboundEmail();
	Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
	
	// Create a new test Lead and insert into test method
	Lead l = new lead(firstName='John',
			 lastName='SMITH',
			 Company='HeluTrans', 
			 Email='user@helutrans.com');
	insert l;
	
	// Create a new test Contact and insert into test method
	Contact c = new Contact(firstName='John', 
   				lastName='SMITH', 
   				Email='user@acme.com');
    insert c;
	
	// Test with a subject containing "Undeliverable" and an email body containing an email address
	email.subject = 'test undeliverable test';
	email.plainTextBody = 'test test test test\nuser@helutrans.com test test test';
	
	// Call the class and test it with the datain test method
	unsubscribe unsubscribeObj = new unsubscribe();
	unsubscribeObj.handleInboundEmail(email, env );
	}
   
}