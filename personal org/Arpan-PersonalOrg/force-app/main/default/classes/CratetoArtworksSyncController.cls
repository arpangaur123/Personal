public class CratetoArtworksSyncController {

        Crate__c crateRecord;
        public list<ArtworkWrapper> artworksList {get;set;}
        public Boolean jobReferenceNumber {get;set;}
        public Boolean location {get;set;}
        public Boolean dateIn {get;set;}
        public Boolean dateout {get;set;}
        public Boolean collector {get;set;}
        public Boolean allChecked { get; set; }

        public CratetoArtworksSyncController(ApexPages.StandardController sc)
        {
                crateRecord = new Crate__c();
                artworksList = new list<ArtworkWrapper>();
                
                crateRecord = (Crate__c)sc.getRecord();
                artworksList = updateArtworkList();
        }

        private list<ArtworkWrapper> updateArtworkList()
        {
                artworksList.clear();
                list<ArtworkWrapper> awList = new list<ArtworkWrapper>();
                ArtworkWrapper awRec = null;
                for(artApp__Artwork__c aw: [select id, Name, artApp__Artist__c, artApp__Artist__r.Name,Shared_Crate__c ,Item_No__c,Job_Reference__c, Job_Reference__r.Name, Date_In__c, Date_Out__c, 
                                                                        Internal_Location__c,Barcode_ID__c, Internal_Location__r.Name, artApp__Collector__c,artApp__Collector__r.Name, Collection_No__c 
                                                                        from artApp__Artwork__c where Crate__c =: crateRecord.id
                                                                        and (Job_Reference__c !=: crateRecord.Job_Reference__c
                                                                        or Internal_Location__c !=: crateRecord.Location__c
                                                                        or Date_In__c !=: crateRecord.Date_In__c or Date_Out__c !=: crateRecord.Date_Out__c
                                                                        or artApp__Collector__r.Name !=: crateRecord.myCollector__c) limit 1000]){
                        awRec = new ArtworkWrapper(aw);
                        awList.add(awRec);
                }
                return awList;
        }

        public PageReference CheckAll(){
        
            for(ArtworkWrapper art : artworksList){
               art.selected = allChecked;
            }
  
        return null;
        }
        
        
        public PageReference syncArtworks()
        {
                if(!jobReferenceNumber && !location && !dateIn && !dateout && !collector)
                {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Please select at least one Crate field from below section to Sync.'));
                        return null;
                }
                
                list<artApp__Artwork__c> awRecordstoSync = new list<artApp__Artwork__c>();
                artApp__Artwork__c awRec = null;
                Boolean updateRecFlag = false;
                if(!artworksList.isEmpty())
                {
                        for(ArtworkWrapper aw: artworksList)
                        {
                                if(aw.selected)
                                {
                                        awRec = new artApp__Artwork__c();
                                        awRec.Id = aw.artwork.id;
                                        
                                        if(jobReferenceNumber && crateRecord.Job_Reference__c != aw.artwork.Job_Reference__c){
                                                awRec.Job_Reference__c = crateRecord.Job_Reference__c;
                                                aw.jrName = crateRecord.Job_Reference__r.Name;
                                                updateRecFlag = true;
                                        }
                                        
                                        if(location && crateRecord.Location__c != aw.artwork.Internal_Location__c){
                                                awRec.Internal_Location__c = crateRecord.Location__c;
                                                aw.locName = crateRecord.Location__r.Name;      
                                                updateRecFlag = true;
                                        }
                                        
                                        if(dateIn && crateRecord.Date_In__c != aw.artwork.Date_In__c){
                                                awRec.Date_In__c = crateRecord.Date_In__c;
                                                aw.artwork.Date_In__c = crateRecord.Date_In__c;
                                                updateRecFlag = true;
                                        }
                                        
                                        if(dateout && crateRecord.Date_Out__c != aw.artwork.Date_Out__c){
                                                awRec.Date_Out__c = crateRecord.Date_Out__c;
                                                aw.artwork.Date_Out__c = crateRecord.Date_Out__c;
                                                updateRecFlag = true;
                                        }
                                        
                                        if(collector && crateRecord.myCollector__c != aw.artwork.artApp__Collector__c){
                                                awRec.artApp__Collector__c = crateRecord.myCollector__c;
                                                aw.artwork.artApp__Collector__c = crateRecord.myCollector__c;
                                                updateRecFlag = true;
                                        }
                                        
                                        if(updateRecFlag)
                                                awRecordstoSync.add(awRec);
                                        
                                        updateRecFlag = false;
                                        aw.selected = false;
                                }
                        }
                        
                        if(!awRecordstoSync.isEmpty())
                        {
                                try{
                                        update awRecordstoSync;
                                        //artworksList = updateArtworkList();
                                        jobReferenceNumber = false;
                                        location = false;
                                        dateIn = false;
                                        dateout = false;
                                        collector = false;
                                }catch(Exception e){
                                        system.debug('Message == '+e.getMessage());
                                        system.debug('Line Number == '+e.getLineNumber());
                                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'An error occured during the Sync process, please try after some time.'));
                                }
                        }
                }
                //PageReference pageRef = new PageReference('/apex/CratetoArtworksSync?id='+ crateRecord.Id);
               // pageRef.setRedirect(true);
               // return pageRef;
               return null;
        }

        
        public class ArtworkWrapper{
                public artApp__Artwork__c artwork {get;set;}
                public Boolean selected {get;set;}
                public string jrName {get;set;}
                public string locName {get;set;}
                
                public ArtworkWrapper(artApp__Artwork__c aw){
                        artwork = aw;
                        jrName = aw.Job_Reference__r.Name;
                        locName = aw.Internal_Location__r.Name;
                        selected = false;
                }
                
        }

}