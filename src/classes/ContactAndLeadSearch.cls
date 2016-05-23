public class ContactAndLeadSearch {
    public static List<List< SObject>> searchContactsAndLeads(string searchString){
        List<List<sObject>> searchList = [FIND :searchString IN ALL FIELDS RETURNING Lead(Name), Contact(Name)];
        return searchList;
    }
}