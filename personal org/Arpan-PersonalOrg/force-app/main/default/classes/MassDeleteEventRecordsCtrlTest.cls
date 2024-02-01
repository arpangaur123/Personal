@isTest
public class MassDeleteEventRecordsCtrlTest{

    public static testMethod void testCase(){
        PageReference pageRef = Page.MassDeleteEventRecords;
        Test.setCurrentPage(pageRef);
        event evt = setupMethodHelperClasses.getEvent();
        ApexPages.currentPage().getParameters().put( 'id', evt.WhatId);
        MassDeleteEventRecordsCtrl ms = new MassDeleteEventRecordsCtrl();
        for(MassDeleteEventRecordsCtrl.RealtedOppLineWrap rl :ms.realtedOppLineWrapList){
          rl.isselected = true;
        }
        ms.deleteBtn();
        ms.backButton();
    }
   

}