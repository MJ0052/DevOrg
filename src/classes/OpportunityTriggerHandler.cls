public with sharing class OpportunityTriggerHandler {
    public static void NotificationEmailOnAmount(List<Opportunity> newOpportunityList,Map<Id,Opportunity> oldOpportunityMap,Boolean IsUpdate) {
    Map<Id,User> mapObj = new Map<Id,User>([Select Id,Name,ManagerID,Email from User]);
    Map<String,String> emailMap = new Map<String,String>();
	User obj = new User();
    User managerObj = new User();
    Boolean IsAmountChanged = false;
    for(Opportunity oppObj:newOpportunityList){
    	IsAmountChanged = false;
    	if(IsUpdate){
    		if(oppObj.Amount == oldOpportunityMap.get(oppObj.Id).Amount){
    			IsAmountChanged = true;
    		}
    	}
        if(!IsAmountChanged && oppObj.Amount > 25000){
    		obj = mapObj.get(oppObj.OwnerId);
            managerObj = mapObj.get(obj.ManagerId);
            emailMap.put(managerObj.Email,oppObj.Name);
        }
    }
    Email.SendEMail(emailMap);
}
}