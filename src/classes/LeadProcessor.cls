global class LeadProcessor implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT ID from Lead');
    }

    global void execute(Database.BatchableContext bc, List<Lead> records){
        List<Lead> leadListToUpdate = new List<Lead>();
        for(Lead leadObj : records){
        	leadObj.LeadSource = 'Dreamforce';
            leadListToUpdate.add(leadObj);
        }
        update leadListToUpdate;
    }    

    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }    

}