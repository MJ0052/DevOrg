public with sharing class TriggerSettingsController {
    public void Process(){
    	TriggerSetting__c triggerSetting = TriggerSetting__c.getInstance(UserInfo.getUserId());
    	if(triggerSetting != null)
    	{
    		List<ApexTrigger> apexTriggerObj = new List<ApexTrigger>([SELECT Id, Name, Status FROM ApexTrigger]);
    		List<ApexTrigger> apexTriggerToUpdate = new List<ApexTrigger>();
    		if(triggerSetting.DisableTrigger__c){
    			//DISABLE ALL TRIGGERS
    			for(ApexTrigger obj : apexTriggerObj){
    				obj.Status = 'In Active';
    				apexTriggerToUpdate.add(obj);
    			}
    		}
    		else{
    			//ENABLE ALL TRIGGERS
    			for(ApexTrigger obj : apexTriggerObj){
    				obj.Status = 'Active';
    				apexTriggerToUpdate.add(obj);
    			}
    		}
    		if(apexTriggerToUpdate.size() > 0){
    			//update apexTriggerToUpdate;
    		}
    	}
    }
}