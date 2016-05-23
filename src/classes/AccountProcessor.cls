public class AccountProcessor {
    @future(callout=true)
    public static void countContacts(List<ID> AccountIDs) {
        List<Account> accountList = new List<Account>([Select Id,Number_of_Contacts__c from Account where Id IN :AccountIDs]);
        List<Account> accountListToUpdate = new List<Account>();
        List<Contact> contactList;
        System.debug('ACCOUNT LIST ' + accountList);
        for(Account accountObj : accountList){
            contactList = new List<Contact>();
            contactList = [Select Id from Contact where AccountId =: accountObj.Id];
            accountObj.Number_of_Contacts__c = contactList.size();
            accountListToUpdate.add(accountObj);
        }
        update accountListToUpdate;
    }
}