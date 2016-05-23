public class UserAccountOpportunitiesExtension {
    public final ABC_Inc__c abcObj;
    List<Account> accountList;
    List<Opportunity> opportunityList;
    public String myAccount {get; set;}
    String notification;
    STring username;
    Boolean ShouldIRenderAccount;
    Boolean ShouldIRenderOpportunity;
    public String stage {get; set;}

    public UserAccountOpportunitiesExtension(apexpages.standardController controller){
    	abcObj=(ABC_Inc__c)controller.getRecord();
        myAccount = '';
        accountList = null;
        opportunityList = null;
        notification = '';
        List<User> userList = [Select Name from User Where Id =: Userinfo.getUserId()];
        username = userList.size() > 0 ? 'Welcome - ' + userList[0].Name : 'Logged Out';
    }
    public String getStage(){
        return stage;
    }
    public Boolean getShouldIRenderAccount() { 
        if (accountList != null && accountList.size() > 0) { return true; } 
        else { return false; } 
    }
    public Boolean getShouldIRenderOpportunity() { 
        if (opportunityList != null && opportunityList.size() > 0) { return true; } 
        else { return false; } 
    }
    public void verifyUser(){
        if(abcObj.Validation_Code__c == '' || abcObj.Validation_Code__c == null){
            notification = 'Please enter validation code';
        }
        else{
        	List<ABC_Inc__c> abcList = new List<ABC_Inc__c>([Select ID from ABC_Inc__c Where User__c =: Userinfo.getUserId() AND Validation_Code__c =: abcObj.Validation_Code__c]);
        	if(abcList.size() > 0){
            	accountList = [select Id,Name from Account Where OwnerId =: Userinfo.getUserId()];
                notification = '';
        	}
        	else{
            	accountList = null;
            	notification = 'Invalid validation code';
        	}    
        }
        opportunityList = null;
    }
    public List<Account> getAccountList(){
        return accountList;
    }
    public List<Opportunity> getOpportunityList(){
        return opportunityList;
    }
    public String getNotification(){
        return notification;
    }
    public String getUsername(){
        return username;
    }
    public void getOpportunityByAccount(){
        System.debug('SELECTED ACCOUNT ' + myAccount);
        opportunityList = [select Id,Name,AccountId,StageName from Opportunity Where AccountId =: myAccount];
        notification = opportunityList.size() <= 0 ? 'No opportunities found for the selected account' : '';
        System.debug('OPPPPP' + opportunityList);
    }
    public void updateOpportuntityStage(){
        System.debug('SELECTED STAGE ' + stage);
        for(Opportunity oppObj : opportunityList){
            oppObj.StageName = stage;
        }
        update opportunityList;
        notification = 'Opportunity Stage Updated';
    }
}