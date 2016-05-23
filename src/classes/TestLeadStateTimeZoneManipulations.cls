@isTest
private class TestLeadStateTimeZoneManipulations {
    @isTest static void TestInsertContact() {
        Contact acct = new Contact(FirstName='Test Account',LastName='INVALIDNAME');
        insert acct;
        
        Test.startTest();
        Database.DeleteResult result = Database.delete(acct, false);
        Test.stopTest();
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('The Last Name INVALIDNAME is not allowed for DML',result.getErrors()[0].getMessage());
    }
}