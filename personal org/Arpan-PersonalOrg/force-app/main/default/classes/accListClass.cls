public class accListClass{
    @AuraEnabled 
    public List<OpportunityLineItem> accList = new List<OpportunityLineItem>();
    
    @AuraEnabled 
    public List<OpportunityLineItem> delRec = new List<OpportunityLineItem>();
    
    @AuraEnabled 
    public static List<OpportunityLineItem> getAccounts(String query)
    {
        accListClass alc = new accListClass();
        
        alc.accList = Database.query('SELECT Id,Name from OpportunityLineItem');
                
        return alc.accList;
    }
   
    @AuraEnabled 
    public static List<OpportunityLineItem> delSlctRec(List<String> slctRec)
    {
        accListClass alc = new accListClass();
        alc.delRec = [SELECT Id FROM OpportunityLineItem WHERE Id IN: slctRec ];
       try{
           delete alc.delRec;
           } catch(Exception ex)
          {
             throw new AuraHandledException(ex.getMessage());
          }
        alc.accList = Database.query('SELECT Id,Name from OpportunityLineItem');
                
        return alc.accList;
       
    }
}