public class CurrentRecordIdDemoController{
public String currentRecordId {get;set;}
 
    public CurrentRecordIdDemoController(ApexPages.StandardController controller) {
        currentRecordId  = ApexPages.CurrentPage().getparameters().get('id');
    }
}