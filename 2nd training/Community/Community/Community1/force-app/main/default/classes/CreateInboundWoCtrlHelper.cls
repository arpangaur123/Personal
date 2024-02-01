@isTest 
public class CreateInboundWoCtrlHelper{

    public static testMethod void testCase(){
      opportunity opp = setupMethodHelperClasses.getOpp();
      CreateInboundWoCtrl.getStageName(opp.id);
    
    }


}