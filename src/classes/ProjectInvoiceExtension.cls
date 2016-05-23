public with sharing class ProjectInvoiceExtension {
    private final Project__c ProjectObj;
	List<Time_Entries__c> timeEntriesList;
	//List<Project__c> selectedProjects = new List<Project__c>();
	
	public ProjectInvoiceExtension(apexpages.standardController controller){
		ProjectObj=(Project__c)controller.getRecord();
		String val = ApexPages.CurrentPage().getParameters().get('ProjectID');
		Project__c currentProjectObj = [SELECT Id,Name FROM Project__c WHERE Id =: val];
        ProjectObj.Start_Date__c = System.Date.today().toStartOfMonth();
        ProjectObj.End_Date__c = ProjectObj.Start_Date__c.addMonths(1).addDays(-1);
        ProjectObj.name = currentProjectObj.Name;
        ProjectObj.Id = val;
    }
    public List<Time_Entries__c> gettimeEntriesList() {
      //  if(projects == null) projects = [SELECT Account__c,End_Date__c,Id,Name,Start_Date__c,Total_Invoiced_Hrs__c,Selected__c,Total_Project_Hrs__c FROM Project__c LIMIT 10];
        return timeEntriesList;
    }
     public PageReference getSelected()
    {
       // selectedAccounts.clear();
        //for(accountwrapper accwrapper : accountList)
        //if(accwrapper.selected == true)
       // selectedAccounts.add(accwrapper.acc);
        return null;
    }
    public void searchProjectTimeEntries(){
    	List<Time_Entries__c> timeEntriesListtemp = [SELECT Billable_Amount__c,Contact__c,Date__c,Description__c,Duration__c,Id,Invoiced__c,Name,Project__c,Selected__c FROM Time_Entries__c WHERE Project__c =: ProjectObj.Id AND Invoiced__c != true];
    	System.debug(timeEntriesListtemp);
    	timeEntriesList = new List<Time_Entries__c>();
    	for(Time_Entries__c timeEntryObj : timeEntriesListtemp){
    		Time_Entries__c dupObj = timeEntryObj.Clone();
    		dupObj.Selected__c = true;
    		System.debug('DUPLICATE OBJ ' + dupObj);
    		//System.debug(timeEntriesList);
    		timeEntriesList.Add(dupObj);
    	}
    }
    public void generateInvoice(){
    	List<Time_Entries__c> TimeEntryList = new List<Time_Entries__c>();
    	List<Time_Entries__c> TimeEntryListToUpdate = new List<Time_Entries__c>();
    	List<Invoice_Line_Items__c> InvoiceLineItemList = new List<Invoice_Line_Items__c>();
    	Project__c currentProjectObj = [SELECT Account__c,End_Date__c,Id,Name,Selected__c,Start_Date__c,Total_Invoiced_Hrs__c,Total_Project_Hrs__c FROM Project__c WHERE Id =: projectObj.Id];
    	
    	Invoice__c InvoiceObj = new Invoice__c();
        InvoiceObj.Name = 'Invoice for Project - ' + currentProjectObj.Name;
    	InvoiceObj.Project__c = currentProjectObj.Id;
        InvoiceObj.Account__c = currentProjectObj.Account__c;
        InvoiceObj.Invoice_Start_Date__c = currentProjectObj.Start_Date__c;
        InvoiceObj.Invoice_End_Date__c = currentProjectObj.End_Date__c;
        
        insert InvoiceObj;
        
       	for(Time_Entries__c timeEntryObj:timeEntriesList)
   		{
   			if(timeEntryObj.Selected__c == true){
   				System.debug('TIME ENTRY OBJECT ' + timeEntryObj);
   				Invoice_Line_Items__c invoiceLineItemsObj = new Invoice_Line_Items__c();
   				invoiceLineItemsObj.Name = invoiceObj.Name + ' - Line Item';
    			invoiceLineItemsObj.Invoice__c = invoiceObj.Id;
   				invoiceLineItemsObj.Invoice_Amount__c = timeEntryObj.Billable_Amount__c;
   				invoiceLineItemsObj.Invoice_Hrs__c = timeEntryObj.Duration__c;
   				System.debug('TIME ENTRY OBJECT ID ' + timeEntryObj.Id);
   				invoiceLineItemsObj.Time_Entry__c = timeEntryObj.Id;
   				invoiceLineItemsObj.Entry_Date__c = timeEntryObj.Date__c;
   				invoiceLineItemsObj.Description__c = timeEntryObj.Description__c;
   				InvoiceLineItemList.Add(invoiceLineItemsObj);
    			
   				timeEntryObj.Invoiced__c = true;
   				TimeEntryListToUpdate.Add(timeEntryObj);
    			}
    		}
    	insert InvoiceLineItemList;
    	//update TimeEntryListToUpdate;
    }   
}