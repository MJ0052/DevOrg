public with sharing class BioBriefing{
    //Variable Declaration
    private final contact con;
    public string Conlastname{get;set;}
    public string conphone{get;set;}
    public string conemail{get;set;}
    public string Conmobilephone{get;set;}
    public string Accid='';
    public blob Photo{get;set;}
    public string photoname{get;set;}
    public string photourl{get;set;}
    //Contstructor 
    public BioBriefing(apexpages.standardController controller){
        con=(Contact)controller.getRecord();
    }
    
    //this method updates the Contact with photourl and insert The Attachment Record
    public void UploadPhoto(){
        try{
            con.lastname = conlastname;  
            con.email = conemail;
            con.phone = conphone;
            con.mobilephone = conmobilephone;
            insert con;
           // Accid = ApexPages.currentPage().getParameters().get('id');  
           // inserting attachement with Attached photo      
            Attachment objA=new Attachment();
            objA.body = photo;
            objA.name = 'testname';
            objA.parentid= con.id;
            objA.ContentType = 'application/jpg';
            insert objA;
            string Attid= objA.id;
            string attachmentid=Attid.substring(0,15);
           // con.imageUrl__c = '/servlet/servlet.FileDownload?file='+attachmentid;
            update con;
            //photourl = con.imageurl__c;        
        }catch(Exception e){
            system.debug('Exception message'+e);
        }
     } 
}