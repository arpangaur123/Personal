public class artworkCon {
	
	String transactionID = ApexPages.currentPage().getParameters().get('id');
		
	/* List to hold Artwork records */
	public List<artApp__Artwork__c>listArtwork = new List<artApp__Artwork__c>();
	public List<artApp__Artwork__c>listArtwork2 = new List<artApp__Artwork__c>();
	
	/* List to hold Line Items records */
	public List<artApp__Line_Item__c>listLineItems = new List<artApp__Line_Item__c>();
	
	/* List to hold innerClass records */
	public List<innerClass>firstInner {get;set;}
	
	/* Indicator for deleted row */
	public String selectedRowIndex {get; set;}
	
	/* Counter for records added to inner class List */
	public Integer count = 1;
	
	String myCurrentURL;

	String collectorID;
	String permitNo;
	String counter;
	
	public PageReference save() {
		/* Prepare variables to store into step 2 URL */
		collectorID = firstInner[0].myArtwork.artApp__Collector__c;
		permitNo = firstInner[0].myArtwork.II_Permit_No__c;
		System.debug('MY COLLECTOR ID ******************* ' + collectorID);
		System.debug('MY PERMIT NUMBER ****************** ' + permitNo);
		Record_Type_Counter__c rtc = [SELECT Name, Count__c FROM Record_Type_Counter__c WHERE Name='Artapp Count'];
		system.debug('***********COUNTer************' + rtc.Count__c);
		
		counter = String.valueOf(rtc.Count__c);
		
		system.debug('***********************' + counter);
		rtc.Count__c++;
		update rtc;
		
		for (Integer i=0;i<firstInner.size();i++) {
			firstInner[i].myArtwork.counter__c = Integer.valueof(counter);
			firstInner[i].myArtwork.II_Permit_No__c = firstInner[0].myArtwork.II_Permit_No__c;
			firstInner[i].myArtwork.II_Permit_Declared_Date__c = firstInner[0].myArtwork.II_Permit_Declared_Date__c;
			firstInner[i].myArtwork.artApp__Collector__c = firstInner[0].myArtwork.artApp__Collector__c;
			firstInner[i].myArtwork.Job_No__c = firstInner[0].myArtwork.Job_No__c;
			firstInner[i].myArtwork.artApp__Exhibition__c = firstInner[0].myArtwork.artApp__Exhibition__c;
			
			listArtwork.add(firstInner[i].myArtwork);
		}
		insert listArtwork;
		addArtworksToLineItems();
		return step2();
	}
	
	public void addArtworksToLineItems() {
		listArtwork2 = [SELECT id FROM artApp__Artwork__c 
        WHERE counter__c =: Integer.valueof(counter)];
        
		/* Populate Line Items records */
		Integer z=0;
		for (artApp__Artwork__c artwork : listArtwork2) {
			firstInner[z].myLineItem.artApp__Transaction__c=transactionID;
			system.debug(' ======= ARTWORK ID ========= ' + artwork.Id);
			firstInner[z].myLineItem.artApp__Artwork__c = artwork.Id;
			
			listLineItems.add(firstInner[z].myLineItem);
			z++;
		}/*End of FOR loop*/
		
		insert listLineItems;
	}/*End of addArtworksToLineItems*/
	
	public void add() {
		/*Increment counter*/
		count = count + 1;
		addRow();
	}/*End of Add*/
	
	public void addRow() {
		innerClass innerObjClass = new innerClass(count);
		firstInner.add(innerObjClass);
		System.debug('FIRST INNERCLASS**************' + firstInner);
	}/*End of addRow*/
	
	/* Delete */
	public void del() {
		system.debug('selected row index---->' + selectedRowIndex);
		firstInner.remove(Integer.valueOf(selectedRowIndex)-1);
		count = count - 1;	
	}/*End delete*/
	
	/* Contructor */
	public artworkCon(ApexPages.StandardController ctlr) {
		firstInner = new List<innerClass>();
		addRow();
		selectedRowIndex = '0';
	}

	/* Define innerClass */
	public class innerClass {
		public String counter {get; set;}
		public artApp__Artwork__c myArtwork {get;set;}
		public artApp__Line_Item__c myLineItem {get;set;}
		
		/*innerClass constructor */
		public innerClass(Integer intCount) {
			counter = String.valueOf(intCount);
			myArtwork = new artApp__Artwork__c();
			myLineItem = new artApp__Line_Item__c();
			
		}/*End of innerClass Constructor*/
	}/*End of innerClass*/
	
	/* Create page navigation */
	public PageReference step2() {
	  listArtwork.clear();
	  listLineItems.clear();
      PageReference artworkPage2 = new PageReference ('/apex/ArtworkStep2');
      artworkPage2.getParameters().put('count',counter);
      artworkPage2.getParameters().put('tid',transactionID);
      artworkPage2.setRedirect(true);
      return artworkPage2;
   }
	/*  test methods below here  */
	static testMethod void testArtCon() {
		PageReference pageRef = Page.ArtworkStep1;
        Test.setCurrentPage(pageRef);
        
        artApp__Artist__c artist = new artApp__Artist__c(Name ='John');
        insert artist;
          
        artApp__Collector__c collector = new artApp__Collector__c(Name = 'Allan', RecordTypeId = '01220000000TzOSAA0');
        insert collector;
        
        artApp__Exhibition__c exhibition = new artApp__Exhibition__c(Name='My Exhibition');
        insert exhibition;
        
        artApp__Artwork__c artwork = new artApp__Artwork__c(artApp__Artist__c = artist.Id);
        insert artwork;
        
        artworkCon con = new artworkCon(new ApexPages.StandardController(artwork));
        
        innerClass innerC = new innerClass(0);
        con.firstInner.add(innerC);
        con.firstInner[0].myArtwork.artApp__Collector__c = collector.Id;
        con.firstInner[0].myArtwork.artApp__Artist__c = artist.Id;
        con.firstInner[0].myArtwork.Name = 'My Artwork';
        con.firstInner[0].myArtwork.RecordTypeId = '01220000000TzOQAA0';
        con.firstInner[0].myArtwork.II_Permit_No__c='permit num 1';
        con.firstInner[0].myArtwork.II_Permit_Declared_Date__c=Date.newInstance(2009, 11, 01);
        con.firstInner[0].myArtwork.artApp__Exhibition__c = exhibition.Id;
        con.firstInner[0].myArtwork.Job_No__c='Job 123';
        
        con.add();
        con.selectedRowIndex = '1';
        con.firstInner[1].myArtwork.artApp__Collector__c = collector.Id;
        con.firstInner[1].myArtwork.artApp__Artist__c = artist.Id;
        con.firstInner[1].myArtwork.Name = 'My Artwork';
        con.firstInner[1].myArtwork.RecordTypeId = '01220000000TzOQAA0';
        con.firstInner[1].myArtwork.II_Permit_No__c='permit num 1';
        con.firstInner[1].myArtwork.II_Permit_Declared_Date__c=Date.newInstance(2009, 11, 01);
        con.firstInner[1].myArtwork.artApp__Exhibition__c = exhibition.Id;
        con.firstInner[1].myArtwork.Job_No__c='Job 123';
        con.del();
        
        //PageReference savePage = con.save();
        //System.assert(savePage.getUrl().contains('ArtworkStep2'));
        
        PageReference step2 = con.step2();
        System.assert(step2.getUrl().contains('ArtworkStep2'));

	}
}