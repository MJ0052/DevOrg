trigger InvoiceRelatedTimeEntries on Invoice__c (before delete) {
	TR_InvoiceRelatedTimeEntriesHandler.InitiateProcess(Trigger.Old);
}