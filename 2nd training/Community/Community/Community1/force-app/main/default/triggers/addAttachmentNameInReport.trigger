trigger addAttachmentNameInReport on Attachment (after delete, after insert, after undelete, after update){
   Set<ID> oppIdSet =new Set<id>();
    Set<ID> jobrefIdSet =new Set<id>();
    Set<ID> artworkIdSet =new Set<id>();
    Map<Id,Opportunity> oppMap ;
    Map<Id,Job_Reference__c> jobrefMap ;
    Map<Id,artApp__Artwork__c> artworkMap ;
    if(trigger.isInsert || trigger.isUpdate){
        for(Attachment a: Trigger.new){
            String objName = a.parentId.getSObjectType().getDescribe().getName();
            if(objName == 'Opportunity'){
                oppIdSet.add(a.parentid);
            }
            else if(objName== 'job_reference__c'){
                jobrefIdSet.add(a.parentid);
            }
            else if(objName== 'artApp__Artwork__c'){
                 artworkIdSet.add(a.parentid);
            }
        }
     }
     if(trigger.isdelete){
            for(Attachment a: Trigger.old){
                String objName = a.parentId.getSObjectType().getDescribe().getName();
                if(objName == 'Opportunity'){
                    oppIdSet.add(a.parentid);
                }
                else if(objName== 'job_reference__c'){
                    jobrefIdSet.add(a.parentid);
                }
                else if(objName== 'artApp__Artwork__c'){
                     artworkIdSet.add(a.parentid);
                }
            }
     }
        
    if(trigger.isInsert || trigger.isUpdate){
        system.debug('Inside if ');
        if(oppIdSet.size() > 0 ){
            oppMap = new Map<Id,Opportunity>([select Id,Attachment__c from Opportunity where Id IN: oppIdSet]);
            if(oppMap.size() > 0 ){
                for(Attachment att : Trigger.new){
                    if(oppMap.get(att.parentId) != null){
                        if(oppMap.get(att.parentId).Attachment__c != null && oppMap.get(att.parentId).Attachment__c != ''){
                            if(Trigger.isInsert){
                                system.debug('Opp insert');
                                oppMap.get(att.parentId).Attachment__c += +'\n' +att.Name;
                            }
                            else if(Trigger.isUpdate){
                                system.debug('Updateeeee === ');
                                system.debug('$$$$$$'+ Trigger.oldMap.get(att.Id).Name);
                                system.debug('value of new name'+ att.Name);
                                if(Trigger.oldMap.get(att.Id).Name != att.Name && oppMap.get(att.parentId).Attachment__c.contains(Trigger.oldMap.get(att.Id).Name)){
                                    oppMap.get(att.parentId).Attachment__c = oppMap.get(att.parentId).Attachment__c.replaceFirst(Trigger.oldMap.get(att.Id).Name,att.Name);
                                    system.debug('Old Name=== '+Trigger.oldMap.get(att.Id).Name);
                                    system.debug('Assingd Name === '+oppMap.get(att.parentId).Attachment__c);
                                }
                            }
                        }
                        else{
                             oppMap.get(att.parentId).Attachment__c = string.escapeSingleQuotes(att.Name);
                        }
                    }
                }
                system.debug('Update Attachment --->'+oppMap.values());
            // update oppMap.values();
			 Database.SaveResult[] srList = Database.update(oppMap.values(), false);

			 
            }
        }
        if(jobrefIdSet.size()>0){
            jobrefMap = new Map<Id,job_reference__c>([select Id,Attachment__c from job_reference__c where Id IN: jobrefIdSet]);
            if(jobrefMap.size() > 0 ){
                for(Attachment att : Trigger.new){
                    if(jobrefMap.get(att.parentId) != null){
                        if(jobrefMap.get(att.parentId).Attachment__c != null && jobrefMap.get(att.parentId).Attachment__c != ''){
                            if(Trigger.isInsert){
                                jobrefMap.get(att.parentId).Attachment__c += +'\n' +att.Name;
                            }
                            else if(Trigger.isUpdate){
                                system.debug('Updateeeee === ');
                                if(Trigger.oldMap.get(att.Id).Name != att.Name && jobrefMap.get(att.parentId).Attachment__c.contains(Trigger.oldMap.get(att.Id).Name)){
                                    jobrefMap.get(att.parentId).Attachment__c = jobrefMap.get(att.parentId).Attachment__c.replaceFirst(Trigger.oldMap.get(att.Id).Name,att.Name);
                                    system.debug('Old Name=== '+Trigger.oldMap.get(att.Id).Name);
                                    system.debug('Assingd Name === '+jobrefMap.get(att.parentId).Attachment__c);
                                }
                            }
                        }
                        else{
                            jobrefMap.get(att.parentId).Attachment__c = string.escapeSingleQuotes(att.Name);
                        }
                    }
                }
                
               //  update jobrefMap.values();
			   Database.SaveResult[] srList = Database.update(jobrefMap.values(), false);
            }
        }
        if(artworkIdSet.size()>0){
            artworkMap = new Map<Id,artApp__Artwork__c>([select Id,Attachment__c from artApp__Artwork__c where Id IN: artworkIdSet]);
            if(artworkMap.size() > 0 ){
                for(Attachment att : Trigger.new){
                    if(artworkMap.get(att.parentId) != null){
                        if(artworkMap.get(att.parentId).Attachment__c != null && artworkMap.get(att.parentId).Attachment__c != ''){
                            if(Trigger.isInsert){
                                artworkMap.get(att.parentId).Attachment__c += +'\n' +att.Name;
                            }
                            else if(Trigger.isUpdate){
                                system.debug('Updateeeee === ');
                                if(Trigger.oldMap.get(att.Id).Name != att.Name && artworkMap.get(att.parentId).Attachment__c.contains(Trigger.oldMap.get(att.Id).Name)){
                                    artworkMap.get(att.parentId).Attachment__c = artworkMap.get(att.parentId).Attachment__c.replaceFirst(Trigger.oldMap.get(att.Id).Name,att.Name);
                                    system.debug('Old Name=== '+Trigger.oldMap.get(att.Id).Name);
                                    system.debug('Assingd Name === '+artworkMap.get(att.parentId).Attachment__c);
                                }
                            }
                        }
                        else{
                            artworkMap.get(att.parentId).Attachment__c = string.escapeSingleQuotes(att.Name);
                        }
                    }
                }
            // update artworkMap.values();
             Database.SaveResult[] srList = Database.update(artworkMap.values(), false);
			}
        }
    }
    else if(Trigger.isDelete){
        if(oppIdSet.size() > 0 ){
        system.debug('Opp Size'+oppIdSet.size());
            oppMap = new Map<Id,Opportunity>([select Id,Attachment__c from Opportunity where Id IN: oppIdSet]);
            
            Integer index = 0;              //added on 15/07/2020
            Boolean isduplicate = false;    //added on 15/07/2020
            Integer count  = 0 ;            //added on 15/07/2020
            Integer i  = 0 ;                //added on 15/07/2020
            
            if(oppMap.size() > 0 ){
                for(Attachment att : Trigger.old){
                    if(oppMap.get(att.parentId).attachment__c != null && oppMap.get(att.parentId).attachment__c != '' && oppMap.get(att.parentId).Attachment__c.contains(Trigger.oldMap.get(att.Id).Name)){
                        
                        /****************************added on 15/07/2020********************************************/
                        isduplicate = false;
                        if(oppMap.get(att.parentId).Attachment__c.contains('\n')){
                            
                            index = 0;
                            count = 0;
                            i=0;
                            list<String> strlst = oppMap.get(att.parentId).Attachment__c.split('\n');
                            for(String str : strlst){
                                if(str.contains(Trigger.oldMap.get(att.Id).Name)){
                                    count++;
                                    index=i;
                                }
                                i++;
                            }
                            if(count > 1){
                                isduplicate = true;
                                strlst.remove(index);
                                oppMap.get(att.parentId).attachment__c = String.join(strlst, '\n');
                            }
                        }
                        /**************************************************End on 15/07/2020*************************************/
                        
                        if(!isduplicate)
                            oppMap.get(att.parentId).attachment__c = oppMap.get(att.parentId).attachment__c.replace(Trigger.oldMap.get(att.Id).Name,'');
                    }
                }
                   // Update oppMap.values();
					Database.SaveResult[] srList = Database.update(oppMap.values(), false);
			}
        }
        if(jobrefIdSet.size()>0){
            jobrefMap = new Map<Id,job_reference__c>([select Id,Attachment__c from job_reference__c where Id IN: jobrefIdSet]);
            if(jobrefMap.size() > 0 ){
                for(Attachment att : Trigger.old){
                    if(jobrefMap.get(att.parentId).attachment__c != null && jobrefMap.get(att.parentId).attachment__c != '' && jobrefMap.get(att.parentId).Attachment__c.contains(Trigger.oldMap.get(att.Id).Name)){
                        jobrefMap.get(att.parentId).attachment__c = jobrefMap.get(att.parentId).attachment__c.replace(Trigger.oldMap.get(att.Id).Name,'');
                    }
                }
                   // update jobrefMap.values();
					Database.SaveResult[] srList = Database.update(jobrefMap.values(), false);	
		   }
        }
        if(artworkIdSet.size()>0){
            artworkMap = new Map<Id,artApp__Artwork__c>([select Id,Attachment__c from artApp__Artwork__c where Id IN: artworkIdSet]);
            if(artworkMap.size() > 0 ){
                for(Attachment att : Trigger.old){
                    if(artworkMap.get(att.parentId).attachment__c != null && artworkMap.get(att.parentId).attachment__c != '' && artworkMap.get(att.parentId).Attachment__c.contains(Trigger.oldMap.get(att.Id).Name)){
                        artworkMap.get(att.parentId).attachment__c = artworkMap.get(att.parentId).attachment__c.replace(Trigger.oldMap.get(att.Id).Name,'');
                    }
                }
                    update artworkMap.values();
				Database.SaveResult[] srList = Database.update(artworkMap.values(), false);		
            }
        }
    }
}