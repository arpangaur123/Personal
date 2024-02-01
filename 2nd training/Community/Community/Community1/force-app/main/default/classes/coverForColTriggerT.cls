@isTest
private class coverForColTriggerT {

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
    
    /* Create new Artist and link and artwork to it */
    artApp__Artist__c art = new artApp__Artist__c(name='Acai', CurrencyIsoCode='HKD');
    insert art;
    
    
    artApp__Artwork__c aw = new artApp__Artwork__c(name='planet', artApp__Artist__c = art.Id, CurrencyIsoCode='HKD');
    insert aw;
    
    /* Link the Artwork to the Collector */
    aw.artApp__Collector__c = col.Id;
    
    try
    {
        delete aw;
    
    }
    catch(Exception e) {
        system.debug ('error: ' + e.getMessage() );
    }
    
        
} // end of myunittest()

}// end of class test trigger