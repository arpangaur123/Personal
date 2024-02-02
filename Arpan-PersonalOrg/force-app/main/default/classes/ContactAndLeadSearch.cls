/*public class ContactAndLeadSearch {
    public static list<list<Sobject>> searchContactsAndLeads(String searchText){
             String soslFindClause = 'searchText';
    List<List<sObject>> searchList = [FIND :soslFindClause IN ALL FIELDS
                        RETURNING Contact(FirstName,LastName),
                                      Lead(FirstName,LastName)];
  Contact[] searchContacts = (Contact[])searchList[0];
    Lead[] searchLeads = (Lead[])searchList[1];
    System.debug('Found the following Contacts.');
    for (Contact c : searchContacts) {
        System.debug(c.LastName + ', ' + c.FirstName);
    }
    System.debug('Found the following Leads.');
    for (Lead l : searchLeads) {
        
}
    return searchList;
    }

}*/

public class ContactAndLeadSearch {

    public static List<List< sObject>> searchContactsAndLeads(String LastName){
        List<List< sObject>> listObj=[FIND :LastName IN ALL FIELDS RETURNING Contact(Name,LastName),Lead(Name,LastName)];
        return listObj;
    }
}