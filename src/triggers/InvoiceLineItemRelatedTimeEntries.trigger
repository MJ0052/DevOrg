trigger InvoiceLineItemRelatedTimeEntries on Invoice_Line_Items__c (after delete) {
    System.debug('TRIGGER');
}