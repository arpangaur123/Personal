trigger crateTrigger on Crate__c (after update , after insert) {    
    if (Trigger.isUpdate){
        Set<Id> setCrateIds = new Set<Id>();
        for(Crate__c crate : trigger.new){
            if(crate.Location__c != null){
                //system.debug('crate.Location__c'+crate.Location__c);
                //system.debug('crate.Id'+crate.Id);
                //system.debug('trigger.oldmap.get(crate.Id).Location__c'+trigger.oldmap.get(crate.Id).Location__c);
                if(trigger.oldmap.get(crate.Id).Location__c != null & !String.isBlank(trigger.oldmap.get(crate.Id).Location__c)){
                    if(crate.Location__c != trigger.oldmap.get(crate.Id).Location__c){
                        setCrateIds.add(crate.Id);
                    }
                }
            }
        }
        if(setCrateIds.size() > 0){
            //Code added by jatin singh at 25 Feb 2022
           // Database.executeBatch(new crateTriggerHelperBatch(setCrateIds), 50);
            System.enqueueJob(new crateTriggerHelperBatch(setCrateIds));
            //Code added by jatin singh at 25 Feb 2022
            
            //old code
            //update([Select Id From artApp__Artwork__c Where Crate__c IN:setCrateIds]);
            
            //List<String> newlist = new List<String>();
            
            
        }
    }
    
    //Code added by jatin singh
    if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate){
            List<Crate__c> cratelist = new List<Crate__c>();
            for(Crate__c crate: trigger.new){
                if(!crate.SourceRFID__c){
                    cratelist.add(crate);
                }
            }
            if(cratelist.size()>0){
                crateTriggerHandler.upsertCrate(cratelist);
            }
        }
        //if (Trigger.isUpdate){
        	//crateTriggerHandler.upsertCrate(trigger.new);
    	//}
    }
}