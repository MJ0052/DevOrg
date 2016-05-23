public class DMLOperations {
    public static void insert_Upsert_Operation(){
        // Insert the Josh contact
		Contact josh = new Contact(FirstName='Josh',LastName='Kaplan',Department='Finance');       
		insert josh;

		// Josh's record has been inserted
		//   so the variable josh has now an ID
		//   which will be used to match the records by upsert
		josh.Title = 'Dev';

		// Create the Kathy contact, but don't persist it in the database
		Contact kathy = new Contact(FirstName='Kathy',LastName='Brown',Department='Technology');

		// List to hold the new contacts to upsert
		List<Contact> contacts = new List<Contact> { josh, kathy };

		// Call upsert
		upsert contacts;
		// Result: Josh is updated and Kathy is created.
    }
    public static void delete_Operation(){
        try {
       			Contact[] contactsDel = [SELECT Id FROM Contact WHERE LastName='Kaplan']; 
        		System.debug(contactsDel);
				delete contactsDel;
			}
        	catch (DmlException e) {
    			System.debug('A DML exception has occurred: ' + e.getMessage());
			}
    }
    public static void Database_Operation(){
        // Create a list of contacts
		List<Contact> conList = new List<Contact> {
        new Contact(FirstName='Monk',LastName='Vert',Department='Finance'),
        new Contact(FirstName='Jack',LastName='Jone',Department='Technology'),
        new Contact(FirstName='Mike',LastName='Gamson',Department='Finance'),
        new Contact()};
            
		// Bulk insert all contacts with one DML call
		Database.SaveResult[] srList = Database.insert(conList, false);

		// Iterate through each returned result
		for (Database.SaveResult sr : srList) {
    		if (sr.isSuccess()) {
        	// Operation was successful, so get the ID of the record that was processed
        	System.debug('Successfully inserted contact. Contact ID: ' + sr.getId());
    		} else {
        		// Operation failed, so get all errors
        		for(Database.Error err : sr.getErrors()) {
            	System.debug('The following error has occurred.');
            	System.debug(err.getStatusCode() + ': ' + err.getMessage());
            	System.debug('Contact fields that affected this error: ' + err.getFields());
	 		}
    }
}

    }
}