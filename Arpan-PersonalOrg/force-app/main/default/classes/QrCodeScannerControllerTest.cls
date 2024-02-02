@isTest
public class QrCodeScannerControllerTest {
    @isTest
    public static void testRun1(){
        Opportunity newOppty = new Opportunity();
        newOppty.StageName = 'Prospecting';
        newOppty.Name = 'Test Oppty';
        newOppty.CloseDate = system.today();
        newOppty.Estimated_Volume__c = 10;
        newOppty.Pack_Date_1__c = system.today();
        newOppty.Amount = 100;
        insert newOppty; 
        
       /* Costing_Sheet__c newCostingSheet = new Costing_Sheet__c();
        newCostingSheet.Costing_Sheet_Id__c ='abc';
        newCostingSheet.Opportunity__c = newOppty.id;
        insert newCostingSheet;*/
        
        newOppty.StageName = 'Closed Won';
      //  newOppty.Approved_Costing_Sheet__c = newCostingSheet.id;
        update newOppty;

        
        Job_Reference__c newJobReference = new Job_Reference__c();
        newJobReference.Name = 'New Job Reference';
        newJobReference.Opportunity__c =  newOppty.id;
        insert newJobReference;
        artApp__Collector__c newCollector = new artApp__Collector__c();
        newCollector.Name = 'New Collector';
        insert newCollector; 
        
        artApp__Artist__c newArtist = new artApp__Artist__c();
        newArtist.Name = 'New Artist';
        insert newArtist;
        Crate__c sampleCrate = new Crate__c();
        sampleCrate.Name = 'Sample Crate';
        sampleCrate.Date_In__c = Date.today();
        sampleCrate.Height__c = 10;
        sampleCrate.Width__c = 10;
        sampleCrate.Length__c = 10;
        sampleCrate.Job_Reference__c = newJobReference.id;
        sampleCrate.myCollector__c = newCollector.id;
        insert sampleCrate;
        artApp__Artwork__c newArtWork = new artApp__Artwork__c();
        newArtWork.Name = 'Sample Artwork';
        newArtWork.artApp__Artist__c = newArtist.id;
        newArtWork.Crate__c = sampleCrate.id; 
        insert newArtWork;
        
        PageReference pageRef = Page.QrCodeScanner;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id',sampleCrate.id);
        QrCodeScannerController inst = new QrCodeScannerController();
    }
     @isTest
    public static void testRun2(){
        Opportunity newOppty = new Opportunity();
        newOppty.StageName = 'Prospecting';
        newOppty.Name = 'Test Oppty';
        newOppty.CloseDate = system.today();
        newOppty.Estimated_Volume__c = 10;
        newOppty.Pack_Date_1__c = system.today();
        newOppty.Amount = 100;
        insert newOppty; 
        
        /* Costing_Sheet__c newCostingSheet = new Costing_Sheet__c();
        newCostingSheet.Costing_Sheet_Id__c ='abc';
        newCostingSheet.Opportunity__c = newOppty.id;
        insert newCostingSheet;*/
        
        newOppty.StageName = 'Closed Won';
      //  newOppty.Approved_Costing_Sheet__c = newCostingSheet.id;
        update newOppty;

        
        Job_Reference__c newJobReference = new Job_Reference__c();
        newJobReference.Name = 'New Job Reference';
        newJobReference.Opportunity__c =  newOppty.id;
        insert newJobReference;
        artApp__Collector__c newCollector = new artApp__Collector__c();
        newCollector.Name = 'New Collector';
        insert newCollector; 
        
        artApp__Artist__c newArtist = new artApp__Artist__c();
        newArtist.Name = 'New Artist';
        insert newArtist;
        
        Location__c newLocation = new Location__c();
        newLocation.Name = 'ATL-E1';
        insert newLocation; 
        
        Crate__c sampleCrate = new Crate__c();
        sampleCrate.Name = 'Sample Crate';
        sampleCrate.Location__c = newLocation.id;
        sampleCrate.Date_In__c = Date.today();
        sampleCrate.Height__c = 10;
        sampleCrate.Width__c = 10;
        sampleCrate.Length__c = 10;
        sampleCrate.Job_Reference__c = newJobReference.id;
        sampleCrate.myCollector__c = newCollector.id;
        insert sampleCrate;
        artApp__Artwork__c newArtWork = new artApp__Artwork__c();
        newArtWork.Name = 'Sample Artwork';
        newArtWork.artApp__Artist__c = newArtist.id;
        newArtWork.Crate__c = sampleCrate.id; 
        insert newArtWork;
        
        PageReference pageRef = Page.QrCodeScanner;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id',sampleCrate.id);
        QrCodeScannerController inst = new QrCodeScannerController();
    }
     @isTest
    public static void testRun3(){
        Opportunity newOppty = new Opportunity();
        newOppty.StageName = 'Prospecting';
        newOppty.Name = 'Test Oppty';
        newOppty.CloseDate = system.today();
        newOppty.Estimated_Volume__c = 10;
        newOppty.Pack_Date_1__c = system.today();
        newOppty.Amount = 100;
        insert newOppty; 
        
        /* Costing_Sheet__c newCostingSheet = new Costing_Sheet__c();
        newCostingSheet.Costing_Sheet_Id__c ='abc';
        newCostingSheet.Opportunity__c = newOppty.id;
        insert newCostingSheet;*/
        
        newOppty.StageName = 'Closed Won';
      //  newOppty.Approved_Costing_Sheet__c = newCostingSheet.id;
        update newOppty;

        
        Job_Reference__c newJobReference = new Job_Reference__c();
        newJobReference.Name = 'New Job Reference';
        newJobReference.Opportunity__c =  newOppty.id;
        insert newJobReference;
        artApp__Collector__c newCollector = new artApp__Collector__c();
        newCollector.Name = 'New Collector';
        insert newCollector; 
        
        artApp__Artist__c newArtist = new artApp__Artist__c();
        newArtist.Name = 'New Artist';
        insert newArtist;
        
        Location__c newLocation = new Location__c();
        newLocation.Name = 'Released ATL-E1';
        insert newLocation; 
        
        Crate__c sampleCrate = new Crate__c();
        sampleCrate.Name = 'Sample Crate';
        sampleCrate.Location__c = newLocation.id;
        sampleCrate.Date_In__c = Date.today();
        sampleCrate.Height__c = 10;
        sampleCrate.Width__c = 10;
        sampleCrate.Length__c = 10;
        sampleCrate.Job_Reference__c = newJobReference.id;
        sampleCrate.myCollector__c = newCollector.id;
        insert sampleCrate;
        artApp__Artwork__c newArtWork = new artApp__Artwork__c();
        newArtWork.Name = 'Sample Artwork';
        newArtWork.artApp__Artist__c = newArtist.id;
        newArtWork.Crate__c = sampleCrate.id; 
        insert newArtWork;
        
        PageReference pageRef = Page.QrCodeScanner;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id',sampleCrate.id);
        QrCodeScannerController inst = new QrCodeScannerController();
    }
     @isTest
    public static void testRun4(){
        PageReference pageRef = Page.QrCodeScanner;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id','');
        QrCodeScannerController inst = new QrCodeScannerController();
    }
}