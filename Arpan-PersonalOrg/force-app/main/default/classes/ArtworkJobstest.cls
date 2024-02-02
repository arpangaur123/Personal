public class ArtworkJobstest{

static testMethod void myPage_Test()

{

//Test converage for the myPage visualforce page

PageReference pageRef = Page.ArtworkJobs;

Test.setCurrentPageReference(pageRef);

// create an instance of the controller

ArtworkJobs myPageCon = new ArtworkJobs();
String magi = 'name ASC';
//try calling methods/properties of the controller in all possible scenarios

// to get the best coverage.

List<artApp__Artwork__c> pageAccounts = myPageCon.getAccounts();

Integer pageSize = myPageCon.getPageSize();
Boolean pageNumber = myPageCon.getPreviousButtonEnabled();
Boolean pagerNext = myPageCon.getNextButtonDisabled();
Integer totalPageNumber = myPageCon.getTotalPageNumber();
Integer pageNumber2 = myPageCon.getPageNumber();
Integer totalRecords = myPageCon.gettotalRecords();
//String sortDirection = myPageCon.getSortDirection(magi);

myPageCon.getPageSize();
myPageCon.Viewdata();
myPageCon.getPreviousButtonEnabled();
myPageCon.getNextButtonDisabled();
myPageCon.getAccounts();
myPageCon.getTotalPAgeNumber();
myPageCon.nextBtnClick();
myPageCon.previousBtnClick();
myPageCon.getSortDirection();
//myPageCon.getSortDirection('ASC');
}
}