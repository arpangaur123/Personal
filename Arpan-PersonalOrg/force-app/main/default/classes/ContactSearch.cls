public class ContactSearch {
    public static list<contact> searchForContacts(string lastname , string postalcode ){
     list<contact> foundcontact = [ select
                                   Id,
                                   Name,
                                   MailingPostalCode 
                                   from contact 
                                   where 
                                   lastname=:lastname and 
                                   MailingPostalCode=:postalcode];   
        return foundcontact;
    }
    

}