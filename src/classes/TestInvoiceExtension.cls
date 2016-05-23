@isTest
public with sharing class TestInvoiceExtension {
    public static testMethod void testInvoiceExtensionSearchClientProjects() {
    	TestData.insertAccount();
    	TestData.insertProjectForAccount();
    	Invoice__c invoiceObj = new Invoice__c();
    	
    	List<Account> accountList = new List<Account>([Select ID from Account]);
    	invoiceObj.Account__c = accountList.size() > 0 ? accountList[0].Id : null;
	 	
		//CALLING CONTROLLER SEARCH METHOD
        InvoiceExtension controller = new InvoiceExtension(new ApexPages.StandardController(invoiceObj));
        controller.searchClientProjects();

        //System.assertEquals(listBeforeCopy.size() + 1,listAfterCopy.size());
    }
    public static testMethod void testInvoiceExtensionGenerateInvoice() {
    	//CREATING TEST DATA
    	TestData.insertAccount();
    	TestData.insertProjectForAccount();
		TestData.insertContactDependingOnAccounts(1);
    	TestData.insertTimeEntries();
    	
    	Invoice__c invoiceObj = new Invoice__c();
    	
    	List<Account> accountList = new List<Account>([Select ID from Account]);
    	invoiceObj.Account__c = accountList.size() > 0 ? accountList[0].Id : null;
	 	
		//CALLING CONTROLLER SEARCH METHOD
        InvoiceExtension controller = new InvoiceExtension(new ApexPages.StandardController(invoiceObj));
        controller.searchClientProjects();       
        List<Project__c> projectList = controller.getProjects();
        controller.generateInvoice();
        List<Time_Entries__c> timeEntryList = new List<Time_Entries__c>([Select Id,Invoiced__c from Time_Entries__c where Project__C IN :projectList AND Invoiced__c = false]);
        List<Invoice__c> invoiceNewList = new List<Invoice__c>([Select Id from Invoice__c where Account__c =: invoiceObj.Account__c]);        
		for(Time_Entries__c timeEntryObj :timeEntryList){
			List<Invoice_Line_Items__c> invoiceLineItemList = new List<Invoice_Line_Items__c>([Select Id, Time_Entry__c from Invoice_Line_Items__c where Time_Entry__c =: timeEntryObj.Id]);
			System.assertEquals(timeEntryObj.Invoiced__c,true);
			System.assertEquals(invoiceLineItemList.size(),1);
		}        
    }      
}