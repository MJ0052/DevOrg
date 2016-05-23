trigger LeadTrigger on Lead (before insert, before update, after insert, after update) {
	if(Trigger.IsBefore){
		if(Trigger.IsInsert){
			LeadTriggerHandler.timezonendStateInLead(Trigger.New,Trigger.oldMap,Trigger.IsUpdate);
			LeadTriggerHandler.LeadDuplication(Trigger.New,Trigger.oldMap,Trigger.IsUpdate);
		}	
		else if(Trigger.IsUpdate){
			LeadTriggerHandler.timezonendStateInLead(Trigger.New,Trigger.oldMap,Trigger.IsUpdate);
			LeadTriggerHandler.LeadDuplication(Trigger.New,Trigger.oldMap,Trigger.IsUpdate);
			LeadTriggerHandler.CloneLeadDependingOnStatus(Trigger.New,Trigger.oldMap,Trigger.IsUpdate);
		}
	}
	else if(Trigger.IsAfter){
		if(Trigger.IsInsert){
			LeadTriggerHandler.GenerateTaskOnLeadCreation(Trigger.New);
			LeadTriggerHandler.CloneLeadDependingOnStatus(Trigger.New,Trigger.newMap,Trigger.IsUpdate);
		}
		else if(Trigger.IsUpdate){
		}	
	}
}