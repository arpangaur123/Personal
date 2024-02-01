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
@isTest
private class TestTrigger {

    static testMethod void myUnitTest() {
        list<Opportunity> opp2Insert = new list<Opportunity>();
        /* Create new Account and Contact record */
        Account a = new Account(name='Tan Enterprise');
        insert a;
        Contact c = new Contact(firstName='Ken', lastName='LEE', 
        accountid=A.id, Email='lim@myMail.com', Phone='777', MobilePhone='111', Fax='222');
        insert c;
        
        /* Create new INBOUND Opportunity record */
        Opportunity opp = new Opportunity 
        (recordtypeid = '012200000008avZAAQ', CloseDate = Date.newInstance(2009, 11, 01), 
        Name = 'Test Opportunity', StageName = 'Survey', Billing_Currency__c = 'SGD');
        //insert opp;
        opp2Insert.add(opp);
        Opportunity opp2 = new Opportunity 
        (recordtypeid = '012200000008avZAAQ', CloseDate = Date.newInstance(2009, 11, 01), 
        Name = 'Test Opportunity', StageName = 'Survey', Billing_Currency__c = 'USD');
        //insert opp2; 
        opp2Insert.add(opp2);
        Opportunity opp3 = new Opportunity 
        (recordtypeid = '012200000008avZAAQ', CloseDate = Date.newInstance(2009, 11, 01), 
        Name = 'Test Opportunity', StageName = 'Survey', Billing_Currency__c = 'EUR');
        //insert opp3; 
        opp2Insert.add(opp3);
        System.assert(opp.recordtypeid == '012200000008avZAAQ');
        
        /* Create new OUTBOUND Opportunity record */
        Opportunity opp4 = new Opportunity 
        (recordtypeid = '01220000000Tr5FAAS', CloseDate = Date.newInstance(2009, 11, 01), 
        Name = 'Test Opportunity', StageName = 'Survey', Billing_Currency__c = 'SGD', 
        ETA__c = Date.newInstance(2011, 01, 29), ETD__c = Date.newInstance(2010, 01, 20));
        //insert opp4;
        opp2Insert.add(opp4);
        Opportunity opp5 = new Opportunity 
        (recordtypeid = '01220000000Tr5FAAS', CloseDate = Date.newInstance(2009, 11, 01), 
        Name = 'Test Opportunity', StageName = 'Survey', Billing_Currency__c = 'SGD', 
        ETA__c = Date.newInstance(2011, 02, 29), ETD__c = Date.newInstance(2010, 02, 20));
        //insert opp5;
        opp2Insert.add(opp5);
        Opportunity opp6 = new Opportunity 
        (recordtypeid = '01220000000Tr5FAAS', CloseDate = Date.newInstance(2009, 11, 01), 
        Name = 'Test Opportunity', StageName = 'Survey', Billing_Currency__c = 'SGD', 
        ETA__c = Date.newInstance(2011, 03, 29), ETD__c = Date.newInstance(2010, 03, 20));
        //insert opp6;
        opp2Insert.add(opp6);
        Opportunity opp7 = new Opportunity 
        (recordtypeid = '01220000000Tr5FAAS', CloseDate = Date.newInstance(2009, 11, 01), 
        Name = 'Test Opportunity', StageName = 'Survey', Billing_Currency__c = 'SGD', 
        ETA__c = Date.newInstance(2011, 04, 29), ETD__c = Date.newInstance(2010, 04, 20));
        //insert opp7;
        opp2Insert.add(opp7);
        Opportunity opp8 = new Opportunity 
        (recordtypeid = '01220000000Tr5FAAS', CloseDate = Date.newInstance(2009, 11, 01), 
        Name = 'Test Opportunity', StageName = 'Survey', Billing_Currency__c = 'SGD', 
        ETA__c = Date.newInstance(2011, 05, 29), ETD__c = Date.newInstance(2010, 05, 20));
        //insert opp8;
        opp2Insert.add(opp8);
        Opportunity opp9 = new Opportunity 
        (recordtypeid = '01220000000Tr5FAAS', CloseDate = Date.newInstance(2009, 11, 01), 
        Name = 'Test Opportunity', StageName = 'Survey', Billing_Currency__c = 'SGD', 
        ETA__c = Date.newInstance(2011, 06, 29), ETD__c = Date.newInstance(2010, 06, 20));
        //insert opp9;
        opp2Insert.add(opp9);
        Opportunity opp10 = new Opportunity 
        (recordtypeid = '01220000000Tr5FAAS', CloseDate = Date.newInstance(2009, 11, 01), 
        Name = 'Test Opportunity', StageName = 'Survey', Billing_Currency__c = 'SGD', 
        ETA__c = Date.newInstance(2011, 07, 29), ETD__c = Date.newInstance(2010, 07, 20));
        //insert opp10;
        opp2Insert.add(opp10);
        Opportunity opp11 = new Opportunity 
        (recordtypeid = '01220000000Tr5FAAS', CloseDate = Date.newInstance(2009, 11, 01), 
        Name = 'Test Opportunity', StageName = 'Survey', Billing_Currency__c = 'SGD', 
        ETA__c = Date.newInstance(2011, 08, 29), ETD__c = Date.newInstance(2010, 08, 20));
        //insert opp11;
        opp2Insert.add(opp11);
        Opportunity opp12 = new Opportunity 
        (recordtypeid = '01220000000Tr5FAAS', CloseDate = Date.newInstance(2009, 11, 01), 
        Name = 'Test Opportunity', StageName = 'Survey', Billing_Currency__c = 'SGD', 
        ETA__c = Date.newInstance(2011, 09, 29), ETD__c = Date.newInstance(2010, 09, 20));
        //insert opp12;
        opp2Insert.add(opp12);
        Opportunity opp13 = new Opportunity 
        (recordtypeid = '01220000000Tr5FAAS', CloseDate = Date.newInstance(2009, 11, 01), 
        Name = 'Test Opportunity', StageName = 'Survey', Billing_Currency__c = 'SGD', 
        ETA__c = Date.newInstance(2011, 10, 29), ETD__c = Date.newInstance(2010, 10, 20));
        //insert opp13;
        opp2Insert.add(opp13);
        Opportunity opp14 = new Opportunity 
        (recordtypeid = '01220000000Tr5FAAS', CloseDate = Date.newInstance(2009, 11, 01), 
        Name = 'Test Opportunity', StageName = 'Survey', Billing_Currency__c = 'SGD', 
        ETA__c = Date.newInstance(2011, 11, 29), ETD__c = Date.newInstance(2010, 11, 20));
        //insert opp14;
        opp2Insert.add(opp14);
        Opportunity opp15 = new Opportunity 
        (recordtypeid = '01220000000Tr5FAAS', CloseDate = Date.newInstance(2009, 11, 01), 
        Name = 'Test Opportunity', StageName = 'Survey', Billing_Currency__c = 'SGD', 
        ETA__c = Date.newInstance(2011, 12, 29), ETD__c = Date.newInstance(2010, 12, 20));
        //insert opp15;
        opp2Insert.add(opp15);
        /* Create new ARTMOVE Opportunity record */
        Opportunity opp16 = new Opportunity 
        (recordtypeid = '012200000008bhJ', AM_Job_Type__c = 'AC - Crating Services', 
        LeadSource ='Agent Rate Request', CloseDate = Date.newInstance(2009, 11, 01), 
        Name = 'Test ARTMOVE Opportunity', StageName = 'Survey', Person_In_Charge__c = 'IN');
        //insert opp16;
        opp2Insert.add(opp16);
        
        /* Create new ARTMOVE FP */
        Opportunity opp17 = new Opportunity 
        (recordtypeid = '01220000000JTCx', AM_Job_Type__c = 'IM - International Move', 
        LeadSource ='Agent Rate Request', CloseDate = Date.newInstance(2009, 11, 01), 
        Name = 'Test ARTMOVE Opportunity 2', StageName = 'Survey', Person_In_Charge__c = 'IN');
        //insert opp17;
        opp2Insert.add(opp17);
        /* Create new ARTMOVE HK */
        Opportunity opp18 = new Opportunity 
        (recordtypeid = '01220000000JTD7', AM_Job_Type__c = 'AS - Installation', 
        LeadSource ='Agent Rate Request', CloseDate = Date.newInstance(2009, 11, 01), 
        Name = 'Test ARTMOVE Opportunity 2', StageName = 'Survey', Person_In_Charge__c = 'IN');
        //insert opp18;
        opp2Insert.add(opp18);
        /* Create new ARTMOVE SH */
        Opportunity opp19 = new Opportunity 
        (recordtypeid = '01220000000JTD2', AM_Job_Type__c = 'AX - Anything & Everything', 
        LeadSource ='Agent Rate Request', CloseDate = Date.newInstance(2009, 11, 01), 
        Name = 'Test ARTMOVE Opportunity 2', StageName = 'Survey', Person_In_Charge__c = 'IN');
        //insert opp19;
        opp2Insert.add(opp19);
        /* Create new ARTMOVE BJ ZAI*/
        Opportunity opp20 = new Opportunity 
        (recordtypeid = '01220000000JTDC', AM_Job_Type__c = 'DS - Destination Services', 
        LeadSource ='Agent Rate Request', CloseDate = Date.newInstance(2009, 11, 01), 
        Name = 'Test ARTMOVE Opportunity 2', StageName = 'Survey', Person_In_Charge__c = 'IN');
        //insert opp20;
        opp2Insert.add(opp20);
        /* Create new HHG IM Agent Booked door to door*/
        Opportunity opp21 = new Opportunity 
        (recordtypeid = '01220000000Tr5A', Shipment_Details__c = 'IM Door to Door', 
        LeadSource ='Agent Rate Request', CloseDate = Date.newInstance(2009, 11, 01), 
        Name = 'Test HHG IM Agent Booked', StageName = 'Survey', Person_In_Charge__c = 'IN');
        //insert opp21;
        opp2Insert.add(opp21);
        /* Create new HHG LM Corporate Account local move*/
        Opportunity opp22 = new Opportunity 
        (recordtypeid = '01220000000Tr5K', Shipment_Details__c = 'Local Move', 
        LeadSource ='Agent Rate Request', CloseDate = Date.newInstance(2009, 11, 01), 
        Name = 'Test HHG IM Agent Booked', StageName = 'Survey', Person_In_Charge__c = 'IN');
        //insert opp22;
        opp2Insert.add(opp22);
        /* Create new HHG WA Personal Account warehouse*/
        Opportunity opp23 = new Opportunity 
        (recordtypeid = '01220000000Tr5F', Shipment_Details__c = 'Warehousing', 
        LeadSource ='Agent Rate Request', CloseDate = Date.newInstance(2009, 11, 01), 
        Name = 'Test HHG IM Agent Booked', StageName = 'Survey', Person_In_Charge__c = 'IN');
        //insert opp23;
        opp2Insert.add(opp23);
        /* Create new HHG WA Personal Account Origin Services*/
        Opportunity opp24 = new Opportunity 
        (recordtypeid = '01220000000Tr5F', Shipment_Details__c = 'Origin Services', 
        LeadSource ='Agent Rate Request', CloseDate = Date.newInstance(2009, 11, 01), 
        Name = 'Test HHG Origin Services', StageName = 'Survey', Person_In_Charge__c = 'IN');
        //insert opp24;
        opp2Insert.add(opp24);
        /* Create new HHG WA Personal Account Office Move*/
        Opportunity opp25 = new Opportunity 
        (recordtypeid = '01220000000Tr5F', Shipment_Details__c = 'Office Move', 
        LeadSource ='Agent Rate Request', CloseDate = Date.newInstance(2009, 11, 01), 
        Name = 'Test HHG Office Move', StageName = 'Survey', Person_In_Charge__c = 'IN');
        //insert opp25;
        opp2Insert.add(opp25);
        /* Create new HHG IM Agent Booked door to port*/
        Opportunity opp26 = new Opportunity 
        (recordtypeid = '01220000000Tr5A', Shipment_Details__c = 'IM Door to Port', 
        LeadSource ='Agent Rate Request', CloseDate = Date.newInstance(2012, 11, 01), 
        Name = 'Test HHG IM Agent Booked', StageName = 'Survey', Person_In_Charge__c = 'IN');
        //insert opp26;       
        opp2Insert.add(opp26);
        
        /* Create new HHG IM Agent Booked 3rd Country Move*/
        Opportunity opp27 = new Opportunity 
        (recordtypeid = '01220000000Tr5A', Shipment_Details__c = '3rd Country Move', 
        LeadSource ='Agent Rate Request', CloseDate = Date.newInstance(2012, 11, 02), 
        Name = 'Test HHG IM Agent Booked3', StageName = 'Survey', Person_In_Charge__c = 'IN');
        //insert opp27;
        opp2Insert.add(opp27);
        /* Create new HHG IM Agent Booked IM DTD Inbound*/
        Opportunity opp28 = new Opportunity 
        (recordtypeid = '01220000000Tr5A', Shipment_Details__c = 'IM DTD Inbound', 
        LeadSource ='Agent Rate Request', CloseDate = Date.newInstance(2012, 11, 02), 
        Name = 'Test HHG IM Agent Booked5', StageName = 'Survey', Person_In_Charge__c = 'IN');
        //insert opp28;
        opp2Insert.add(opp28);
        /* Create new HHG Quote*/
        Opportunity opp32 = new Opportunity 
        (recordtypeid = '01220000000Tr5F', Shipment_Details__c = 'Office Move', 
        LeadSource ='Agent Rate Request', Quote_Mode__c ='IM', CloseDate = Date.newInstance(2012, 11, 01), 
        Name = 'Test HHG Office Move', StageName = 'Survey', Person_In_Charge__c = 'IN');
        //insert opp32;
        opp2Insert.add(opp32);
        Opportunity opp29 = new Opportunity 
        (recordtypeid = '012200000008bhJAAQ', AM_Job_Type__c = 'IT - Third Party Managament', 
        LeadSource ='Agent Rate Request', CloseDate = Date.newInstance(2009, 11, 01), 
        Name = 'Test ARTMOVE Opportunity 2', StageName = 'Survey', Person_In_Charge__c = 'IN');
        //insert opp29;
        opp2Insert.add(opp29);
        Opportunity opp30 = new Opportunity 
        (recordtypeid = '012200000008bhJAAQ', AM_Job_Type__c = 'LS - Local Services', 
        LeadSource ='Agent Rate Request', CloseDate = Date.newInstance(2009, 11, 01), 
        Name = 'Test ARTMOVE Opportunity 2', StageName = 'Survey', Person_In_Charge__c = 'IN');
        //insert opp30;
        opp2Insert.add(opp30);
        Opportunity opp31 = new Opportunity 
        (recordtypeid = '012200000008bhJAAQ', AM_Job_Type__c = 'MP - Manpower', 
        LeadSource ='Agent Rate Request', CloseDate = Date.newInstance(2009, 11, 01), 
        Name = 'Test ARTMOVE Opportunity 2', StageName = 'Survey', Person_In_Charge__c = 'IN');
        //insert opp31;
        opp2Insert.add(opp31);
        insert opp2Insert;
        /* Create new DS Rate Reply record */              
        list<Rate_Reply__c> rr2Insert = new list<Rate_Reply__c>();
        Rate_Reply__c r3 = new Rate_Reply__c (recordtypeid = '01220000000TsdvAAC', Agent_Name__c = c.Id,
        Agent_Email__c = 'OSagent@what.com', Quote_Validity_days__c = '60', Initials__c = 'LLY',
        Date__c = Date.newInstance(2009, 11, 17), Quote_Revision__c = 'A', quote_number__c = 'quote');
        insert r3;
        
        r3.Agent_Email__c = 'OSagent@mail.com';
        update r3;
        
        Rate_Reply__c r4 = new Rate_Reply__c (recordtypeid = '01220000000TsdvAAC', Agent_Name__c = c.Id,
        Agent_Email__c = 'OSagent@what.com', Quote_Validity_days__c = '60', Initials__c = 'LLY',
        Date__c = Date.newInstance(2009, 11, 17), Quote_Revision__c = 'A', quote_number__c = 'quote-');
        insert r4;
        
        r4.Agent_Email__c = 'OSagent@mail.com';
        update r4;
        
        /* Create new OS Rate Reply record */
        Rate_Reply__c r2 = new Rate_Reply__c (recordtypeid = '01220000000Tse0AAC', Agent_Name__c = c.Id,
        Agent_Email__c = 'OSagent@what.com', Quote_Validity_days__c = '60', Initials__c = 'LLY',
        Date__c = Date.newInstance(2009, 11, 01), Quote_Revision__c = 'A', quote_number__c = 'quote');
        insert r2;
        
        r2.Agent_Email__c = 'OSagent@mail.com';
        update r2;
        
        Rate_Reply__c r5 = new Rate_Reply__c (recordtypeid = '01220000000Tse0AAC', Agent_Name__c = c.Id,
        Agent_Email__c = 'OSagent@what.com', Quote_Validity_days__c = '60', Initials__c = 'LLY',
        Date__c = Date.newInstance(2009, 11, 17), Quote_Revision__c = 'A', quote_number__c = 'quote-');
        insert r5;
        
        r5.Agent_Email__c = 'OSagent@mail.com';
        update r5;
        
        /* Create new OpportunityContactRole record */
        OpportunityContactRole ocrr = new OpportunityContactRole (OpportunityId = opp4.id, ContactId = c.id, Role = 'Shipper');
        insert ocrr;
        OpportunityContactRole ocrr2 = new OpportunityContactRole (OpportunityId = opp4.id, ContactId = c.id, Role = 'Destination Agent');
        insert ocrr2;
        OpportunityContactRole ocrr3 = new OpportunityContactRole (OpportunityId = opp4.id, ContactId = c.id, Role = 'Booker');
        insert ocrr3;
        
        /* Update OUTBOUND Opportunity record 
        opp4.Name = 'NEW opp';
        update opp4;
        opp5.Name = 'NEW opp';
        update opp5;
        opp6.Name = 'NEW opp';
        update opp6;
        opp7.Name = 'NEW opp';
        update opp7;
        opp8.Name = 'NEW opp';
        update opp8;
        opp9.Name = 'NEW opp';
        update opp9;
        opp10.Name = 'NEW opp';
        update opp10;
        opp11.Name = 'NEW opp';
        update opp11;
        opp12.Name = 'NEW opp';
        update opp12;
        opp13.Name = 'NEW opp';
        update opp13;
        opp14.Name = 'NEW opp';
        update opp14;
        opp15.Name = 'NEW opp';
        update opp15;
        */
        
        /* Create new Traffic record */
        Traffic__c t = new Traffic__c (Load_1__c = true, Load_2__c = false, Shipping_Mode__c = 'BY SEA', 
        Billing_Instructions__c = 'You are to bill us according to your quote of:', 
        Quantity_of_Containers__c = 100, Container_Type__c = 'CASE', Gross_Weight_KG__c = 1000, Volume_CBM__c = 500,
        Packages__c = 30, Content__c = 'Content text',
        Special_Instruction_Details__c = 'Door to Port shipment, please contact shippers for immediate clearance. Helutrans will not be responsible for any storage charges.');
        insert t;
        
        Traffic__c t2 = new Traffic__c (Load_1__c = true, Load_2__c = true, Shipping_Mode__c = 'BY SEA', 
        Billing_Instructions__c = 'You are to bill us according to your quote of:', 
        Quantity_of_Containers__c = 100, Quantity_of_Container_2__c = 40, Container_Type__c = 'CASE', 
        Gross_Weight_KG__c = 1000, Gross_Weight_2_KG__c = 800, Volume_CBM__c = 500, Volume_2_CBM__c = 200,
        Packages__c = 30, Packages_2__c = 10, Content__c = 'Content text',
        Special_Instruction_Details__c = 'Door to Port shipment, please contact shippers for immediate clearance. Helutrans will not be responsible for any storage charges.');
        insert t2;
        
        /* Update Traffic record */
        t.Shipping_Line_Carrier__c = 'my shipping line';
        update t;

    }//end of my unit test
}