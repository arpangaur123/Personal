@isTest
private class updateInternationalMoveOppTest {

    static testMethod void updateinternationopp() {
    
      //Id fullRecTypeA = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Doctor Feedback').getRecordTypeId();
    
    
    Account testAccount = new Account();
        testAccount.Name='New mAWS Deal' ;
        try{
        insert testAccount;
        }catch(Exception e )
        {}
        Contact cont = new Contact();
        cont.FirstName='Test';
        cont.LastName='Test';
        cont.Accountid= testAccount.id;
        insert cont;
        
        Opportunity oppt = new Opportunity();
        oppt.Name ='New mAWS Deal';
        oppt.AccountID = testAccount.ID;
        oppt.StageName = 'Generate Opportunity';
        oppt.Amount = 3000;
        oppt.Enquiry_received__c = System.today();
        oppt.Enquiry_Acknowledged__c = System.today();
        oppt.CloseDate = System.today();
        oppt.Shipper_First_Name__c=cont.FirstName;
        oppt.Shipper_Last_Name__c=cont.LastName;
        oppt.Shipper_Account__c=testAccount.Name;
        //oppt.Acknowledgement_Time_New__c=oppt.Enquiry_received__c - oppt.Enquiry_Acknowledged__c;

        //oppt.New_Stage__c = 'Generate Opportunity';
        insert oppt;
        Opportunity oppt2 = new Opportunity();
        oppt2.Name ='New mAWS Deal';
        oppt2.AccountID = testAccount.ID;
        oppt2.StageName = 'Generate Opportunity';
        oppt2.Amount = 3000;
        oppt2.Enquiry_received__c = System.today() +1 ;
        oppt2.Enquiry_Acknowledged__c = System.today() +2;
        oppt2.CloseDate = System.today();
        oppt2.Shipper_First_Name__c=cont.FirstName;
        oppt2.Shipper_Last_Name__c=cont.LastName;
        oppt2.Shipper_Account__c=testAccount.Name;
        try{
        
        insert oppt2;
        }catch(exception e){}
        
         Opportunity oppt3 = new Opportunity();
        oppt3.Name ='New mAWS Deal';
        oppt3.AccountID = testAccount.ID;
        oppt3.StageName = 'Generate Opportunity';
        oppt3.Amount = 3000;
        oppt3.Enquiry_received__c = System.today() +4 ;
        oppt3.Enquiry_Acknowledged__c = System.today() +5;
        oppt3.CloseDate = System.today();
        oppt3.Shipper_First_Name__c=cont.FirstName;
        oppt3.Shipper_Last_Name__c=cont.LastName;
        oppt3.Shipper_Account__c=testAccount.Name;
        insert oppt3;
    }
    }