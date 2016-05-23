public with sharing class LeadTriggerHandler {
	private static boolean run = true;
    public static void timezonendStateInLead(List<Lead> newList,Map<ID,Lead> leadOldMap, Boolean UpdateFlag){
    	String areaCode = '',temp='';
    	Boolean flag = true;
    	Map<String, TimeZoneDetails__c> tzMap = Query.getTimeZoneDetailsWithKeyAreaCodeInMap();
		for (Lead leadObj : newList) {
        	if(UpdateFlag){
        		if(leadOldMap.get(leadObj.Id).Phone == leadObj.Phone){
            		flag = false;
        		}
        	}
        	else{
            	flag = true;
        	}
        	if(flag)
        	{
            	temp = leadObj.Phone;
            	if(temp != null && temp.length() > 3){
                	areaCode =  leadObj.Phone.substring(0,3);
            	}
            	if(tzMap.size() > 0 && tzMap.get(areaCode) != null){
	        		if(leadObj.State__c == null)
	        		{
	        			leadObj.State = tzMap.get(areaCode).State__c;
                    	leadObj.Time_Zone__c = tzMap.get(areaCode).Time_Zone__c;
        			}
        		}
        	}
    	}
    }
    
    public static void LeadDuplication(List<Lead> newLeadList,Map<ID,Lead> leadOldMap, Boolean UpdateFlag){
    Map<String,Lead> leadMapForEmail = new Map<String,Lead>();
    List<Lead> leadListFromDb = [Select Id,Name,Phone,Email from Lead];
    List<Lead> actualLeadList = new List<Lead>();
    //actualLeadList.addAll(newLeadList);
    actualLeadList.addAll(leadListFromDb);
    for(Lead leadObj : actualLeadList){
    	leadMapForEmail.put(leadObj.Email,leadObj);
    }
    Map<String,Lead> leadMapForPhone = new Map<String,Lead>();
    for(Lead leadObj : actualLeadList){
    	leadMapForPhone.put(leadObj.Phone,leadObj);
    }
    Boolean emailCheckFlag = true, phoneCheckFlag = true;
	for(Lead leadObj:newLeadList){
		if(UpdateFlag){
			if(leadObj.Email == leadOldMap.get(leadObj.Id).Email){
				emailCheckFlag = false;
			}
			if(leadObj.Phone == leadOldMap.get(leadObj.Id).Phone){
				phoneCheckFlag = false;
			}
			if(!emailCheckFlag && !phoneCheckFlag){
				continue;
			}
		}
    	if(emailCheckFlag  && leadObj.Email != null &&  leadMapForEmail.get(leadObj.Email) != null){
    		System.debug('emailCheckFlag' + emailCheckFlag);
    		System.debug('leadObj.Email' + leadObj.Email);
    		System.debug('leadMapForEmail.get(leadObj.Email) ' + leadMapForEmail.get(leadObj.Email));
    		System.debug('IN EMAIL');
        	leadObj.AddError('Email is duplicate');
            break;
		}
		if(phoneCheckFlag && leadObj.Phone != null &&  leadMapForPhone.get(leadObj.Phone) != null){
			System.debug('IN PHONE');
        	leadObj.AddError('Phone is duplicate');
            break;
		}
		if(leadObj.Email != null){
			leadMapForEmail.put(leadObj.Email,leadObj);
		}
		if(leadObj.Phone != null){
			leadMapForPhone.put(leadObj.Phone,leadObj);
		}
    }
   }
   public static void GenerateTaskOnLeadCreation(List<Lead> newLeadList){
   	List<Task> taskList = new List<Task>(); 
	for (Lead leadObj : newLeadList) { 
		Task taskObj = new Task(WhoId = LeadObj.Id,Ownerid = leadObj.OwnerId, Subject=leadObj.FirstName, Status='Not Started',Priority='Normal'); 
		taskList.add(taskObj);  
	}
	insert taskList; 
   }
   public static void CloneLeadDependingOnStatus(List<Lead> newLeadList,Map<ID,Lead> leadOldMap, Boolean UpdateFlag) {
   	if(runOnce()){
    	List<Lead> leadListToClone = new List<Lead>();
    	Boolean ToClone = true;
    	for (Lead leadObj : newLeadList) {
    		ToClone = true; 
    		if(UpdateFlag){
    			if(leadObj.Status == leadOldMap.get(leadObj.Id).Status){
    				ToClone = false;
    			}
    		}
        	if(ToClone && leadObj.Status == 'Open - Not Contacted'){
        	    Lead duplicateLead = leadObj.clone();
        	    //CHECK FOR RECURSIVE CALL
        	    //duplicateLead.Status = 'Working - Contacted';
        	    duplicateLead.Phone = '';
        	    duplicateLead.Email = '';
    	        leadListToClone.add(duplicateLead);
	        }
		}
    	if(newLeadList.size() > 0){
    		insert leadListToClone;
    	}
   		}
	}
    public static boolean runOnce(){
    if(run){
    	run=false;
    	return true;
    }else{
       	return run;
    }
    }
}