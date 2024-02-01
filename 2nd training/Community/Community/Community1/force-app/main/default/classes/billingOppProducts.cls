public class billingOppProducts {
	public List<OpportunityLineItem> oppLineItem;
	public Billing__c billing;
	
	public billingOppProducts(ApexPages.StandardController controller) {
        this.billing= (Billing__c)controller.getRecord();
    }
    
    public List<OpportunityLineItem> getOppLineItem() {
        Billing__c bill = [SELECT Id, Opportunity__r.Id FROM Billing__c where id = :billing.id];
        
        oppLineItem = [SELECT id, UnitPrice, TotalPrice, Quantity, PricebookEntry.Name, Opportunity.Id 
            FROM OpportunityLineItem WHERE Opportunity.Id = :bill.Opportunity__r.Id];
        if (oppLineItem == null) {
        	return null;
        }
        else {
        	return oppLineItem;
        }
    }//end of getOppLineItem

}