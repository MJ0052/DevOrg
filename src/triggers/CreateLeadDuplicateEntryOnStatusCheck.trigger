trigger CreateLeadDuplicateEntryOnStatusCheck on Lead (after insert) {
    List<Lead> leadList = Trigger.new; 
    List<Lead> newLeadList = new List<Lead>();
    for (Lead leadObj : leadList) { 
        if(leadObj.Status == 'Open - Not Contacted'){
            Lead duplicateLead = new Lead(FirstName = leadObj.FirstName ,LastName = leadObj.LastName,Status='Working - Contacted',Company = leadObj.Company);
            newLeadList.add(duplicateLead);
        }
    }
    if(newLeadList.size() > 0){
        System.debug('New lead list  ' + newLeadList);
        insert newLeadList;
    }
}