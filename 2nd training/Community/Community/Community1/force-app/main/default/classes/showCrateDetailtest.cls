public class showCrateDetailtest{

static testMethod void myPage_Test()

{

//Test converage for the myPage visualforce page

PageReference pageRef = Page.shCratedetail;

Test.setCurrentPageReference(pageRef);

artApp__Collector__c newAccount = new artApp__Collector__c (name='Collector XYZ');

insert newAccount;

//create first contact

Crate__c myContact = new Crate__c (Name='JoeCrate',

myCollector__c=newAccount.id);

insert myContact;

ApexPages.StandardController sc = new ApexPages.standardController(myContact);

// create an instance of the controller

showCrateDetail myPageCon = new showCrateDetail(sc);

//try calling methods/properties of the controller in all possible scenarios

// to get the best coverage.
}
}