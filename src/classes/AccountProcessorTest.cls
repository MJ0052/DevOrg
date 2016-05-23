@IsTest
private class AccountProcessorTest {

  @IsTest
  private static void testCountContacts() {
    List<Account> newAccounts = new List<Account>();
    Account accountObj1;
    for(Integer i=0;i<50;i++){
    	accountObj1 = new Account();
        accountObj1.Name = 'TEST ' + i;
        newAccounts.add(accountObj1);
    }
    insert newAccounts;
    Test.setMock(HttpCalloutMock.class, new CalloutMock());
    List<Account> accountList = new List<Account>([Select Id from Account]);
    List<ID> accountIDs = new List<ID>();
    for(Account accountObj : accountList){
    	accountIDs.add(accountObj.ID);
    }
    Test.startTest();
    AccountProcessor.countContacts(accountIDs);
    Test.stopTest();
    
    //accountList = [Select Id,Number_of_Contacts__c from A]
    //System.assertEquals(1, logs.size());
    //System.assertEquals('success', logs[0].msg__c);
  }

}