@isTest
public class MyPagingController2test{
    
    static testMethod void myPage_Test()
        
    {
        
        //Test converage for the myPage visualforce page
        
        PageReference pageRef = Page.myPaging2;
        myPagingController2 myPageCon = new myPagingController2();
        
        Test.setCurrentPageReference(pageRef);
        //try{
        
        
        myPageCon.getTotalPageNumber();
        myPageCon.showArtist = false;
        myPageCon.showBarCode = false;
        myPageCon.showDimension = false;
        myPageCon.showExhibition = false;
        myPageCon.showLotNo = false;
        myPageCon.showTitle = false;
        myPageCon.showImage = false;
        myPageCon.showItemNo = false;
        myPageCon.showConditionReport = false;
        
        myPageCon.showgst = false;
        myPageCon.showbondstatus = false;
        myPageCon.goBack();
        
        myPageCon.showArtist = true;
        myPageCon.showBarCode = true;
        myPageCon.showDimension = true;
        myPageCon.showExhibition = true;
        myPageCon.showLotNo = true;
        myPageCon.showTitle = true;
        myPageCon.showImage = true;
        myPageCon.showItemNo = true;
        myPageCon.showConditionReport = true;
        myPageCon.goBack();
        // }
        // catch(Exception e){}
        String magi = 'name ASC';
        //create records
        
        //artist records
        list<artApp__Artist__c> artistList = new list<artApp__Artist__c>();
        artApp__Artist__c artistRec = new artApp__Artist__c(Name = 'Pankaj');
        artistList.add(artistRec);
        artApp__Artist__c artistRec1 = new artApp__Artist__c(Name = 'Prashant');
        artistList.add(artistRec1);
        artApp__Artist__c artistRec2 = new artApp__Artist__c(Name = 'Saurabh');
        artistList.add(artistRec2);
        artApp__Artist__c artistRec3 = new artApp__Artist__c(Name = 'Pranav');
        artistList.add(artistRec3);
        artApp__Artist__c artistRec4 = new artApp__Artist__c(Name = 'Pranathi');
        artistList.add(artistRec4);
        
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
        
        //Antony@TMC Starts here .  Opportunity Creation for Test Class 6th July 2015
        
        Opportunity heluTransOpp     = new Opportunity();
        heluTransOpp.Name        = 'Test Helutrans';
        heluTransOpp.Type        = 'Artmove';
        heluTransOpp.StageName   = 'Closed Lost';
        heluTransOpp.CloseDate   = Date.today() ;
        heluTransOpp.Estimated_Volume__c = 200;
        heluTransOpp.Pack_Date_1__c  = Date.today() ;
        heluTransOpp.Amount = 100;   
        heluTransOpp.Reason_Lost__c = 'Test';
        insert heluTransOpp;
        heluTransOpp.StageName   = 'Closed Won';
        update heluTransOpp;
        system.debug('>>>>>>>>>>>>>>>>>'+heluTransOpp);
        // Antony Ends here. Opportunity Creation ends here.         
        
        //Job Reference records
        list<Job_Reference__c> jobRefList = new list<Job_Reference__c>();
        Job_Reference__c jobRefRec = new Job_Reference__c(Name = 'AERC1753945');
        jobRefRec.Opportunity__c = heluTransOpp.Id;  // Antony@TMC - 6/7/2015 
        jobRefList.add(jobRefRec);
        
        Job_Reference__c jobRefRec1 = new Job_Reference__c(Name = 'AGRT1856942');
        jobRefRec.Opportunity__c = heluTransOpp.Id;   // Antony@TMC - 6/7/2015
        jobRefList.add(jobRefRec1);
        
        Job_Reference__c jobRefRec2 = new Job_Reference__c(Name = 'GRT18569421');
        jobRefRec.Opportunity__c = heluTransOpp.Id;    // Antony@TMC - 6/7/2015
        jobRefList.add(jobRefRec2);
        try{
            insert jobRefList;}catch(exception e){}
        
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
        
        list<artApp__Collector__c> collecList = new list<artApp__Collector__c>();
        artApp__Collector__c coolectRec = new artApp__Collector__c(RecordTypeId = artistRT.Id,Name='PaintingArtist',artApp__Contact_Last_Name__c = 'Aruv');
        collecList.add(coolectRec);
        artApp__Collector__c coolectRec1 = new artApp__Collector__c(RecordTypeId = auctHouRT.Id,Name='AuctionHall',artApp__Contact_Last_Name__c = 'Arjun',artApp__Email__c = 'arjun@noemail.com'); //myPageCon.currentEmail);
        collecList.add(coolectRec1);
        artApp__Collector__c coolectRec2 = new artApp__Collector__c(RecordTypeId = auctHouRT.Id,Name='PaintingHall',artApp__Contact_Last_Name__c = 'Abhijith',artApp__Email__c = 'abhijit@noemail.com'); //myPageCon.currentEmail);
        collecList.add(coolectRec2);
        artApp__Collector__c coolectRec3 = new artApp__Collector__c(RecordTypeId = priavteCollectorRT.Id,Name='Artist',artApp__Contact_Last_Name__c = 'Abhay',artApp__Email__c = 'abhay@noemail.com'); //myPageCon.currentEmail);
        collecList.add(coolectRec3);
        artApp__Collector__c coolectRec4 = new artApp__Collector__c(RecordTypeId = priavteCollectorRT.Id,Name='Creator',artApp__Contact_Last_Name__c = 'Ariva',artApp__Email__c =  'ariva@noemail.com'); //myPageCon.currentEmail);
        collecList.add(coolectRec4);
        //artApp__Email__c = helutrans@techmatrixconsulting.com
        insert collecList;
        
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
        artList.add(artRec);
        
        artApp__Artwork__c artRec1 = new artApp__Artwork__c();
        artRec1.Barcode_ID__c = 'ART13434';
        artRec1.Item_No__c = 'ITM7235';
        artRec1.Lot_No__c = 'JI2756';
        artRec1.artApp__Exhibition__c = exhibRec.Id;
        artRec1.Job_Reference__c = jobRefRec.Id;
        artRec1.artApp__Collector__c = coolectRec.Id;
        artRec1.artApp__Artist__c = artistRec.Id;
        artRec1.Name = 'Wedding';
        artList.add(artRec1);
        
        artApp__Artwork__c artRec2 = new artApp__Artwork__c();
        artRec2.Barcode_ID__c = 'ART18592';
        artRec2.Item_No__c = 'ITM7465';
        artRec2.Lot_No__c = 'EB2756';
        artRec2.artApp__Exhibition__c = exhibRec.Id;
        artRec2.Job_Reference__c = jobRefRec.Id;
        artRec2.artApp__Collector__c = coolectRec.Id;
        artRec2.artApp__Artist__c = artistRec.Id;
        artRec2.Name = 'Wind';
        artList.add(artRec2);
        
        artApp__Artwork__c artRec3 = new artApp__Artwork__c();
        artRec3.Barcode_ID__c = 'ART24534';
        artRec3.Item_No__c = 'ITM8435';
        artRec3.Lot_No__c = 'BA2756';
        artRec3.artApp__Exhibition__c = exhibRec.Id;
        artRec3.Job_Reference__c = jobRefRec.Id;
        artRec3.artApp__Collector__c = coolectRec1.Id;
        artRec3.artApp__Artist__c = artistRec1.Id;
        artRec3.Name = 'ART';
        artList.add(artRec3);
        
        artApp__Artwork__c artRec4 = new artApp__Artwork__c();
        artRec4.Barcode_ID__c = 'ART18304';
        artRec4.Item_No__c = 'ITM9 435';
        artRec4.Lot_No__c = 'GW2756';
        artRec4.artApp__Exhibition__c = exhibRec.Id;
        artRec4.Job_Reference__c = jobRefRec.Id;
        artRec4.artApp__Collector__c = coolectRec1.Id;
        artRec4.artApp__Artist__c = artistRec1.Id;
        artRec4.Name = 'BacholearLife';
        artList.add(artRec4);
        
        artApp__Artwork__c artRec5 = new artApp__Artwork__c();
        artRec5.Barcode_ID__c = 'RT185345';
        artRec5.Item_No__c = 'ITM7465';
        artRec5.Lot_No__c = 'SE2756';
        artRec5.artApp__Exhibition__c = exhibRec.Id;
        artRec5.Job_Reference__c = jobRefRec1.Id;
        artRec5.artApp__Collector__c = coolectRec1.Id;
        artRec5.artApp__Artist__c = artistRec1.Id;
        artRec5.Name = 'BuddyList';
        artList.add(artRec5);
        
        artApp__Artwork__c artRec6 = new artApp__Artwork__c();
        artRec6.Barcode_ID__c = 'AR185364';
        artRec6.Item_No__c = 'ITM2435';
        artRec6.Lot_No__c = 'KD2756';
        artRec6.artApp__Exhibition__c = exhibRec.Id;
        artRec6.Job_Reference__c = jobRefRec1.Id;
        artRec6.artApp__Collector__c = coolectRec2.Id;
        artRec6.artApp__Artist__c = artistRec2.Id;
        artRec6.Name = 'PartyCulture';
        artList.add(artRec6);
        
        artApp__Artwork__c artRec7 = new artApp__Artwork__c();
        artRec7.Barcode_ID__c = 'AT182534';
        artRec7.Item_No__c = 'ITM0435';
        artRec7.Lot_No__c = 'RJ2756';
        artRec7.artApp__Exhibition__c = exhibRec.Id;
        artRec7.Job_Reference__c = jobRefRec1.Id;
        artRec7.artApp__Collector__c = coolectRec2.Id;
        artRec7.artApp__Artist__c = artistRec2.Id;
        artRec7.Name = 'PainAndGain';
        artList.add(artRec7);
        
        artApp__Artwork__c artRec8 = new artApp__Artwork__c();
        artRec8.Barcode_ID__c = 'RF192834';
        artRec8.Item_No__c = 'ITM7585';
        artRec8.Lot_No__c = 'ZW2756';
        artRec8.artApp__Exhibition__c = exhibRec1.Id;
        artRec8.Job_Reference__c = jobRefRec1.Id;
        artRec8.artApp__Collector__c = coolectRec2.Id;
        artRec8.artApp__Artist__c = artistRec2.Id;
        artRec8.Name = 'PaintTheWorld';
        artList.add(artRec8);
        
        artApp__Artwork__c artRec9 = new artApp__Artwork__c();
        artRec9.Barcode_ID__c = 'ER192634';
        artRec9.Item_No__c = 'ITM5425';
        artRec9.Lot_No__c = 'DF2756';
        artRec9.artApp__Exhibition__c = exhibRec1.Id;
        artRec9.Job_Reference__c = jobRefRec1.Id;
        artRec9.artApp__Collector__c = coolectRec3.Id;
        artRec9.artApp__Artist__c = artistRec3.Id;
        artRec9.Name = 'FollowYourself';
        artList.add(artRec9);
        
        artApp__Artwork__c artRec10 = new artApp__Artwork__c();
        artRec10.Barcode_ID__c = 'EF192345';
        artRec10.Item_No__c = 'ITM1435';
        artRec10.Lot_No__c = 'VB2756';
        artRec10.artApp__Exhibition__c = exhibRec2.Id;
        artRec10.Job_Reference__c = jobRefRec2.Id;
        artRec10.artApp__Collector__c = coolectRec3.Id;
        artRec10.artApp__Artist__c = artistRec3.Id;
        artRec10.Name = 'DirtyMind';
        artList.add(artRec10);
        
        artApp__Artwork__c artRec11 = new artApp__Artwork__c();
        artRec11.Barcode_ID__c = 'GTF18534';
        artRec11.Item_No__c = 'ITM7855';
        artRec11.Lot_No__c = 'HG2756';
        artRec11.artApp__Exhibition__c = exhibRec2.Id;
        artRec11.Job_Reference__c = jobRefRec2.Id;
        artRec11.artApp__Collector__c = coolectRec3.Id;
        artRec11.artApp__Artist__c = artistRec3.Id;
        artRec11.Name = 'PlasticGreen';
        artList.add(artRec11);
        
        artApp__Artwork__c artRec12 = new artApp__Artwork__c();
        artRec12.Barcode_ID__c = 'GF185434';
        artRec12.Item_No__c = 'ITM6535';
        artRec12.Lot_No__c = 'AT2756';
        artRec12.artApp__Exhibition__c = exhibRec2.Id;
        artRec12.Job_Reference__c = jobRefRec2.Id;
        artRec12.artApp__Collector__c = coolectRec4.Id;
        artRec12.artApp__Artist__c = artistRec4.Id;
        artRec12.Name = 'WorldInBottle';
        artList.add(artRec12);
        
        artApp__Artwork__c artRec13 = new artApp__Artwork__c();
        artRec13.Barcode_ID__c = 'TF18554';
        artRec13.Item_No__c = 'ITM4435';
        artRec13.Lot_No__c = 'LG2756';
        artRec13.artApp__Exhibition__c = exhibRec2.Id;
        artRec13.Job_Reference__c = jobRefRec2.Id;
        artRec13.artApp__Collector__c = coolectRec4.Id;
        artRec13.artApp__Artist__c = artistRec4.Id;
        artRec13.Name = 'Humanity';
        artList.add(artRec13);
        
        artApp__Artwork__c artRec14 = new artApp__Artwork__c();
        artRec14.Barcode_ID__c = 'GT195342';
        artRec14.Item_No__c = 'ITM4935';
        artRec14.Lot_No__c = 'NT2756';
        artRec14.artApp__Exhibition__c = exhibRec2.Id;
        artRec14.Job_Reference__c = jobRefRec2.Id;
        artRec14.artApp__Collector__c = coolectRec4.Id;
        artRec14.artApp__Artist__c = artistRec4.Id;
        artRec14.Name = 'LovelyEnvironment';
        artList.add(artRec14);
        
        insert artList;
        
        Attachment attRec = new Attachment();
        attRec.Body = Blob.valueOf('This is for Code coverage');
        attRec.ParentId = artRec14.Id;
        attRec.ContentType = 'application/pdf';
        attRec.IsPrivate = false;
        attRec.Name = 'Attack';
        
        insert attRec;
        // create an instance of the controller
        
        
        
        myPagingController2 myPageCon1 = new myPagingController2();
        //try calling methods/properties of the controller in all possible scenarios
        myPageCon1.tempData=artList;
        // to get the best coverage.
        myPageCon1.showHideAction();
        myPageCon1.getItems();
        myPageCon1.next();
        myPageCon1.next();
        myPageCon1.previous();
        myPageCon1.first();
        myPageCon1.last();
        myPageCon1.pageNavigation();
        myPageCon1.limits = '10';
        myPageCon1.changeLimit();
        myPageCon1.setSortDirection('ASC');
        //myPageCon1.
        
        system.currentPageReference().getParameters().put('typeString','exhb');
        myPageCon1.exhibitionSelected = exhibRec2.Name;
        myPageCon1.subfilterClick = true;
        myPageCon1.subFilter();
        myPageCon1.next();
        myPageCon1.previous();
        myPageCon1.first();
        myPageCon1.last();
        
        system.currentPageReference().getParameters().put('typeString','artist');
        myPageCon1.artistSelected = artistRec4.Name;
        myPageCon1.subfilterClick = true;
        myPageCon1.subFilter();
        
        system.currentPageReference().getParameters().put('typeString','lotno');
        myPageCon1.lotnoSelected = 'NT2756';
        myPageCon1.subfilterClick = true;
        myPageCon1.subFilter();
        
        List<artApp__Artwork__c> pageAccounts = myPageCon.getAccounts();
        //myPageCon1.accounts=artList;
        string recordInfo = myPageCon1.getRecordInfo();
        // Integer totalPage = myPageCon1.getTotalPage();
        Integer pageSize = myPageCon1.getPageSize();
        Boolean pageNumber = myPageCon1.getPreviousButtonEnabled();
        Boolean pagerNext = myPageCon1.getNextButtonDisabled();
        Integer totalPageNumber = myPageCon1.getTotalPageNumber();
        Integer pageNumber2 = myPageCon1.getPageNumber();
        Integer totalRecords = myPageCon1.gettotalRecords();
        //String sortDirection = myPageCon.getSortDirection(magi);
        
        myPageCon1.getPageSize();
        //myPageCon.Viewdata();
        myPageCon1.getPreviousButtonEnabled();
        myPageCon1.getNextButtonDisabled();
        myPageCon1.getAccounts();
        myPageCon1.getPageSize();
        myPageCon1.getPreviousButtonEnabled();
        myPageCon1.getNextButtonDisabled();
        myPageCon1.getTotalPageNumber();
        
        //myPageCon1.previousBtnClick();
        myPageCon1.getSortDirection();
        
        //for Reset
        myPageCon1.reset();
        
        //for search records
        myPageCon1.searchText = 's';
        myPageCon1.searchClick = true;
        myPageCon1.searchRecords();
        string recordInfo1 = myPageCon1.getRecordInfo();
        myPageCon1.pageNavigation();
        myPageCon1.next();
        myPageCon1.previous();
        myPageCon1.first();
        //myPageCon1.last();
        myPageCon1.limits = '10';
        myPageCon1.changeLimit();
        system.currentPageReference().getParameters().put('typeString','exhb');
        myPageCon1.exhibitionSelected = exhibRec1.Name;
        myPageCon1.subfilterClick = true;
        myPageCon1.subFilter();
        myPageCon1.next();
        myPageCon1.previous();
        myPageCon1.first();
        //myPageCon1.last();
        myPageCon1.limits = '10';
        myPageCon1.changeLimit();
        myPageCon1.tempData=artList;
        myPageCon1.loadExportPage();
        myPageCon1.imageId='1234';
        myPageCon1.encodeTheChipperTxt();
        //myPageCon.getSortDirection('ASC');
        //delete heluTransOpp;  // Antony@TMC deleting newly created Opportunity test data. 
    }
}