@isTest
public class AccountBatchTest {
	@isTest
    Public static void executeTest(){
        //Creat a Contact
        Contact newcontact1 = new Contact(FirstName = 'Shivansh', LastName='Sharma');
        insert newcontact1;
        
        AccountBatch ab = new AccountBatch();
        Test.startTest();
            Id jobId = Database.executeBatch(ab,5);
        Test.stopTest();
        //Check whether account is Created or not with Contact's FirstName and Last Name
        Account acc = [SELECT Id, Name FROM Account WHERE CreatedDate = TODAY];
        //System.debug('Account'+ acc);
        //system.debug('account' +jobId);
        System.assertEquals('Shivansh__Sharma', acc.Name);
        //Check 
        Contact con = [SELECT Id, AccountId , name From Contact Where CreatedDate = Today];
        System.debug('con'+con);
        system.assertEquals(acc.Id, con.AccountId);
        //
    }
}