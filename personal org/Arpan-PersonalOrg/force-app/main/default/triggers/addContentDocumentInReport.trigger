trigger addContentDocumentInReport on ContentDocument (after update, before delete){
    
    String str = 'This is new \n';
    String prt = str.removeEnd('\n');
    //added addContentDocumentTrigger and ContentDocumentLinkTrigger in place of this trigger
    /*Map<Id, Job_Reference__c> updateJobRefRecords = new Map<Id, Job_Reference__c>();
    Map<Id, Opportunity> updateOppRecords = new Map<Id, Opportunity>();
    Map<Id, artApp__Artwork__c> updateArtworkRecords = new Map<Id, artApp__Artwork__c>();   
    if(Trigger.isUpdate){
        Set<Id> contentDocumentIdSet = new Set<Id>();
        Set<Id> jobrefIdSet =new Set<Id>();
        Set<Id> oppIdSet =new Set<Id>();
        Set<Id> artworkIdSet =new Set<Id>();
         
        for(ContentDocument cd: trigger.new){
            contentDocumentIdSet.add(cd.Id);        
        }
        
        List<ContentDocumentLink>  contentDocumentLinkList = [SELECT Id, LinkedEntityId, ContentDocumentId, IsDeleted, 
                                                     ContentDocument.Title, ContentDocument.FileExtension FROM 
                                                     ContentDocumentLink WHERE ContentDocumentId IN: contentDocumentIdSet];
        
        for(ContentDocumentLink link: contentDocumentLinkList){
            String objName = link.LinkedEntityId.getSObjectType().getDescribe().getName();
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
        
        if(!oppIdSet.isEmpty()){
            System.debug(oppIdSet);
            updateAttachmentField(oppIdSet, null, 'Opportunity');
            refreshAttachents(oppIdSet, 'Opportunity');
        }
        if(!jobrefIdSet.isEmpty()){
            System.debug(jobrefIdSet);
            updateAttachmentField(jobrefIdSet, null, 'job_reference__c');
            refreshAttachents(jobrefIdSet, 'job_reference__c');
        }
        if(!artworkIdSet.isEmpty()){
            System.debug(artworkIdSet);
            updateAttachmentField(artworkIdSet, null, 'artApp__Artwork__c');
            refreshAttachents(artworkIdSet, 'artApp__Artwork__c');
        }
        if(updateOppRecords.size()>0){
         // update updateOppRecords.values();
        Database.SaveResult[] srList = Database.update(updateOppRecords.values(), false);}
        else if(updateJobRefRecords.size()>0){
           // update updateJobRefRecords.values();
        Database.SaveResult[] srList = Database.update(updateJobRefRecords.values(), false);}
        else if(updateArtworkRecords.size()>0){
         //   update updateArtworkRecords.values();
        Database.SaveResult[] srList = Database.update(updateArtworkRecords.values(), false);}
    }
    else if(Trigger.isDelete){
        Set<Id> contentDocumentIdSet = new Set<Id>();
        Set<Id> jobrefIdSet =new Set<Id>();
        Set<Id> oppIdSet =new Set<Id>();
        Set<Id> artworkIdSet =new Set<Id>();
        
        for(ContentDocument cd: trigger.old){
            contentDocumentIdSet.add(cd.Id);        
        }
        
        List<ContentDocumentLink> contentDocumentLinkList = [SELECT Id, LinkedEntityId, ContentDocumentId, IsDeleted, 
                                                     ContentDocument.Title, ContentDocument.FileExtension FROM 
                                                     ContentDocumentLink WHERE ContentDocumentId IN: contentDocumentIdSet];
        
        for(ContentDocumentLink link:  contentDocumentLinkList){
            String objName = link.LinkedEntityId.getSObjectType().getDescribe().getName();
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

        if(!oppIdSet.isEmpty()){
            updateAttachmentField(oppIdSet, contentDocumentIdSet, 'Opportunity');
        }
        if(!jobrefIdSet.isEmpty()){
            updateAttachmentField(jobrefIdSet, contentDocumentIdSet, 'job_reference__c');
            refreshAttachents(jobrefIdSet, 'job_reference__c');
        }
        if(!artworkIdSet.isEmpty()){
            updateAttachmentField(artworkIdSet, contentDocumentIdSet, 'artApp__Artwork__c');
        }
        
        if(updateOppRecords.size()>0){
           // update updateOppRecords.values();
       Database.SaveResult[] srList = Database.update(updateOppRecords.values(), false);}
        else if(updateJobRefRecords.size()>0){
           // update updateJobRefRecords.values();
         Database.SaveResult[] srList = Database.update(updateJobRefRecords.values(), false);}
        else if(updateArtworkRecords.size()>0){
         //   update updateArtworkRecords.values();
     Database.SaveResult[] srList = Database.update(updateArtworkRecords.values(), false);}
    }
    
    public void updateAttachmentField(Set<Id> objIdSet, Set<Id> deletedIdSet, String objName){
        Boolean remainingCDLinkZero = true;
        
        if(objIdSet.size()> 0){
            for(ContentDocumentLink link:  [SELECT Id, LinkedEntityId, ContentDocumentId, IsDeleted, 
                                                         ContentDocument.Title, ContentDocument.FileExtension FROM 
                                                         ContentDocumentLink WHERE LinkedEntityId IN: objIdSet AND ContentDocumentId NOT In: deletedIdSet]){
                remainingCDLinkZero = false;
                if(objName.equalsIgnoreCase('Opportunity')){
                    Opportunity temp = new Opportunity(Id = link.LinkedEntityId, Attachment__c = '');
                    if(updateOppRecords.containsKey(link.LinkedEntityId)){
                        temp = updateOppRecords.get(link.LinkedEntityId);                 
                    }
                    temp.Attachment__c += link.ContentDocument.Title + '.' + link.ContentDocument.FileExtension + '\n ';
                    updateOppRecords.put(link.LinkedEntityId, temp);
                }
                else if(objName.equalsIgnoreCase('job_reference__c')){
                    Job_Reference__c temp = new Job_Reference__c(Id = link.LinkedEntityId, Attachment__c = '');
                    if(updateJobRefRecords.containsKey(link.LinkedEntityId)){
                        temp = updateJobRefRecords.get(link.LinkedEntityId);                 
                    }
                    temp.Attachment__c += link.ContentDocument.Title + '.' + link.ContentDocument.FileExtension + '\n ';
                    updateJobRefRecords.put(link.LinkedEntityId, temp);   
                    System.debug(updateJobRefRecords);
                }
                else if(objName.equalsIgnoreCase('artApp__Artwork__c')){
                    artApp__Artwork__c temp = new artApp__Artwork__c(Id = link.LinkedEntityId, Attachment__c = '');
                    if(updateArtworkRecords.containsKey(link.LinkedEntityId)){
                        temp = updateArtworkRecords.get(link.LinkedEntityId);                 
                    }
                    temp.Attachment__c += link.ContentDocument.Title + '.' + link.ContentDocument.FileExtension + '\n ';
                    updateArtworkRecords.put(link.LinkedEntityId, temp);   
                }
            }
            if(remainingCDLinkZero){
                if(objName.equalsIgnoreCase('Opportunity')){
                    for(Id oppId: objIdSet){
                        Opportunity temp = new Opportunity(Id = oppId, Attachment__c = '');
                        if(updateOppRecords.containsKey(oppId)){
                            temp = updateOppRecords.get(oppId);                 
                        }
                        updateOppRecords.put(oppId, temp);     
                    }
                }
                else if(objName.equalsIgnoreCase('job_reference__c')){
                    for(Id jobRefId: objIdSet){
                        Job_Reference__c temp = new Job_Reference__c(Id = jobRefId, Attachment__c = '');
                        if(updateJobRefRecords.containsKey(jobRefId)){
                            temp = updateJobRefRecords.get(jobRefId);                 
                        }
                        updateJobRefRecords.put(jobRefId, temp);     
                    }
                }
                else if(objName.equalsIgnoreCase('artApp__Artwork__c')){
                    for(Id artworkId: objIdSet){
                        artApp__Artwork__c temp = new artApp__Artwork__c(Id = artworkId, Attachment__c = '');
                        if(updateArtworkRecords.containsKey(artworkId)){
                            temp = updateArtworkRecords.get(artworkId);                 
                        }
                        updateArtworkRecords.put(artworkId, temp);     
                    }
                }
            }
        }
    }
    
    public void refreshAttachents(Set<Id> objIdSet, String objName){
        if(objName == 'Opportunity'){
            List<Attachment> attList= [SELECT Id, Name, ParentId  FROM Attachment WHERE ParentId In: objIdSet];
            for(Attachment obj: attList){
                updateOppRecords.get(obj.ParentId).Attachment__c += +'\n' +string.escapeSingleQuotes(obj.Name);        
            }       
        }
        else if(objName == 'job_reference__c'){
            List<Attachment> attList= [SELECT Id, Name, ParentId  FROM Attachment WHERE ParentId In: objIdSet];
            for(Attachment obj: attList){
                updateJobRefRecords.get(obj.ParentId).Attachment__c += +'\n' +string.escapeSingleQuotes(obj.Name);
            }       
        }
        else if(objName == 'artApp__Artwork__c'){
            List<Attachment> attList= [SELECT Id, Name, ParentId  FROM Attachment WHERE ParentId In: objIdSet];
            for(Attachment obj: attList){
                updateArtworkRecords.get(obj.ParentId).Attachment__c += +'\n' +string.escapeSingleQuotes(obj.Name);
            }       
        }
    }*/
}