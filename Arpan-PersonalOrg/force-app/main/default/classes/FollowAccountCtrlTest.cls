@isTest
public class FollowAccountCtrlTest {
@isTest
    public static void run(){
      
       Account acc = new Account();
        acc.Name='karan';
		 
        
        List<Account> acclist = new List<Account>();
            acclist.add(acc);
   insert acclist;
         
        EntitySubscription ent = new EntitySubscription();
        ent.ParentId = acc.Id;
            ent.SubscriberId = userInfo.getUserId();
        insert ent;
      
       List<EntitySubscription> eslist = new List<EntitySubscription>();
        eslist.add(ent);
           
        PageReference pageRef = Page.FollowAccount;
        ApexPages.StandardSetController stdJR = new ApexPages.StandardSetController(acclist);
        FollowAccountCtrl fol = new FollowAccountCtrl(stdJR);
        
        fol.backBtn();
        fol.accountList = acclist;
        fol.createSubscription();
        fol.errorStr='kajak';
        fol.successStr='jjww';
        
    }
}