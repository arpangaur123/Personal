public class myAddArtWorkTest{
public String Cid = System.currentPagereference().getParameters().get('Cid');
public String Cname = System.currentPagereference().getParameters().get('Cname');

static testMethod void myPage_Test()

{

System.currentPagereference().getParameters().put('Cid','123452');
System.currentPagereference().getParameters().put('Cname','crate 123');

//Test converage for the myPage visualforce page
//PageReference pageRef = new PageReference('/apex/mAddartwork?Cid='+Cid+'&Cname='+Cname);
PageReference pageRef = Page.mAddartwork;
pageRef.getParameters().put('Cid','123452');
pageRef.getParameters().put('Cname','crate 123');
Test.setCurrentPageReference(pageRef);

artApp__Collector__c newAccount = new artApp__Collector__c (name='Collector XYZ');

insert newAccount;

// Create new artist
artApp__Artist__c newArtist = new artApp__Artist__c (name='Artist XYZ');
insert newArtist;

//create new Crate

Crate__c newCrate = new Crate__c (name='JoeCrate',

myCollector__c=newAccount.id);

insert newCrate;

// Create new artwork
artApp__Artwork__c newArtwork = new artApp__Artwork__c (name='Art XYZ',artApp__Artist__c=newArtist.id,
Crate__c=newCrate.id);
insert newArtwork;

ApexPages.StandardController sc = new ApexPages.standardController(newCrate);

myAddArtWork myPageCon = new myAddArtWork();
// create an instance of the controller

//showCrateDetail myPageCon = new showCrateDetail(sc);



// create an instance of the controller


String magi = 'name ASC';
String Cid = 'a123';
String Cname = 'crate123';

//try calling methods/properties of the controller in all possible scenarios

// to get the best coverage.

List<artApp__Artwork__c> pageAccounts = myPageCon.getAccounts();

String s = myPageCon.keywords;
mypageCon.keywords = 'bar';

String s2 = myPageCon.keywords2;
mypageCon.keywords2 = 'bar2';

myPageCon.Viewdata();
myPageCon.Viewdata2();
//myPageCon.UpdateRecords();
myPageCon.mySaveExit();

Test.StartTest();

PageReference p = myPageCon.ViewData();
PageReference q = myPageCon.ViewData2();
PageReference r = myPageCon.mySaveExit();

PageReference pr = new PageReference('/apex/shCratedetail?id='+Cid); 
pr.getParameters().put('id', '1234500');

Test.setCurrentPageReference(pr);

//system.assertEquals('/apex/mAddartwork?Cid='+Cid+'&Cname='+Cname, p.getUrl()); 
//system.assertEquals(myArticle.id, p.getParameters().get(id));
//Test.setCurrentPageReference(p);
Test.StopTest();


}
}