trigger addContentDocumentTrigger on ContentDocument (before delete) {

    Map<Id, Opportunity> oppMap;
    Map<Id,Job_Reference__c> jobrefMap ;
    Map<Id,artApp__Artwork__c> artworkMap ;
    Set<Id> contentDocumentIdSet = new Set<Id>();
    Set<Id> oppIdSet =new Set<Id>();
    Set<ID> jobrefIdSet =new Set<id>();
    Set<ID> artworkIdSet =new Set<id>();
    
    for(ContentDocument cd: trigger.old){
        contentDocumentIdSet.add(cd.Id);        
    }
    
    List<ContentDocumentLink> contentDocumentLinkList = [SELECT Id, LinkedEntityId, ContentDocumentId, IsDeleted, 
                                                         ContentDocument.Title, ContentDocument.FileExtension FROM 
                                                         ContentDocumentLink WHERE ContentDocumentId IN: contentDocumentIdSet];
    for(ContentDocumentLink link:  contentDocumentLinkList){
        String objName = link.LinkedEntityId.getSObjectType().getDescribe().getName();
        if(objName == 'Opportunity')
            oppIdSet.add(link.LinkedEntityId);
        else if(objName== 'job_reference__c'){
            jobrefIdSet.add(link.LinkedEntityId);
        }
        else if(objName== 'artApp__Artwork__c'){
            artworkIdSet.add(link.LinkedEntityId);
        }
    }
    if(oppIdSet.size()> 0){
        System.debug('In----');
        oppMap = new Map<Id,Opportunity>([select Id,Attachment__c from Opportunity where Id IN: oppIdSet]);
        for(ContentDocumentLink link:  [SELECT Id, LinkedEntityId, ContentDocumentId, IsDeleted, 
                                        ContentDocument.Title, ContentDocument.FileExtension FROM 
                                        ContentDocumentLink WHERE ContentDocumentId In:contentDocumentIdSet]){
                                            System.debug('no----');
                                            String oldtiltle = link.ContentDocument.Title + '.' + link.ContentDocument.FileExtension;
                                            if(oppMap.containskey(link.LinkedEntityId) && oppMap.get(link.LinkedEntityId).attachment__c != null && oppMap.get(link.LinkedEntityId).attachment__c != '' && oppMap.get(link.LinkedEntityId).Attachment__c.contains(oldtiltle)){
                                                oppMap.get(link.LinkedEntityId).attachment__c = oppMap.get(link.LinkedEntityId).attachment__c.replace(oldtiltle,'');
                                                System.debug('oldtiltle--->>>>'+oppMap);
                                            }
                                        }
        
        // Update oppMap.values();
        Database.SaveResult[] srList = Database.update(oppMap.values(), false);
    }
    if(jobrefIdSet.size()> 0){
        System.debug('In----');
        jobrefMap = new Map<Id,job_reference__c>([select Id,Attachment__c from job_reference__c where Id IN: jobrefIdSet]);
        for(ContentDocumentLink link:  [SELECT Id, LinkedEntityId, ContentDocumentId, IsDeleted, 
                                        ContentDocument.Title, ContentDocument.FileExtension FROM 
                                        ContentDocumentLink WHERE ContentDocumentId In:contentDocumentIdSet]){
                                            System.debug('no----');
                                            String oldtiltle = link.ContentDocument.Title + '.' + link.ContentDocument.FileExtension;
                                            if(jobrefMap.containskey(link.LinkedEntityId) && jobrefMap.get(link.LinkedEntityId).attachment__c != null && jobrefMap.get(link.LinkedEntityId).attachment__c != '' && jobrefMap.get(link.LinkedEntityId).Attachment__c.contains(oldtiltle)){
                                                jobrefMap.get(link.LinkedEntityId).attachment__c = jobrefMap.get(link.LinkedEntityId).attachment__c.replace(oldtiltle,'');
                                                System.debug('oldtiltle--->>>>'+jobrefMap);
                                            }
                                        }
        
        // Update oppMap.values();
        Database.SaveResult[] srList = Database.update(jobrefMap.values(), false);
    }
    if(artworkIdSet.size()> 0){
        System.debug('In----');
        artworkMap = new Map<Id,artApp__Artwork__c>([select Id,Attachment__c from artApp__Artwork__c where Id IN: artworkIdSet]);
        for(ContentDocumentLink link:  [SELECT Id, LinkedEntityId, ContentDocumentId, IsDeleted, 
                                        ContentDocument.Title, ContentDocument.FileExtension FROM 
                                        ContentDocumentLink WHERE ContentDocumentId In:contentDocumentIdSet]){
                                            System.debug('no----');
                                            String oldtiltle = link.ContentDocument.Title + '.' + link.ContentDocument.FileExtension;
                                            if(artworkMap.containskey(link.LinkedEntityId) && artworkMap.get(link.LinkedEntityId).attachment__c != null && artworkMap.get(link.LinkedEntityId).attachment__c != '' && artworkMap.get(link.LinkedEntityId).Attachment__c.contains(oldtiltle)){
                                                artworkMap.get(link.LinkedEntityId).attachment__c = artworkMap.get(link.LinkedEntityId).attachment__c.replace(oldtiltle,'');
                                                System.debug('oldtiltle--->>>>'+jobrefMap);
                                            }
                                        }
        
        // Update oppMap.values();
        Database.SaveResult[] srList = Database.update(artworkMap.values(), false);
    }
}