@isTest
private class TestBarcodeScannerController {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        
        Location__c Loc = new Location__c();
        Loc.Name = 'Location';
        insert Loc;
        
        Crate__c c1 = new Crate__c();
        c1.Name = 'Barcode 1';
        c1.Date_In__c = system.today().addDays(-15);
        c1.Date_Out__c = system.today().addDays(20);
        insert c1;
        
        artApp__Artist__c artist = new artApp__Artist__c();
        artist.Name = 'Karthik';
        insert artist;
        
        artApp__Artwork__c Artwork = new artApp__Artwork__c();
        Artwork.Barcode_ID__c = 'Barcode 1';
        Artwork.artApp__Artist__c = artist.id;
        insert Artwork;
        
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
           
		artApp__Collector__c col = new artApp__Collector__c();        
		    col.artApp__Mobile__c = '1234567';
		    col.artApp__Fax__c = '22516464';
		    col.artApp__Contact_First_Name__c = 'Andrew';
		    col.artApp__Contact_Last_Name__c = 'Mayne';
		    col.artApp__Contact_Middle_Name__c = 'Vinod';
		    col.artApp__Title__c = 'Mr';
		    col.artApp__Address_1__c = 'chua';
		    col.artApp__Address_2__c = 'chu kang';
		    col.artApp__City__c = 'bahamas';
		    col.artApp__State_Province__c = 'mehico';
		    col.artApp__Zip_Postal_Code__c = '90201';
		    col.artApp__Country__c = 'Singapore';
		    //col.artAppE2__Account_Id__c = v.AccountId;
		    col.artApp__Email__c = 'acai@mymail.com';
		    col.artApp__Phone__c = '98221453';
		    insert col;
        
        
        BarcodeScannerController BSC = new BarcodeScannerController();
        BSC.getOptions();
        BSC.VisibleMethod();
        BSC.collection_string = c1.Name;
        BSC.selectedpickvalue = 'Crate';
        BSC.crate.Location__c = Loc.id;
        BSC.task1.ActivityDate = system.today();
        BSC.task2.ActivityDate = system.today();
        BSC.task3.ActivityDate = system.today();
        BSC.artwork.Internal_Location__c = Loc.id;
        BSC.crate.Job_Reference__c = jobRef.id;
        BSC.crate.myCollector__c = col.id;
        BSC.artwork.Job_Reference__c = jobRef.id;
        BSC.artwork.artApp__Collector__c = col.id;
        BSC.artwork.Crate__c = c1.id;
        BSC.updateSave();
        BSC.VisibleMethod();
        BSC.selectedpickvalue = 'Artwork';
        BSC.collection_string = c1.Name+','+'Test';
        BSC.updateSave();
        BSC.collection_string = c1.Name+','+'Test'+'Tes';
        BSC.VisibleMethod();
        for(Integer i=0;i<25;i++){
        	BSC.collection_string += ',';
        	BSC.collection_string += 'Test';
        	BSC.collection_string += i;
        }
        BSC.updateSave();
        BSC.VisibleMethod();
        BSC.collection_string = '';
        BSC.updateSave();
        bsc.collection_string='test';
       // update bsc;
       	BSC.pack.Opportunity__c=o.id;
        BSC.pack.Storage_In__c=system.today();
        BSC.updateSave1();
        bsc.chckUpdate();

        
        
        
    }
}