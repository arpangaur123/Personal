@isTest
private class TestCratetoArtworksSyncController {

    static testMethod void myUnitTest() {
        
        Location__c Loc = new Location__c();
        Loc.Name = 'Location';
        insert Loc;
        
        opportunity o=new opportunity();
            o.StageName='Closed Won';
            o.name='Test Opp';
            o.CloseDate=System.TODAY();
            o.Estimated_Volume__c=30;
            o.Pack_Date_1__c=System.TODAY();
            o.Amount=50000;
            o.Quote_Number__c='Test Quote';
            o.OB_Job_Number__c='Test Job Number';
            o.attachment__c='Test Attachment';
            insert o;
            
		Job_Reference__c jobRef= new Job_Reference__c();
			jobRef.Name='Test Job Ref';
			jobRef.Opportunity__c=o.ID;
			insert jobRef;
        
        Crate__c c1 = new Crate__c();
        c1.Name = 'Barcode 1';
        c1.Job_Reference__c = jobRef.id;
        c1.Location__c = Loc.Id;
        c1.Date_In__c = system.today().addDays(-15);
        c1.Date_Out__c = system.today().addDays(20);
        c1.Collection_No__c = 'Test12345';
        insert c1;
              
		artApp__Artist__c artist = new artApp__Artist__c();
        artist.Name = 'Karthik';
        insert artist;
                
        artApp__Artwork__c Artwork = new artApp__Artwork__c();
        Artwork.Barcode_ID__c = 'Barcode 1';
        Artwork.artApp__Artist__c = artist.id;
        Artwork.Crate__c = c1.Id;
        insert Artwork;
        
        
        
        CratetoArtworksSyncController CASC = new CratetoArtworksSyncController(new ApexPages.StandardController(c1));
        
        CASC.jobReferenceNumber = false;
        CASC.location = false;
        CASC.dateIn = false;
        CASC.dateout = false;
        CASC.collector = false;
        
        CASC.syncArtworks();
        
        CASC.jobReferenceNumber = true;
        CASC.location = true;
        CASC.dateIn = true;
        CASC.dateout = true;
        CASC.collector = true;
                
        for(Integer i=0;i<CASC.artworksList.size();i++)
        	CASC.artworksList[i].selected = true;
        	
		CASC.syncArtworks();
        
    }
}