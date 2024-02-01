public class AccountHandler {
    public static Account insertNewAccount( string Accountname){
        try{
        Account newAccount = new Account(Name = Accountname);
        insert newAccount;
   		return newAccount;        
    
        }
        catch(DmlException e){
            system.debug('A DML exception has occurred: '+e.getMessage());
      		return null; 
        }
    } 

}