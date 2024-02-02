public class PushOpportunityToEportalController {
    
    @auraEnabled
    public static String apiCallout(ID recordId,String ApiName){
        string message = '';
        try{
            list<Opportunity> opplst = [SELECT Id,(SELECT Id,Contact.Name from OpportunityContactRoles order by CreatedDate desc limit 1),
                                        Push_Opportunity_Info__c,Push_Lost_Cancelled_Status__c,Quote_test_sfdc__c,AM_Job_Type__c,
                                        Reason_for_Cancelled__c,StageName,Reason_Lost__c,Account.Name,CurrencyIsoCode,Payment_Terms__c,Description 
                                        from Opportunity where Id=:recordId];
            if(opplst!=null && opplst.size() > 0){
                System.debug('rt--->>>'+opplst[0].OpportunityContactRoles);
                if(opplst[0].Push_Opportunity_Info__c && ApiName=='Interaction1')
                    message = 'Warning@Data has already pushed to Eportal';
                else if (ApiName=='Interaction1' && !(opplst[0].OpportunityContactRoles!=null && opplst[0].OpportunityContactRoles.size() > 0))
                    message = 'Warning@Contact is Mandatory';
                else if (ApiName=='Interaction3A' && !(opplst[0].Push_Opportunity_Info__c))
                    message = 'Warning@Opportunity has not been pushed to EPortal';
                else if(opplst[0].Push_Lost_Cancelled_Status__c && ApiName=='Interaction3A')
                    message = 'Warning@Status is already updated to Eportal';
                else if(opplst[0].StageName!='Cancelled' && opplst[0].StageName!='Closed Lost' && ApiName=='Interaction3A')
                    message = 'Warning@Stage Should be Cancelled or Closed Lost';
                else{
                    if(ApiName=='Interaction1'){
                        Opportunity opp = PortalAPIUtility.pushOpportunity(opplst);
                        if(opp.API_Error__c!=null)
                            message = 'Error@'+opp.API_Error__c;
                        else
                            message = 'success@Data Pushed Successfully';
                    }
                    else if(ApiName=='Interaction3A'){
                        Opportunity opp = PortalAPIUtility.pushStatus(opplst);
                        System.debug('opp.API_Error__c--->>>>'+opp.API_Error__c);
                        if(opp.API_Error__c!=null)
                            message = 'Error@'+opp.API_Error__c;
                        else
                            message = 'success@Data Pushed Successfully';
                    }
                }
            }else
                message+= 'Warning@Oppportunity list is Empty';
        }catch(Exception e){
            message='Error@'+e.getMessage()+' At Line '+e.getLineNumber();
        }
        return message;
    }
    
}