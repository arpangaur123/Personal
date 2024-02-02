public class MassDeleteRecordsEvent {
    
    public List<RealtedJobRefWrap> realtedJobRefWrapList{get;set;}
    
    public string errorStr{get;set;}
    public string oppId;
    
    public MassDeleteRecordsEvent(){
        realtedJobRefWrapList = new List<RealtedJobRefWrap>();
        errorStr = '';
        oppId = ApexPages.currentPage().getParameters().get('id');
        
        if(oppId != Null && oppId != ''){
            
            List<OpportunityLineItem> oppLineList = new List<OpportunityLineItem>([select id, name, opportunityId, Product2.Name, 
                                                                                   Product2Id, Quantity, UnitPrice, ServiceDate, Description
                                                                                   from OpportunityLineItem where opportunityId =: oppId]);
            
            if(oppLineList.size() > 0){
                
                for(OpportunityLineItem oppLineItem : oppLineList){
                    
                    RealtedJobRefWrap wrap = new RealtedJobRefWrap();
                    wrap.isSelected = false;
                    wrap.oppLine = oppLineItem;
                    
                    realtedJobRefWrapList.add(wrap);
                    
                }
            }else{
                errorStr = 'No Record to display.';
            }
        }
        
    }
    
    public pageReference deleteBtn(){
        pageReference pg = new pageReference('/apex/MassDeleteRecords?id='+oppId);
        
        List<OpportunityLineItem> deletedRecordList = new List<OpportunityLineItem>();
        if(realtedJobRefWrapList.size() >0){
            for(RealtedJobRefWrap row : realtedJobRefWrapList){
                if(row.isSelected){
                    deletedRecordList.add(row.oppLine);
                }
            }
        }
        if(deletedRecordList.size() > 0){
            try{
                delete deletedRecordList;
                
                pg.setRedirect(true);
                return pg;
            }catch(DMLException ex){
                Integer numErrors = ex.getNumDml();
                
                for(Integer i=0; i<numErrors; i++) {
                    errorStr += ex.getDmlFieldNames(i) + ', ';
                    errorStr += ex.getDmlMessage(i) + ', ';
                }
                
                return null;
            }
        }
        
        return null;
        
    }
    
    public pageReference backButton(){
        
        pageReference pg = new pageReference('/'+oppId);
        
        pg.setRedirect(true);
        return pg;
        
    }
    
    public class RealtedJobRefWrap{
        
        public boolean isSelected{get;set;}
        public OpportunityLineItem oppLine{get;set;}
        
    }
    
}