public class SearchableComboBoxController {
    @AuraEnabled
    public static List<Opportunity> feachOpportunity(string searchKey){
        string query ='';
        system.debug('searchKey'+searchKey);
        if(searchKey == null){
            system.debug('in null');
            query = 'SELECT Id, Name, Account.Name from Opportunity limit 5';
        }
        else if(!string.isEmpty(searchKey) &&  searchKey != null){
            system.debug('In nut empty');
            string searchvalue = '%'+searchKey+'%';
            query = 'SELECT Id, Name, Account.Name from Opportunity  WHERE Name like :searchvalue ORDER by CreatedDate limit 5';
        }
       system.debug('query'+Database.query(query));
        return Database.query(query);
    }
}