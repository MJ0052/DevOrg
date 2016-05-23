@isTest
public class AddPrimaryContactTest {

    @testSetup 
    static void setup() {
        List<Account> accounts = new List<Account>();
        accounts.add(new Account(name='Q APEX',BillingState='MAHA'));
        for (Integer i = 0; i < 100; i++) {
            accounts.add(new Account(
                name='FOR Q APEX '+i,BillingState='GUJ'
            ));
        }
        insert accounts;
    }
    
    static testmethod void testQueueable() {
        Contact obj = new Contact(LastName = 'Queueable APEX');
        AddPrimaryContact updater = new AddPrimaryContact(obj, 'MAHA');
        Test.startTest();        
        System.enqueueJob(updater);
        Test.stopTest();        
    }
    
}