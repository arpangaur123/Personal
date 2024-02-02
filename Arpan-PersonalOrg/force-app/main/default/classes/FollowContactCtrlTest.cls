@isTest
public class FollowContactCtrlTest {
@isTest
    public static void run(){
         Account acc = new Account();
        acc.Name='karan';
        insert acc;
        
        Contact con = new Contact();
        con.LastName='bhatt';
        con.AccountId=acc.id;
        
        List<Contact> conlist = new List<Contact>();
        conlist.add(con);
        insert conlist;
        
        
         PageReference pageRef = Page.FollowContact;
        ApexPages.StandardSetController stdJR = new ApexPages.StandardSetController(conlist);
        FollowContactCtrl fol = new FollowContactCtrl(stdJR);
        fol.backBtn();
        fol.errorStr='jhuf';
        fol.successStr='fhaf';
        fol.contactList=conlist;
        fol.createSubscription();
    }
}