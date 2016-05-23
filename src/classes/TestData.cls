public with sharing class TestData {
    public static void insertLeads(Integer numberOfLeads){
    	List<Lead> leadList = new List<Lead>();
    	Lead leadObj;
    	for(Integer i = 0;i< numberOfLeads;i++){
    		leadObj = new Lead();
    		leadObj.Company = 'Test Company ' + i;
    		leadObj.FirstName = 'T Lead First Name ' + i;
			leadObj.LastName = 'T Lead Last Name ' + i;
			leadObj.Phone = '8555555555555' + i;
            leadObj.MobilePhone = '8555555555555' + i;
            leadObj.Email = 'mj@gmail.com';
            leadObj.Status = 'Open - Not Contacted';
            leadList.Add(leadObj);
    	}
    	insert leadList;
    }
    public static List<Lead> getLeads(Integer numberOfLeads){
    	List<Lead> leadList = new List<Lead>();
    	Lead leadObj;
    	for(Integer i = 0;i< numberOfLeads;i++){
    		leadObj = new Lead();
    		leadObj.Company = 'Test Company ' + i;
    		leadObj.FirstName = 'T Lead First Name ' + i;
			leadObj.LastName = 'T Lead Last Name ' + i;
			leadObj.Phone = '091855555555' + i;
            leadObj.MobilePhone = '091855555555';
            leadObj.Email = 'mj'+ i + '@gmail.com';
            leadList.Add(leadObj);
    	}
    	return leadList;
    }
    public static List<Opportunity> getOpportunities(Integer numberOfLeads){
    	List<Opportunity> oppList = new List<Opportunity>();
    	Opportunity oppObj;
    	for(Integer i = 0;i< numberOfLeads;i++){
    		oppObj = new Opportunity();
    		oppObj.Name = 'Test Opp' + i;
    		oppObj.CloseDate = Datetime.now().date();
			oppObj.StageName = 'Qualification';
			oppObj.Amount = 1200000;
            oppList.Add(oppObj);
    	}
    	return oppList;
    }
    public static void generateTimeZoneDetails(){
    	TimeZoneDetails__c timezoneObj = new TimeZoneDetails__c(Area_Code__c = '091',State__c='MH',Time_Zone__c='05:30');
    	insert timezoneObj;
    	timezoneObj = new TimeZoneDetails__c(Area_Code__c = '091',State__c='MH',Time_Zone__c='05:30');
    	insert timezoneObj;
    	timezoneObj = new TimeZoneDetails__c(Area_Code__c = '024',State__c='GJ',Time_Zone__c='05:30');
    	insert timezoneObj;
    	timezoneObj = new TimeZoneDetails__c(Area_Code__c = '020',State__c='AP',Time_Zone__c='05:20');
    	insert timezoneObj;
    }
     public static void insertAccount(){
    	Account accountObj = new Account(Name = 'Test Account');
    	insert accountObj;
    	accountObj = new Account(Name = 'Test Account 1');
    	insert accountObj;
    	accountObj = new Account(Name = 'Test Account 2');
    	insert accountObj;
    	accountObj = new Account(Name = 'Test Account 3');
    	insert accountObj;
    }
    public static void insertProjectForAccount(){
    	List<Account> accountList = new List<Account>([Select Id,Name from Account]);
    	List<Project__c> projectList = new List<Project__c>();
    	Project__c projectObj;
    	for(Account accountObj : accountList){
    		projectObj = new Project__c();
    		projectObj.Name = 'Project For - ' +accountObj.Name;
    		projectObj.Account__c = accountObj.Id;
    		projectObj.Start_Date__c = Datetime.now().date();
    		projectObj.End_Date__c = Datetime.now().date();
    		projectList.add(projectObj);
    	}
    	insert projectList;
    }
    public static void insertTimeEntries(){
    	List<Project__c> projectList = new List<Project__c>([Select Id,Name from Project__c]);
    	List<Contact> contactList = new List<Contact>([Select Id,Name from Contact]);
    	List<Time_Entries__c> timeEntriesList = new List<Time_Entries__c>();
    	Time_Entries__c timeEntryObj;
    	for(Project__c projObj:projectList){
    		for(Contact contactObj : contactList){
    			timeEntryObj = new Time_Entries__c();
    			timeEntryObj.Name = 'TE for C - '+contactObj.Name;
    			timeEntryObj.Project__c = projObj.Id;
    			timeEntryObj.Date__c = Datetime.now().date();
    			timeEntryObj.Duration__c = 10;
    			timeEntryObj.Contact__c = contactObj.Id;
    			timeEntriesList.add(timeEntryObj);
    		}
    	}
    	insert timeEntriesList;
    }
    public static void insertContactDependingOnAccounts(Integer numberOfContacts){
    	List<Contact> contactList = new List<Contact>();
    	List<Account> accountList = new List<Account>([Select Id,Name from Account]);
    	Contact contactObj;
    	
    	for(Account accountObj : accountList){
    		for(Integer i=0;i<numberOfContacts;i++){
    			contactObj = new Contact();
    			contactObj.AccountId = accountObj.Id;
    			contactObj.FirstName = 'FN Contact For - ' + accountObj.Name;
    			contactObj.LastName = 'LN Contact For - ' + accountObj.Name;
    			contactList.add(contactObj);
    		}	
    	}
    	insert contactList;
    }
}