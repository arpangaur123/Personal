public class MyPagingController2{

public String currentEmail ;

  Set<Id> artWorIds;
public   String typeString{set;get;}
  list<artApp__Artwork__c> tempDatasubfilter;

 list<Attachment> attachList;
public  transient list<artApp__Artwork__c> tempData{set;get;}

public   Boolean searchClick{set;get;}
public   Boolean subfilterClick{set;get;}

public   transient list<artWorkWrapper> artWorkWrapperList{set;get;}
public   list<artWorkWrapper> artWorkWrapperListOriginal{set;get;}
public   list<artWorkWrapper> artWorkWrapperListForExcelPage{set;get;}

public   string searchText{set;get;}
public   string artistSelected{set;get;}
public   string lotnoSelected{set;get;}
public   string exhibitionSelected{set;get;}
public   string itemNoSelected{set;get;}
    
public   string bondnoSelected{set;get;} //added on 22072020
    
public   list<SelectOption> artistOptions{set;get;}
public   list<SelectOption> lotnoOptions{set;get;}
public   list<SelectOption> exhibitionOptions{set;get;}
public   list<SelectOption> itemNoOptions{set;get;}
    
public   list<SelectOption> bondNoOptions{set;get;}//added on 22072020
    
public   boolean showHideColumn{set;get;}

public   boolean showArtist{set;get;}
public   boolean showTitle{set;get;}
public   boolean showBarCode{set;get;}
public   boolean showItemNo{set;get;}
public   boolean showLotNo{set;get;}
public   boolean showDimension{set;get;}
public   boolean showExhibition{set;get;}
public   boolean showImage{set;get;}
public   boolean showConditionReport{set;get;}
public   boolean showPD{set;get;}
public   boolean showPM{set;get;}
    list<artApp__Artwork__c> searchRecords;
    
    //added on 07072020
    public   boolean showgst{set;get;}
    public   boolean showbondstatus{set;get;}

public   Date todayDate{set;get;}
private  transient list<artApp__Artwork__c> accounts;
private  transient list<artApp__Artwork__c> pageAccounts;
private   Integer totalRecords;
private   Integer pageSize;
private   Integer totalPageNumber;
private   String sortDirection = 'ASC';
private   String sortExp = 'artApp__Artist__r.Name';
  Integer  queryLimit;
  Integer  offset;
  Integer   offsetSearch;
  Integer  offsetSubFilter;

// for active and deactive page naviagator
public   Boolean firstOff{set;get;}    // previous part
public   Boolean lastOff{set;get;}     // next part

public String limits{set;get;}
public Integer pageNumber{set;get;}
Integer listSize;    // for total contact size

public Integer getPageNumber(){
    return pageNumber;
}
public Integer gettotalRecords(){
    return totalRecords;
}

public list<artApp__Artwork__c> getAccounts(){
    return pageAccounts;
}

public Integer getPageSize(){
    return pageSize;
}

public Boolean getPreviousButtonEnabled(){
    return !(pageNumber > 1);
}

public Boolean getNextButtonDisabled(){
    if (accounts == null) return true;
    else
    return ((pageNumber * pageSize) >= accounts.size());
}

public Integer getTotalPageNumber(){
   
    if (totalPageNumber == 0 && accounts !=null){
        totalPageNumber = accounts.size() / pageSize;
        Integer mod = accounts.size() - (totalPageNumber * pageSize);
        if (mod > 0)
        totalPageNumber++;
    }
    return totalPageNumber;
}

public String sortExpression{
     get{
        return sortExp;
     }
     set{
       //if the column is clicked on then switch between Ascending and Descending modes
       if (value == sortExp)
         sortDirection = (sortDirection == 'ASC')? 'DESC' : 'ASC';
       else
         sortDirection = 'ASC';
       sortExp = value;
     }
}

 public String getSortDirection(){
    //if not column is selected
    if (sortExpression == null || sortExpression == '')
      return 'ASC';
    else
     return sortDirection;
 }

 public void setSortDirection(String value){
   sortDirection = value;
 }

public MyPagingController2(){

    typeString ='';
    firstOff = false;
    queryLimit = 20;
    offset = 0;
    offsetSearch = 0;
    limits = '20';
    pageNumber = 1;
    searchClick = false;
    subfilterClick = false;
    User u = [Select Id,SelectedColumns__c, Name, Email from User where Id = :UserInfo.getUserId()];
    currentEmail=u.Email;
    String sortFullExp = sortExpression  + ' ' + sortDirection;
    //aggregateResult res = [select COUNT(id) cnt from artApp__Artwork__c where artApp__Collector__r.artApp__Email__c= : currentEmail AND (NOT(Internal_Location__r.Name LIKE :'%release%' OR Internal_Location__r.Name LIKE :'%deliver%' OR Internal_Location__r.Name LIKE :'%not ship%' OR Internal_Location__r.Name LIKE :'%pending%' OR Internal_Location__r.Name LIKE :'%fp to cc%' OR Internal_Location__r.Name LIKE :'%cc to fp%' OR Internal_Location__r.Name LIKE :'%enroute%' OR Internal_Location__r.Name ='' OR Internal_Location__r.Name LIKE :'%tbc%' OR Internal_Location__r.Name LIKE :'%old record%'))];

    List<String> huList = new list<String>();
    if(u.SelectedColumns__c != null && u.SelectedColumns__c != ''){
        huList = u.SelectedColumns__c.split(',', 0);
    } else {
        showArtist = true;
        showTitle = true;
        showBarCode = true; 
        showItemNo = false;//change default added on 13072020
        showLotNo = true;
        showDimension = false; //change default added on 13072020
        showExhibition = false;//change default added on 13072020
        showImage = true;
        showConditionReport = true;
        showPD = true;
        showPM = true;
        
        //added on 07072020
        showgst = false;
        showbondstatus = false;
    }
    if(huList != null && huList.size() > 0) {
        for(String s: huList) {
            if(s!=null && s!= '' && s!=',') {
                if(s == 'showArtist') showArtist = true;
                if(s == 'showTitle') showTitle = true;
                if(s == 'showBarCode') showBarCode = true;
                if(s == 'showItemNo') showItemNo = true;
                if(s == 'showLotNo') showLotNo = true;
                if(s == 'showDimension') showDimension = true;
                if(s == 'showExhibition') showExhibition = true;
                if(s == 'showImage') showImage = true;
                if(s == 'showConditionReport') showConditionReport = true;
                if(s == 'showPD') showPD = true;
                if(s == 'showPM') showPM = true;
                
                //added on 07072020
                if(s == 'showgst') showgst = true;
                if(s == 'showbondstatus') showbondstatus = true;

            }
        }
    }

    showHideColumn = false;
    accounts = new List<artApp__Artwork__c>();
    //pageNumber = 0;
    //totalPageNumber = 0;
    pageSize = 5;
    searchText = '';
    artistOptions = new list<SelectOption>();
    artistOptions.add(new SelectOption('--none--','--none--'));
    lotnoOptions = new list<SelectOption>();
    lotnoOptions.add(new SelectOption('--none--','--none--'));
    exhibitionOptions = new list<SelectOption>();
    exhibitionOptions.add(new SelectOption('--none--','--none--'));
    itemNoOptions = new list<SelectOption>();
    itemNoOptions.add(new SelectOption('--none--','--none--'));
    ViewData();
}

public void reset() {
    
    system.debug('<--bondnoSelected'+bondnoSelected);
    
    
    firstOff = false;
    queryLimit = 20;
    offset = 0;
    offsetSearch = 0;
    limits = '20';
    pageNumber = 1;
    searchClick = false;
    subfilterClick = false;

    String sortFullExp = sortExpression  + ' ' + sortDirection;
    //aggregateResult res = [select COUNT(id) cnt from artApp__Artwork__c where artApp__Collector__r.artApp__Email__c= : currentEmail AND (NOT(Internal_Location__r.Name LIKE :'%release%' OR Internal_Location__r.Name LIKE :'%deliver%' OR Internal_Location__r.Name LIKE :'%not ship%' OR Internal_Location__r.Name LIKE :'%pending%' OR Internal_Location__r.Name LIKE :'%fp to cc%' OR Internal_Location__r.Name LIKE :'%cc to fp%' OR Internal_Location__r.Name LIKE :'%enroute%' OR Internal_Location__r.Name ='' OR Internal_Location__r.Name LIKE :'%tbc%' OR Internal_Location__r.Name LIKE :'%old record%'))];

    // Initial Action - Get Size of all Properties
    //listSize = Integer.valueOf(res.get('cnt'));
    showHideColumn = false;
    accounts = new List<artApp__Artwork__c>();
    //pageNumber = 0;
    //totalPageNumber = 0;
    pageSize = 5;
    //if(listSize > queryLimit) lastOff = true;
    //else lastOff = false;

    searchText = '';
    artistOptions = new list<SelectOption>();
    artistOptions.add(new SelectOption('--none--','--none--'));
    lotnoOptions = new list<SelectOption>();
    lotnoOptions.add(new SelectOption('--none--','--none--'));
    exhibitionOptions = new list<SelectOption>();
    exhibitionOptions.add(new SelectOption('--none--','--none--'));
    itemNoOptions = new list<SelectOption>();
    itemNoOptions.add(new SelectOption('--none--','--none--'));
    artistSelected = 'All';
    exhibitionSelected = 'All';
    itemNoSelected = 'All';
    lotnoSelected = 'All';
    
    bondnoSelected = 'All';
        
        system.debug('<--bondnoSelected'+bondnoSelected);
    //typeString = '';
    ViewData();
}

public PageReference ViewData(){
    System.debug('tempData---->>>'+tempData);
    //build the full sort expression
    String sortFullExp = sortExpression  + ' ' + sortDirection;
    accounts = null;
    tempData = null;
    todayDate = Date.today();
    //totalPageNumber = 0;
    BindData(1,sortFullExp);
    return null;
}

// Zai
public PageReference exportToExcel() {
   return Page.My_ControllerExcel2;
 }

public void loadExportPage() {
    artWorkWrapperListForExcelPage = new list<artWorkWrapper>();
    if(tempData != null && tempData.size() > 0) {
        system.debug('--------tempData--Size------' + tempData.size());
        for(artApp__Artwork__c a : tempData){
            artWorkWrapper aww =  new artWorkWrapper();
            aww.apArt = a;
            artWorkWrapperListForExcelPage.add(aww);
        }
    }
    //system.debug('--------artWorkWrapperListForExcelPage--------' + artWorkWrapperListForExcelPage);
    if(artWorkWrapperListForExcelPage != null && artWorkWrapperListForExcelPage.size() > 0) {
        system.debug('--------artWorkWrapperListForExcelPage--Size------' + artWorkWrapperListForExcelPage.size());
    }
}

//public List<TMC_Property__c> getRecords(){
   //return (List<TMC_Property__c>)database.query(queryString+' LIMIT '+queryLimit+' OFFSET '+offset);
//}

// navigate on next page
    public void next(){
        openPopUp = false;
        system.debug('<--bondnoSelected'+bondnoSelected);
        system.debug('<--searchText'+searchText);
        if(typeString == null || typeString == '') {
            typeString = system.currentPageReference().getParameters().get('typeString');
        }

        if(searchText != null && searchText != '' && searchText.trim().length() > 0){
            offsetSearch += queryLimit;
            pageNumber++;
            searchRecords();
            if(offsetSearch+queryLimit >= listSize) lastOff = false;
            firstOff = true;
        } else if((artistSelected != null && artistSelected != '' && artistSelected != '--none--' && artistSelected != 'All') ||
                    (lotnoSelected != null && lotnoSelected != '' && lotnoSelected != '--none--' && lotnoSelected != 'All') ||
                    (itemNoSelected != null && itemNoSelected != '' && itemNoSelected != '--none--' && itemNoSelected != 'All') ||
                    (exhibitionSelected != null && exhibitionSelected != '' && exhibitionSelected != '--none--' && exhibitionSelected != 'All') ||
                    (bondnoSelected != null && bondnoSelected != '' && bondnoSelected != '--none--' && bondnoSelected != 'All')) {
          
            offset += queryLimit;
            pageNumber++;
            subFilter();
            if(offset+queryLimit >= listSize) lastOff = false;
            firstOff = true;
        }else{
            firstOff = true;
            pageNumber++;
            offset += queryLimit;
            ViewData();
            if(offset+queryLimit >= listSize) lastOff = false;
        }
    }

    // navigate on previous page
    public void previous(){
        openPopUp = false;
        if(typeString == null || typeString == '') {
            typeString = system.currentPageReference().getParameters().get('typeString');
        }
        if(searchText != null && searchText != ''){

            if(offsetSearch-queryLimit <= 0){
                offsetSearch = 0;
                firstOff = false;
            }
            else offsetSearch -= queryLimit;
            lastOff = true;
            pageNumber--;
            searchRecords();
        } else if((artistSelected != null && artistSelected != '' && artistSelected != '--none--' && artistSelected != 'All') ||
                  (lotnoSelected != null && lotnoSelected != '' && lotnoSelected != '--none--' && lotnoSelected != 'All') ||
                  (itemNoSelected != null && itemNoSelected != '' && itemNoSelected != '--none--' && itemNoSelected != 'All') ||
                  (exhibitionSelected != null && exhibitionSelected != '' && exhibitionSelected != '--none--' && exhibitionSelected != 'All') ||
                  (bondnoSelected != null && bondnoSelected != '' && bondnoSelected != '--none--' && bondnoSelected != 'All')) {
            if(offset-queryLimit <= 0){
                offset = 0;
                firstOff = false;
            }
            else offset -= queryLimit;
            lastOff = true;
            pageNumber--;
            subFilter();
        }else{
            if(offset-queryLimit <= 0){
                offset = 0;
                firstOff = false;
            }
            else offset -= queryLimit;
            lastOff = true;
            pageNumber--;
            ViewData();
        }
    }

    // switch on first page
    public void first(){
        openPopUp = false;
        if(typeString == null || typeString == '') {
            typeString = system.currentPageReference().getParameters().get('typeString');
        }
        if(searchText != null && searchText != ''){
            offsetSearch = 0;
            searchRecords();
        } else if((artistSelected != null && artistSelected != '' && artistSelected != '--none--' && artistSelected != 'All') ||
                  (lotnoSelected != null && lotnoSelected != '' && lotnoSelected != '--none--' && lotnoSelected != 'All') ||
                  (itemNoSelected != null && itemNoSelected != '' && itemNoSelected != '--none--' && itemNoSelected != 'All') ||
                  (exhibitionSelected != null && exhibitionSelected != '' && exhibitionSelected != '--none--' && exhibitionSelected != 'All') ||
                  (bondnoSelected != null && bondnoSelected != '' && bondnoSelected != '--none--' && bondnoSelected != 'All')) {
            offset = 0;
            //searchRecords();
            subFilter();
        }else{
            offset = 0;
            ViewData();
        }
        pageNumber = 1;
        firstOff = false;
        lastOff = true;
    }

    // switch on last page
    public void last(){
        openPopUp = false;
        if(typeString == null || typeString == '') {
            typeString = system.currentPageReference().getParameters().get('typeString');
        }
        if(searchText != null && searchText != ''){
            
            if(Math.Mod(listSize,queryLimit) == 0){
                if(listSize-queryLimit>=0)
                    offsetSearch = listSize-queryLimit;
                pageNumber = listSize/queryLimit;
            }
            else{
                offsetSearch = (listSize/queryLimit)*queryLimit;
                pageNumber = (listSize/queryLimit)+1;
            }
            system.debug('-------pageNumber--------' + pageNumber);
            system.debug('offset'+offset);
            searchRecords();
        } else if((artistSelected != null && artistSelected != '' && artistSelected != '--none--' && artistSelected != 'All') ||
                  (lotnoSelected != null && lotnoSelected != '' && lotnoSelected != '--none--' && lotnoSelected != 'All') ||
                  (itemNoSelected != null && itemNoSelected != '' && itemNoSelected != '--none--' && itemNoSelected != 'All') ||
                  (exhibitionSelected != null && exhibitionSelected != '' && exhibitionSelected != '--none--' && exhibitionSelected != 'All') ||
                  (bondnoSelected != null && bondnoSelected != '' && bondnoSelected != '--none--' && bondnoSelected != 'All')) {
           
            if(Math.Mod(listSize,queryLimit) == 0){
                if(listSize-queryLimit>=0)
                    offset = listSize-queryLimit;
                pageNumber = listSize/queryLimit;
            }
            else{
                offset = (listSize/queryLimit)*queryLimit;
                pageNumber = (listSize/queryLimit)+1;
            }
                        system.debug('offset'+offset);
                        system.debug('-------pageNumber--------' + pageNumber);
            subFilter();
        }else{
           
            // set page number of and offset
            if(Math.Mod(listSize,queryLimit) == 0){
                if(listSize-queryLimit>=0)
                    offset = listSize-queryLimit;
                pageNumber = listSize/queryLimit;
            }
            else{
                offset = (listSize/queryLimit)*queryLimit;
                pageNumber = (listSize/queryLimit)+1;
            }
            system.debug('offset'+offset);
            system.debug('-------pageNumber--------'+pageNumber);
            ViewData();
        }
       
        lastOff = false;
        firstOff = true;
        //system.debug('-------pageNumber----2----' + pageNumber);
    }

    // for record limits
    public List<SelectOption> getItems(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('5','5'));
        options.add(new SelectOption('10','10'));
        options.add(new SelectOption('20','20'));
        options.add(new SelectOption('50','50'));
        options.add(new SelectOption('100','100'));
        return options;
    }

    // change query limit
    public void changeLimit(){
        if(typeString == null || typeString == '') {
            typeString = system.currentPageReference().getParameters().get('typeString');
        }
        if(searchText != null && searchText != ''){
            // set query limit
            queryLimit = Integer.valueOf(limits);

            offset = 0;
            offsetSearch = 0;
            firstOff = false;

            // initialy check page more then 1 or not
            if(listSize > queryLimit) lastOff = true;
            else lastOff = false;

            // set page number
            pageNumber = 1;
            searchRecords();
        } else if((artistSelected != null && artistSelected != '' && artistSelected != '--none--' && artistSelected != 'All') ||
                  (lotnoSelected != null && lotnoSelected != '' && lotnoSelected != '--none--' && lotnoSelected != 'All') ||
                  (itemNoSelected != null && itemNoSelected != '' && itemNoSelected != '--none--' && itemNoSelected != 'All') ||
                  (exhibitionSelected != null && exhibitionSelected != '' && exhibitionSelected != '--none--' && exhibitionSelected != 'All') ||
                  (bondnoSelected != null && bondnoSelected != '' && bondnoSelected != '--none--' && bondnoSelected != 'All')) {
            // set query limit
            queryLimit = Integer.valueOf(limits);

            offset = 0;
            firstOff = false;

            // initialy check page more then 1 or not
            if(listSize > queryLimit) lastOff = true;
            else lastOff = false;

            // set page number
            pageNumber = 1;
            subFilter();
        }else{
            // set query limit
            queryLimit = Integer.valueOf(limits);

            offset = 0;
            firstOff = false;

            // initialy check page more then 1 or not
            if(listSize > queryLimit) lastOff = true;
            else lastOff = false;

            // set page number
            pageNumber = 1;
            ViewData();
        }
    }

    // for show current record numbers
    public String getRecordInfo(){
        if(searchText != null && searchText != ''){
            integer lastLimit;
            if(offsetSearch+queryLimit > listSize) lastLimit = listSize;
            else lastLimit = offsetSearch+queryLimit;
            return (offsetSearch+1) + ' - ' + lastLimit + ' of '+listSize;
        } else {
            integer lastLimit;
            if(offset+queryLimit > listSize) lastLimit = listSize;
            else lastLimit = offset+queryLimit;
            return (offset+1) + ' - ' + lastLimit + ' of '+listSize;
        }
    }

    // return total page number
    public Integer getTotalPage(){
        if(Math.Mod(listSize,queryLimit) == 0) {
            return listSize/queryLimit;
        } else {
            return (listSize/queryLimit)+1;
        }
    }

    // for direct page switching
    public void pageNavigation(){
        if(searchText != null && searchText != ''){
            if(Math.Mod(listSize,queryLimit) == 0 && pageNumber > listSize/queryLimit)
                pageNumber = listSize/queryLimit;
            else if(pageNumber > (listSize/queryLimit)+1)
                pageNumber = (listSize/queryLimit)+1;

            // set offset according to pageNumber
            if((pageNumber-1)*queryLimit < 0) offsetSearch = 0;
            else offsetSearch = (pageNumber-1)*queryLimit;
            if(pageNumber == 1) firstOff = false;
            else if(pageNumber == 0) pageNumber = 1;
            else if(pageNumber > 1) firstOff = true;

            // user enter last number of pagenumber than deactive next navigator
            if(Math.Mod(listSize,queryLimit) == 0){
                if(pageNumber == listSize/queryLimit) lastOff = false;
                else lastOff = true;
            }
            else{
                if(pageNumber == (listSize/queryLimit)+1) lastOff = false;
                else lastOff = true;
            }
            searchRecords();
        }else{
            if(Math.Mod(listSize,queryLimit) == 0 && pageNumber > listSize/queryLimit)
                pageNumber = listSize/queryLimit;
            else if(pageNumber > (listSize/queryLimit)+1)
                pageNumber = (listSize/queryLimit)+1;

            // set offset according to pageNumber
            if((pageNumber-1)*queryLimit < 0) offset = 0;
            else offset = (pageNumber-1)*queryLimit;
            if(pageNumber == 1) firstOff = false;
            else if(pageNumber == 0) pageNumber = 1;
            else if(pageNumber > 1) firstOff = true;

            // user enter last number of pagenumber than deactive next navigator
            if(Math.Mod(listSize,queryLimit) == 0){
                if(pageNumber == listSize/queryLimit) lastOff = false;
                else lastOff = true;
            }
            else{
                if(pageNumber == (listSize/queryLimit)+1) lastOff = false;
                else lastOff = true;
            }
            ViewData();
        }
    }

private void BindData(Integer newPageIndex, String tmyExp){
    String queryStr = '';
    queryStr= 'SELECT (Select Id, ParentId, Name, LastModifiedDate From Attachments where ContentType = \'application/pdf\' OR  ContentType = \'application/doc\' OR ContentType = \'application/docx\'  order by LastModifiedDate desc limit 1),';
    queryStr+= ' Name, Id, ItemcurrentEmail_No__c, Lot_No__c, artApp__Exhibition__r.Name, ';
    queryStr+= 'Image__c,artApp__Primary_Image_Id__c,';
    queryStr+= ' Barcode_ID__c, Dimensions__c,GST__c,Bond_Status__c, ';
    queryStr+= 'RecordType.Name, artApp__Artist__r.Name, artApp__Collector__r.Id,';
    queryStr+= 'Internal_Location__r.Name, Packed_Dimensions__c, Packing_Method__c FROM artApp__Artwork__c ';
    queryStr+= '   Where artApp__Collector__r.artApp__Email__c= \'' + currentEmail + '\' AND (NOT(Internal_Location__r.Name LIKE \'%release%\' OR Internal_Location__r.Name LIKE \'%held by%\' OR Internal_Location__r.Name LIKE \'%disposed%\' OR Internal_Location__r.Name LIKE \'%deliver%\' OR Internal_Location__r.Name LIKE \'%not ship%\' OR Internal_Location__r.Name LIKE \'%pending%\' OR Internal_Location__r.Name LIKE \'%fp to cc%\' OR Internal_Location__r.Name LIKE \'%cc to fp%\' OR Internal_Location__r.Name LIKE \'%enroute%\' OR Internal_Location__r.Name = \'\' OR Internal_Location__r.Name LIKE \'%tbc%\' OR Internal_Location__r.Name LIKE \'%old record%\'  OR Internal_Location__r.Name LIKE \'%annex%\')) ORDER BY '+ tmyExp;
    //queryStr+= '   Where (NOT(Internal_Location__r.Name LIKE \'%release%\' OR Internal_Location__r.Name LIKE \'%deliver%\' OR Internal_Location__r.Name LIKE \'%not ship%\' OR Internal_Location__r.Name LIKE \'%pending%\' OR Internal_Location__r.Name LIKE \'%fp to cc%\' OR Internal_Location__r.Name LIKE \'%cc to fp%\' OR Internal_Location__r.Name LIKE \'%enroute%\' OR Internal_Location__r.Name = \'\' OR Internal_Location__r.Name LIKE \'%tbc%\' OR Internal_Location__r.Name LIKE \'%old record%\')) ORDER BY '+ tmyExp;
   // queryStr +=' AND NOT(Internal_Location__r.Name LIKE \'%disposed%\' )';
    //Used to populate the filter lists

    try {
        if (accounts == null) {
            accounts = new list<artApp__Artwork__c>();
            system.debug('queryStr-----' + queryStr);
            if(tempData == null){
                tempData = Database.query(queryStr);
                system.debug('--------tempData--------' + tempData.size());
            }
            
            /**********************************************added on 6july2020**************************************************/
            
            
            //queryStr += ' LIMIT ' + queryLimit + ' OFFSET ' + offset;
            
            //system.debug('--------queryStr----Bind Data---2----' + queryStr);
            //accounts = database.query(queryStr);
            
            
            Integer min = OFFSET;
            Integer max = OFFSET+queryLimit;
            while(min<max){
                if(min < tempData.size())
                    accounts.add(tempData[min]);
                min++;
            }
            system.debug('-------Acc Size---1-----' + accounts.size());
            
            
            /************************************************************end***************************************************/
        }
       
        if(tempDatasubfilter != null && tempDatasubfilter.size() > 0){
            //system.debug('--------BD---2--------');
            totalRecords = tempDatasubfilter.size();
            listSize = tempDatasubfilter.size();
            if(listSize > queryLimit) lastOff = true;
            else lastOff = false;
        }else{
            //system.debug('--------BD---3--------');
            totalRecords = tempData.size();
            listSize = tempData.size();
            if(listSize > queryLimit) lastOff = true;
            else lastOff = false;
        }
        //system.debug('--------BD---4--------');
        pageAccounts = new List<artApp__Artwork__c>();
        Transient Integer counter = 0;
        Transient Integer min = 0;
        Transient Integer max = 0;
        if (newPageIndex > pageNumber){
            min = pageNumber * pageSize;
            max = newPageIndex * pageSize;
        }
        else{
            max = newPageIndex * pageSize;
            min = max - pageSize;
        }
        //system.debug('--------BD---5--------');
        artWorIds = new Set<Id>();
        artWorkWrapperList =  new list<artWorkWrapper>();
        system.debug('testTempData--->'+tempData);
        if(accounts!=null){
            for(artApp__Artwork__c a : accounts){
                artWorIds.add(a.Id);
                counter++;
                if (counter > min && counter <= max)
                pageAccounts.add(a);
            }
           
            for(artApp__Artwork__c a : accounts){
                artWorkWrapper aww =  new artWorkWrapper();
                aww.apArt = a;
                if(a.Attachments != null && a.Attachments.size() > 0) {
                    for(Attachment aa: a.Attachments) {
                        aww.attachmentrec = aa.Id;
                    }
                }
                artWorkWrapperList.add(aww);
            }
        }
        //system.debug('--------BD---7--------');
        //system.debug('--------BD---7--------' + artWorkWrapperList);
       // if(artWorkWrapperList != null && artWorkWrapperList.size() > 0) {
            system.debug('--------BD---7--------' + artWorkWrapperList.size());
        //}
        //artWorkWrapperListOriginal = artWorkWrapperList;

        artistOptions = new list<SelectOption>();
        lotnoOptions = new list<SelectOption>();
        exhibitionOptions = new list<SelectOption>();
        itemNoOptions = new list<SelectOption>();
        bondNoOptions = new list<SelectOption>();
            
        artWorkWrapperListOriginal =  new list<artWorkWrapper>();
        Set<String> set1 = new Set<String>();
        Set<String> set2 = new Set<String>();
        Set<String> set3 = new Set<String>();
        Set<String> set4 = new Set<String>();
        //system.debug('--------BD---8--------');
         integer sizeSet1 = 1;
         integer sizeSet2 = 1;
         integer sizeSet3 = 1;
         integer sizeSet4 = 1;
        
         if(tempData!=null){
             
             if(tempData.size() > 0){
                 bondNoOptions.add(new SelectOption('All','All'));
                 bondNoOptions.add(new SelectOption('Red','Red - Bonded,GST Suspended'));
                 bondNoOptions.add(new SelectOption('Green','Green - Duty Paid'));
                 bondNoOptions.add(new SelectOption('Yellow','Yellow - Temporary export'));
                 bondNoOptions.add(new SelectOption('Black','Black - Export offset temporary import'));
             }
             
            for(artApp__Artwork__c searcrec : tempData){
                artWorkWrapper aww =  new artWorkWrapper();
                aww.apArt = searcrec;
                if(searcrec.Attachments != null && searcrec.Attachments.size() > 0) {
                    for(Attachment aa: searcrec.Attachments) {
                        aww.attachmentrec = aa.Id;
                    }
                }
                //artWorkWrapperListOriginal.add(aww);
                 if(searcrec.artApp__Artist__r.Name != null){
                    if(sizeSet1<=1000){
                      set1.add(searcrec.artApp__Artist__r.Name);
                      sizeSet1++;
                    }
                }
                if(searcrec.Lot_No__c != null){
                    if(sizeSet2<1000){
                        set2.add(searcrec.Lot_No__c);
                        sizeSet2++;
                    }
                }
                if(searcrec.artApp__Exhibition__r.Name != null){
                    if(sizeSet3<1000){
                        set3.add(searcrec.artApp__Exhibition__r.Name);
                        sizeSet3++;
                    }
                }
                if(searcrec.Item_No__c != null){
                    if(sizeSet4<1000){
                        set4.add(searcrec.Item_No__c);
                        sizeSet4++;
                    }
                }
            }
         }else{
             if(bondnoSelected!=null && bondnoSelected!='' && bondnoSelected!='--none--' && bondnoSelected != 'All')
                 bondNoOptions.add(new SelectOption(bondnoSelected,''));
             else if(artistSelected!=null && artistSelected!='' && artistSelected!='--none--' && artistSelected != 'All'){
                 artistOptions.add(new SelectOption(artistSelected,''));
             }else if(itemNoSelected!=null && itemNoSelected!='' && itemNoSelected!='--none--' && itemNoSelected != 'All'){
                 itemNoOptions.add(new SelectOption(itemNoSelected,''));
             }else if(exhibitionSelected!=null && exhibitionSelected!='' && exhibitionSelected!='--none--' && exhibitionSelected != 'All'){
                 exhibitionOptions.add(new SelectOption(exhibitionSelected,''));
             }else if(lotnoSelected!=null && lotnoSelected!='' && lotnoSelected!='--none--' && lotnoSelected != 'All'){
                 lotnoOptions.add(new SelectOption(lotnoSelected,''));
             }
         }
        //system.debug('<--bondnoSelected'+bondnoSelected);
        List<String> tempList = null;
        if(set1 != null && set1.size() > 0) {
            artistOptions.add(new SelectOption('All','All'));
            tempList = new List<String>();
            tempList.addAll(set1);
            tempList.sort();
            for(String s1: tempList) {
                artistOptions.add(new SelectOption(s1,s1));
            }
        }

        if(set2 != null && set2.size() > 0) {
            lotnoOptions.add(new SelectOption('All','All'));
            tempList = new List<String>();
            tempList.addAll(set2);
            tempList.sort();
            for(String s2: tempList) {
                lotnoOptions.add(new SelectOption(s2,s2));
            }
        }
        if(set3 != null && set3.size() > 0) {
            exhibitionOptions.add(new SelectOption('All','All'));
            tempList = new List<String>();
            tempList.addAll(set3);
            tempList.sort();
            for(String s3: tempList) {
                exhibitionOptions.add(new SelectOption(s3,s3));
            }
        }

        if(set4 != null && set4.size() > 0) {
            itemNoOptions.add(new SelectOption('All','All'));
            tempList = new List<String>();
            tempList.addAll(set4);
            tempList.sort();

            for(String s4: tempList) {
                itemNoOptions.add(new SelectOption(s4,s4));
            }
        }
        
        //this.attachments();
        //pageNumber = newPageIndex;
        if (pageAccounts == null || pageAccounts.size() <= 0) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Data not available for this view.'));
        }
    } catch(Exception ex){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,ex.getMessage()));
    }
    //system.debug('--------BD---11--------');
}

public void searchRecords(){
    system.debug('offsetSearch------' + offsetSearch);
    if(searchClick == true){
        //limits = '5';
        offsetSearch = 0;
        lastOff = true;
        searchClick = false;
    }
    //system.debug('--------Search Record-----offsetSearch---2---' + offsetSearch);
    tempDatasubfilter = new list<artApp__Artwork__c>();
    artistSelected = 'All';
    exhibitionSelected = 'All';
    itemNoSelected = 'All';
    lotnoSelected = 'All';
    
    bondnoSelected = 'All';
    
    
    typeString = '';
    String sortFullExp = sortExpression  + ' ' + sortDirection;
    if(searchText != null && searchText != ''){
        searchRecords = new list<artApp__Artwork__c>();
        String queryStr = '';
        queryStr+= 'SELECT (Select Id, ParentId, Name, LastModifiedDate From Attachments where ContentType = \'application/pdf\' OR  ContentType = \'application/doc\' OR ContentType = \'application/docx\'  order by LastModifiedDate desc limit 1),';
        queryStr+= ' Name, Id, Item_No__c, Lot_No__c, artApp__Exhibition__r.Name, ';
        queryStr+= ' Image__c, artApp__Primary_Image_Id__c,';
        queryStr+= ' Barcode_ID__c, Dimensions__c,Packed_Dimensions__c,GST__c,Bond_Status__c, ';
        queryStr+= ' RecordType.Name, artApp__Artist__r.Name, artApp__Collector__r.Id,';
        queryStr+= ' Internal_Location__r.Name, Packing_Method__c FROM artApp__Artwork__c';
        queryStr+= ' Where artApp__Collector__r.artApp__Email__c= \'' + currentEmail + '\' AND (NOT(Internal_Location__r.Name LIKE \'%release%\' ';
        queryStr+= ' OR Internal_Location__r.Name LIKE \'%deliver%\' OR Internal_Location__r.Name LIKE \'%held by%\' OR Internal_Location__r.Name LIKE \'%disposed%\' OR Internal_Location__r.Name LIKE \'%not ship%\' OR Internal_Location__r.Name ';
        queryStr+= ' LIKE \'%pending%\' OR Internal_Location__r.Name LIKE \'%fp to cc%\' OR Internal_Location__r.Name LIKE \'%cc to fp%\' OR Internal_Location__r.Name';
        queryStr+= ' LIKE \'%enroute%\' OR Internal_Location__r.Name = \'\' OR Internal_Location__r.Name LIKE \'%tbc%\' OR Internal_Location__r.Name LIKE \'%old record%\' OR Internal_Location__r.Name LIKE \'%annex%\')) AND (artApp__Artist__r.Name';
        queryStr+= ' LIKE \'%'+searchText+'%\' OR Lot_No__c LIKE \'%'+searchText+'%\' OR artApp__Exhibition__r.Name LIKE \'%'+searchText+'%\' OR Name  ';
        queryStr+= 'LIKE \'%'+searchText+'%\' OR Barcode_ID__c  LIKE \'%'+searchText+'%\' OR Item_No__c  LIKE \'%'+searchText+'%\' OR Dimensions__c  LIKE';
        queryStr+= ' \'%'+searchText+'%\') ';
      
        //queryStr +=' AND (NOT(Internal_Location__r.Name LIKE \'%disposed%\' ))';
        queryStr +='ORDER BY '+ sortFullExp ;
        
        //system.debug('--------queryStr----1-------' + queryStr);
        tempData = new list<artApp__Artwork__c>();
        tempData = Database.query(queryStr);
        
        listSize = tempData.size();
        system.debug('<--tempData-->'+tempData);
        
        /*******************************************added on 07072020**********************************************/
        Integer min = offsetSearch;
        Integer max = offsetSearch+queryLimit;
       
        while(min<max){
            if(min< tempData.size())
                searchRecords.add(tempData[min]);
            min++;
        }
        
         /*queryStr += ' LIMIT '+queryLimit+' OFFSET '+offsetSearch;
            system.debug('--------queryStr----2-------' + queryStr);
             searchRecords = Database.query(queryStr);
        
         */
        /******************************************************end***************************************************/
       

        if(searchRecords != null && searchRecords.size() > 0){
            accounts = new list<artApp__Artwork__c>();
            system.debug('---1-----searchRecords----' + searchRecords.size());
            accounts.addAll(searchRecords);
            totalPageNumber = 0;
            BindData(1,sortFullExp);
        }
    } else {
       reset();
    }
}

public void subFilter() {
    //system.debug('--------Sub Filter-----------');
    boolean check = false;
    //system.debug('--------Sub Filter---typeString---1-----[' + typeString + ']');
    //system.debug('--------Sub Filter---typeString---2-----[' + system.currentPageReference().getParameters().get('typeString') + ']');
    if(typeString == null || typeString == '') {
        typeString = system.currentPageReference().getParameters().get('typeString');
    }
    //system.debug('--------Sub Filter---typeString--------[' + typeString + ']');
    if(typeString != null && typeString != '') {
        check = true;
        if(subfilterClick == true){
            //limits = '5';
            if(searchText != null && searchText != ''){
                offsetSearch = 0;
            } else {
                offset = 0;
            }
            subfilterClick = false;
        }
        searchRecords = new list<artApp__Artwork__c>();
        String sortFullExp = sortExpression  + ' ' + sortDirection;
      
        String queryStr = 'SELECT (Select Id, ParentId, Name, LastModifiedDate From Attachments where ContentType = \'application/pdf\' OR  ContentType = \'application/doc\' OR ContentType = \'application/docx\'  order by LastModifiedDate desc limit 1),';
            queryStr+= ' Name, Id, Item_No__c, Lot_No__c, artApp__Exhibition__r.Name, ';
            queryStr+= ' Image__c,artApp__Primary_Image_Id__c, ';
            queryStr+= ' Barcode_ID__c, Dimensions__c,GST__c,Bond_Status__c, ';
            queryStr+= ' RecordType.Name, artApp__Artist__r.Name, artApp__Collector__r.Id,';
            queryStr+= ' Internal_Location__r.Name, Packed_Dimensions__c, Packing_Method__c FROM artApp__Artwork__c';
            queryStr+= ' Where artApp__Collector__r.artApp__Email__c= \'' + currentEmail + '\' AND (NOT(Internal_Location__r.Name LIKE \'%release%\' ';
            queryStr+= ' OR Internal_Location__r.Name LIKE \'%deliver%\' OR Internal_Location__r.Name LIKE \'%held by%\' OR Internal_Location__r.Name LIKE \'%disposed%\' OR Internal_Location__r.Name LIKE \'%not ship%\' OR Internal_Location__r.Name ';
            queryStr+= ' LIKE \'%pending%\' OR Internal_Location__r.Name LIKE \'%fp to cc%\' OR Internal_Location__r.Name LIKE \'%cc to fp%\' OR Internal_Location__r.Name';
            queryStr+= ' LIKE \'%enroute%\' OR Internal_Location__r.Name LIKE \'%tbc%\' OR Internal_Location__r.Name LIKE \'%old record%\' OR Internal_Location__r.Name LIKE \'%annex%\')) ';
       
        if(searchText != null && searchText != ''){
        // Zai
        //string searchText27 = string.escapeSingleQuotes(searchText);

            queryStr+= ' AND (artApp__Artist__r.Name LIKE \'%'+searchText+'%\' OR Lot_No__c LIKE \'%'+searchText+'%\' OR artApp__Exhibition__r.Name LIKE \'%'+searchText+'%\' OR Name  ';
            queryStr+= 'LIKE \'%'+searchText+'%\' OR Barcode_ID__c  LIKE \'%'+searchText+'%\' OR Item_No__c  LIKE \'%'+searchText+'%\' OR Dimensions__c  LIKE';
            queryStr+= ' \'%'+searchText+'%\')';
            
        }

        artWorkWrapperList = new List<artWorkWrapper>();
        /*system.debug('--------typeString-----------' + typeString);
        system.debug('--------artistSelected-----------' + artistSelected);
        system.debug('--------lotnoSelected-----------' + lotnoSelected);
        system.debug('--------exhibitionSelected-----------' + exhibitionSelected);
        system.debug('--------itemNoSelected-----------' + itemNoSelected);*/

        if(artistSelected != null && artistSelected != '' && artistSelected != 'All') {
           //system.debug('--------11-----------');
            queryStr+= ' AND artApp__Artist__r.Name = '+'\''+artistSelected+'\'';
            //system.debug('--------queryStr----1!-------' + queryStr);
        }
        if(lotnoSelected != null && lotnoSelected != '' && lotnoSelected != 'All') {
            //system.debug('--------22-----------');
            queryStr+= ' AND Lot_No__c = '+'\''+lotnoSelected+'\'';
            //system.debug('--------queryStr----2!-------' + queryStr);
        }
        if(exhibitionSelected != null && exhibitionSelected != '' && exhibitionSelected != 'All') {
        // Zai
            //system.debug('--------33-----------');
            queryStr+= ' AND artApp__Exhibition__r.Name = '+'\''+String.escapeSingleQuotes(exhibitionSelected)+'\'';
            
            //system.debug('--------queryStr----3!-------' + queryStr);
        }
        if(itemNoSelected != null && itemNoSelected != '' && itemNoSelected != 'All') {
           // system.debug('--------44-----------');
            queryStr+= ' AND Item_No__c = '+'\''+itemNoSelected+'\'';
            //system.debug('--------queryStr----3!-------' + queryStr);
        }
       
        if(bondnoSelected != null && bondnoSelected != '' && bondnoSelected != 'All') {
            // system.debug('--------44-----------');
            queryStr+= ' AND Bond_Status_Color__c = '+'\''+bondnoSelected+'\'';
            
        }
        
        //artistSelected = 'All';
        //lotnoSelected = 'All'; 
        //exhibitionSelected = 'All';
      //  queryStr +=' AND (NOT(Internal_Location__r.Name LIKE \'%disposed%\' )) ';
        queryStr += ' ORDER BY '+ sortFullExp;
        //system.debug('--------queryStr-----------' + queryStr);
        tempDatasubfilter = new list<artApp__Artwork__c>();
        tempDatasubfilter = Database.query(queryStr);
        
        
        
       //system.debug('testTempData--->'+tempData);
        Integer min = 0;                 //added on 07072020
        Integer max = 0;                 //added on 07072020
       
        if(searchText != null && searchText != ''){
            //system.debug('--------1-----------');
            //queryStr += ' LIMIT '+queryLimit+' OFFSET '+ offsetSearch;
            
            min = offsetSearch;                  //added on 07072020
            max = offsetSearch+queryLimit;       //added on 07072020
        } else {
            //system.debug('--------2-----------');
            //queryStr += ' LIMIT '+queryLimit+' OFFSET '+ offset;
            
            min = offset;                  //added on 07072020
            max = offset+queryLimit;        //added on 07072020
        }
        //system.debug('--------queryStr---SubFilter--------' + queryStr);
        
         //added on 07072020
        while(min<max){
            if(min< tempDatasubfilter.size())
                searchRecords.add(tempDatasubfilter[min]);
            min++;
        }
       
       // searchRecords = Database.query(queryStr);
       system.debug('testTempData--->'+tempData);
        if(searchRecords != null && searchRecords.size() > 0){
            accounts = new list<artApp__Artwork__c>();
            accounts = searchRecords;
            totalPageNumber = 0;
            //system.debug('<--bondnoSelected'+bondnoSelected);
            BindData(1,sortFullExp);
        }else{
            artistOptions = new list<SelectOption>();
            lotnoOptions = new list<SelectOption>();
            exhibitionOptions = new list<SelectOption>();
            itemNoOptions = new list<SelectOption>();
            bondNoOptions = new list<SelectOption>();
        }

    }

}

public void showHideAction() {
    showHideColumn = true;
}
public void goBack() {
    boolean colSelected = false;
    List<String> shFieldsList = new List<String>();
    if(showArtist) {
        colSelected = true;
        shFieldsList.add('showArtist');
    }
    if(showTitle) {
        colSelected = true;
        shFieldsList.add('showTitle');
    }
    if(showBarCode) {
        colSelected = true;
        shFieldsList.add('showBarCode');
    }
    if(showItemNo) {
        colSelected = true;
        shFieldsList.add('showItemNo');
    }
    if(showLotNo) {
        colSelected = true;
        shFieldsList.add('showLotNo');
    }
    if(showDimension) {
        colSelected = true;
        shFieldsList.add('showDimension');
    }
    if(showExhibition) {
        colSelected = true;
        shFieldsList.add('showExhibition');
    }
    if(showImage) {
        colSelected = true;
        shFieldsList.add('showImage');
    }
    if(showConditionReport) {
        colSelected = true;
        shFieldsList.add('showConditionReport');
    }
    if(showPD) {
        colSelected = true;
        shFieldsList.add('showPD');
    }
    if(showPM) {
        colSelected = true;
        shFieldsList.add('showPM');
    }
    
    /******************************************added on 07072020*********************************************/
    if(showgst) {
        colSelected = true;
        shFieldsList.add('showgst');
    }
    if(showbondstatus) {
        colSelected = true;
        shFieldsList.add('showbondstatus');
    }
    /***********************************************end*****************************************************/       
    if(colSelected) {
        system.debug('------shFieldsList--------' + shFieldsList);
        User userObj = [select SelectedColumns__c, id from User where id=: Userinfo.getUserId()];
        system.debug('------ userObj---1-----' +  userObj);
        if(shFieldsList != null && shFieldsList.size() > 0) {
            userObj.SelectedColumns__c = '';
            for(String s: shFieldsList) {
                userObj.SelectedColumns__c += s + ',';
            }
        }
        if(!Test.isRunningTest())
        update userObj;
        //system.debug('------ userObj---2-----' +  userObj);
        showHideColumn = false;
    } else {
        //system.debug('------None Selected--------');
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please Select at least one Column'));
    }
}



    //Image Popups
    
    public String imageId {get;set;}
    public Boolean openPopUp {get;set;}
    public String encodedImageId {get;set;}
    
    public void encodeTheChipperTxt(){
        if(imageId!=null){
            String encryptId = String.valueOf(imageId);
    
            encodedImageId = EncodingUtil.base64Encode(Blob.valueOf(encryptId));
            String randomStr = generateRandomString(Integer.valueOf(15));
            encodedImageId+=randomStr; 
            
            openPopUp = true;
        }
    }
    
    public static String generateRandomString(Integer len) {
        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
        String randStr = '';
        while (randStr.length() < len) {
            Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
            randStr += chars.substring(idx, idx+1);
        }
        return randStr; 
    }
    
    public void setBoolToFalse(){
        openPopUp = false;
    }
    
    public Class artWorkWrapper{
        public artApp__Artwork__c apArt{set;get;}
        public String attachmentrec{set;get;}
        public artWorkWrapper(){
            apArt = new artApp__Artwork__c();
        }
    }
}