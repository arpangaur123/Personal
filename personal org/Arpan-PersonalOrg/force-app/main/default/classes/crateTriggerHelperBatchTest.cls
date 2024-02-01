@isTest 
public class crateTriggerHelperBatchTest {
	static testMethod void testMethod1(){
        artApp__Collector__c lstCollector = new artApp__Collector__c(Name='Test123',artApp__Contact_Last_Name__c='Test Lastname');
        
        insert lstCollector;
        
        Location__c lstLocation = new Location__c(Name='Test123');
        
        insert lstLocation;
        
        Crate__c lstCrate = new Crate__c(Name='Test123',myCollector__c=lstCollector.Id,Location__c=lstLocation.Id,Status__c='Empty',With_Legs__c='Yes',IPPC_Stamp__c='Yes');
		insert lstCrate;
        
        Location__c lstLocationNew = new Location__c(Name='Test1234');
        
        insert lstLocationNew;
        

		Opportunity heluTransOpp     = new Opportunity();
        heluTransOpp.Name        = 'Test Helutrans';
        heluTransOpp.Type        = 'Artmove';
        heluTransOpp.StageName   = 'Closed Won';
        heluTransOpp.CloseDate   = Date.today() ;
        heluTransOpp.Estimated_Volume__c = 200;
        heluTransOpp.Pack_Date_1__c  = Date.today() ;
        heluTransOpp.Amount = 100;   
        heluTransOpp.Reason_Lost__c = 'Test';
        insert heluTransOpp;        
        
        
        //Collectors Records
        List<RecordType> recTypes = [SELECT Id,Name FROM RecordType WHERE sObjectType='artApp__Collector__c'];
        RecordType agentsRT;
        RecordType artistRT;
        RecordType auctHouRT;
        RecordType consultDealerRT;
        RecordType galleryRT;
        RecordType priavteCollectorRT;
        
        for(RecordType rt : recTypes){
            if(rt.Name == 'Agents'){
                agentsRT = rt;
            }
            if(rt.Name == 'Artist'){
                artistRT = rt;
            }
            if(rt.Name == 'Auction House'){
                auctHouRT = rt;
                
            }
            if(rt.Name == 'Consultant/Dealer'){
                consultDealerRT = rt;
            }
            if(rt.Name == 'Gallery'){
                galleryRT = rt;
            }
            if(rt.Name == 'Private Collector'){
                priavteCollectorRT = rt;
            }
        }
        
        
        
        
        //Job Reference records
        list<Job_Reference__c> jobRefList = new list<Job_Reference__c>();
        Job_Reference__c jobRefRec = new Job_Reference__c(Name = 'AERC1753945');
        jobRefRec.Opportunity__c = heluTransOpp.Id;  // Antony@TMC - 6/7/2015 
        jobRefList.add(jobRefRec);
        insert jobRefList;
        
        list<artApp__Collector__c> collecList = new list<artApp__Collector__c>();
        artApp__Collector__c coolectRec = new artApp__Collector__c(RecordTypeId = artistRT.Id,Name='PaintingArtist',artApp__Contact_Last_Name__c = 'Aruv');
        collecList.add(coolectRec);
        
        insert collecList;
        
        //artist records
        list<artApp__Artist__c> artistList = new list<artApp__Artist__c>();
        artApp__Artist__c artistRec = new artApp__Artist__c(Name = 'Pankaj');
        artistList.add(artistRec);
        
        insert artistList;
        
        //Exhibition records
        list<artApp__Exhibition__c> exhibList = new list<artApp__Exhibition__c>();
        artApp__Exhibition__c exhibRec = new artApp__Exhibition__c(Name = 'Palikaa');
        exhibList.add(exhibRec);
        artApp__Exhibition__c exhibRec1 = new artApp__Exhibition__c(Name = 'Sarojini');
        exhibList.add(exhibRec1);
        artApp__Exhibition__c exhibRec2 = new artApp__Exhibition__c(Name = 'LajpatNagar');
        exhibList.add(exhibRec2);
        
        insert exhibList;
        
        
        //Artwork records
        list<artApp__Artwork__c> artList = new list<artApp__Artwork__c>();
        artApp__Artwork__c artRec = new artApp__Artwork__c();
        artRec.Barcode_ID__c = 'ART18534';
        artRec.Item_No__c = 'ITM7435';
        artRec.Lot_No__c = 'LN2756';
        artRec.artApp__Exhibition__c = exhibRec.Id;
        artRec.Job_Reference__c = jobRefRec.Id;
        artRec.artApp__Collector__c = coolectRec.Id;
        artRec.artApp__Artist__c = artistRec.Id;
        artRec.Name = 'GreenParkGirl';
        artRec.Crate__c = lstCrate.Id;
        artList.add(artRec);
        
        insert artList;
        
        
        
        lstCrate.Location__c = lstLocationNew.Id; 
        
        Set<Id> setCrateIds = new Set<Id>();
        
        update lstCrate;
        setCrateIds.add(lstCrate.Id);
        Test.startTest();
			
            crateTriggerHelperBatch obj = new crateTriggerHelperBatch(setCrateIds);
            DataBase.executeBatch(obj); 
            
        Test.stopTest();
    }
}