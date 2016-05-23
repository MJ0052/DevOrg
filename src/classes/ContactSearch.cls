public class ContactSearch {
    public static List<Contact> searchForContacts(string c_LastName, string c_PostalCode){
        List<Contact> contactList = new List<Contact>();
        contactList = [Select ID, Name from Contact where LastName = :c_LastName];
        System.debug(contactList[0]);
        return contactList;
    }
}