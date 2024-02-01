public class showCrateDetail{
    
    private Crate__c cntact; 
    public showCrateDetail(ApexPages.StandardController controller) {
        this.cntact= (Crate__c)controller.getRecord();
    }
    
}