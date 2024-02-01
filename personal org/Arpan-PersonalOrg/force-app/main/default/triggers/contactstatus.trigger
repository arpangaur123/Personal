trigger contactstatus on Contact (after insert, after update, after delete, after undelete) {
    
    if(trigger.isafter){
        if(trigger.isinsert || trigger.isupdate || trigger.isundelete){
            for(Contact con:trigger.new){
                
            }
        }
        
        if(trigger.isupdate || trigger.isdelete){
            for(Contact con:trigger.old){
                
            }
        }
    }

}