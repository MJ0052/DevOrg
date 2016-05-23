public with sharing class InvoiceExtension {
    
    private final Invoice__c InvoiceObj;
	List<Project__c> projects;
	List<Project__c> selectedProjects = new List<Project__c>();
	
	public InvoiceExtension(apexpages.standardController controller){
		InvoiceObj=(Invoice__c)controller.getRecord();
		Date startDate = System.Date.today().toStartOfMonth(); 
		Date endDate = startDate.addMonths(1).addDays(-1);
        InvoiceObj.Invoice_Start_Date__c = startDate;
        InvoiceObj.Invoice_End_Date__c = endDate;
    }
    public List<Project__c> getProjects() {
      //  if(projects == null) projects = [SELECT Account__c,End_Date__c,Id,Name,Start_Date__c,Total_Invoiced_Hrs__c,Selected__c,Total_Project_Hrs__c FROM Project__c LIMIT 10];
        return projects;
    }
    // public PageReference getSelected()
    //{
       // selectedAccounts.clear();
        //for(accountwrapper accwrapper : accountList)
        //if(accwrapper.selected == true)
       // selectedAccounts.add(accwrapper.acc);
      //  return null;
    //}
    public PageReference searchClientProjects(){
    	//Invoice__c currentInvoice =(Invoice__c)controller.getRecord();
    	projects = [SELECT Account__c,End_Date__c,Id,Name,Start_Date__c,Total_Invoiced_Hrs__c,Selected__c,Total_Project_Hrs__c FROM Project__c  WHERE Account__c =: InvoiceObj.Account__c  LIMIT 10];
    	//projects = [SELECT Account__c,End_Date__c,Id,Name,Start_Date__c,Total_Invoiced_Hrs__c,Selected__c,Total_Project_Hrs__c FROM Project__c WHERE Account__c =: InvoiceObj.Account__c AND Start_Date__c >=: InvoiceObj.Invoice_Start_Date__c AND End_Date__c <=: InvoiceObj.Invoice_End_Date__c];
    	return null;
    }
    public PageReference generateInvoice(){
    	List<Invoice__c> InvoiceList = new List<Invoice__c>();
        
                
    	Invoice__c newInvoiceObj;
    	for(Project__c projectObj: projects)
    	{
    		newInvoiceObj  = new Invoice__c();
    		newInvoiceObj = InvoiceObj.clone();
    		newInvoiceObj.Name = 'Invoice for Project - ' + projectObj.Name;
    		newInvoiceObj.Project__c = projectObj.Id;
    		InvoiceList.Add(newInvoiceObj);
    	}
    	insert InvoiceList;
        
        List<Invoice_Line_Items__c> InvoiceLineItemList = new List<Invoice_Line_Items__c>();
    	List<Time_Entries__c> TimeEntryList = new List<Time_Entries__c>();
    	List<Time_Entries__c> TimeEntryListToUpdate = new List<Time_Entries__c>();
    
        for(Invoice__c invoiceObj : InvoiceList){
        	TimeEntryList = [SELECT Billable_Amount__c,Contact__c,Date__c,Description__c,Duration__c,Id,Invoiced__c,Name,Project__c FROM Time_Entries__c WHERE Project__C =: invoiceObj.Project__c];
    		for(Time_Entries__c timeEntryObj:TimeEntryList)
    		{
    			Invoice_Line_Items__c invoiceLineItemsObj = new Invoice_Line_Items__c();
    			invoiceLineItemsObj.Name = invoiceObj.Name + ' - Line Item';
	    		invoiceLineItemsObj.Invoice__c = invoiceObj.Id;
    			invoiceLineItemsObj.Invoice_Amount__c = timeEntryObj.Billable_Amount__c;
    			invoiceLineItemsObj.Invoice_Hrs__c = timeEntryObj.Duration__c;
    			invoiceLineItemsObj.Time_Entry__c = timeEntryObj.Id;
    			invoiceLineItemsObj.Entry_Date__c = timeEntryObj.Date__c;
    			invoiceLineItemsObj.Description__c = timeEntryObj.Description__c;
    			InvoiceLineItemList.Add(invoiceLineItemsObj);
    			
    			timeEntryObj.Invoiced__c = true;
    			TimeEntryListToUpdate.Add(timeEntryObj);
    		}
    	}
    	System.debug(InvoiceLineItemList);
    	insert InvoiceLineItemList;
    	update TimeEntryListToUpdate;
    	
		return null;
    }
}