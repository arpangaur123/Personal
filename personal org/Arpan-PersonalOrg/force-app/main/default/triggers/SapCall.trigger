/*
*  Trigger : SapCall
Description: Whenever an artApp__Artwork__c is created or updated it will call  SAp API
Author : Saifullah Saifi with Rajesh    
Date: 17/08/2017

*/
trigger SapCall on artApp__Artwork__c(before insert, before update, after insert, after update) {    
    if (trigger.isBefore) {
        for (artApp__Artwork__c art: trigger.new) {
            
            //By default we need to set check location = 'OK'
            art.Location_Check__c = 'OK';
            
            if (art.Crate__c == null && art.Shared_Crate__c == 'S') {
                art.Billing_Volume_Trg__c = 0;         
                System.debug('KK1...');
            } 
            
            else if(art.Crate__c == null ) {
                
                art.Billing_Volume_Trg__c = art.Packed_Volume_cbm__c;
                System.debug('KK2...');
            }
            
            else  {
                
                /*Setup Location check = 'OK' if 
1. IF both location are same and Shared_crate = 'P' or 'blank' or S then Location = ok
2. IF both location are not same and Shared_crate = 'I' then Location = OK
3. Else Location = Check
*/
                string slocation;
                
                if(art.Internal_Location__c!=null)
                {
                    System.debug('KK3...');
                    string loc = art.Internal_Location__c;
                    Location__c sloc = [select Name from Location__c where id = :loc];
                    System.debug('KK4...sloc Name = '+sloc.Name);
                    System.debug('KK5...sloc = '+sloc);
                    slocation = sloc.Name;
                }
                
                
                
                ///////////////////////////////////////////
                if (art.Crate_Location__c != null && (art.Crate_Location__c.touppercase().indexOf('RELEASE') != -1 ||
                                                      art.Crate_Location__c.touppercase().indexOf('DELIV') != -1 ||
                                                      art.Crate_Location__c.touppercase().indexOf('HELD') != -1 ||
                                                      art.Crate_Location__c.touppercase().indexOf('OLD') != -1 ||
                                                      art.Crate_Location__c.touppercase().indexOf('DISPOSED') != -1))
                {
                    System.debug('KK11...');
                    //System.debug('art.Crate_Location__c index ...' + art.Crate_Location__c.touppercase().indexOf('RELEASE') );
                    if(slocation!=null && (slocation.touppercase().indexOf('RELEASE') != -1 ||
                                           slocation.touppercase().indexOf('DELIV') != -1 ||
                                           slocation.touppercase().indexOf('HELD') != -1 ||
                                           slocation.touppercase().indexOf('OLD') != -1 ||
                                           slocation.touppercase().indexOf('DISPOSED') != -1))
                    {
                        
                        System.debug('KK12...');
                        if(art.Shared_Crate__c == null || art.Shared_Crate__c == 'P')
                        {
                            System.debug('KK13...');
                            art.Billing_Volume_Trg__c = art.Crate_CBM__c;                    
                        }
                        else if(art.Shared_Crate__c == 'S')
                        {
                            System.debug('KK14...');
                            art.Billing_Volume_Trg__c = 0;       
                        }
                        else if(art.Shared_Crate__c == 'I')
                        {
                            System.debug('KK14...');
                            art.Billing_Volume_Trg__c = art.Packed_Volume_cbm__c;       
                        }
                    }
                    else if(slocation!=null && (slocation.touppercase().indexOf('RELEASE') == -1 ||
                                                slocation.touppercase().indexOf('DELIV') == -1 ||
                                                slocation.touppercase().indexOf('HELD') == -1 ||
                                                slocation.touppercase().indexOf('OLD') == -1 ||
                                                slocation.touppercase().indexOf('DISPOSED') == -1))
                    {
                        System.debug('KK15...');
                        System.debug('art.Crate_Location__c index ...' + art.Crate_Location__c.touppercase());
                        
                        if(art.Shared_Crate__c == 'S')
                        {
                            System.debug('KK16...');
                            art.Billing_Volume_Trg__c = 0;       
                        }
                        else 
                        {
                            System.debug('KK17...');
                            art.Billing_Volume_Trg__c = art.Packed_Volume_cbm__c;       
                        }
                    }
                }
                
                if((art.Bill_as__c == 'Lay Flat' || art.Bill_as__c == 'Non-Stackable') && art.Packed_Area_sqm__c != null){
                    art.Billing_Volume_Trg__c = art.Packed_Area_sqm__c;
                }
                
                else // when crate location doesn't contain those values
                {
                    System.debug('KK18...');
                    //System.debug('art.Crate_Location__c index ...' + art.Crate_Location__c.touppercase().indexOf('RELEASE') );
                    if(slocation!=null && (slocation.touppercase().indexOf('RELEASE') != -1 ||
                                           slocation.touppercase().indexOf('DELIV') != -1 ||
                                           slocation.touppercase().indexOf('HELD') != -1 ||
                                           slocation.touppercase().indexOf('OLD') != -1 ||
                                           slocation.touppercase().indexOf('DISPOSED') != -1))
                    {
                        
                        System.debug('KK19...');
                        if(art.Shared_Crate__c == null || art.Shared_Crate__c == 'P')
                        {
                            System.debug('KK20...');
                            art.Billing_Volume_Trg__c = art.Crate_CBM__c;                    
                        }
                        else if(art.Shared_Crate__c == 'S')
                        {
                            System.debug('KK21...');
                            art.Billing_Volume_Trg__c = 0;       
                        }
                        else if(art.Shared_Crate__c == 'I')
                        {
                            System.debug('KK22...');
                            art.Billing_Volume_Trg__c = art.Packed_Volume_cbm__c;       
                        }
                    }
                    else
                    {
                        System.debug('KK23...');
                        if(art.Shared_Crate__c == null || art.Shared_Crate__c == 'P')
                        {
                            System.debug('KK24...');
                            art.Billing_Volume_Trg__c = art.Crate_CBM__c;                    
                        }
                        else if(art.Shared_Crate__c == 'S')
                        {
                            System.debug('KK25...');
                            art.Billing_Volume_Trg__c = 0;       
                        }
                        else if(art.Shared_Crate__c == 'I')
                        {
                            System.debug('KK26...');
                            art.Billing_Volume_Trg__c = art.Packed_Volume_cbm__c;       
                        }
                        
                        /*If crate ID is not blank 
AND crate location does not contain 'release,deliv,held,old,dispo,annex,not ship' 
AND  Storage location does not contain 'release,deliv,held,old,dispo,annex,not ship' 
AND Shared Crate = Blank,P,S  
AND storage location != crate location else Location check = Check */
                        if (art.Crate_Location__c != slocation )
                        {
                            System.debug('KK6...');
                            //Shared_crate = 'P' or 'blank' or S then Location = ok
                            if(art.Shared_Crate__c == 'S' || art.Shared_Crate__c == 'P' || String.isBlank(art.Shared_Crate__c) )
                            {
                                System.debug('KK8...');
                                art.Location_Check__c = 'Check';    
                                
                            }
                            
                        }
                    }
                }
                
                ///////////////////////////////////////////
                
                
            }
        }
    }
    
    
    if (trigger.isAfter) {
        List < string > artWorkId = new List < string > ();
        string act;
        
        if (Trigger.isInsert) {
            for (artApp__Artwork__c ar: Trigger.new) {
                if (sapCallHelper.checkBlank(ar))
                    artWorkId.add(ar.Id);
            }
            
            act = 'Insert';
        }
        
        if (Trigger.isUpdate) {
            for (artApp__Artwork__c ar: Trigger.new) {
                if (sapCallHelper.checkBlank(ar)) {
                    if (ar.Item_No__c != trigger.oldmap.get(ar.id).Item_No__c || ar.artApp__Width__c != trigger.oldmap.get(ar.id).artApp__Width__c ||
                        ar.artApp__Length__c != trigger.oldmap.get(ar.id).artApp__Length__c || ar.artApp__Height__c != trigger.oldmap.get(ar.id).artApp__Height__c ||
                        ar.artApp__UOM__c != trigger.oldmap.get(ar.id).artApp__UOM__c || ar.Weight_kg__c != trigger.oldmap.get(ar.id).Weight_kg__c ||
                        ar.UOM_Wt__c != trigger.oldmap.get(ar.id).UOM_Wt__c) {
                            artWorkId.add(ar.Id);
                        }
                }
                act = 'Update';
            }
        }
        
        if (artWorkId.size() > 0)
            sapCallHelper.callApi(artWorkId, act);
    }
    
    
}