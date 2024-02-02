public class AssetScannerController {
    public Asset__c assetNew{get; set;}
    public Task task1{get;set;}
    public Task task2{get;set;}
    public List<selectOption> option_list{get;set;}
    public string selectedpickvalue{get;set;}
    public boolean visibleSection{get;set;}
    public string collection_string{get;set;}
    public boolean messageFlag{get;set;}
    public string message{get;set;}
    public string message1{get;set;}
    public string messageTitle{get;set;}
    public boolean messageFlagError{get;set;}
    public boolean messageFlagSuccess{get;set;}
    public string contactBarcode{get;set;}
    public string location{get;set;}
    //public Date dateIn{get; set;}
    //public Date dateOut{get; set;}
    
    public AssetScannerController(){
        init(); 
    }
    
    public List<SelectOption> getOptions(){
        option_list = new List<selectOption>();
        option_list.add(new selectOption('--None--','--None--'));
        option_list.add(new selectOption('Borrow','Borrow'));
        option_list.add(new selectOption('Return','Return'));
        return option_list; 
    } 
    
    public void init() {
        visibleSection = false;
        contactBarcode = '';
        collection_string = '';
        assetNew = new Asset__c();
        task1 = new Task();
        task2 = new Task();
        
        //visibleCrate = false;
        selectedpickvalue = '--None--';
        
    }
        
    public void VisibleMethod(){
        messageFlag = false;
        system.debug('--selectedpickvalue--'+selectedpickvalue);
        if(selectedpickvalue == 'Borrow'){
            //visibleCrate = true;
            visibleSection = true;
           // dateOut = Date.today();
           task2.ActivityDate = Date.today();
           task1.ActivityDate = null;
        } else if(selectedpickvalue == 'Return'){
            //visibleCrate = false;
            visibleSection = true;
           // dateIn = Date.today();
           task1.ActivityDate = Date.today();
           task2.ActivityDate = null;
        } else {
            //visibleCrate = false;
            visibleSection = false;
        }
        
    }
    
    public void updateSave(){
        message='';
        message1='';
        messageTitle = '';
    
        Set<String> barCodeIdSet = new Set<String>();
        Set<String> barCodeIdSetFound = new Set<String>();
        Set<String> barCodeIdSetNotFound = new Set<String>();
        
        //List<Contact> parentContact;
        List<Asset__c> duplicateAssets = new List<Asset__c>();
        List<Asset__c> updateAssets = new List<Asset__c>();
        List<Asset__c> updateAssetsReturn = new List<Asset__c>();
        String assetsHeldWithContact = '';
        
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
        
        if(System.Label.BarCodeLimitForAsset != null && System.Label.BarCodeLimitForAsset != '') {
            barCodeLimit = Integer.valueOf(System.Label.BarCodeLimitForAsset);
        }
        system.debug('-----------collection_string-----------' + collection_string);
        system.debug('-----------barCodeLimit-----------' + barCodeLimit);
        
        if(collection_string != null && collection_string != '') {
            if(barCodeIdSet.size() <= barCodeLimit){
                if(selectedpickvalue == 'Borrow') {
                	
                    List<Asset__c> assetList = [Select Id, Name, Date_In__c, Loan_Date__c, Loaned_To__c,Loaned_To__r.Name, HT_Barcode_No__c from Asset__c where HT_Barcode_No__c IN :barCodeIdSet];
                    Set<String> assetSet = new Set<String>();
                    system.debug('-----------assetList-----------' + assetList);
                    
                    System.debug('--contactBarcode inside Borrow--'+contactBarcode);
                    if(contactBarcode != null && contactBarcode != ''){
                        if(contactBarcode.endsWith(',')){
                            contactBarcode = contactBarcode.substring(0,contactBarcode.length()-1);
                        }
                        System.debug('--contactBarcode inside Borrow after comma removing--'+contactBarcode);
                        
                        List<Contact> parentContact = [Select Id, Name, ID_No_HT__c from Contact where ID_No_HT__c = :contactBarcode Limit 1]; 
                        System.debug('--parentContact--'+parentContact);
                        messageFlag = false;    
                        
                        if(assetList != null && assetList.size() > 0) {
                            for(Asset__c asst :assetList){
                                string str;
                                string upperStr;
                                str = asst.HT_Barcode_No__c;
                                upperStr = str.toUpperCase();
                                
                                if(barCodeIdSet.contains(upperStr)) {
                                    barCodeIdSetFound.add(upperStr);
                                    assetSet.add(upperStr);
                                }
                                System.debug('--barCodeIdSetFound in Borrow--'+barCodeIdSetFound);
                                System.debug('--parentContact inside Borrow--'+parentContact);
                                System.debug('--parentContact Size--'+parentContact.size());
                                
                                if(parentContact != null && parentContact.size()>0){
                                    system.debug('--parentContact.Id inside Borrow-'+parentContact[0].Id);
                                    system.debug('--asst.Loaned_To__c before If condition of Borrow=='+asst.Loaned_To__c);
                                    if(asst.Loaned_To__c == null){
                                        system.debug('--asst.Loaned_To__c inside If condition of Borrow=='+asst.Loaned_To__c);
                                        asst.Loaned_To__c = parentContact[0].Id;
                                        
                                        if(task2.ActivityDate != null) {
                                            asst.Loan_Date__c = task2.ActivityDate;
                                        }
                                        if(task1.ActivityDate != null){
                                            asst.Date_In__c = task1.ActivityDate;
                                        }
                                        updateAssets.add(asst);
                                    }
                                    else{
                                        system.debug('====> asst asst >> '+asst);
                                        assetsHeldWithContact = assetsHeldWithContact + ' ' + asst.HT_Barcode_No__c;
                                        duplicateAssets.add(asst);
                                        
                                    }
                                    
                                }
                                else{
                                    messageFlag = true;
                                    messageTitle = 'Contact is Invalid';
                                    message = 'The Contact with this ID No. does not exist. Please enter a valid ID No.';
                                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, messageTitle, message));
                                    message1 = '';
                                }
                                
                            }
                            system.debug('====> assetsHeldWithContact >> '+assetsHeldWithContact);
                            system.debug('--updateAssets--'+updateAssets);
                            system.debug('--duplicateAssets--'+duplicateAssets);
                            system.debug('--assetList--'+assetList);     
                            system.debug('--messageFlag before update--'+messageFlag);  
                            
                            if(messageFlag != true && updateAssets.size() > 0 && duplicateAssets.size() == 0){
                                system.debug('--IF 1--');
                                update updateAssets;
                                
                                message = 'The Total number of records you have successfully updated is ' + updateAssets.size() + '.';
                                messageTitle = 'Asset records Updated';
                                messageFlagSuccess = True;
                                messageFlag = true;
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, messageTitle, message));
                            }
                            else if(messageFlag != true && updateAssets.size() > 0 && duplicateAssets.size() > 0){
                                system.debug('--Else IF 2--');
                                update updateAssets;
                                
                                messageTitle = 'Asset records Updated but Some records are being held by the Contact';
                                message = 'The Total number of records you have successfully updated is ' + updateAssets.size() + '. \n '+ assetsHeldWithContact +' held by another Contact';
                                messageFlagSuccess = True;
                                messageFlag = true;
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, messageTitle, message));
                            }
                            else{
                                system.debug('--Else 3--');
                                messageFlag = true;
                                messageTitle = assetsHeldWithContact +' held by another Contact';
                                message = '' ;
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, messageTitle, message));
                                message1 = '';
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
                                                          
                    }
                    else {
                        messageFlag = true;
                        messageTitle = 'Loan To Missing';
                        message = 'You are required to enter the Contact ID No. in Loan To field';
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, messageTitle, message));
                        message1 = '';
                    }                               
                                            
                }
                else if(selectedpickvalue == 'Return'){
                    List<Asset__c> assetList = [Select Id, Name, Date_In__c, Loan_Date__c, Loaned_To__c,Loaned_To__r.Name, HT_Barcode_No__c from Asset__c where HT_Barcode_No__c IN :barCodeIdSet];
                    Set<String> assetSet = new Set<String>();
                    system.debug('-----------assetList-----------' + assetList);
                    string returnedItems = '';
                    
                    if(assetList != null && assetList.size() > 0) {
                        for(Asset__c asst :assetList){
                            string str;
                            string upperStr;
                            str = asst.HT_Barcode_No__c;
                            upperStr = str.toUpperCase();
                            
                            if(barCodeIdSet.contains(upperStr)) {
                                barCodeIdSetFound.add(upperStr);
                                assetSet.add(upperStr);
                            }
                            System.debug('--barCodeIdSetFound Inside Return--'+barCodeIdSetFound);
                            //System.debug('--location--'+location);
                            System.debug('--Location_New__c--'+assetNew.Location_New__c);
                            if(asst.Loaned_To__c != null){                                  
                                asst.Loaned_To__c = null;
                                
                                if(assetNew.Location_New__c != null){
                                    asst.Location_New__c = assetNew.Location_New__c;
                                }
                                if(task2.ActivityDate != null) {
                                    asst.Loan_Date__c = task2.ActivityDate;                             
                                }
                                if(task1.ActivityDate != null){
                                    asst.Date_In__c = task1.ActivityDate;
                                }   
                                updateAssetsReturn.add(asst);
                            }
                            else{
                                returnedItems = returnedItems + ' ' +asst.HT_Barcode_No__c;
                                system.debug('-->returnedItems-- >>'+returnedItems);
                               /* messageFlag = true;
                                messageTitle = 'Assets not updated as they have already been returned';
                                message = 'Please check Asset '+ returnedItems;
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, messageTitle, message));*/
                            }
                        }
                        system.debug('-->returnedItems 2-- >>'+returnedItems);
                        system.debug('-->updateAssetsReturn-->'+updateAssetsReturn);
                        if(updateAssetsReturn != null && updateAssetsReturn.size() > 0 && returnedItems == '' && returnedItems.trim().length() == 0){
                            update updateAssetsReturn;
                            message = 'The Total number of records you have successfully updated is ' + updateAssetsReturn.size() + '.';
                            messageTitle = 'Asset records Updated';
                            messageFlagSuccess = True;
                            messageFlag = true;
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, messageTitle, message));
                        }
                        else if(updateAssetsReturn.size() == 0  && returnedItems != '' && returnedItems.trim().length() > 0){
                        	messageFlag = true;
                            messageTitle = 'Assets not updated as they have already been returned';
                            message = 'Please check Asset '+ returnedItems;
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, messageTitle, message));
                        }
                        else if(updateAssetsReturn != null && updateAssetsReturn.size() > 0 && returnedItems != '' && returnedItems.trim().length() > 0){
                        	update updateAssetsReturn;
                            message = 'The Total number of records you have successfully updated is ' + updateAssetsReturn.size() + '. \n Please check Asset '+ returnedItems +' already been returned';
                            messageTitle = 'Asset records updated but some Assets not updated as they have already been returned';
                            messageFlagSuccess = True;
                            messageFlag = true;
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, messageTitle, message));
                        }
                    }   
                    
                    for(String str: barCodeIdSet) {
                        if(!barCodeIdSetFound.contains(str)) {
                            barCodeIdSetNotFound.add(str);
                        }
                    }
                    
                    system.debug('-----------barCodeIdSet inside return-----------' + barCodeIdSet);
                    system.debug('-----------barCodeIdSetFound inside return-----------' + barCodeIdSetFound);
                    system.debug('-----------barCodeIdSetNotFound inside return-----------' + barCodeIdSetNotFound);
            
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
                }             
                                
            }
            else{
                messageFlag = true;
                messageTitle = 'Barcode IDs Limit Exceeded';
                message = 'The maximum number of Barcodes you may scan is  ' + barCodeLimit + '. Please contact your System Administrator for an increase in the Limit.';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, messageTitle, message));
                message1 = '';
            } 
        }
        else{
            messageFlag = true;
            messageTitle = 'Barcode IDs Missing';
            message = 'You are required to enter at least "One" Barcode ID.';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, messageTitle, message));
            message1 = '';
        }
         
    }
   /* public PageReference reset() {
        PageReference pg = new PageReference(System.currentPageReference().getURL());
        pg.setRedirect(false);
        return pg;
    }*/
     public pageReference Close(){
        Pagereference pref = new Pagereference('/home/home.jsp');
        pref.setRedirect(true);
        return pref;
    }
}