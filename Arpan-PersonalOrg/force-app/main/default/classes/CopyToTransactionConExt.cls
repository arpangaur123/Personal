public with sharing class CopyToTransactionConExt extends DynamicListController {
    private List<ArtworkWrapper> artworks;
    Map<Id, ArtworkWrapper> selectedArtworkMap;
    public List<ArtworkWrapper> selectedArtworks {get{return selectedArtworkMap.values();}}
    
    public CopyToTransactionConExt(ApexPages.StandardSetController con) {
        super('Select Id, name, artApp__Artist__c, Barcode_ID__c, Part_of__c, Lot_No__c, Item_No__c, Dimensions__c, Bond_Status__c, artApp__Primary_Image__c'// + getAllFields('artApp__Artwork__c', gd )
            +' from artApp__Artwork__c '
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
        if(this.artworks == null){this.artworks = new List<ArtworkWrapper>();}
        if(selectedArtworkMap == null){selectedArtworkMap = new Map<Id, ArtworkWrapper>();}
    }
    
    public List<ArtworkWrapper> getArtworks() {
        this.artworks.clear();
        for (artApp__Artwork__c a : (List<artApp__Artwork__c>) getRecords()){
            if(!selectedArtworkMap.containsKey(a.Id)){
                artworks.add(new ArtworkWrapper(a));
            }
        }
        return artworks;
    }
    
    private static String getWhere(){
        String whereClause = ' and Is_Unavailable__c = false ';
        Id wId =  ApexPages.CurrentPage().getParameters().get('id');
        if(wId != null){
            System.debug('object is '+ wId.getsobjecttype());
            String oName = wId.getsobjecttype().getDescribe().getName();
            System.debug('oName is '+ oName);
            if(oName == 'Job_Reference__c'){
                whereClause += ' and Job_Reference__c = \'' + String.escapeSingleQuotes(wId) + '\'';
            }else if(oName == 'artApp__Collector__c'){
                whereClause += ' and artApp__Collector__c = \'' + String.escapeSingleQuotes(wId) + '\'';
            }            
        }
        return whereClause;
    }
    
    
    
    public PageReference addSelected() {
        for (ArtworkWrapper a :artworks) {
            if (a.isSelected){
                selectedArtworkMap.put(a.Artwork.Id,a);
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,a.artwork.name + ' added.'));
            }
        }
        return null;
    }
    
    public class ArtworkWrapper{
        public Boolean isSelected {get; set;}
        public artApp__Artwork__c artwork {get; private set;}
        
        public ArtworkWrapper(artApp__Artwork__c a){
            artwork = a;
            isSelected = true;    
        }  
    }
    
    public PageReference copyArtwork() {
        //System.debug('~~~selectedArtworkMap '+ selectedArtworkMap);
        //System.debug('~~~this.t.artApp__Transaction__c '+ this.t.artApp__Transaction__c);
        List<artApp__Line_Item__c> lineItems = new List<artApp__Line_Item__c>();
        for (ArtworkWrapper a :selectedArtworks) {
            lineItems.add(new artApp__Line_Item__c(artApp__Transaction__c = this.t.artApp__Transaction__c, 
                                                   artApp__Artwork__c = a.artwork.Id
                                                  ));   
        }
        //System.debug('~~~lineItems '+ lineItems);
        Database.insert(lineItems);
        
        return cancel();
    }

}