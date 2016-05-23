@isTest
public with sharing class TestBioBriefingExtension {
	 public static testMethod void testBioBriefingExtensionByUploadingAttachement() {
	 	//INSERTING SAMPLE DATA
      	BioBriefing__c bObj = new BioBriefing__c();
		bObj.Name__c = 'APEX TEST CLASS';
		insert bObj;
		//INSERTING ATTACHEMENT
		Blob b = Blob.valueOf('Test Class Data');  
		Attachment attachment = new Attachment();  
		attachment.ParentId = bObj.id;  
		attachment.Name = 'Test Class Attachment for Parent';  
		attachment.Body = b;  
		insert(attachment);
		
		//CHECK FOR THE IMAGE URL IN OBJECT
        BioBriefing__c oldbObj = [Select Id,ImageURL__C,Name__c from BioBriefing__c where Id =: bObj.Id];
        System.assertEquals(oldbObj.ImageURL__c, null);
        
		//CALLING CONTROLLER SAVE METHOD
        BioBriefingExtension controller = new BioBriefingExtension(new ApexPages.StandardController(bObj));
        controller.save();
        
        //FETCHING ATTACHEMENT LIST AND CHECK WHETHER UPDATED OR NOT
        List<Attachment> attachmentList = [SELECT Id,Name,ContentType FROM Attachment where ParentId =: bObj.Id Order By LastModifiedDate DESC  LIMIT 1];
        BioBriefing__c newbObj = [Select Id,ImageURL__C,Name__c from BioBriefing__c where Id =: bObj.Id];
        System.assertEquals(newbObj.ImageURL__c, '/servlet/servlet.FileDownload?file='+attachmentList[0].Id);
    }   
    public static testMethod void testBioBriefingExtensionWithoutUploadingAttachement() {
	 	//INSERTING SAMPLE DATA
      	BioBriefing__c bObj = new BioBriefing__c();
		bObj.Name__c = 'APEX TEST CLASS';
		insert bObj;
		
		//CHECK FOR THE IMAGE URL IN OBJECT
        BioBriefing__c oldbObj = [Select Id,ImageURL__C,Name__c from BioBriefing__c where Id =: bObj.Id];
        System.assertEquals(oldbObj.ImageURL__c, null);
        
		//CALLING CONTROLLER SAVE METHOD
        BioBriefingExtension controller = new BioBriefingExtension(new ApexPages.StandardController(bObj));
        controller.save();
        
        //FETCHING ATTACHEMENT LIST AND CHECK WHETHER UPDATED OR NOT
        List<Attachment> attachmentList = [SELECT Id,Name,ContentType FROM Attachment where ParentId =: bObj.Id Order By LastModifiedDate DESC  LIMIT 1];
        BioBriefing__c newbObj = [Select Id,ImageURL__C,Name__c from BioBriefing__c where Id =: bObj.Id];
        System.assertEquals(newbObj.ImageURL__c, null);
    }
}