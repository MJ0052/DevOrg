trigger OpportunityTrigger on Opportunity (after insert, after update) {
	if(Trigger.IsBefore){
		
	}
	if(Trigger.IsAfter){
		if(Trigger.IsInsert){
			OpportunityTriggerHandler.NotificationEmailOnAmount(Trigger.New,Trigger.oldMap,Trigger.IsUpdate);	
		}
		if(Trigger.IsUpdate){
			OpportunityTriggerHandler.NotificationEmailOnAmount(Trigger.New,Trigger.oldMap,Trigger.IsUpdate);	
		}	
	}
}