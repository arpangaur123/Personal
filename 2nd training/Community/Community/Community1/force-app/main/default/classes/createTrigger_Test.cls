@istest
public class createTrigger_Test {
    
    public static testmethod void method1(){
        Location__c Loc = new Location__c();
        Loc.Name = 'Location';
        insert Loc;
        
        Location__c Loc1 = new Location__c();
        Loc1.Name = 'Location';
        insert Loc1;
        
        
        
        Crate__c c1 = new Crate__c();
        c1.Name = 'Barcode 1';
      //  c1.Job_Reference__c = jobRef.id;
        c1.Location__c = Loc.Id;
        c1.Date_In__c = system.today().addDays(-15);
        c1.Date_Out__c = system.today().addDays(20);
        c1.Collection_No__c = 'Test12345';
        insert c1;
        
        artApp__Artist__c artist = new artApp__Artist__c();
        artist.Name = 'Karthik';
        insert artist;
        
        artApp__Artwork__c Artwork = new artApp__Artwork__c();
        Artwork.Barcode_ID__c = 'Barcode 1';
        Artwork.artApp__Artist__c = artist.id;
        Artwork.Crate__c = c1.Id;
        insert Artwork;
        
        c1.Location__c = Loc1.Id;
        update c1;
        
    }
}