@isTest
public class wrapperClassDelArtTest{
public String Cid = System.currentPagereference().getParameters().get('Cid');
public String Cname = System.currentPagereference().getParameters().get('Cname');

static testMethod void myDelArt_Test()
{

System.currentPagereference().getParameters().put('Cid','123452');
System.currentPagereference().getParameters().put('Cname','crate 123');

//Test converage for the myPage visualforce page
//PageReference pageRef = new PageReference('/apex/mAddartwork?Cid='+Cid+'&Cname='+Cname);
PageReference pageRef = Page.mywrapper;
pageRef.getParameters().put('Cid','123452');
pageRef.getParameters().put('Cname','crate 123');
Test.setCurrentPageReference(pageRef);


wrapperClassDelArt myPageCon = new wrapperClassDelArt();
// create an instance of the controller

String Cid = 'a123';
String Cname = 'crate123';

//try calling methods/properties of the controller in all possible scenarios

// to get the best coverage.

myPageCon.getContacts();
myPageCon.processSelected();

myPageCon.mySaveExit();
PageReference r = myPageCon.mySaveExit();

Test.StartTest();
PageReference pr = new PageReference('/apex/shCratedetail?id='+Cid); 
pr.getParameters().put('id', '1234500');
Test.setCurrentPageReference(pr);

Test.StopTest();


myPageCon.inflateTest();

}

}