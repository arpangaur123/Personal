@isTest 
private class addContentDocumentInReportTest{
    static testMethod void validateAttachmentForOpportunity(){
        Id rcdtype = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Personal Account').getRecordTypeId();
        Test.startTest();
        ContentVersion cv = new ContentVersion(
            Title = 'Test',
            PathOnClient = 'Test.jpg',
            VersionData = blob.valueof('Test Content Data'),
            IsMajorVersion = true
        );
        insert cv;
            
        ContentVersion contentVersionSelect = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id LIMIT 1];
        
        List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        
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
        
        ContentDocumentLink contentlink=new ContentDocumentLink();
        contentlink.LinkedEntityId=o.id;  
        contentlink.ShareType= 'v';               
        contentlink.ContentDocumentId=documents[0].Id;
        
        insert contentlink;
        delete contentlink;
        delete documents;
        
        
            
        Test.stopTest();    
    }
    
    static testMethod void validateAttachmentForJobReference(){
        Test.startTest();
        ContentVersion cv = new ContentVersion(
            Title = 'Test',
            PathOnClient = 'Test.jpg',
            VersionData = blob.valueof('Test Content Data'),
            IsMajorVersion = true
        );
        insert cv;
            
        ContentVersion contentVersionSelect = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id LIMIT 1];
        
        List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        
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
           
        ContentDocumentLink contentlink=new ContentDocumentLink();
        contentlink.LinkedEntityId=jobRef.id;  
        contentlink.ShareType= 'v';               
        contentlink.ContentDocumentId=documents[0].Id;
        
        insert contentlink;
        
        delete documents;
            
        Test.stopTest();    
    }
    
    static testMethod void validateAttachmentForArtwork(){
        Test.startTest();
        ContentVersion cv = new ContentVersion(
            Title = 'Test',
            PathOnClient = 'Test.jpg',
            VersionData = blob.valueof('Test Content Data'),
            IsMajorVersion = true
        );
        insert cv;
            
        ContentVersion contentVersionSelect = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id LIMIT 1];
        
        List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        
        artApp__Artist__c artist= new   artApp__Artist__c();
        artist.name='Test Artist';
        insert artist;
        
        artApp__Artwork__c artwork = new artApp__Artwork__c();
        artwork.name='test Artwork';
        artwork.artApp__Artist__c=artist.id;
        insert artwork;
           
        ContentDocumentLink contentlink=new ContentDocumentLink();
        contentlink.LinkedEntityId=artwork.id;  
        contentlink.ShareType= 'v';               
        contentlink.ContentDocumentId=documents[0].Id;
        
        insert contentlink;
        delete documents;
            
        Test.stopTest();    
    }
    //added by uzair tmc to cover new trigger addContentDocumentTrigger and ContentDocumentLinkTrigger
    static testMethod void validateContentLinkForArtwork(){
        Test.startTest();
        ContentVersion cv = new ContentVersion(
            Title = 'Test',
            PathOnClient = 'Test.jpg',
            VersionData = blob.valueof('Test Content Data'),
            IsMajorVersion = true
        );
        insert cv;
            
        ContentVersion contentVersionSelect = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id LIMIT 1];
        
        List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        
        artApp__Artist__c artist= new   artApp__Artist__c();
        artist.name='Test Artist';
        insert artist;
        
        artApp__Artwork__c artwork = new artApp__Artwork__c();
        artwork.name='test Artwork';
        artwork.artApp__Artist__c=artist.id;
        insert artwork;
           
        ContentDocumentLink contentlink=new ContentDocumentLink();
        contentlink.LinkedEntityId=artwork.id;  
        contentlink.ShareType= 'v';               
        contentlink.ContentDocumentId=documents[0].Id;
        
        insert contentlink;
        delete contentlink;
            
        Test.stopTest();    
    }
    static testMethod void validateAttachmentForJobReferenceDelete(){
        Test.startTest();
        ContentVersion cv = new ContentVersion(
            Title = 'Test',
            PathOnClient = 'Test.jpg',
            VersionData = blob.valueof('Test Content Data'),
            IsMajorVersion = true
        );
        insert cv;
        
        ContentVersion contentVersionSelect = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id LIMIT 1];
        
        List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        
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
        
        ContentDocumentLink contentlink=new ContentDocumentLink();
        contentlink.LinkedEntityId=jobRef.id;  
        contentlink.ShareType= 'v';               
        contentlink.ContentDocumentId=documents[0].Id;
        
        insert contentlink;
        
        delete contentlink;
        
        Test.stopTest();    
    }
    
}