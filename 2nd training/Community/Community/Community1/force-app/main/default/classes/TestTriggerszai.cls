@isTest
private class TestTriggerszai {

static testMethod void myUnitTest() {
artApp__Collector__c col = new artApp__Collector__c();        
    col.artApp__Mobile__c = '1234567';
    col.artApp__Fax__c = '22516464';
    col.artApp__Contact_First_Name__c = 'Andrew';
    col.artApp__Contact_Last_Name__c = 'Mayne';
    col.artApp__Contact_Middle_Name__c = 'Vinod';
    col.artApp__Title__c = 'Mr';
    col.artApp__Address_1__c = 'chua';
    col.artApp__Address_2__c = 'chu kang';
    col.artApp__City__c = 'bahamas';
    col.artApp__State_Province__c = 'mehico';
    col.artApp__Zip_Postal_Code__c = '90201';
    col.artApp__Country__c = 'Singapore';
    //col.artAppE2__Account_Id__c = v.AccountId;
    col.artApp__Email__c = 'acai@mymail.com';
    col.artApp__Phone__c = '98221453';
    
    insert col;
    
    /* Create new Account and Contact record */
        Account a = new Account(name='Tan Enterprise');
        insert a;        
    
    Contact c = new Contact(firstName='Ken', lastName='LEE', 
        accountid=A.id, Email='lim@myMail.com', Phone='777', MobilePhone='111', Fax='222');
        insert c;
        
        
    artApp__Collector__c col1 = new artApp__Collector__c(artApp__Contact_Last_Name__c ='Mayne',
    artApp__Email__c = 'acai1@mymail.com', artApp__Phone__c = '98255553');
    insert col1;
    
    /* Create new Account and Contact record */
        Account b = new Account(name='Ben Enterprise');
        insert b;        
    
    Contact d = new Contact(firstName='Chuin', lastName='Mee', 
        accountid=b.id, Email='limed@myMail.com', Phone='75477', MobilePhone='23111', Fax='05222');
        insert d;
    
    
    
    
}


}