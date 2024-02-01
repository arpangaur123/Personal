public class CreateInboundWoCtrl {

    @auraEnabled
    public static boolean getStageName(String sobjectId){
        if(sobjectId != null && sobjectId != ''){
            List<Opportunity> oppList = [select id , stageName from opportunity where id=:sobjectId AND stageName ='Closed Won'];
            if(oppList != null && oppList.size() > 0){
                return true;
            }
        }
        return false;
    }
    
}