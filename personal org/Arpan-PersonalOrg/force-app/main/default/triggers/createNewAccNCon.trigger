trigger createNewAccNCon on artApp__Collector__c (after insert) {
    try {

        //Dont run on bulk updates, just single updates
        if (Trigger.new.size() == 1) {

        // create list of Contacts
        List <Contact> ct = new List <Contact>();

        // For each new Collector record trigger
        for(artApp__Collector__c o : Trigger.new) {
            
            // Check if Collector that is being inserted
            // is Not Institutional OR Individual
            if (!(o.RecordTypeId == '01220000000TzOSAA0' || o.RecordTypeId == '01220000000TzORAA0' )) {
            
            // Instantiate the Contact object to put values for future record        
            Contact v = new Contact ();
            
            // Map Collector fields to the new Contact record                
            v.FirstName = o.artApp__Contact_First_Name__c;
            v.LastName = o.artApp__Contact_Last_Name__c;
            v.artAppE2__Middle_Name__c = o.artApp__Contact_Middle_Name__c;
            v.Title = o.artApp__Title__c;
            v.AccountId = o.artAppE2__Account_Id__c;            
            v.Email = o.artApp__Email__c;         
            v.Phone = o.artApp__Phone__c;
            v.MobilePhone = o.artApp__Mobile__c;
            v.Fax = o.artApp__Fax__c;
            v.Type__c = 'Others';
            v.RecordTypeId = '012200000008bxwAAA'; 
            v.MailingStreet = o.artApp__Address_1__c +', '+o.artApp__Address_2__c;
            v.MailingCity = o.artApp__City__c;
            v.MailingState = o.artApp__State_Province__c;
            v.MailingPostalCode = o.artApp__Zip_Postal_Code__c;
            v.MailingCountry = o.artApp__Country__c;
            
            // Once done, need to add this new record details to the list that would be later inserted.
            ct.add(v);
            
            } // end of if check Collector condition
        } // end of for loop
        
        // Check if Contact list is not empty then do insert
        if(!ct.isEmpty()){
                insert ct;
            }

        } // end of if Trigger.new.size()

    } // end of try
    catch(Exception e) {
        system.debug ('error: ' + e.getMessage() );
    }
} // end of trigger