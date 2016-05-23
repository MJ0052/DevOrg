public with sharing class CampaignManagementExtension {
	public ID CampaignId {get; set;}
	public Campaign_Management__c campaignObj;
	//private ApexPages.StandardController standardController; // ASK SOURABH
	
	public CampaignManagementExtension(apexpages.standardController controller) {
		Campaign_Management__c campaignRecord=(Campaign_Management__c)controller.getRecord();
		//this.standardController = controller; // ASK SOURABH
     	campaignObj = [SELECT Campaign_Name__c,Category__c,CreatedById,CreatedDate,Description__c,End_Date__c,Id,LastModifiedDate,Name,Num_Sent__c,OwnerId,Parent_Campaign__c,Start_Date__c,Status__c,Type__c FROM Campaign_Management__c WHERE ID= :campaignRecord.Id];
   	}    
   	
    public void softDeleteRecord(){
    	//ApexPages.StandardController controller
    	CampaignId = campaignObj.id; 
        //CampaignId = controller.getId();
        campaignObj = [Select Campaign_Name__c,Category__c,Soft_Deleted__c,Name FROM Campaign_Management__c WHERE ID= :CampaignId];
        campaignObj.Soft_Deleted__c = true;
        update campaignObj;
   	}
   	public void copyRecord(){
   		Campaign_Management__c copy = campaignObj.clone();
   		insert copy;
   	}
}