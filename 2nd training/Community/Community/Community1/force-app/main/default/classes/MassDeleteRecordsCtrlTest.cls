@isTest(seealldata=true)
public class MassDeleteRecordsCtrlTest{

    public static testMethod void testCase(){
       OpportunityLineItem opl = setupMethodHelperClasses.getOppLineItem();
        PageReference pageRef = Page.MassDeleteRecords;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put( 'id', opl.OpportunityId);
        MassDeleteRecordsCtrl ms = new MassDeleteRecordsCtrl();
        for(MassDeleteRecordsCtrl.RealtedOppLineWrap ro :ms.realtedOppLineWrapList){
         ro.isSelected = true;
        }
        ms.deleteBtn();
        ms.backButton();
    }
    public static testMethod void testCase1(){
       OpportunityLineItem opl = setupMethodHelperClasses.getOppLineItem();
        PageReference pageRef = Page.MassDeleteRecords;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put( 'id', opl.OpportunityId);
        MassDeleteRecordsCtrl ms = new MassDeleteRecordsCtrl();
        ms.deleteBtn();
        ms.backButton();
    }


}