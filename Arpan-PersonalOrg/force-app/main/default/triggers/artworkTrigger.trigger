/*
 *  Author:Arpan Gaur
 * 	Team-  TechMatricx
 * 
 */
trigger artworkTrigger on artApp__Artwork__c (before insert, before update, after insert, after update) {
    Id profileId = UserInfo.getProfileId();
    String profileName =[Select Id, Name from Profile where Id=:profileId].Name;
    SYSTEM.debug('profileName---->'+profileName);
    SYSTEM.debug('Trigger.isUpdate---->'+Trigger.isUpdate);
    SYSTEM.debug('ArtworkHelper.isExecute---->'+ArtworkHelper.isExecute);
    
    List<artApp__artwork__c> listToBeUpdated = new List<artApp__artwork__c>();
    
    if(test.isRunningTest() && trigger.isUpdate == true){       
            ArtworkHelper.isExecute = true;       
    }
    if (Trigger.isBefore) {
        if (Trigger.isInsert && ArtworkHelper.isExecute == true) {
            ArtworkHelper obj = new ArtworkHelper();
            obj.updateLocationStatusOnInsert(Trigger.new);
            ArtworkHelper.isExecute = false;
            
       // artworkTriggerHandler.insertArtWork(trigger.new);  

        }
        
        else if (Trigger.isUpdate && ArtworkHelper.isExecute == true) {
            if(profileName != 'Customer Community Plus User Clone' ){
                for(artApp__artwork__c artwork : Trigger.new){
                    if(artwork.Internal_Location__c != Trigger.OldMap.get(artwork.Id).Internal_Location__c ||
                      artwork.Location_Status__c != Trigger.OldMap.get(artwork.Id).Location_Status__c ){
                        listToBeUpdated.add(artwork);
                    }
                }
                ArtworkHelper obj = new ArtworkHelper();
                obj.updateLocationStatusOnUpdate(listToBeUpdated, Trigger.oldMap);

            }
            else{
                ArtworkHelper obj = new ArtworkHelper();
                obj.updateLocationStatusOnUpdate(Trigger.new, Trigger.oldMap); 
            }
        }
    }
    
    if(Trigger.isAfter){
        List<artApp__Artwork__c> artWorklist = new List<artApp__Artwork__c>();
        String ArtworkName;
        
        
		if(Trigger.isInsert || Trigger.isUpdate){
            for(artApp__Artwork__c artWork: trigger.new){
                if(!String.isBlank(artWork.Name)){
                    ArtworkName = artWork.Name.replaceAll('"', '');
                }
                system.debug('artWork in trigger--->'+artwork);
                if((!artWork.SourceRFID__c && ArtworkName != 'Untitled') || Trigger.isUpdate ){   
                    system.debug('trigger.isInsert-->'+trigger.isInsert );
                    system.debug('trigger.isUpdate-->'+trigger.isUpdate );
                    artWorklist.add(artWork);
                }
            }
            system.debug('artWorklist>>>>'+artWorklist);
            if(artWorklist.size()>0){
                artworkTriggerHandler.insertArtWork(artWorklist);
            }
        }
        
        /*if(Trigger.isUpdate){
            for(artApp__Artwork__c artWork: trigger.new){
                if(!String.isBlank(artWork.Name)){
                    ArtworkName = artWork.Name.replaceAll('"', '');
                }
                if(ArtworkName != 'Untitled'){
                    artWorklist.add(artWork);
                }
            }
            
            if(artWorklist.size()>0){
                //artworkTriggerHandler.insertArtWork(artWorklist);
            }
        }*/
    }
}