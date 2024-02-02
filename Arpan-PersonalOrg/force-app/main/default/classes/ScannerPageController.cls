public with sharing class ScannerPageController {
	
	//Declarations
	public Crate__c crate{get;set;}
	public artApp__Artwork__c artwork{get;set;}
	public Task task1{get;set;}
	public Task task2{get;set;}
	public Task task3{get;set;}
	public string collection_string{get;set;}
	public string selectedpickvalue{get;set;}
	public string message{get;set;}
	public string message1{get;set;}
	public list<selectOption> option_list{get;set;}
	public boolean visibleCrate{get;set;}
	public boolean messageFlag{get;set;}
	public boolean visibleStorage{get;set;}
	public boolean visibleSection{get;set;}
	
	//Constructor
	public ScannerPageController(){
		init();
	}
	//Methods
	public list<selectOption> getOptions(){
		option_list = new list<selectOption>();
		option_list.add(new selectOption('--None--','--None--'));
		option_list.add(new selectOption('Crate','Crate'));
		option_list.add(new selectOption('Artwork','Artwork'));
		return option_list;
	}
	
	public void VisibleMethod(){
		messageFlag = false;
		if(selectedpickvalue == 'Crate'){
			visibleCrate = true;
			visibleStorage = false;
		} else if(selectedpickvalue == 'Artwork'){
			visibleCrate = false;
			visibleStorage = true;
		} else{
			visibleCrate = false;
			visibleStorage = false;
		}
		visibleSection = true;
	}
	public void updateSave(){
		message='';
		message1='';
		Set<String> barCodeIdSet = new Set<String>();
		Set<String> barCodeIdSetFound = new Set<String>();
		Set<String> barCodeIdSetNotFound = new Set<String>();
		if(collection_string != Null && collection_string != ''){
			List<String> barCodeList = collection_string.split(',');
			system.debug('-----------barCodeList-----------' + barCodeList);
			//To Avoid Duplicates
			barCodeIdSet.addAll(barCodeList);
		}	
		system.debug('-----------barCodeIdSet-----------' + barCodeIdSet);
		integer barCodeLimit = 25;
		if(System.Label.BarCodeLimit != null && System.Label.BarCodeLimit != '') {
			barCodeLimit = Integer.valueOf(System.Label.BarCodeLimit);
		}
		system.debug('-----------collection_string-----------' + collection_string);
		system.debug('-----------barCodeIdSet.size()-----------' + barCodeIdSet.size());
		system.debug('-----------barCodeLimit-----------' + barCodeLimit);
		if(collection_string != null && collection_string != '') {
			if(barCodeIdSet.size() <= barCodeLimit){
				if(selectedpickvalue == 'Crate'){
					List<Crate__c> crateList = [select Name,id,Date_In__c,Date_Out__c,Location__c from Crate__c where Name in: barCodeIdSet];
                    system.debug('-----------crateList-----------' + crateList);
	                if(crateList != null && crateList.size() > 0) {
	                    for(Crate__c c: crateList) {
	                        if(barCodeIdSet.contains(c.Name)) {
	                            barCodeIdSetFound.add(c.Name);
	                        }
	                        if(task1.ActivityDate != null) {
	                            c.Date_In__c = task1.ActivityDate;
	                        }
	                        if(task2.ActivityDate != null) {
	                            c.Date_Out__c = task2.ActivityDate;
	                        }
	                        if(task3.ActivityDate != null) {
                                c.Physical_Check_done_on__c = task3.ActivityDate;
                            }
	                        if(crate.Location__c != null) {
	                            c.Location__c = crate.Location__c;
	                        }
	                    }
	                    update crateList;
	                    message = 'Total number of Crate(s) updated [' + crateList.size() + ']. ';
	                }
				} else if(selectedpickvalue == 'Artwork') {
					List<artApp__Artwork__c> artworkList = [select Barcode_ID__c,id,Date_In__c,Date_Out__c,Physical_Check_done_on__c,Internal_Location__c 
                                                           from artApp__Artwork__c where Barcode_ID__c in: barCodeIdSet];
	                system.debug('-----------artworkList-----------' + artworkList);
	                if(artworkList != null && artworkList.size() > 0) {
	                    system.debug('-----------barCodeIdSet-----------' + barCodeIdSet);
	                    for(artApp__Artwork__c a: artworkList) {
	                        system.debug('-----------a.Barcode_ID__c-----------' + a.Barcode_ID__c);
	                        if(barCodeIdSet.contains(a.Barcode_ID__c)) {
	                           barCodeIdSetFound.add(a.Barcode_ID__c);
	                        }
	                        if(task1.ActivityDate != null) {
	                            a.Date_In__c = task1.ActivityDate;
	                        }
	                        if(task2.ActivityDate != null) {
	                            a.Date_Out__c = task2.ActivityDate;
	                        }
	                        if(task3.ActivityDate != null) {
	                            a.Physical_Check_done_on__c = task3.ActivityDate;
	                        }
	                        if(artwork.Internal_Location__c != null) {
	                            a.Internal_Location__c = artwork.Internal_Location__c;
	                        }
	                    }
	                    update artworkList;
	                    message = 'Total number of Artwork(s) updated [' + artworkList.size() + ']. ';
	                }
	                
				}
				
				for(String str: barCodeIdSet) {
					if(!barCodeIdSetFound.contains(str)) {
						barCodeIdSetNotFound.add(str);
					}
				}
				
				system.debug('-----------barCodeIdSet-----------' + barCodeIdSet);
	            system.debug('-----------barCodeIdSetFound-----------' + barCodeIdSetFound);
	            system.debug('-----------barCodeIdSetNotFound-----------' + barCodeIdSetNotFound);
	            
				if(barCodeIdSetNotFound != null && barCodeIdSetNotFound.size() > 0) {
					if(selectedpickvalue == 'Crate'){
						message1 = 'Unable to find Crate(s) with Barcode(s): ' + barCodeIdSetNotFound + '.';
					} else if(selectedpickvalue == 'Artwork') {
						message1 = 'Unable to find Artwork(s) with Barcode(s): ' + barCodeIdSetNotFound + '.';
					}
				}
				system.debug('-----------message-----------' + message);
	            collection_string = '';
	            messageFlag = true;
			} else {
				messageFlag = true;
                message = 'The maximum number of BarCodes allowed are ' + barCodeLimit + '.';
                message1 = '';
			}	
		} else {
			messageFlag = true;
			message = 'Please enter atleast 1 BarCode.';
			message1 = '';
		}
	}
	
	public void init() {
		visibleSection = false;
		collection_string = '';
        crate = new Crate__c();
        artwork = new artApp__Artwork__c();
        task1 = new Task();
        task2 = new Task();
        task3 = new Task();
        visibleCrate = false;
        visibleStorage = false;
        selectedpickvalue = '--None--';
	}
	
	
}