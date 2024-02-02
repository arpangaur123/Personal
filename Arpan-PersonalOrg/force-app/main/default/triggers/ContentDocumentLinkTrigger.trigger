trigger ContentDocumentLinkTrigger on ContentDocumentLink (after insert,after update, before delete) {
	System.debug('file uploaded here <<<<< please check.');
    
    Set<Id> oppIdSet =new Set<Id>();
    Set<ID> jobrefIdSet =new Set<id>();
    Set<ID> artworkIdSet =new Set<id>();
    Map<Id, Opportunity> oppMap;
    Map<Id,Job_Reference__c> jobrefMap ;
    Map<Id,artApp__Artwork__c> artworkMap ;
    Set<Id> deleteIdSet2 =new Set<Id>();
    Set<Id> documrntIdSet =new Set<Id>();
    
    
       
    if(trigger.isInsert || Trigger.isUpdate){
        
        Set<Id> contentDocumentIdSet = new Set<Id>();
      
        for(ContentDocumentLink link: trigger.new){
            String objName = link.LinkedEntityId.getSObjectType().getDescribe().getName();
            deleteIdSet2.add(link.id);
            if(objName == 'Opportunity'){
                oppIdSet.add(link.LinkedEntityId);
            }
            else if(objName== 'job_reference__c'){
                jobrefIdSet.add(link.LinkedEntityId);
            }
            else if(objName== 'artApp__Artwork__c'){
                 artworkIdSet.add(link.LinkedEntityId);
            }
        }
        
        
    }
    if(trigger.isdelete){
        for(ContentDocumentLink link: Trigger.old){
            String objName = link.LinkedEntityId.getSObjectType().getDescribe().getName();
            deleteIdSet2.add(link.Id);
            documrntIdSet.add(link.ContentDocumentId);
            if(objName == 'Opportunity'){
                oppIdSet.add(link.LinkedEntityId);
            }
            else if(objName== 'job_reference__c'){
                jobrefIdSet.add(link.LinkedEntityId);
            }
            else if(objName== 'artApp__Artwork__c'){
                artworkIdSet.add(link.LinkedEntityId);
            }
        }
    }
    if(trigger.isInsert || trigger.isUpdate){
        system.debug('Inside if ');
        if(oppIdSet.size() > 0 ){
            oppMap = new Map<Id,Opportunity>([select Id,Attachment__c from Opportunity where Id IN: oppIdSet]);
            if(oppMap.size() > 0 ){
                for(ContentDocumentLink att : [SELECT Id, LinkedEntityId, ContentDocumentId, IsDeleted,ContentDocument.Title, ContentDocument.FileExtension FROM 
                                               ContentDocumentLink where Id IN:deleteIdSet2]){
                                                   if(oppMap.get(att.LinkedEntityId) != null){
                                                       if(oppMap.get(att.LinkedEntityId).Attachment__c != null && oppMap.get(att.LinkedEntityId).Attachment__c != ''){
                                                           if(Trigger.isInsert){
                                                               system.debug('Opp insert');
                                                               oppMap.get(att.LinkedEntityId).Attachment__c += +'\n' +att.ContentDocument.Title + '.' + att.ContentDocument.FileExtension;
                                                           }
                                                           else if(Trigger.isUpdate){
                                                               system.debug('Updateeeee === ');
                                                               String oldtiltle = Trigger.oldMap.get(att.Id).ContentDocument.Title + '.' + Trigger.oldMap.get(att.Id).ContentDocument.FileExtension;
                                                               String newtiltle = Trigger.oldMap.get(att.Id).ContentDocument.Title + '.' + Trigger.oldMap.get(att.Id).ContentDocument.FileExtension;
                                                               system.debug('oldtiltle$$$$$$'+ oldtiltle);
                                                               system.debug('newtiltle name#######'+newtiltle);
                                                               if(oldtiltle != newtiltle && oppMap.get(att.LinkedEntityId).Attachment__c.contains(oldtiltle)){
                                                                   oppMap.get(att.LinkedEntityId).Attachment__c = oppMap.get(att.LinkedEntityId).Attachment__c.replaceFirst(oldtiltle,newtiltle);
                                                                   system.debug('Old Name=== '+newtiltle);
                                                                   system.debug('Assingd Name === '+oppMap.get(att.LinkedEntityId).Attachment__c);
                                                               }
                                                           }
                                                       }
                                                       else{
                                                           oppMap.get(att.LinkedEntityId).Attachment__c = string.escapeSingleQuotes(att.ContentDocument.Title + '.' + att.ContentDocument.FileExtension);
                                                       }
                                                   }
                                               }
                
                system.debug('Update Attachment --->'+oppMap.values());
                // update oppMap.values();
                Database.SaveResult[] srList = Database.update(oppMap.values(), false);
                
            }
        }
        if(jobrefIdSet.size() > 0 ){
            jobrefMap = new Map<Id,job_reference__c>([select Id,Attachment__c from job_reference__c where Id IN: jobrefIdSet]);
            if(jobrefMap.size() > 0 ){
                for(ContentDocumentLink att : [SELECT Id, LinkedEntityId, ContentDocumentId, IsDeleted,ContentDocument.Title, ContentDocument.FileExtension FROM 
                                               ContentDocumentLink where Id IN:deleteIdSet2]){
                                                   if(jobrefMap.get(att.LinkedEntityId) != null){
                                                       if(jobrefMap.get(att.LinkedEntityId).Attachment__c != null && jobrefMap.get(att.LinkedEntityId).Attachment__c != ''){
                                                           if(Trigger.isInsert){
                                                               system.debug('Opp insert');
                                                               jobrefMap.get(att.LinkedEntityId).Attachment__c += +'\n' +att.ContentDocument.Title + '.' + att.ContentDocument.FileExtension;
                                                           }
                                                           else if(Trigger.isUpdate){
                                                               system.debug('Updateeeee === ');
                                                               String oldtiltle = Trigger.oldMap.get(att.Id).ContentDocument.Title + '.' + Trigger.oldMap.get(att.Id).ContentDocument.FileExtension;
                                                               String newtiltle = Trigger.oldMap.get(att.Id).ContentDocument.Title + '.' + Trigger.oldMap.get(att.Id).ContentDocument.FileExtension;
                                                               system.debug('oldtiltle$$$$$$'+ oldtiltle);
                                                               system.debug('newtiltle name#######'+newtiltle);
                                                               if(oldtiltle != newtiltle && oppMap.get(att.LinkedEntityId).Attachment__c.contains(oldtiltle)){
                                                                   jobrefMap.get(att.LinkedEntityId).Attachment__c = jobrefMap.get(att.LinkedEntityId).Attachment__c.replaceFirst(oldtiltle,newtiltle);
                                                                   system.debug('Old Name=== '+newtiltle);
                                                                   system.debug('Assingd Name === '+oppMap.get(att.LinkedEntityId).Attachment__c);
                                                               }
                                                           }
                                                       }
                                                       else{
                                                           jobrefMap.get(att.LinkedEntityId).Attachment__c = string.escapeSingleQuotes(att.ContentDocument.Title + '.' + att.ContentDocument.FileExtension);
                                                       }
                                                   }
                                               }
                
                system.debug('Update Attachment --->'+jobrefMap.values());
                // update jobrefMap.values();
                Database.SaveResult[] srList = Database.update(jobrefMap.values(), false);
                
            }
        }
        if(artworkIdSet.size()>0){
            artworkMap = new Map<Id,artApp__Artwork__c>([select Id,Attachment__c from artApp__Artwork__c where Id IN: artworkIdSet]);
            for(ContentDocumentLink att : [SELECT Id, LinkedEntityId, ContentDocumentId, IsDeleted,ContentDocument.Title, ContentDocument.FileExtension FROM 
                                           ContentDocumentLink where Id IN:deleteIdSet2]){
                                               if(artworkMap.get(att.LinkedEntityId) != null){
                                                   if(artworkMap.get(att.LinkedEntityId).Attachment__c != null && artworkMap.get(att.LinkedEntityId).Attachment__c != ''){
                                                       if(Trigger.isInsert){
                                                           system.debug('Opp insert');
                                                           artworkMap.get(att.LinkedEntityId).Attachment__c += +'\n' +att.ContentDocument.Title + '.' + att.ContentDocument.FileExtension;
                                                       }
                                                       else if(Trigger.isUpdate){
                                                           system.debug('Updateeeee === ');
                                                           String oldtiltle = Trigger.oldMap.get(att.Id).ContentDocument.Title + '.' + Trigger.oldMap.get(att.Id).ContentDocument.FileExtension;
                                                           String newtiltle = Trigger.oldMap.get(att.Id).ContentDocument.Title + '.' + Trigger.oldMap.get(att.Id).ContentDocument.FileExtension;
                                                           system.debug('oldtiltle$$$$$$'+ oldtiltle);
                                                           system.debug('newtiltle name#######'+newtiltle);
                                                           if(oldtiltle != newtiltle && artworkMap.get(att.LinkedEntityId).Attachment__c.contains(oldtiltle)){
                                                               artworkMap.get(att.LinkedEntityId).Attachment__c = artworkMap.get(att.LinkedEntityId).Attachment__c.replaceFirst(oldtiltle,newtiltle);
                                                               system.debug('Old Name=== '+newtiltle);
                                                               system.debug('Assingd Name === '+artworkMap.get(att.LinkedEntityId).Attachment__c);
                                                           }
                                                       }
                                                   }
                                                   else{
                                                       artworkMap.get(att.LinkedEntityId).Attachment__c = string.escapeSingleQuotes(att.ContentDocument.Title + '.' + att.ContentDocument.FileExtension);
                                                   }
                                               }
                                           }
            
            system.debug('Update Attachment --->'+artworkMap.values());
            // update artworkMap.values();
            Database.SaveResult[] srList = Database.update(artworkMap.values(), false);
        }
    }
    else if(Trigger.isDelete){
        if(oppIdSet.size() > 0 ){
            system.debug('Opp Size'+oppIdSet.size());
            oppMap = new Map<Id,Opportunity>([select Id,Attachment__c from Opportunity where Id IN: oppIdSet]);
            if(oppMap.size() > 0 ){
                
                System.debug('deleteIdSet2--->>>>'+deleteIdSet2);
                System.debug('deleteIdSet2-3-->>>>'+[SELECT Id,Title,FileExtension FROM 
                                                     ContentDocument where Id IN:documrntIdSet]);
                map<Id,String> map2add = new map<Id,String>();
                for(ContentDocument con : [SELECT Id,Title,FileExtension FROM ContentDocument where Id IN:documrntIdSet]){
                    String oldtiltle = con.Title + '.' + con.FileExtension;
                    map2add.put(con.id,oldtiltle);
                }
                for(ContentDocumentLink att : [SELECT Id, LinkedEntityId, ContentDocumentId, IsDeleted,ContentDocument.Title, ContentDocument.FileExtension FROM 
                                               ContentDocumentLink where Id IN:deleteIdSet2]){
                                                   
                                                   
                                                   System.debug('oldtiltle--->>>>'+map2add.get(att.ContentDocumentId));
                                                   String oldtiltle = map2add.get(att.ContentDocumentId);
                                                   System.debug('oldtiltle-12-->>>>'+oppMap.get(att.LinkedEntityId).Attachment__c.contains(oldtiltle));
                                                   if(oppMap.get(att.LinkedEntityId).attachment__c != null && oppMap.get(att.LinkedEntityId).attachment__c != '' && oppMap.get(att.LinkedEntityId).Attachment__c.contains(oldtiltle)){
                                                       System.debug('oldtiltle--->>>>'+map2add.get(att.ContentDocumentId));
                                                       oppMap.get(att.LinkedEntityId).attachment__c = oppMap.get(att.LinkedEntityId).attachment__c.replace(oldtiltle,'');
                                                       System.debug('oldtiltle--->>>>'+oppMap);
                                                   }
                                               }
                // Update oppMap.values();
                Database.SaveResult[] srList = Database.update(oppMap.values(), false);
            }
        }
        if(jobrefIdSet.size() > 0 ){
            system.debug('Job Size'+jobrefIdSet.size());
            jobrefMap = new Map<Id,job_reference__c>([select Id,Attachment__c from job_reference__c where Id IN: jobrefIdSet]);
            if(jobrefMap.size() > 0 ){
                
                System.debug('deleteIdSet2--->>>>'+deleteIdSet2);
                System.debug('deleteIdSet2-3-->>>>'+[SELECT Id,Title,FileExtension FROM 
                                                     ContentDocument where Id IN:documrntIdSet]);
                map<Id,String> map2add = new map<Id,String>();
                for(ContentDocument con : [SELECT Id,Title,FileExtension FROM ContentDocument where Id IN:documrntIdSet]){
                    String oldtiltle = con.Title + '.' + con.FileExtension;
                    map2add.put(con.id,oldtiltle);
                }
                for(ContentDocumentLink att : [SELECT Id, LinkedEntityId, ContentDocumentId, IsDeleted,ContentDocument.Title, ContentDocument.FileExtension FROM 
                                               ContentDocumentLink where Id IN:deleteIdSet2]){
                                                   
                                                   
                                                   System.debug('oldtiltle--->>>>'+map2add.get(att.ContentDocumentId));
                                                   String oldtiltle = map2add.get(att.ContentDocumentId);
                                                   System.debug('oldtiltle-12-->>>>'+jobrefMap.get(att.LinkedEntityId).Attachment__c.contains(oldtiltle));
                                                   if(jobrefMap.get(att.LinkedEntityId).attachment__c != null && jobrefMap.get(att.LinkedEntityId).attachment__c != '' && jobrefMap.get(att.LinkedEntityId).Attachment__c.contains(oldtiltle)){
                                                       System.debug('oldtiltle--->>>>'+map2add.get(att.ContentDocumentId));
                                                       jobrefMap.get(att.LinkedEntityId).attachment__c = jobrefMap.get(att.LinkedEntityId).attachment__c.replace(oldtiltle,'');
                                                       System.debug('oldtiltle--->>>>'+jobrefMap);
                                                   }
                                               }
                // Update oppMap.values();
                Database.SaveResult[] srList = Database.update(jobrefMap.values(), false);
            }
        }
        if(artworkIdSet.size() > 0 ){
            system.debug('Job Size'+artworkIdSet.size());
            artworkMap = new Map<Id,artApp__Artwork__c>([select Id,Attachment__c from artApp__Artwork__c where Id IN: artworkIdSet]);
            if(artworkMap.size() > 0 ){
                
                System.debug('deleteIdSet2--->>>>'+deleteIdSet2);
                System.debug('deleteIdSet2-3-->>>>'+[SELECT Id,Title,FileExtension FROM 
                                                     ContentDocument where Id IN:documrntIdSet]);
                map<Id,String> map2add = new map<Id,String>();
                for(ContentDocument con : [SELECT Id,Title,FileExtension FROM ContentDocument where Id IN:documrntIdSet]){
                    String oldtiltle = con.Title + '.' + con.FileExtension;
                    map2add.put(con.id,oldtiltle);
                }
                for(ContentDocumentLink att : [SELECT Id, LinkedEntityId, ContentDocumentId, IsDeleted,ContentDocument.Title, ContentDocument.FileExtension FROM 
                                               ContentDocumentLink where Id IN:deleteIdSet2]){
                                                   
                                                   
                                                   System.debug('oldtiltle--->>>>'+map2add.get(att.ContentDocumentId));
                                                   String oldtiltle = map2add.get(att.ContentDocumentId);
                                                   System.debug('oldtiltle-12-->>>>'+artworkMap.get(att.LinkedEntityId).Attachment__c.contains(oldtiltle));
                                                   if(artworkMap.get(att.LinkedEntityId).attachment__c != null && artworkMap.get(att.LinkedEntityId).attachment__c != '' && artworkMap.get(att.LinkedEntityId).Attachment__c.contains(oldtiltle)){
                                                       System.debug('oldtiltle--->>>>'+map2add.get(att.ContentDocumentId));
                                                       artworkMap.get(att.LinkedEntityId).attachment__c = artworkMap.get(att.LinkedEntityId).attachment__c.replace(oldtiltle,'');
                                                       System.debug('oldtiltle--->>>>'+jobrefMap);
                                                   }
                                               }
                // Update oppMap.values();
                Database.SaveResult[] srList = Database.update(artworkMap.values(), false);
            }
        }
    }
    
    
}