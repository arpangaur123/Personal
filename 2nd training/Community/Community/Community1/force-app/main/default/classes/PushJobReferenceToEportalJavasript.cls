/* to push opportunity data from salesforce to Eportal using javascript button
developed by tmc on 14th May*/
global class PushJobReferenceToEportalJavasript {
    webservice static String apiCallout(ID recordId){ 
        return PushJobReferenceToEportalController.apiPushInfo(recordId);
        
    }
}