public class LeadDataManipulation {
    public static Lead ChangeLeadState(Lead leadObj, String State){
        leadObj.State = State;
        return leadObj;
    }
    public static Lead ChangeLeadTimeZone(Lead leadObj, String TimeZone){
        leadObj.Time_Zone__c = TimeZone;
        return leadObj;
    }
    public static Boolean CheckForOldAndNewPhoneChange(Lead oldLeadObj, Lead newLeadObj){
        Boolean flag = true;
        if(oldLeadobj.Phone == newLeadObj.Phone){
            flag = false;
            System.debug('new phone is similar to old phone');
        }
        return flag;
    }
    public static List<Lead> GetAllLeads(){
        return [Select Id,Name,Phone,Email from Lead];
    }
    public static Boolean DuplicateCheckOnEmail(String Email){
        Boolean flag = false;
        
        List<Lead> leadList = GetAllLeads();
        for(Lead sObj: leadList){
            if(sObj.Email != null && sObj.Email == Email){
                flag = true;
                break;
            }
        }
        return flag;
    } 
    public static Boolean DuplicateCheckOnPhone(String Phone){
        Boolean flag = false;
        
        List<Lead> leadList = GetAllLeads();
        for(Lead sObj: leadList){
            if(sObj.Phone != null && sObj.Phone == Phone){
                System.debug(sObj.Phone + ' ' + Phone);
                flag = true;
                break;
            }
        }
        return flag;
    }
}