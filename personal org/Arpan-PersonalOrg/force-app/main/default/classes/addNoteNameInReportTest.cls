@isTest 
/*-----------added by uzair tmc for adding notes in Attachment field-------*/
public class addNoteNameInReportTest {
    public static testMethod void validateNoteForOpportunity(){
        Id rcdtype = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Personal Account').getRecordTypeId();
        
        Test.startTest();
        opportunity o=new opportunity();
        o.StageName='Closed Won';
        o.name='Test Opp';
        o.CloseDate=System.TODAY();
        o.Estimated_Volume__c=30;
        o.Pack_Date_1__c=System.TODAY();
        o.Amount=50000;
        o.Person_In_Charge__c='AM';
        o.Quote_Number__c='Test Quote';
        o.OB_Job_Number__c='Test Job Number';
        o.attachment__c='Test Attachment';
        o.RecordTypeId = rcdtype;
        insert o;
        
       
        Note addedntes = new Note();
        addedntes.ParentId = o.Id;
        addedntes.Body = o.attachment__c;
        addedntes.Title = 'Creation Note';
        insert addedntes;
        delete addedntes;
        Test.stopTest();    
    }
   
    static testMethod void validateAttachmentForJobReference(){
        Test.startTest();
        
        Id rcdtype = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Personal Account').getRecordTypeId();
        system.debug('rcdtype--'+rcdtype);
        opportunity o=new opportunity();
        o.StageName='Closed Won';
        o.name='Test Opp';
        o.Person_In_Charge__c ='AM';
        o.RecordTypeId = rcdtype;
        o.CloseDate=System.TODAY();
        o.Person_In_Charge__c='AM';
        o.Estimated_Volume__c=30;
        o.Pack_Date_1__c=System.TODAY();
        o.Amount=50000;
        o.Quote_Number__c='Test Quote';
        o.OB_Job_Number__c='Test Job Number';
        o.attachment__c='Test Attachment';
        o.RecordTypeId = rcdtype;
        insert o;
        
        Job_Reference__c jobRef = new Job_Reference__c();
        jobRef.Name='Test Job Ref';
        //  jobRef.CsinchargeOpp__c='01220000000762SAAQ';
        jobRef.Opportunity__c=o.ID;
        insert jobRef;
        
        Note addedntes = new Note();
        addedntes.ParentId = jobRef.Id;
        addedntes.Body = 'Twst';
        addedntes.Title = 'Creation Note';
        insert addedntes;
        delete addedntes;
        Test.stopTest();    
    }
    
    static testMethod void validateAttachmentForArtwork(){
        Test.startTest();
        
        
        artApp__Artist__c artist= new   artApp__Artist__c();
        artist.name='Test Artist';
        insert artist;
        
        artApp__Artwork__c artwork = new artApp__Artwork__c();
        artwork.name='test Artwork';
        artwork.artApp__Artist__c=artist.id;
        insert artwork;
        
        Note addedntes = new Note();
        addedntes.ParentId = artwork.Id;
        addedntes.Body = 'Twst';
        addedntes.Title = 'Creation Note';
        insert addedntes;
        
        delete addedntes;
        
        Test.stopTest();    
    }
}