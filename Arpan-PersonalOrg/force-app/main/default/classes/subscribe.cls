/**
 * Email services are automated processes that use Apex classes
 * to process the contents, headers, and attachments of inbound
 * email.
 */
global class subscribe implements Messaging.InboundEmailHandler {

    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope env) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();

	// Create contact and lead lists to hold all the updated records.
	List<Contact> lc = new List <contact>();
	List<Lead> ll = new List <lead>();
	 
	// Convert the subject line to lower case so the program can match on lower case.
	String mySubject = email.subject.toLowerCase();
	
	// The search string used in the subject line.
	String s = 'subscribe';
	 
	// Check the variable to see if the word "subscribe" was found in the subject line. 
	Boolean subMe;
	// Look for the word "unsubcribe" in the subject line. 
	// If it is found, return true; otherwise, return false.
	subMe = mySubject.contains(s);
	 
	 // If subscribe is found in the subject line, enter the IF statement.
	 
	 if (subMe == true) {
	 	
	 	try {
	 		
	 	// Look up all contacts with a matching email address.
	 		
		 for (Contact c : [Select Id, Name, Email, HasOptedOutOfEmail
							From Contact
							Where Email = :env.fromAddress
							And hasOptedOutOfEmail = true
							Limit 100]) {
							
		// Add all the matching contacts into the list.	
								c.hasOptedOutOfEmail = false;
								lc.add(c);					               
		}	 
			// Update all of the contact records to uncheck Email Opt Out.
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
							And hasOptedOutOfEmail = true
							Limit 100]) {
			// Add all the leads to the list.		
	                l.hasOptedOutOfEmail = false;
			ll.add(l);
						           
	           System.debug('Lead Object: ' + l);   
		}	 
			// Update all lead records in the query to uncheck Email Opt Out.
			update ll;
	 			}
	
	 	catch (System.QueryException e) {
			System.debug('Lead Query Issue: ' + e);
			} 	
	
		System.debug('Found the subscribe word in the subject line.');
	 } 
	 else {
	 	System.debug('No suscribe word found in the subject line.' );
	 }
	// Return True and exit.
	// True confirms program is complete and no emails 
	// should be sent to the sender of the subscribe request. 
	result.success = true;
	return result;
		}	
		
		// The following test methods provide adequate code coverage.
		// There are two methods, one that does the testing
		// with a valid "unsubscribe" in the subject line
		// and one the does not contain "unsubscribe" in the
		// subject line.
		
	static testMethod void testSubscribe() {
	
	// Create a new email and envelope object.
	   Messaging.InboundEmail email = new Messaging.InboundEmail() ;
	   Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
	
	// Create a new test lead and insert it in the test method.
	   Lead l = new lead(firstName='John', 
	   			lastName='SMITH',
	   			Company='Salesforce', 
	   			Email='user@acme.com', 
	   			HasOptedOutOfEmail=true);
	   insert l;
	
	// Create a new test contact and insert it in the test method.
	   Contact c = new Contact(firstName='John', 
	   				lastName='SMITH', 
	   				Email='user@acme.com', 
	   				HasOptedOutOfEmail=true);
	   insert c;
	   
	   // Test with the subject that matches the unsubscribe statement.
	   email.subject = 'test subscribe test';
	   env.fromAddress = 'user@acme.com';
	   
	   // Call the class and test it with the data in the testMethod.
	   subscribe subscribeObj = new subscribe();
	   subscribeObj.handleInboundEmail(email, env );
							
	   }
	 
	static testMethod void testSubscribe2() {
	
	// Create a new email and envelope object.
	   Messaging.InboundEmail email = new Messaging.InboundEmail();
	   Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
	
	// Create a new test lead and insert it in the test method.        
	   Lead l = new lead(firstName='john', 
	   			lastName='SMITH',
	   			Company='Salesforce', 
	   			Email='user@acme.com', 
	   			HasOptedOutOfEmail=true);
	   insert l;
	
	// Create a new test contact and insert it in the test method.    
	   Contact c = new Contact(firstName='john', 
	   				lastName='SMITH', 
	   				Email='user@acme.com', 
	   				HasOptedOutOfEmail=true);
	   insert c;
	   
	   // Test with a subject that does not contain "unsubscribe."
	   email.subject = 'test';
	   env.fromAddress = 'user@acme.com';
	
	   // Call the class and test it with the data in the test method.
	   subscribe subscribeObj = new subscribe();
	   subscribeObj.handleInboundEmail(email, env );						
	   }    
	}