@isTest 
private class TestaddAttachmentNameInReport{
    static testMethod void validateAttachment() {
        
        Id rcdtype = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Personal Account').getRecordTypeId();
        opportunity o=new opportunity();
            o.StageName='Closed Won';
            o.name='Test Opp';
            o.CloseDate=System.TODAY();
            o.Estimated_Volume__c=30;
            o.Pack_Date_1__c=System.TODAY();
            o.Amount=50000;
            o.Quote_Number__c='Test Quote';
            o.OB_Job_Number__c='Test Job Number';
            o.attachment__c='Test Attachment';
            o.Person_In_Charge__c='AM';
            o.RecordTypeId = rcdtype;
            insert o;
           Attachment att1=new Attachment ();
           att1.name='Test Attachment100';
           att1.ParentId=o.id;
           att1.Body=Blob.valueof('Test Body');
           insert att1;
           att1.name='Test Attachment1000';
           update att1;
           Job_Reference__c jobRef= new Job_Reference__c();
           jobRef.Name='Test Job Ref';
           jobRef.Opportunity__c=o.ID;
           insert jobRef;
           Attachment att2=new Attachment ();
           att2.name='Test Attachment100';
           att2.ParentId=jobRef.id;
           att2.Body=Blob.valueof('Test Body');
           insert att2;
           att2.name='Test Attachment1000';
           update att2;
           
           artApp__Artist__c artist= new   artApp__Artist__c();
            artist.name='Test Artist';
            insert artist;
            
            artApp__Artwork__c artwork = new artApp__Artwork__c();
            artwork.name='test Artwork';
            artwork.artApp__Artist__c=artist.id;
            insert artwork;
            
            Attachment att3=new Attachment ();
           att3.name='Test Attachment100';
           att3.ParentId=artwork.id;
           att3.Body=Blob.valueof('Test Body');
           insert att3;
           att3.name='Test Attachment1000';
           update att3;
           
           
           opportunity o1=new opportunity();
            o1.StageName='Closed Won';
            o1.name='Test Opp';
            o1.CloseDate=System.TODAY();
            o1.Estimated_Volume__c=30;
            o1.Pack_Date_1__c=System.TODAY();
            o1.Amount=50000;
            o1.Quote_Number__c='Test Quote';
            o1.OB_Job_Number__c='Test Job Number';
            o1.attachment__c='Test Attachment';
        	o1.Person_In_Charge__c='AM';
            o1.RecordTypeId = rcdtype;
            insert o1;
           Attachment att11=new Attachment ();
           att11.name='Test Attachment100';
           att11.ParentId=o1.id;
           att11.Body=Blob.valueof('Test Body');
           insert att11;
           delete att1;
           
           Job_Reference__c jobRef1= new Job_Reference__c();
           jobRef1.Name='Test Job Ref1';
           jobRef1.Opportunity__c=o1.ID;
           insert jobRef1;
           Attachment att22=new Attachment ();
           att22.name='Test Attachment100';
           att22.ParentId=jobRef1.id;
           att22.Body=Blob.valueof('Test Body');
           insert att22;
           
           delete att2;
           
           artApp__Artist__c artist1= new   artApp__Artist__c();
            artist1.name='Test Artist 6th July2015'; // Antony@TMC modifying test data naming; 7th July 2015
            insert artist1;
            
            artApp__Artwork__c artwork1 = new artApp__Artwork__c();
            artwork1.name='test Artwork';
            artwork1.artApp__Artist__c=artist1.id;
            insert artwork1;
            
            Attachment att33=new Attachment ();
           att33.name='Test Attachment_6_July_2015'; // Antony@TMC modifying test data naming; 7th July 2015
           att33.ParentId=artwork1.id;
           att33.Body=Blob.valueof('Test Body');
           insert att33;
           delete att3;
           // Antony@TMC Start Updating for Test Class Issues while migration 7th July 2015 
           delete artwork1;
           delete artist1;
           // Antony@TMC End. 
            
           
    }
}