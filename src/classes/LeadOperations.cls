public class LeadOperations {
    public static void UpdatingLeadFieldsDependingOnPhone(List<Lead> triggerNew,Boolean IsUpdateFlag,Map<Id,Lead> triggeroldMap){
    	String phoneNumber = '';
    	String areaCode = '';
    
    	Boolean flag = true;
    	Lead oldLead = null;
    
		for (Lead a : triggerNew) {
	        if(IsUpdateFlag){
    	        oldLead = triggeroldMap.get(a.Id);
        	    if(a.Phone == oldLead.Phone){
            	    flag = false;
                	System.debug('new phone is similar to old phone');
            	}
        	}
        	else{
            	flag = true;
        	}	
        	if(flag)
        	{
         		phoneNumber = a.Phone;
         		areaCode =  phoneNumber.substring(0,3);
            
        		List<TimeZoneDetails__c> tzObj = 
    	    	new List<TimeZoneDetails__c>([SELECT ID,State__c,Time_Zone__c,Area_Code__c from TimeZoneDetails__c WHERE Area_Code__c =:areaCode]);
            	if(tzObj.size() > 0){
	        		if(a.State__c == null){
	        			a.State = tzObj[0].State__c;
                    	System.debug('State updated');
                    
                    	a.Time_Zone__c = tzObj[0].Time_Zone__c;
                    	System.debug('Time zone updated');
        		}
        	}
            else{
                System.debug('No related area code found');
            }
        }
        else{
        	System.debug('Phone is no updated so state and time zone is not updated');
        }
    }
    }
}