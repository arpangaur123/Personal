/*
Author: Arpan Gaur
Date:	09/06/2023

Date                   last madify by          discription 
08/11/2023 				Arpan Gaur			   change in method -"updateLocationStatusOnUpdate", Now user can edit some fields even if the location status
												value is "In Helutrans". Fields: Customer's Remark, Condition Notes/Remarks, Provenance, Exhibition History, Selling Currency, Selling Price

Discreption: 1. If location status value "In Helutrans", Portal user can  make changes in only field:Customer's Remark, Condition Notes/Remarks, Provenance, Exhibition History, Selling Currency, Selling Price 
2. If storage location field is not containing "old, dispose, annex, held by, deliver" then location status value should be "in helutrans" and
if storage location contains release then location status value should be "Released".
*/
public class ArtworkHelper {
    @testVisible
    public static boolean isExecute = true;
    Id profileId = UserInfo.getProfileId();
    @testVisible
    String profileName =[Select Id, Name from Profile where Id=:profileId].Name;
    
    Map<Id,Location__c> mapOfIdToLocation = new Map<Id,Location__c>();
    // This method is for condition 2 while inserting a record
    public void updateLocationStatusOnInsert(list<artApp__artwork__c> newArtworkList){
        fetchStorageLocationRecords(newArtworkList);
        for(artApp__artwork__c artwork : newArtworkList){
            
            if(mapOfIdToLocation.size()>0){
                
                if(!mapOfIdToLocation.get(artwork.Internal_Location__c).Name.toLowercase().Contains('old')||                        
                   !mapOfIdToLocation.get(artwork.Internal_Location__c).Name.toLowercase().Contains('held by')||
                   !mapOfIdToLocation.get(artwork.Internal_Location__c).Name.toLowercase().Contains('annex')){
                       artwork.Location_Status__c = 'In Helutrans';
                   }
                if(mapOfIdToLocation.get(artwork.Internal_Location__c).Name.toLowercase().Contains('release') ||
                   mapOfIdToLocation.get(artwork.Internal_Location__c).Name.toLowercase().Contains('dispose')||
                   mapOfIdToLocation.get(artwork.Internal_Location__c).Name.toLowercase().Contains('deliver')){
                       artwork.Location_Status__c = 'Released';
                   }
                
            }
        }
    }
    
    // This method is for condition 1 and 2 while updating a record
    
    public void updateLocationStatusOnUpdate(list<artApp__artwork__c> newArtworkList , map<id,artApp__artwork__c> oldMap){
        string proflName = 'Customer Community Plus User Clone';
        string locationStatusFieldError = System.Label.LocationStatusFieldError;
        string ArtworkRecordError = System.Label.ArtworkRecordError;
        fetchStorageLocationRecords(newArtworkList);
        
        for(artApp__artwork__c artwork : newArtworkList){
            if(artwork.Location_Status__c!=oldMap.get(artwork.id).Location_Status__c && oldMap.get(artwork.id).Location_Status__c=='In Helutrans' && profileName == proflName){
                system.debug('Error 1');
                artwork.addError(locationStatusFieldError);
            }
            
            if(oldMap.get(artwork.id).Location_Status__c =='In Helutrans' && profileName == proflName && 
               ((artwork.Item_No__c !=oldMap.get(artwork.id).Item_No__c) || (artwork.Lot_No__c !=oldMap.get(artwork.id).Lot_No__c) || (artwork.Part_of__c !=oldMap.get(artwork.id).Part_of__c) ||(artwork.Dept_Code__c !=oldMap.get(artwork.id).Dept_Code__c) || (artwork.artApp__UOM__c !=oldMap.get(artwork.id).artApp__UOM__c) ||(artwork.artApp__Length__c !=oldMap.get(artwork.id).artApp__Length__c) ||(artwork.artApp__Width__c !=oldMap.get(artwork.id).artApp__Width__c) ||(artwork.artApp__Height__c !=oldMap.get(artwork.id).artApp__Height__c) ||(artwork.Packed_Length__c !=oldMap.get(artwork.id).Packed_Length__c) || (artwork.Packed_Width__c !=oldMap.get(artwork.id).Packed_Width__c) || (artwork.Packed_Height__c !=oldMap.get(artwork.id).Packed_Height__c)||  (artwork.artApp__Artist__c !=oldMap.get(artwork.id).artApp__Artist__c)||  (artwork.Name !=oldMap.get(artwork.id).Name) || (artwork.artApp__Type__c !=oldMap.get(artwork.id).artApp__Type__c) || (artwork.artApp__Media__c !=oldMap.get(artwork.id).artApp__Media__c) || (artwork.artApp__Year__c !=oldMap.get(artwork.id).artApp__Year__c) || (artwork.Edition_No__c !=oldMap.get(artwork.id).Edition_No__c) || (artwork.Frame__c !=oldMap.get(artwork.id).Frame__c) || (artwork.CurrencyIsoCode !=oldMap.get(artwork.id).CurrencyIsoCode) || (artwork.artApp__Cost__c !=oldMap.get(artwork.id).artApp__Cost__c) || (artwork.GST_Rate__c !=oldMap.get(artwork.id).GST_Rate__c) )){
                  artwork.addError(ArtworkRecordError);
              }
            
            system.debug('newArtworkListin update-->'+newArtworkList);
            
            if(mapOfIdToLocation.size()>0){
                if(!mapOfIdToLocation.get(artwork.Internal_Location__c).Name.toLowercase().Contains('old')||
                   !mapOfIdToLocation.get(artwork.Internal_Location__c).Name.toLowercase().Contains('held by')||
                   !mapOfIdToLocation.get(artwork.Internal_Location__c).Name.toLowercase().Contains('annex')){  
                       artwork.Location_Status__c = 'In Helutrans';
                   }  
                if(mapOfIdToLocation.get(artwork.Internal_Location__c).Name.toLowercase().Contains('release') ||
                   mapOfIdToLocation.get(artwork.Internal_Location__c).Name.toLowercase().Contains('dispose')||
                   mapOfIdToLocation.get(artwork.Internal_Location__c).Name.toLowercase().Contains('deliver')){
                       artwork.Location_Status__c = 'Released';
                   }
            }
            
        }   
        
        
    }
    
    // this method is feching location records to check whether storage location contain those words or not.
    public void fetchStorageLocationRecords(list<artApp__artwork__c> newArtworkList) {
        system.debug('newArtworkList'+newArtworkList);
        set<Id> storageLocationIdSet = new set<Id>();
        if(newArtworkList.size() >0){
            for(artApp__artwork__c artwork : newArtworkList){
                if(string.isNotBlank(artwork.Internal_Location__c)){
                    storageLocationIdSet.add(artwork.Internal_Location__c);
                }
            }
        }
        List<Location__c>  loc = [SELECT Id, Name From Location__c Where Id IN:storageLocationIdSet ];
        mapOfIdToLocation.putAll(loc);
        
    }

}