@isTest
public class FC_Artworks_ControllerTestClass {
    Static testmethod void FC_Artworks_ControllerTestClass()
    {
        Freight_Calculator__c fc = new Freight_Calculator__c();
        fc.Collection_City__c = 'Singapore (SIN airport)';
        fc.Destination_City__c = 'Hong Kong (HKG airport)'; 
        insert fc;
        
        Temporary_Artwork__c art = new Temporary_Artwork__c();
        art.Freight_No__c = fc.Id;
        art.Length__c = 50;
        art.Height__c = 20;
        art.Breadth__c = 10;
        art.Chargeable_Weight__c =15;
        insert art;
        
        Temporary_Artwork__c TempArt = new Temporary_Artwork__c();
        TempArt.Freight_No__c = fc.Id;
        TempArt.Chargeable_Weight__c = 0;
        Insert TempArt;
        
           //Temporary_Artwork__c TArt = new Temporary_Artwork__c();
           //TArt.Freight_No__c = fc.Id;
           //TArt.Length__c = null;
           //TArt.Breadth__c = null;
           //TArt.Height__c = null;
           //Insert TArt;
        
        FreightCalc_Airfreight__c far = new FreightCalc_Airfreight__c();
        far.Name = 'Custom_Settings';
        far.Airport_Name__c = 'Singapore (SIN airport)';//Hong Kong (HKG airport)';
        far.Weight__c = 25;
        far.Price__c = 100;
        insert far;

        PageReference PageRef = Page.Fc_ProductsPage; 
        test.setCurrentPage(PageRef);
        ApexPages.CurrentPage().getparameters().put('id', fc.id);
        ApexPages.StandardController sc = new ApexPages.standardController(fc);
        
        FC_Artworks_Controller ctrl = new FC_Artworks_Controller(sc);
        ctrl.newArtwork();
      //ctrl.saveArtworks();
        ctrl.deleteArtwork();
      //ctrl.loadArtworks();
        ctrl.getheaders();
        ctrl.getArtworks();
        ctrl.GoProductsPage();
        ctrl.saveArtworks();
        ctrl.GoCratePage();
        ctrl.Cancel();
    }
}