global class BatchJobProcessor implements Database.Batchable<sObject>, Database.Stateful {

    private Datetime StartDatetime,EndDatetime;
    private Integer NumberOfOpportunity = 0,OpportunityAmount = 0;
    private Decimal TotalDuration;
    global Database.QueryLocator start(Database.BatchableContext bc) {
        StartDatetime = Datetime.now();
        return Database.getQueryLocator('Select Amount,StageName,IsAggregated__c from Opportunity Where StageName=\'Closed Won\'');
    }

    global void execute(Database.BatchableContext bc, List<Opportunity> records){
    	for(Opportunity oppObj : records){
    		oppObj.put('IsAggregated__c',true);
     		OpportunityAmount = OpportunityAmount + ((oppObj.get('Amount') == null || oppObj.get('Amount') == '') ? 0 : integer.valueOf(oppObj.get('Amount')));
    	}
    	NumberOfOpportunity = NumberOfOpportunity + records.size();
    	update records;
    }    

    global void finish(Database.BatchableContext bc){
    	EndDatetime = Datetime.now();
   		TotalDuration = (EndDatetime.hour() - StartDatetime.hour());
   		String subject = 'Daily Opportunity Amount Aggregator Job Complete';
   		String emailBody = 'The batch job for Daily Opportunity Amount Aggregation has completed successfully. The details associated with the job are as follows:\n\n Start DateTime : '+ startDatetime +' \nEnd DateTime : '+ endDatetime +' \n Total Duration (in Hours) : '+TotalDuration+' \nNumber of Opportunities Closed Won Today : '+NumberOfOpportunity+' \n Total Opportunity Amount for today : '+OpportunityAmount+'';
   		Email.sendSingleEMail('mustafa.jhabuawala@extrapreneursindia.com',subject,emailBody);
    }    

}