@isTest
public class QrCodeScanOnArtWorkControllerTest {
    @isTest
    public static void testRun1(){
        artApp__Artist__c newArtist = new artApp__Artist__c();
        newArtist.Name = 'New Artist';
        insert newArtist;
        
        artApp__Artwork__c newArtWork = new artApp__Artwork__c();
        newArtWork.Name = 'Sample Artwork';
    	newArtWork.artApp__Artist__c = newArtist.id;
        insert newArtWork;
    	Attachment attachment = new Attachment();
    	attachment.ParentId = newArtWork.id;
        Blob b = Blob.valueOf('Test Data');
    	attachment.Name = 'Test Attachment for Parent';
    	attachment.Body = b;
    	insert(attachment);
        
        PageReference pageRef = Page.QrCodeScannerOnArtWork;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id',newArtWork.id);
		QrCodeScanOnArtWorkController inst = new QrCodeScanOnArtWorkController();
    }
	@isTest
    public static void testRun2(){
        artApp__Artist__c newArtist = new artApp__Artist__c();
        newArtist.Name = 'New Artist';
        insert newArtist;
        
        Location__c newLocation = new Location__c();
        newLocation.Name = 'ATL-E1';
        insert newLocation;
        
        
        
        artApp__Artwork__c newArtWork = new artApp__Artwork__c();
        newArtWork.Name = 'Sample Artwork';
        newArtWork.Internal_Location__c = newLocation.id;
    	newArtWork.artApp__Artist__c = newArtist.id;
        insert newArtWork;
    	Attachment attachment = new Attachment();
    	attachment.ParentId = newArtWork.id;
        Blob b = Blob.valueOf('Test Data');
    	attachment.Name = 'Test Attachment for Parent';
    	attachment.Body = b;
    	insert(attachment);
        
        PageReference pageRef = Page.QrCodeScannerOnArtWork;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id',newArtWork.id);
		QrCodeScanOnArtWorkController inst = new QrCodeScanOnArtWorkController();
    }
    @isTest
    public static void testRun3(){
        artApp__Artist__c newArtist = new artApp__Artist__c();
        newArtist.Name = 'New Artist';
        insert newArtist;
        
        Location__c newLocation = new Location__c();
        newLocation.Name = 'Released ATL-E1';
        insert newLocation;
        
        
        
        artApp__Artwork__c newArtWork = new artApp__Artwork__c();
        newArtWork.Name = 'Sample Artwork';
        newArtWork.Internal_Location__c = newLocation.id;
    	newArtWork.artApp__Artist__c = newArtist.id;
        insert newArtWork;
    	Attachment attachment = new Attachment();
    	attachment.ParentId = newArtWork.id;
        Blob b = Blob.valueOf('Test Data');
    	attachment.Name = 'Test Attachment for Parent';
    	attachment.Body = b;
    	insert(attachment);
        
        PageReference pageRef = Page.QrCodeScannerOnArtWork;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id',newArtWork.id);
		QrCodeScanOnArtWorkController inst = new QrCodeScanOnArtWorkController();
    }
    @isTest
    public static void testRun4(){
        PageReference pageRef = Page.QrCodeScannerOnArtWork;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id','');
		QrCodeScanOnArtWorkController inst = new QrCodeScanOnArtWorkController();
    }
}