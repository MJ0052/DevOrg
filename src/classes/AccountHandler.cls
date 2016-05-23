public with sharing class AccountHandler {
	public static Account insertNewAccount(string accountName){
		Account acct = new Account(Name= accountName);
		try {
    		insert acct;
    		ID acctID = acct.Id;
    		System.debug('ID = ' + acctID);
  		}
        catch (DmlException e) {
      		System.debug('A DML exception has occurred: ' + e.getMessage());
   			acct=null;
   		}
  		return acct;
  }
}