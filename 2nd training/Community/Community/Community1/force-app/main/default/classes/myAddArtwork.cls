public class myAddArtwork{
public String Cid = System.currentPagereference().getParameters().get('Cid');
public String Cname = System.currentPagereference().getParameters().get('Cname');
public String getCname(){return System.currentPagereference().getParameters().get('Cname');}
public String getCid(){return System.currentPagereference().getParameters().get('Cid');}


  private List<artApp__Artwork__c> accounts;

  public List<artApp__Artwork__c> getAccounts() {
      return accounts;
  }

  public string keywords {
    get;
    set;
  }
  
  public string keywords2 {
    get;
    set;
  }

  public PageReference ViewData() {
     
     //dynamically build the query to insertthe filter values
     String query = 'SELECT Id, Name, Crate__c FROM artApp__Artwork__c WHERE Crate__c =null AND Name LIKE \'%' + keywords + '%\' LIMIT 1';
     
     accounts = Database.query(query);
                   
     return null;
  }
  
  public PageReference ViewData2() {
     
     //dynamically build the query to insertthe filter values
     String query = 'SELECT Id, Name, Crate__c, Barcode_ID__c FROM artApp__Artwork__c WHERE Crate__c =null AND Barcode_ID__c LIKE \'%' + keywords2 + '%\' LIMIT 1';
     
     accounts = Database.query(query);
                   
     return null;
  }

  public PageReference UpdateRecords() {
    // this simple line of code finds out which column was changed and update the 
    // relevant account record accordingly!
    artApp__Artwork__c account=accounts[0];
    account.Crate__c=Cid;
    update account;
    //PageReference p = new Apexpages.Standardcontroller(account).view();
    //PageReference p = new PageReference('/apex/SampleDetailPage?id='+Cid);
    PageReference p = new PageReference('/apex/mAddartwork?Cid='+Cid+'&Cname='+Cname);
    p.setRedirect(true);
    return p;
    //return null;
  }
  
  public PageReference mySaveExit() {    
    
    PageReference p = new PageReference('/apex/shCratedetail?id='+Cid);    
    p.setRedirect(true);
    return p;
    
  }
  
}