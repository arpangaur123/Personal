@isTest
public class FollowCaseCtrlTest {
@isTest
    public static void run(){
        
         Account acc = new Account();
        acc.Name='karan';
        insert acc;
        
        Case cs = new Case();
       
        
        List<Case> caselist = new List<Case>();
        caselist.add(cs);
        insert caselist;
        
         PageReference pageRef = Page.FollowCase;
        ApexPages.StandardSetController stdJR = new ApexPages.StandardSetController(caselist);
        FollowCaseCtrl fol = new FollowCaseCtrl(stdJR);
        fol.backBtn();
        fol.errorStr='jkahf';
        fol.successStr='fha';
        fol.caseList=caselist;
        fol.createSubscription();
    }
}