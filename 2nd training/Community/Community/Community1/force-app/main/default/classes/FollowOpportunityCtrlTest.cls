@isTest
public class FollowOpportunityCtrlTest{

  public static testMethod void testCase(){
  List<Opportunity> opportunityList = new List<Opportunity>();
  opportunityList.add(setupMethodHelperClasses.getOpp());
  
 
  Test.setCurrentPage(Page.FollowOpportunity);
  ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(opportunityList);
  stdSetController.setSelected(opportunityList);
   FollowOpportunityCtrl fo = new FollowOpportunityCtrl(stdSetController);
   fo.createSubscription();
  }

}