public class shartwkdetails
{
/*String currentId = UserInfo.getUserId();*/

User u = [Select Id, Name, Email from User where Id = :UserInfo.getUserId()];
String currentEmail = u.Email;
   
  public List<artApp__Artwork__c> getartwkdetails()
  {
      List<artApp__Artwork__c> artworks = [SELECT Name, II_Permit_Declared_Date__c, artApp__Media__c, artApp__Primary_Image_Id__c, artApp__Primary_Image__c, 
      artApp__Type__c, Date_Out__c, Barcode_ID__c, Date_In__c, Dimensions__c, artApp__Primary_Image_URL__c, 
      RecordType.Name, artApp__Artist__r.Name, artApp__Artist__r.artApp__Type__c, artApp__Collector__r.Id, artApp__Collector__r.Name, Internal_Location__r.Name FROM artApp__Artwork__c 
      Where artApp__Collector__r.artApp__Email__c= :currentEmail OR artApp__Collector__r.artApp__Email__c= :currentEmail+'.sg.testbox'];      
      return artworks;
      /* OR artApp__Collector__r.artApp__Email__c= :currentEmail+'.sg.testbox'*/
  }
}