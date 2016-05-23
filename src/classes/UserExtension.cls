public with sharing class UserExtension {
	
	private final User myUser;
	private final HR__c myHRUser;
	
	public UserExtension(apexpages.standardController controller){
        myUser=(User)controller.getRecord();
        String val = ApexPages.CurrentPage().getParameters().get('RecordID');
        myHRUser = [SELECT Active_Employee__c,Assignment_Status__c,Company_Function_SBU__c,Email__c,Employee_Source__c,First_Name__c,HR_Name__c,Id,Job_Code__c,Job_Family__c,Job_Title__c,Last_Name__c,Legacy_ID__c,LMG_Office_Code__c,LMG_Office_Name__c,Management_Group__c,Middle_Name__c,Name,New_Org_Code__c,N__c,Office_City__c,Office_State__c,OwnerId,Telecommuter_Indicator__c,User__c,Work_Phone__c FROM HR__c WHERE Id = :val ];
        System.debug(myHRUser);
        System.debug(val);
    }
    //public UserExtension(String RecordID){
    	//string val = ApexPages.CurrentPage().getParameters().get('RecordID');
    	//System.debug(val); 
    	//System.debug(RecordID);
    //}
}