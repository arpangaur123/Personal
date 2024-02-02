@isTest
public class TokenUtilityClassTest {

    @isTest
    public static void run(){
        
        
        Swagger_Credential__c swag = new Swagger_Credential__c();
        swag.Name = 'SwaggerToken';
        swag.Company_Name__c = 'HELU-TRANS (SINGAPORE) PTE LTD';
        swag.Email__c = 'epadmin@helutrans.com';
        swag.Password__c = 'Epadmin123';
        swag.End_Point__c = 'http://202.55.79.254:8080/api';
        insert swag;
        
          Account a = new Account(name='Tan Enterprise');
        insert a;
       
        Contact c = new Contact();
		c.FirstName = 'Paul';
		c.LastName  = 'Test';
		c.AccountId = a.id;
		c.MailingStreet = '298 S. Ringo Street';
		c.MailingCity = 'Little Rock';
		c.MailingState = 'AR';
		c.MailingPostalCode = '72201'; 
		
		insert c;
		System.debug('created primary contact');
			
		//Then create another non-primary contact
		Contact ci = new Contact();
		ci.FirstName = 'Bob';
		ci.LastName  = 'Test';
		ci.AccountId = a.id;
		ci.MailingStreet = '298 S. Ringo Street';
		ci.MailingCity = 'Little Rock';
		ci.MailingState = 'AR';
		ci.MailingPostalCode = '72201'; 
		
		insert ci;
        
       List<Opportunity> Opplist = new List<Opportunity>();
        
        Id devRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Artmove').getRecordTypeId();
        Opportunity opp = new Opportunity 
            (recordtypeid = devRecordTypeId,Push_Lost_Cancelled_Status__c  = false, Push_Opportunity_Info__c=false,CloseDate = Date.newInstance(2009, 11, 01), 
             Name = 'Test Opportunity', StageName = 'Survey', Billing_Currency__c = 'SGD', SAMJobType__c = 'LAC',QuoteCounter__c = '123',Sales_Person__c = 'KQ',
           Description = 'Test an Apex Class', Payment_Terms__c = '30 Days', AM_Job_Type__c = 'AR - ArtSpace', ETA__c = Date.newInstance(2011, 04, 29), ETD__c = Date.newInstance(2010, 04, 20),AccountId=a.id,Actual_Volume_cuft__c=12);
        //insert opp;
        Opplist.add(opp);
        insert Opplist;
        
         // OpportunityContactRole oppcontrole = new OpportunityContactRole();
       // oppcontrole.ContactId = c.id;
       // oppcontrole.OpportunityId = Opplist[0].id;
       // insert oppcontrole;
        
        
        OpportunityContactRole ocr = new OpportunityContactRole();
		ocr.ContactId = c.Id;
		ocr.OpportunityId = Opplist[0].id;
		ocr.IsPrimary = TRUE;
		
		insert ocr;
		System.debug('created opportunity contact role for primary');
			
		//Now update the OCR for the non-primary contact
		OpportunityContactRole ocr1 = new OpportunityContactRole();
			
		ocr1.ContactId = ci.Id;
		ocr1.OpportunityId = Opplist[0].id;
		ocr1.IsPrimary = FALSE;
		
		insert ocr1;
		System.debug('created opportunity contact role for non-primary contact');
		
		Update opp;
        
        TokenUtilityClass TokenObj = new TokenUtilityClass();
       
        TokenUtilityClass.getToken();
        TokenUtilityClass.IsSuccess = true;
        TokenUtilityClass.endpoint = 'http://202.55.79.254:8080/api';
        TokenUtilityClass.token = 'message';
        PortalAPIUtility.pushOpportunity(Opplist);
    }
}