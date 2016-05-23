global class BJ_DailyOpportunityAmountAggregator implements Database.Batchable<sObject>, Database.Stateful{
   global final String Query;
   global final String Entity;
   global final String Field;
   global final Boolean Value;
   global final String OtherField;
   global final String StageName;
   
   //EMAIL VARIABLES
   global Datetime StartDatetime;
   global Datetime EndDatetime;
   global Double TotalDuration;
   global Integer NumberOfOpportunity;
   global Integer OpportunityAmount;

   global BJ_DailyOpportunityAmountAggregator(String q, String e, String f, Boolean v, String a,String s){
   	StartDatetime = Datetime.now();
	System.debug('BJ_DailyOpportunityAmountAggregator');
      Query=q; Entity=e; Field=f;Value=v; OtherField=a; StageName=s;
   }

   global Database.QueryLocator start(Database.BatchableContext BC){
   	System.debug('Database.QueryLocator start');
   	System.debug('QUERY - ' + query + 'where StageName=\''+ StageName +'\'');
    return Database.getQueryLocator(query);
   }

   global void execute(Database.BatchableContext BC, List<sObject> scope){
   	System.debug('execute');
   	Integer Amount = 0;
    for(sobject s : scope){
    	s.put(Field,Value);
     	Amount = Amount + ((s.get(OtherField) == null || s.get(OtherField) == '') ? 0 : integer.valueOf(s.get(OtherField)));
    }
    System.debug('AMOUNT' + Amount);
    System.debug('SCOPE' + scope);
    NumberOfOpportunity = 3;
    OpportunityAmount = Amount;
    update scope;
    }

   global void finish(Database.BatchableContext BC){
   	//NumberOfOpportunity = 3;
    //OpportunityAmount = 1;
   	EndDatetime = Datetime.now();
   	TotalDuration = (EndDatetime.hour() - StartDatetime.hour());
   	System.debug('Start'+StartDatetime);
   	System.debug('End'+EndDatetime);
   	System.debug('TotalDuration'+TotalDuration);
   	System.debug('NumberOfOpportunity'+NumberOfOpportunity);
   	System.debug('OpportunityAmount'+OpportunityAmount);
   	String subject = 'Daily Opportunity Amount Aggregator Job Complete';
   	
   	String emailBody = 'The batch job for Daily Opportunity Amount Aggregation has completed successfully. The details associated with the job are as follows:\n\n Start DateTime : '+ startDatetime +' \nEnd DateTime : '+ endDatetime +' \n Total Duration (in Hours) : '+TotalDuration+' \nNumber of Opportunities Closed Won Today : '+NumberOfOpportunity+' \n Total Opportunity Amount for today : '+OpportunityAmount+'';
   	Email.sendSingleEMail('mustafa.jhabuawala@extrapreneursindia.com',subject,emailBody);
   }
}