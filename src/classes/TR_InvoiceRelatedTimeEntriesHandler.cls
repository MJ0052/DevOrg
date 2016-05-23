public with sharing class TR_InvoiceRelatedTimeEntriesHandler {
    public static void InitiateProcess(List<Invoice__c> InvoiceList){
    	System.debug(InvoiceList);
    	List<Time_Entries__c> TimeEntryList = new List<Time_Entries__c>();
    	List<Invoice_Line_Items__c> some = GetInvoiceLineItems(InvoiceList);
    	System.debug('SOME ' + some);
    	TimeEntryList = GetInvoiceTimeEntries(some);
    	update TimeEntryList;
    }
    public static List<Invoice_Line_Items__c> GetInvoiceLineItems(List<Invoice__c> InvoiceList){
    	List<Invoice_Line_Items__c> InvoiceLineItemList;
    	List<Invoice_Line_Items__c> InvoiceLineItemListToRetrive = new List<Invoice_Line_Items__c>();
    	
    	for(Invoice__c invoiceObj : InvoiceList){
    		InvoiceLineItemList = new List<Invoice_Line_Items__c>();
    		InvoiceLineItemList = [SELECT Description__c,Entry_Date__c,Id,Invoice_Amount__c,Invoice_Hrs__c,Invoice__c,Name,Time_Entry__c FROM Invoice_Line_Items__c WHERE Invoice__c =: invoiceObj.Id];
    		InvoiceLineItemListToRetrive.AddAll(InvoiceLineItemList);
    	}
    	return InvoiceLineItemListToRetrive;
    }
    public static List<Time_Entries__c> GetInvoiceTimeEntries(List<Invoice_Line_Items__c> InvoiceLineItemList){
    	Time_Entries__c timeEntryObj;
    	List<Time_Entries__c> TimeEntryList = new List<Time_Entries__c>();
    	for(Invoice_Line_Items__c invoiceLineItmeObj : InvoiceLineItemList){
    		timeEntryObj = new Time_Entries__c();
    		System.debug('Invoice Line items ' + invoiceLineItmeObj);
    		timeEntryObj = [SELECT Billable_Amount__c,Contact__c,Date__c,Description__c,Duration__c,Id,Invoiced__c,Name,Project__c FROM Time_Entries__c WHERE Id=: invoiceLineItmeObj.Time_Entry__c];
    		System.debug('Time entry Obj ' + timeEntryObj);
    		
    		timeEntryObj.Invoiced__c = false;
    		TimeEntryList.Add(timeEntryObj);    		
    	}
    	return TimeEntryList;
    }
}