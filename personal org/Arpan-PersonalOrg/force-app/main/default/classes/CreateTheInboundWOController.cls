public class CreateTheInboundWOController {
	public String currentRecordId {get;set;}
    //public String parameterValue {get;set;}
    public Opportunity opp{get;set;}
     
    public CreateTheInboundWOController(ApexPages.StandardController controller) {
        currentRecordId  = ApexPages.CurrentPage().getparameters().get('id');
        opp = [select id ,Name, Contact_Person_TEL__c, Contact_Person__c,
               Survey_Address__c, Destination_Address__c, Pack_Date_1__c,
               OB_Job_Number__c, Estimated_Volume__c, Shipment_Details__c,
               Load_Type__c, Mode_of_Transport__c, Sales_Person_Remark__c,
               Pack_Type__c, StageName from Opportunity where id =: currentRecordId ];
        //parameterValue = ApexPages.CurrentPage().getparameters().get('nameParam');
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunityRecord(String oppId) {
        system.debug('oppId >> ' + oppId);
        return [select id ,Name, Contact_Person_TEL__c, Contact_Person__c,
               Survey_Address__c, Destination_Address__c, Pack_Date_1__c,
               OB_Job_Number__c, Estimated_Volume__c, Shipment_Details__c,
               Load_Type__c, Mode_of_Transport__c, Sales_Person_Remark__c,
               Pack_Type__c, StageName from Opportunity where id = :oppId];
    }
}