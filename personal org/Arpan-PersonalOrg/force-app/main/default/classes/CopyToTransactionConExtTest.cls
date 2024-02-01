/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class CopyToTransactionConExtTest {

    static testMethod void myUnitTest() {
        Account a = new Account(name='Test Acc');
        Database.insert(a);
        Contact con = new Contact(firstName='Joe', lastName='Doe', 
        accountid=A.id, Email='joe@mail.com', Phone='123', MobilePhone='321', Fax='213');
        Database.insert(con);
        
        
        Opportunity opp = new Opportunity(CloseDate = Date.today(), 
        								  Name = 'Test Opportunity', 
        								  StageName = 'Closed Won',
        								  Estimated_Volume__c = 123,
                                   		  Pack_Date_1__c = Date.today(),
                                          Amount = 22  
        								  );
        Database.insert(opp);
        
        Job_Reference__c j = new Job_Reference__c(Opportunity__c = opp.Id);
		Database.insert(j);
		artApp__Artist__c myArtist = new artApp__Artist__c(Name = 'TestCTT', artApp__First_Name__c = 'J1234');
    	Database.insert(myArtist);
    	artApp__Artwork__c myArt = new artApp__Artwork__c(Name= 'TestTitle123', artApp__Artist__c = myArtist.id, Job_Reference__c = j.Id, artApp__Status__c = 'Available');
    	Database.insert(myArt);
	    artApp__Transaction__c t = new artApp__Transaction__c(Job_Reference__c = j.Id, Payment_to_be_Collected__c = 0); 
		Database.insert(t);
		
		Pagereference newPage = Page.CopyToTransaction;
        Test.setCurrentPage(newPage);
        newPage.getParameters().put('id',j.id);
        system.assertEquals(j.id, Apexpages.currentPage().getParameters().get('id'));      
        
        list<artApp__Artwork__c> artworkList = new list<artApp__Artwork__c>{myArt};
        
        ApexPages.StandardSetController sc = new ApexPages.StandardSetController(artworkList);
		CopyToTransactionConExt myTest = new CopyToTransactionConExt(sc);
		
		myTest.t.artApp__Transaction__c = t.ID;
		List<CopyToTransactionConExt.ArtworkWrapper> artworks = myTest.getArtworks();
		artworks[0].isSelected = true;
		List<CopyToTransactionConExt.ArtworkWrapper> selectedArtworks = myTest.selectedArtworks;
		
		myTest.addSelected();
		myTest.copyArtwork();
		
		myTest.filter();
		myTest.search();
        myTest.nameSearchFld = 'Test%';
        myTest.search();
        myTest.sortDesc = false;
        myTest.sort();
        myTest.sortDesc = true;
        myTest.sort();
        myTest.first();
        myTest.next();
        myTest.previous();
        myTest.last();
        myTest.getHasNext();
        myTest.getHasPrevious();
        myTest.getPageCount();
        myTest.getPageNumber();
        myTest.setPageNumber(1);
        myTest.getRenderResults();
        myTest.getResultSize();
        myTest.getController ();
        myTest.save();
        myTest.cancel();
        
        artApp__Collector__c col = new artApp__Collector__c(Name = 'TestJoe');
        Database.insert(col);	
        newPage.getParameters().put('id',col.id);
        CopyToTransactionConExt myTest2 = new CopyToTransactionConExt(sc);
		
        
    }
}