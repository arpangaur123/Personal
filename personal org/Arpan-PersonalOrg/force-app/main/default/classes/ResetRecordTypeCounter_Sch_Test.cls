/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest(seeAllData=false)
private class ResetRecordTypeCounter_Sch_Test {

    static testMethod void myUnitTestAnnual() {
      Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
      User u = new User(Alias = 'standt', Email='sysadmindusergreatwavw1@greatwavetech.com', 
      EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
      LocaleSidKey='en_US', ProfileId = p.Id, 
      TimeZoneSidKey='America/Los_Angeles', UserName='sysadmindusergreatwavw1@greatwavetech.com');

      System.runAs(u) {
        Test.startTest();
           String CRON_EXP = '0 0 0 15 3 ? 2022';
           Record_Type_Counter__c rc = new Record_Type_Counter__c();
           rc.Object_Name__c = 'Opportunity';
           rc.Name = 'Test';
           rc.Initial_Counter__c = 1000;
           rc.Frequency__c = 'Annual';
           rc.Description__c = 'test';
           rc.Count__c = 1001;
           insert rc;
           String jobId = System.schedule('testBasicScheduledApex', CRON_EXP, new ResetRecordTypeCounter_Sch());
            // Get the information from the CronTrigger API object
           CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
                     NextFireTime
                    FROM CronTrigger WHERE id = :jobId];
           // Verify the expressions are the same
           System.assertEquals(CRON_EXP,  ct.CronExpression);
           // Verify the job has not run
           System.assertEquals(0, ct.TimesTriggered);
        Test.stopTest();
      }
    }
    
    static testMethod void myUnitTestMonthly() {
      Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
      User u = new User(Alias = 'standt', Email='sysadmindusergreatwavw1@greatwavetech.com', 
      EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
      LocaleSidKey='en_US', ProfileId = p.Id, 
      TimeZoneSidKey='America/Los_Angeles', UserName='sysadmindusergreatwavw1@greatwavetech.com');

      System.runAs(u) {
        Test.startTest();
           String CRON_EXP = '0 0 0 15 3 ? 2022';
           Record_Type_Counter__c rc = new Record_Type_Counter__c();
           rc.Object_Name__c = 'Opportunity';
           rc.Name = 'Test';
           rc.Initial_Counter__c = 1000;
           rc.Frequency__c = 'Monthly';
           rc.Description__c = 'test';
           rc.Count__c = 1001;
           insert rc;
           String jobId = System.schedule('testBasicScheduledApex', CRON_EXP, new ResetRecordTypeCounter_Sch());
            // Get the information from the CronTrigger API object
           CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
                     NextFireTime
                    FROM CronTrigger WHERE id = :jobId];
           // Verify the expressions are the same
           System.assertEquals(CRON_EXP,  ct.CronExpression);
           // Verify the job has not run
           System.assertEquals(0, ct.TimesTriggered);
        Test.stopTest();
      }
    }
}