public with sharing class TransactionCloneWithLineItemsConExt {
    private Id pId;
    public artApp__Transaction__c tra {get; private set;}
    public String rt {get;set;}
    private list<SelectOption> options;
    
    public List<SelectOption> rtOptions { 
        get{
            if(options == null){
               options = new list<SelectOption>();
               for (RecordType rt: [select id, Name, DeveloperName, SobjectType
                                        from RecordType
                                        where IsActive = true
                                        and SobjectType = 'artApp__Transaction__c'
                                       ]){
                   options.add(new SelectOption(rt.Id, rt.Name));
               }
            }
            return options;
        }
    }
    
    public TransactionCloneWithLineItemsConExt(ApexPages.StandardController con) {
        this.pId = con.getId();
        this.tra = (artApp__Transaction__c)con.getRecord();

    }
    
    public PageReference onSave() {
        artApp__Transaction__c newTra = new artApp__Transaction__c(Payment_to_be_Collected__c = 0);
        if(rt != null){
            newTra.RecordtypeId = this.rt;
        }
        Database.insert(newTRa);
        
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe() ;
        
        List<artApp__Line_Item__c> newlineItems = new List<artApp__Line_Item__c>();
        for(artApp__Line_Item__c li : getLineItems(this.pId, gd)) {
            artApp__Line_Item__c newLi = li.clone(false, true);
            newLi.artApp__Transaction__c = newTra.Id;
            newlineItems.add(newLi);
        }
        Database.insert(newlineItems);
        
        
        List<Crate_Line_Item__c> newCrateLinks = new List<Crate_Line_Item__c>();
        for(Crate_Line_Item__c cl : getCrateLinks(this.pId, gd)) {
            Crate_Line_Item__c newCl = cl.clone(false, true);
            newCl.Transaction__c = newTra.Id;
            newCrateLinks.add(newCl);
        }
        Database.insert(newCrateLinks);
        
        
        
        return goBack(newTra.Id);
    }
    
    
    private static List<Crate_Line_Item__c> getCrateLinks(Id tId, Map<String, Schema.SObjectType> gd) {
        String sql = 'Select '
                     + getAllFields('Crate_Line_Item__c', gd )
                     + ' from Crate_Line_Item__c' 
                     + ' where Transaction__c = \'' + String.escapeSingleQuotes(tId) + '\''
                     + ' order by Name' ;                              
        System.debug('\n~~~sql: '+ sql);
        return Database.query(sql); 
    }
    
    
    private static List<artApp__Line_Item__c> getLineItems(Id tId, Map<String, Schema.SObjectType> gd) {
        String sql = 'Select '
                     + getAllFields('artApp__Line_Item__c', gd )
                     + ' from artApp__Line_Item__c' 
                     + ' where artApp__Transaction__c = \'' + String.escapeSingleQuotes(tId) + '\''
                     + ' order by Name' ;                              
        System.debug('\n~~~sql: '+ sql);
        return Database.query(sql); 
    }
    
    private static String getAllFields(String sObj,  Map<String, Schema.SObjectType> gd){
        System.debug( '\n~~~sObj: '+ sObj) ;
        Schema.SObjectType s = gd.get(sObj) ;
        Schema.DescribeSObjectResult r = s.getDescribe() ;
        Map<String, Schema.SObjectField> f = r.fields.getMap() ;
        String fields = '';
        Set<String> excludedFields = new Set<String>{'lastvieweddate', 'lastreferenceddate'};
        for (String o : f.keySet()){
            if(!excludedFields.contains(o.toLowerCase())){
                fields = fields + o + ', ';
            }     
        }
        Integer length = fields.length() - 2;
        String myFields = fields.substring(0,length);
        System.debug( '\n~~~Fields string is: '+ myFields ) ;
        return myFields;
    }
    
    public PageReference goBack(String tId){
        String backPage = tId != null?'/'+tId+'/e?retURL='+tId:'/home/home.jsp';
        PageReference page = new PageReference(backPage);
        page.setRedirect(true);
        return page;
    }

}