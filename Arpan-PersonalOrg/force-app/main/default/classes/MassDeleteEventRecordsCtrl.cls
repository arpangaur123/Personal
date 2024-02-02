public with sharing class MassDeleteEventRecordsCtrl{
    
    public List<RealtedOppLineWrap> realtedOppLineWrapList{get;set;}
    
    public string errorStr{get;set;}
    public string eventId;
    
    public MassDeleteEventRecordsCtrl(){
        
        errorStr = '';
        eventId = ApexPages.currentPage().getParameters().get('id');
        
        if(eventId != Null && eventId != ''){
            realtedOppLineWrapList = new List<RealtedOppLineWrap>();
            
            List<Event> eventList = new List<Event>([select id, Subject, StartDateTime, EndDateTime, WhatId
                                from Event where WhatId =: eventId]);
            
            if(eventList.size() > 0){
            
                for(Event eve : eventList){
                    
                    RealtedOppLineWrap wrap = new RealtedOppLineWrap();
                    wrap.isSelected = false;
                    wrap.event = eve;
                    
                    realtedOppLineWrapList.add(wrap);
                    
                }
            }else{
                errorStr = 'No Record to display.';
            }
            
        }
        
    }
    
    public pageReference deleteBtn(){
        pageReference pg = new pageReference('/apex/MassDeleteEventRecords?id='+eventId);
        
        List<Event> deletedRecordList = new List<Event>();
        for(RealtedOppLineWrap row : realtedOppLineWrapList){
            if(row.isSelected){
                deletedRecordList.add(row.event);
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
                    System.debug('getDmlFieldNames=' + ex.getDmlFieldNames(i));
                    System.debug('getDmlMessage=' + ex.getDmlMessage(i));  
                    errorStr += ex.getDmlFieldNames(i) + ', ';
                    errorStr += ex.getDmlMessage(i) + ', ';
                }
                
                return null;
            }
        }
        
        return null;
        
    }
    
    public pageReference backButton(){
        
        pageReference pg = new pageReference('/'+eventId);
        
        pg.setRedirect(true);
        return pg;
    
    }
    
    public class RealtedOppLineWrap{
        
        public boolean isSelected{get;set;}
        public Event event{get;set;}
    
    }
    
}