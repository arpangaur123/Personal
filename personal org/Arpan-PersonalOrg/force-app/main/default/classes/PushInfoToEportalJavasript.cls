/* to push opportunity data from salesforce to Eportal using javascript button
developed by tmc on 14th May*/

global class PushInfoToEportalJavasript {
    webservice static String apiCallout(ID recordId,String apiName){ 
        return PushOpportunityToEportalController.apiCallout(recordId,apiName);
    }
}