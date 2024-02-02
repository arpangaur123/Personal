public with sharing class BarcodeScannerController {
    
    //Declarations
    public Crate__c crate{get;set;}
    public artApp__Artwork__c artwork{get;set;}
    public Task task1{get;set;}
    public Task task2{get;set;}
    public Task task3{get;set;}
    public Task task4{get;set;}
    public string collection_string{get;set;}
    public string selectedpickvalue{get;set;}
    public string message{get;set;}
    public string message1{get;set;}
    public string messageTitle{get;set;}
    public list<selectOption> option_list{get;set;}
    public boolean visibleCrate{get;set;}
    public boolean visibleArtWork {get;set;}
    public boolean messageFlag{get;set;}
    public boolean visibleStorage{get;set;}
    public boolean visibleSection{get;set;}
    public boolean messageFlagError{get;set;}
    public boolean messageFlagSuccess{get;set;}

    public Package__c pack{get;set;}
    public boolean packageFields{get;set;}
    public boolean packageBarcode{get;set;}
    public boolean packageButton{get;set;}

    
    //Constructor
    public BarcodeScannerController(){
        init();
    }
    
    //Methods
    public list<selectOption> getOptions(){
        option_list = new list<selectOption>();
        option_list.add(new selectOption('--None--','--None--'));

        User curUser= [select Profile.Name from User where id=:UserInfo.getUserId()];
        set<string> ProfName=new set<String>();
        for(Profile prof :[select name from Profile where Name Like 'HHG%'])
            ProfName.add(prof.Name);
        if(!ProfName.contains(curUser.Profile.Name)){     
            option_list.add(new selectOption('Crate','Crate'));
            option_list.add(new selectOption('Artwork','Artwork'));
        }
        else
            option_list.add(new selectOption('Package','Package'));

        if(curUser.Profile.Name=='System Administrator')
            option_list.add(new selectOption('Package','Package'));
        return option_list;
    }
    
    public void VisibleMethod(){
        messageFlag = false;
        if(selectedpickvalue == 'Crate'){
            visibleCrate = true;
            visibleStorage = false;
            visibleSection = true;
            visibleArtWork  = false;

            packageFields = false;
            packageBarcode = false;
            packageButton = true;
        } else if(selectedpickvalue == 'Artwork'){
            visibleCrate = false;
            visibleStorage = true;
            visibleSection = true;
            visibleArtWork = true;

            packageFields = false;
            packageBarcode = false;
            packageButton = true;
        }
        else if (selectedpickvalue == 'Package'){
            visibleCrate = false;
            visibleStorage = false;
            visibleSection = false;
            visibleArtWork = false;

            packageFields = true;
            packageBarcode = true;
            packageButton = true;
        } else {
            visibleCrate = false;
            visibleStorage = false;
            visibleSection = false;
            visibleArtWork = false;

            packageFields = false;
            packageBarcode = false;
            packageButton = false;
        }
        
    }
    public void chckUpdate(){
        if(selectedpickvalue == 'Package')
            updateSave1();
        else
            updateSave();
    }
    public void updateSave()
    {
        message='';
        message1='';
        messageTitle = '';
        Set<String> barCodeIdSet = new Set<String>();
        Set<String> barCodeIdSetFound = new Set<String>();
        Set<String> barCodeIdSetNotFound = new Set<String>();
        if(collection_string != Null && collection_string != ''){
            List<String> barCodeList = collection_string.split(',');
            system.debug('-----------barCodeList-----------' + barCodeList);
            for(integer i = 0; i < barCodeList.size(); i++){
                barCodeList.set(i,barCodeList.get(i).toUpperCase());
            }
            //To Avoid Duplicates
            barCodeIdSet.addAll(barCodeList);
        }   
        system.debug('-----------barCodeIdSet-----------' + barCodeIdSet);
        integer barCodeLimit = 25;
        if(System.Label.BarCodeLimit != null && System.Label.BarCodeLimit != '') {
            barCodeLimit = Integer.valueOf(System.Label.BarCodeLimit);
        }
        system.debug('-----------collection_string-----------' + collection_string);
        system.debug('-----------barCodeLimit-----------' + barCodeLimit);
        if(collection_string != null && collection_string != '') {
            if(barCodeIdSet.size() <= barCodeLimit){
                if(selectedpickvalue == 'Crate'){
                    List<Crate__c> crateList = [select Cycle_Count__c,Name,id,Date_In__c,Date_Out__c,Location__c from Crate__c where Name in: barCodeIdSet];
                    Set<String> crateSet = new Set<String>(); 
                    system.debug('-----------crateList-----------' + crateList);
                    system.debug('-----------task3.ActivityDate-----------' + task3.ActivityDate);
                    if(crateList != null && crateList.size() > 0) {
                        for(Crate__c c: crateList) {
                            
                            string str;
                            string upperStr;
                            str = c.Name;
                            upperStr = str.toUpperCase();
                            
                            if(barCodeIdSet.contains(upperStr)) {
                                barCodeIdSetFound.add(upperStr);
                                crateSet.add(upperStr);
                            }
                            if(task1.ActivityDate != null) {
                                c.Date_In__c = task1.ActivityDate;
                            }
                            if(task2.ActivityDate != null) {
                                c.Date_Out__c = task2.ActivityDate;
                            }
                            /*if(task3.ActivityDate != null) {
                                c.Physical_Check_done_on__c = task3.ActivityDate;
                            }*/
                            if(task3.ActivityDate != null) {
                                c.Cycle_Count__c= task3.ActivityDate;
                            } 
                            if(crate.Location__c != null) {
                                c.Location__c = crate.Location__c;
                            }
                            if(crate.Job_Reference__c != null) {
                                c.Job_Reference__c = crate.Job_Reference__c;
                            }
                            if(crate.myCollector__c != null) {
                                c.myCollector__c = crate.myCollector__c;
                            }
                        }
                        update crateList;
                        system.debug('-----------crateList-----------' + crateList);
                        message = 'The Total number of records you have successfully updated is ' + crateSet.size() + '.';
                        messageTitle = selectedpickvalue + ' records Updated';
                        messageFlagSuccess = True;
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, messageTitle, message));
                    }
                } else if(selectedpickvalue == 'Artwork') {
                    List<artApp__Artwork__c> artworkList = [select Stock_Check__c,Cycle_Count__c,Barcode_ID__c,id,Date_In__c,Date_Out__c,Internal_Location__c 
                                                           from artApp__Artwork__c where Barcode_ID__c in: barCodeIdSet];
                    system.debug('-----------artworkList-----------' + artworkList);
                    Set<String> artworkSet = new Set<String>();
                    if(artworkList != null && artworkList.size() > 0) {
                        system.debug('-----------barCodeIdSet-----------' + barCodeIdSet);
                        
                        for(artApp__Artwork__c a: artworkList) {
                            
                            string str;
                            string upperStr;
                            str = a.Barcode_ID__c;
                            upperStr = str.toUpperCase();
                            
                            system.debug('-----------a.Barcode_ID__c-----------' + a.Barcode_ID__c);
                            if(barCodeIdSet.contains(upperStr)) {
                               barCodeIdSetFound.add(upperStr);
                               artworkSet.add(upperStr);
                            }
                            if(task1.ActivityDate != null) {
                                a.Date_In__c = task1.ActivityDate;
                            }
                            if(task2.ActivityDate != null) {
                                a.Date_Out__c = task2.ActivityDate;
                            }
                            if(task3.ActivityDate != null) {
                                a.Cycle_Count__c= task3.ActivityDate;
                            }
                            if(task4.ActivityDate != null) {
                                a.Stock_Check__c= task4.ActivityDate;
                            }
                            
                            if(artwork.Internal_Location__c != null) {
                                a.Internal_Location__c = artwork.Internal_Location__c;
                            }
                            if(artwork.Job_Reference__c != null) {
                                a.Job_Reference__c = artwork.Job_Reference__c;
                            }
                            if(artwork.artApp__Collector__c != null) {
                                a.artApp__Collector__c = artwork.artApp__Collector__c;
                            }
                            if(artwork.Crate__c != null) {
                                a.Crate__c = artwork.Crate__c;
                            }
                        }
                        update artworkList;
                        messageTitle = selectedpickvalue + ' records Updated';
                        message = 'The Total number of records you have successfully updated is ' + artworkSet.size() + '.';
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, messageTitle , message));
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
                
                if(barCodeIdSetNotFound != null && barCodeIdSetNotFound.size() > 0) 
                {
                    messageFlagError = True;
                    messageTitle = selectedpickvalue + ' records Not Found';
                    message1 = 'We were unable to find the ' + selectedpickvalue + ' records with the following Barcodes: ';
                    integer i = 1;
                    for(String barCodeId : barCodeIdSetNotFound)
                    {
                        if(i == barCodeIdSetNotFound.size())
                        {
                            message1 = message1 + barCodeId + '.';
                        }
                        else
                        {
                            message1 = message1 + barCodeId + ', ';
                        }
                        i++;
                    }
                    
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, messageTitle, message1));
                }
                system.debug('-----------message-----------' + message);
                collection_string = '';
                messageFlag = true;
            } else {
                messageFlag = true;
                messageTitle = 'Barcode IDs Limit Exceeded';
                message = 'The maximum number of Barcodes you may scan is  ' + barCodeLimit + '. Please contact your System Administrator for an increase in the Limit.';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, messageTitle, message));
                message1 = '';
            }   
        } else {
            messageFlag = true;
            messageTitle = 'Barcode IDs Missing';
            message = 'You are required to enter at least "One" Barcode ID.';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, messageTitle, message));
            message1 = '';
        }
    }
    public void updateSave1(){
        message = 'You have ';
        Set<String> barCodeIdSet = new Set<String>();
        Set<String> barCodeIdSetFound = new Set<String>();
        Set<String> barCodeIdSetNotFound = new Set<String>();
        if(collection_string != Null && collection_string != ''){
            List<String> barCodeList = collection_string.split(',');
            system.debug('-----------barCodeList-----------' + barCodeList);
            for(integer i = 0; i < barCodeList.size(); i++){
                barCodeList.set(i,barCodeList.get(i).toUpperCase());
            }
            //To Avoid Duplicates
            barCodeIdSet.addAll(barCodeList);
        }   
        system.debug('-----------barCodeIdSet-----------' + barCodeIdSet);
        integer barCodeLimit = 25;
        if(System.Label.BarCodeLimit != null && System.Label.BarCodeLimit != '') {
            barCodeLimit = Integer.valueOf(System.Label.BarCodeLimit);
        }
        system.debug('-----------collection_string-----------' + collection_string);
        system.debug('-----------barCodeLimit-----------' + barCodeLimit);
        if(collection_string != null && collection_string != '') {
            if(barCodeIdSet.size() <= barCodeLimit){
                if(selectedpickvalue == 'Package'){
                    List<Package__c> packageList = [select Name,id,Crate__c,Opportunity__c,Storage_In__c from Package__c where Name in: barCodeIdSet];
                    Set<String> packageSet = new Set<String>(); 
                    system.debug('-----------crateList-----------' + packageList);
                    //system.debug('-----------task3.ActivityDate-----------' + task3.ActivityDate);
                    if(packageList != null && packageList.size() > 0) {
                        for(Package__c pkg: packageList) {
                            
                            string str;
                            string upperStr;
                            str = pkg.Name;
                            upperStr = str.toUpperCase();
                            
                            if(barCodeIdSet.contains(upperStr)) {
                                barCodeIdSetFound.add(upperStr);
                                packageSet.add(upperStr);
                            }
                            if(pack.Crate__c != Null)
                                pkg.Crate__c = pack.Crate__c;
                             if(pack.Opportunity__c != Null)
                                pkg.Opportunity__c = pack.Opportunity__c;
                             if(pack.Storage_In__c != Null)
                                pkg.Storage_In__c = pack.Storage_In__c;
                           
                        }
                        update packageList;
                        system.debug('-----------packageList-----------' + packageList);
                        message += 'updated ' + packageSet.size() + ' records';
                        
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
                
                if(barCodeIdSetNotFound != null && barCodeIdSetNotFound.size() > 0) 
                {
                    List<Package__c> packageList=new List<Package__c>();
                    for(String bcr: barCodeIdSetNotFound){
                        Package__c pkg=new Package__c();
                        pkg.Name=bcr;
                        if(pack.Crate__c != Null)
                            pkg.Crate__c = pack.Crate__c;
                         if(pack.Opportunity__c != Null)
                            pkg.Opportunity__c = pack.Opportunity__c;
                         if(pack.Storage_In__c != Null)
                            pkg.Storage_In__c = pack.Storage_In__c;
                           packageList.add(pkg);
                    }
                    if(packageList.size()>0){
                        insert packageList;
                        if( message != 'You have ')
                                 message += ' and ' + packageList.size() + '  records Inserted';
                            else
                                message += ' Inserted  ' + packageList.size() + '  records';
                        
                        }
                }
                message+=' successfully.';
                messageTitle = selectedpickvalue + ' records Processed';
                messageFlag = True;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, messageTitle, message));

                
                
            } else {
                messageFlag = true;
                messageTitle = 'Barcode IDs Limit Exceeded';
                message = 'The maximum number of Barcodes you may scan is  ' + barCodeLimit + '. Please contact your System Administrator for an increase in the Limit.';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, messageTitle, message));
                message1 = '';
            }   
        } else {
            messageFlag = true;
            messageTitle = 'Barcode IDs Missing';
            message = 'You are required to enter at least "One" Barcode ID.';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, messageTitle, message));
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
        task4 = new Task();
        visibleCrate = false;
        visibleStorage = false;
        visibleArtWork = false;
        selectedpickvalue = '--None--';

        pack = new Package__c();
        packageFields = false;
        packageBarcode = false;
        packageButton = false;
    }
    
    
}