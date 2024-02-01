public class PushJobReferenceToEportalController {
    @auraEnabled
    public static String apiPushInfo(ID recordId){
        string message = '';
        try{
            list<Job_Reference__c> joblst = [SELECT Id,Opportunity__c,Client_Account__c,Opportunity__r.Push_Opportunity_Info__c,Status__c,
                                             Name,ExhibitionN__c,Push_Job_Info__c,Opportunity__r.Approved_Costing_Sheet__c,Opportunity__r.Approved_Costing_Sheet__r.Costing_Sheet_Id__c,Opportunity__r.Approved_Costing_Sheet__r.Revision_ID__c from Job_Reference__c where Id=:recordId];
            if(joblst!=null && joblst.size() > 0){
                if(joblst[0].Push_Job_Info__c)
                    message = 'Warning@Job Reference is already pushed to EPortal';
                else if(joblst[0].Opportunity__c==null || !(joblst[0].Opportunity__r.Push_Opportunity_Info__c))
                    message = 'Warning@Please push the linked Opportunity to portal first.';
                else If(joblst[0].Opportunity__c!=null && (joblst[0].Opportunity__r.Approved_Costing_Sheet__c==null || joblst[0].Opportunity__r.Approved_Costing_Sheet__r.Costing_Sheet_Id__c==null)){
                 	message = 'Warning@Please select the Approved Costing Sheet on the Opportunity before pushing the Job reference to portal.';   
                }else{
                    Job_Reference__c job = PortalAPIUtility.pushJobReference(joblst);
                    if(job.API_Error__c!=null)
                        message = 'Error@'+job.API_Error__c;
                    else
                        message = 'success@Data Pushed Successfully';
                }
            }else
                message+= 'Warning@Job Reference list is Empty';
        }catch(Exception e){
            message='Error@'+e.getMessage();
        }
        return message;
    }
}