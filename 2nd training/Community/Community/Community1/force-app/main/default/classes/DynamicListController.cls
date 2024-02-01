public virtual class DynamicListController {
    public static Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe() ;
    protected Id pId;
    public Boolean selectAll {get;set;}
    public String objectLabel {get; protected set;}
    protected String objectName;
    public artApp__Line_Item__c t {get; set;}
    
    
    private ApexPages.StandardSetController controller;
    private String baseQuery;
    public String nameSearchFld {get; set;}
    protected String fuzzyNameSearchFld = '';
    //public Boolean hasCollection {get; protected set;}
    //public Integer collectionSize {get; protected set;}
    //public String filterFld {get; set;}
    
    
    // constructor
    public DynamicListController(String baseQuery) {
        this.baseQuery = baseQuery;
        query(); // lazy loading - don't query until the Search function is invoked 
    }
    

    // query methods
    protected void query() {
        // construct the query string
        String queryString = baseQuery + ' ' + getWhereClause() + ' ' + getSortClause() + ' limit 8999';
        System.debug('~~~queryString: ' + queryString);
        System.debug('~~~getWhereClause: ' + getWhereClause());
        System.debug('~~~getSortClause: ' + getSortClause());
        
        System.debug('~~~fuzzyNameSearchFld: ' + fuzzyNameSearchFld);

        // save pageSize
        Integer pageSize = this.pageSize;

        // reboot standard set controller
        System.debug('~~~queryString: ' + queryString);
        controller = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
        System.debug('~~~controller: ' + this.controller);
        System.debug('~~~controller:.getRecords() ' + this.controller.getRecords());
        

        // reset pageSize
        controller.setPageSize(pageSize);
    }
    
    
    

    // search methods
    public PageReference search() {
        query();

        // return to same page
        return null;
    }
    
    // filter methods
    public PageReference filter() {
        query();

        // return to same page
        return null;
    }

    // override to construct dynamic SOQL where clause 
    protected virtual String getWhereClause() {
        if(this.nameSearchFld == 'all'){
            return '';
        }else if(this.nameSearchFld == 'unfiltered'){
            return ' and ' + sortColumn + ' = NULL ';
        }else if (this.nameSearchFld != null && this.nameSearchFld.trim() != ''){
            this.fuzzyNameSearchFld = '%'+ this.nameSearchFld+'%';
            return ' and ' + sortColumn +' like :fuzzyNameSearchFld ';
        }else{
            return ' ';
        }
    }

    // sort methods
    public String sortColumn {
        get {
            if (sortColumn == null){
                sortColumn = 'Name';
                if (baseQuery.contains('from Contact')){
                    sortColumn = 'LastName';    
                }
            }
            return sortColumn;
        }
        set {
            if (sortColumn != value) sortDesc = false;
            sortColumn = value;
        }
    }

    public Boolean sortDesc {
        get {
            if (sortDesc == null) sortDesc = false;
            return sortDesc;
        } 
        set;
    }

    public PageReference sort() {
        sortDesc = !sortDesc;

        query();

        // return to same page
        return null;
    }

    protected virtual String getSortClause() {
        if (sortColumn == '') return 'order by CreatedDate desc';
        else return ' order by ' + sortColumn + (sortDesc ? ' desc ' : ' asc ') + ' nulls last';
    }

    // pageable methods
    // get records on current page 
    protected List<SObject> getRecords() {
        return (controller != null)?controller.getRecords():new List<SObject>();
    }

    public void first() {
        controller.first();
    }

    public void previous() {
        controller.previous();
    }

    public void next() {
        controller.next();
    }

    public void last() {
        controller.last();
    }

    public Boolean getHasPrevious() {
        return (controller != null)?controller.getHasPrevious():false;
    }

    public Boolean getHasNext() {
        return (controller != null)?controller.getHasNext():false;
    }

    public Integer getResultSize() {
        return (controller != null)?controller.getResultSize():0;
    }

    public Integer getPageCount() {
        if (controller == null) {
            return 0;
        } else {
            Integer resultSize = getResultSize();
    
            Integer oddRecordCount = Math.mod(resultSize, pageSize);
            return ((resultSize - oddRecordCount) / pageSize) + (oddRecordCount > 0 ? 1 : 0);
        }
    }

    public Integer getPageNumber() {
        return (controller != null)?controller.getPageNumber():0;
    }

    public void setPageNumber(Integer pageNumber) {
        controller.setPageNumber(pageNumber);
    }

    public Integer pageSize {
        get {
            if (pageSize != null)
                return pageSize;
            else if (controller != null) 
                pageSize = controller.getPageSize();
            else
                // default pagesize
                pageSize = 20; 

            return pageSize;
        }

        set {
            pageSize = value;
            
            if (controller != null)
                controller.setPageSize(pageSize);
        }
    }

    public Boolean getRenderResults() {
        return (getResultSize() > 0);
    }

    public virtual PageReference save() {
        return controller.save();
    }

    public virtual PageReference cancel() {
        return controller.cancel();
    }

    // pass reference to dynamic paginator component 
    public DynamicListController getController () {
        return this;
    }
    
    public static String getAllFields(String sObj,  Map<String, Schema.SObjectType> gd){
        System.debug( '\n~~~sObj: '+ sObj) ;
        Schema.SObjectType s = gd.get(sObj) ;
        Schema.DescribeSObjectResult r = s.getDescribe() ;
        Map<String, Schema.SObjectField> f = r.fields.getMap() ;
        String fields = '';
        Set<String> excludedFields = new Set<String>{'lastvieweddate', 'lastreferenceddate'};
        for (String o : f.keySet()){
            if(!excludedFields.contains(o.toLowerCase())){
                fields = fields + o + ', ';
            }     
        }
        Integer length = fields.length() - 2;
        String myFields = fields.substring(0,length);
        //System.debug( '\n~~~Fields string is: '+ myFields ) ;
        return myFields;
    }
}