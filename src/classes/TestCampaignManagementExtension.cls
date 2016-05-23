@isTest
public with sharing class TestCampaignManagementExtension {
	 public static testMethod void testCampaignManagementExtensionForCopy() {
	 	//INSERTING SAMPLE DATA
      	Campaign_Management__c campaignObj = new Campaign_Management__c();
		campaignObj.Campaign_Name__c = 'APEX TEST CLASS';
		insert campaignObj;
		
		List<Campaign_Management__c> listBeforeCopy = new List<Campaign_Management__c >([Select Id from Campaign_Management__c]);

		//CALLING CONTROLLER SAVE METHOD
        CampaignManagementExtension controller = new CampaignManagementExtension(new ApexPages.StandardController(campaignObj));
        controller.copyRecord();

   		List<Campaign_Management__c> listAfterCopy = new List<Campaign_Management__c >([Select Id from Campaign_Management__c]);

        //CHECK FOR WHETHER COPY IS DONE OR NOT
        System.assertEquals(listBeforeCopy.size() + 1,listAfterCopy.size());
    }   
    public static testMethod void testCampaignManagementExtensionForSoftDelete() {
	 	//INSERTING SAMPLE DATA
      	Campaign_Management__c campaignObj = new Campaign_Management__c();
		campaignObj.Campaign_Name__c = 'APEX TEST CLASS';
		insert campaignObj;
		
		List<Campaign_Management__c> listBeforeSoftDelete = new List<Campaign_Management__c >([Select Id,Soft_Deleted__c from Campaign_Management__c where Soft_Deleted__c = false]);

		//CALLING CONTROLLER SAVE METHOD
        CampaignManagementExtension controller = new CampaignManagementExtension(new ApexPages.StandardController(campaignObj));
        controller.softDeleteRecord();

   		List<Campaign_Management__c> listAfterSoftDelete = new List<Campaign_Management__c >([Select Id,Soft_Deleted__c from Campaign_Management__c where Soft_Deleted__c = false]);

        //CHECK FOR WHETHER COPY IS DONE OR NOT
        System.assertEquals(listBeforeSoftDelete.size() - 1,listAfterSoftDelete.size());
    }  
}