trigger createNewAccNCon3 on artApp__Collector__c (after insert) {

    try {

        //Dont run on bulk updates, just single updates
        if (Trigger.new.size() == 1) {
        
        //variable to hold the New Account Id
        Id newAccountId;
        
        Set<Id> httrRoles = new Set<Id>();
        httrRoles.add(label.HTTR_BD_Role_ID);
        httrRoles.add(label.HTTR_CS_Role_ID);
        httrRoles.add(label.HTTR_Registrar_Role_ID);
        system.debug('httrRoles: '+ httrRoles);
        
        // create list of Contacts
        List <Contact> ct = new List <Contact>();

        // For each new Collector record trigger
        for(artApp__Collector__c o : Trigger.new) {
            
            // Check if Collector that is being inserted
            // is Not Institutional OR Individual OR Private Collector
            
            //if(!(o.RecordTypeId == '01234500000TzOSAA0')) {
            
            // Create New Account
            Account createdAccount = new Account();
            createdAccount.Name = o.Name;
            createdAccount.CurrencyIsoCode = 'SGD';
            
            system.debug('Role: '+ userInfo.getUserRoleId());
            system.debug('Role: '+ httrRoles.contains(userInfo.getUserRoleId()));
            //check if user role is related to HTTR, set HTTR record type for account 
            if(httrRoles != null && httrRoles.contains(userInfo.getUserRoleId())){
                createdAccount.RecordTypeId = label.AccountRecordTypeId_HTTR;
            }else{
                createdAccount.RecordTypeId = label.AccountRecordTypeId_Artmove;
            }
            
            createdAccount.BillingStreet = o.artApp__Address_1__c;
            createdAccount.BillingCity = o.artApp__City__c;
            createdAccount.BillingState = o.artApp__State_Province__c;
            createdAccount.BillingPostalCode = o.artApp__Zip_Postal_Code__c;
            createdAccount.BillingCountry = o.artApp__Country__c;
            createdAccount.ShippingStreet = o.artApp__Address_1__c;
            createdAccount.ShippingCity = o.artApp__City__c;
            createdAccount.ShippingState = o.artApp__State_Province__c;
            createdAccount.ShippingPostalCode = o.artApp__Zip_Postal_Code__c;
            createdAccount.ShippingCountry = o.artApp__Country__c;
            insert createdAccount;
            newAccountId = createdAccount.Id;            
            
            
            // Create this type of contact if record type not individual, institutional or private collector
            // o.RecordTypeId == '01220000000TzOSAA0' || 
            if (!(o.RecordTypeId == label.CollectorRecordTypeId_Individual || o.RecordTypeId == label.CollectorRecordTypeId_PrivateCollectorO || o.RecordTypeId == label.CollectorRecordTypeId_HTTR)) {
            
                // Instantiate the Contact object to put values for future record        
                Contact v = new Contact ();
                
                // Map Collector fields to the new Contact record                
                v.FirstName = o.artApp__Contact_First_Name__c;
                v.LastName = o.artApp__Contact_Last_Name__c;
                v.artAppE2__Middle_Name__c = o.artApp__Contact_Middle_Name__c;
                v.Title = o.artApp__Title__c;
                v.AccountId = newAccountId;            
                v.Email = o.artApp__Email__c;         
                v.Phone = o.artApp__Phone__c;
                v.MobilePhone = o.artApp__Mobile__c;
                v.Fax = o.artApp__Fax__c;
                v.Type__c = 'Others';
                
                //check if user role is related to HTTR, set HTTR record type for contact 
                if(httrRoles != null && httrRoles.contains(userInfo.getUserRoleId())){
                    v.RecordTypeId = label.ContactRecordTypeId_HTTR;
                }else{
                    v.RecordTypeId = label.ContactRecordTypeId_Artmove; 
                }
                
                v.MailingStreet = o.artApp__Address_1__c;
                v.MailingCity = o.artApp__City__c;
                v.MailingState = o.artApp__State_Province__c;
                v.MailingPostalCode = o.artApp__Zip_Postal_Code__c;
                v.MailingCountry = o.artApp__Country__c;
                
                // Once done, need to add this new record details to the list that would be later inserted.
                ct.add(v);
                //insert v;
            
            } // end of if check Collector condition
          
            // Else Let Contact name be Collector & Account name as well
            else {
                Contact v = new Contact ();
            
                // Map Collector fields to the new Contact record                       
                v.LastName = o.Name;
                v.AccountId = newAccountId;            
                v.Email = o.artApp__Email__c;         
                v.Phone = o.artApp__Phone__c;
                v.MobilePhone = o.artApp__Mobile__c;
                v.Fax = o.artApp__Fax__c;
                v.Type__c = 'Others';
                
                //check if user role is related to HTTR, set HTTR record type for contact 
                if(httrRoles != null && httrRoles.contains(userInfo.getUserRoleId())){
                    v.RecordTypeId = label.ContactRecordTypeId_HTTR; 
                }else{
                    v.RecordTypeId = label.ContactRecordTypeId_Artmove; 
                }
                
                v.MailingStreet = o.artApp__Address_1__c;
                v.MailingCity = o.artApp__City__c;
                v.MailingState = o.artApp__State_Province__c;
                v.MailingPostalCode = o.artApp__Zip_Postal_Code__c;
                v.MailingCountry = o.artApp__Country__c;
                
                // Once done, need to add this new record details to the list that would be later inserted.
                ct.add(v);
          
            }
          
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