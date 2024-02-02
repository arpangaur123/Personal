@isTest 
public class SyncArtworkCtrlTest{

   public static testMethod void testCase(){
      artApp__Artwork__c  art = setupMethodHelperClasses.getArtWork();
      SyncArtworkCtrl.getArtAppCount(art.Crate__c);
   }

}