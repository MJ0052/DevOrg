public with sharing class BioBriefingExtension {
 public String imageURL{get;set;}
private BioBriefing__c bbObject;

  public BioBriefingExtension(ApexPages.StandardController controller)
  {
  	bbObject = (BioBriefing__c)controller.getRecord();
    imageURL='/servlet/servlet.FileDownload?file=';
    List< Attachment > attachmentList = [select name from Attachment where ParentId=:bbObject.Id];
    if(attachmentList.size()>0)
    {
      imageURL=imageURL+attachmentList[0].id;
      bbObject.ImageURL__c = imageURL;
    }
    else{
    	imageURL = '';
    }
  }
  public PageReference Save()
  {
  	String fileId = '';
    imageURL='/servlet/servlet.FileDownload?file=';
    List<Attachment> attachmentList = [SELECT Id,Name,ContentType FROM Attachment where ParentId =: bbObject.Id Order By LastModifiedDate DESC  LIMIT 1];
       
    if(attachmentList != null && attachmentList.size() > 0)
    {
    	fileId = attachmentList[0].Id;
        imageURL=imageURL+attachmentList[0].id;
    }
    else{
        imageURL = '';
    }
    bbObject.ImageURL__c = imageURL;
    Upsert bbObject;
    return  new ApexPages.StandardController(bbObject).view();
    }
}