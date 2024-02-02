public class ArtworkJobs
{

User u = [Select Id, Name, Email from User where Id = :UserInfo.getUserId()];
String currentEmail = u.Email;

private List<artApp__Artwork__c> accounts;

private List<artApp__Artwork__c> pageAccounts;

private Integer pageNumber;

private Integer totalRecords;

private Integer pageSize;

private Integer totalPageNumber;

private String sortDirection = 'DESC';

private String sortExp = 'CreatedDate';

public Integer getPageNumber()

{

return pageNumber;

}
public Integer gettotalRecords()

{

return totalRecords;

}

public List<artApp__Artwork__c> getAccounts()

{

return pageAccounts;

}

public Integer getPageSize()

{

return pageSize;

}

public Boolean getPreviousButtonEnabled()

{

return !(pageNumber > 1);

}

public Boolean getNextButtonDisabled()

{

if (accounts == null) return true;

else

return ((pageNumber * pageSize) >= accounts.size());

}

public Integer getTotalPageNumber()

{

if (totalPageNumber == 0 && accounts !=null)

{

totalPageNumber = accounts.size() / pageSize;

Integer mod = accounts.size() - (totalPageNumber * pageSize);

if (mod > 0)

totalPageNumber++;

}

return totalPageNumber;

}

   public String sortExpression
   {
     get
     {
        return sortExp;
     }
     set
     {
       //if the column is clicked on then switch between Ascending and Descending modes
       if (value == sortExp)
         sortDirection = (sortDirection == 'ASC')? 'DESC' : 'ASC';
       else
         sortDirection = 'ASC';
       sortExp = value;
     }
   }

 public String getSortDirection()
 {
    //if not column is selected 
    if (sortExpression == null || sortExpression == '')
      return 'ASC';
    else
     return sortDirection;
 }

 public void setSortDirection(String value)
 {  
   sortDirection = value;
 }

public ArtworkJobs()

{

pageNumber = 0;

totalPageNumber = 0;

pageSize = 25;

ViewData();

}

public PageReference ViewData()

{
//build the full sort expression
String sortFullExp = sortExpression  + ' ' + sortDirection;

accounts = null;

totalPageNumber = 0;

BindData(1,sortFullExp);

return null;

}

private void BindData(Integer newPageIndex, String tmyExp)
{
String queryStr= 'SELECT Id, Name, CreatedDate, Job_No__c, CreatedBy.LastName, LastModifiedBy.LastName '; 
queryStr+= 'FROM artApp__Artwork__c Where Job_No__c !=null ORDER BY '+ tmyExp +' LIMIT 1000';

try

{

if (accounts == null)

accounts = Database.query(queryStr);
totalRecords = accounts.size();
pageAccounts = new List<artApp__Artwork__c>();

Transient Integer counter = 0;

Transient Integer min = 0;

Transient Integer max = 0;

if (newPageIndex > pageNumber)

{

min = pageNumber * pageSize;

max = newPageIndex * pageSize;

}

else

{

max = newPageIndex * pageSize;

min = max - pageSize;


}

for(artApp__Artwork__c a : accounts)

{

counter++;

if (counter > min && counter <= max)

pageAccounts.add(a);

}

pageNumber = newPageIndex;

if (pageAccounts == null || pageAccounts.size() <= 0)

ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Data not available for this view.'));

}

catch(Exception ex)

{

ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,ex.getMessage()));

}

}

public PageReference nextBtnClick() {

BindData(pageNumber + 1, '');

return null;

}

public PageReference previousBtnClick() {

BindData(pageNumber - 1, '');

return null;

}

}