public class AddPrimaryContact implements Queueable {
    private Contact ContactSObject;
    private String State;
    public AddPrimaryContact(Contact contactObj, String State){
        this.ContactSObject = contactObj;
        this.State = State;
    }
    public void execute(QueueableContext context) {
        List<Account> accountList = new List<Account>([SELECT ID,BillingState FROM Account where BillingState =: State]);
        Contact contactObj;
        List<Contact> contactList = new List<Contact>();
        for(Account accountObj : accountList){
            contactObj = new Contact();
            contactObj = ContactSObject.clone();
            contactObj.AccountId = accountObj.Id;
            contactList.add(contactObj);
        }
        insert contactList;
    }
}