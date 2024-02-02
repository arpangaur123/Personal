public with sharing class CopyCrateToTransactionConExt extends DynamicListController {
    private List<CrateWrapper> crates;
    Map<Id, CrateWrapper> selectedCrateMap;
    public List<CrateWrapper> selectedCrates {get{return selectedCrateMap.values();}}

    public CopyCrateToTransactionConExt(ApexPages.StandardSetController con) {
        super('Select ' + getAllFields('Crate__c', gd )
            +' from Crate__c '
            +' where IsDeleted = false '
            +getWhere()
            ); 
        this.selectAll = true;
        this.pId =  ApexPages.CurrentPage().getParameters().get('id');
        if(this.pId != null){
            System.debug('object is '+ pId.getsobjecttype());
            this.objectLabel = pId.getsobjecttype().getDescribe().getLabel();
            this.objectName =  pId.getsobjecttype().getDescribe().getName();
        }
        this.t = new artApp__Line_Item__c();
        if(this.crates == null){this.crates = new List<CrateWrapper>();}
        if(selectedCrateMap == null){selectedCrateMap = new Map<Id, CrateWrapper>();}
    }
    
    private static String getWhere(){
        String whereClause = ' ';
        Id wId =  ApexPages.CurrentPage().getParameters().get('id');
        if(wId != null){
            System.debug('object is '+ wId.getsobjecttype());
            String oName = wId.getsobjecttype().getDescribe().getName();
            System.debug('oName is '+ oName);
            if(oName == 'Job_Reference__c'){
                whereClause += ' and Job_Reference__c = \'' + String.escapeSingleQuotes(wId) + '\'';
            }else if(oName == 'artApp__Collector__c'){
                whereClause += ' and myCollector__c = \'' + String.escapeSingleQuotes(wId) + '\'';
            }            
        }
        return whereClause;
    }
    
    public PageReference addSelected() {        
        for (CrateWrapper a :crates) {
            if (a.isSelected){
                selectedCrateMap.put(a.Crate.Id,a);
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,a.crate.name + ' added.'));
            }
        }
        return null;
    }
    
    public List<CrateWrapper> getCrates() {
        this.crates.clear();
        
        for (Crate__c a : (List<Crate__c>) getRecords()){
            if(!selectedCrateMap.containsKey(a.Id)){
                crates.add(new CrateWrapper(a));
            }
        }
        
        return crates;
    }
    
    public class CrateWrapper{
        public Boolean isSelected {get; set;}
        public Crate__c crate {get; private set;}
        
        public CrateWrapper(Crate__c a){
            crate = a;
            isSelected = true;    
        }  
    }
    
    public PageReference copyCrates() {
        System.debug('~~~selectedCrateMap '+ selectedCrateMap);
        System.debug('~~~this.t.artApp__Transaction__c '+ this.t.artApp__Transaction__c);
        List<Crate_Line_Item__c > lineItems = new List<Crate_Line_Item__c >();
        for (CrateWrapper a :selectedCrates ) {
            lineItems.add(new Crate_Line_Item__c(Transaction__c = this.t.artApp__Transaction__c, 
                                                 Crate__c = a.crate.Id
                                                ));   
        }
        System.debug('~~~lineItems '+ lineItems);
        Database.insert(lineItems);
        
        return cancel();
    }

}