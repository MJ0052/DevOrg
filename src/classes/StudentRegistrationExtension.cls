public with sharing class StudentRegistrationExtension {
    private final Student__c studentObj;
    public string SelectedLanguage {get; set;}

    
    public StudentRegistrationExtension(apexpages.standardController controller){
    	ApexPages.Message notification;
    	try{
    		studentObj=(Student__c)controller.getRecord();
    		studentObj.Student_Name__c = 'SAMPLE';
    		studentObj.H_S_C__c = 100;
    		studentObj.S_S_C__c = 100;
    		studentObj.Roll_Number__c = 123;
    	}
        catch(Exception e){
        	notification = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while storing student details - '+e.getMessage());
            ApexPages.addMessage(notification);
        } 
    }
    /*public void RetriveHeader(){
    	ApexPages.Message notification;
    	try{
			Map<String, Student_Header__c> header = Student_Header__c.getAll();
			Map<String, String> allheader = new Map<String,String>();
			for(Student_Header__c headerValue : header.values()){
				allheader.put(headerValue.Language__c,headerValue.Name);
			}
			if(SelectedLanguage != null && SelectedLanguage != ''){
				allheader.get(SelectedLanguage).Name;
			}
			else{
				StudentHeader = allheader.get('en_US').Name;
			}
    	}
        catch(Exception e){
        	notification = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while retriving student header - '+e.getMessage());
            ApexPages.addMessage(notification);
        } 
    }*/
    public void submitStudentDetails(){
    	ApexPages.Message notification;
    	try{
    		if(studentObj != null){
    			insert studentObj;
    			if(studentObj.Id != null){
    				notification = new ApexPages.Message(ApexPages.severity.CONFIRM,'Your admission application has been submitted successfully. Reference Id is - ' + studentObj.Id);
            		ApexPages.addMessage(notification);
    			}
    		}
    	}
        catch(Exception e){
        	notification = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while storing student details - '+e.getMessage());
            ApexPages.addMessage(notification);
        } 
    }
     public List<SelectOption> getLanguageList() {
    	List<SelectOption> options = new List<SelectOption>();
    	try{
        //options.add(new SelectOption('', 'Select'));        
        Map<String, Languages__c> languages = Languages__c.getAll();
        
        //SORTING BY NAME - NOT NEEDED - EXTRA FUNCTIONALITY
        List<String> sortinglanguages = new List<String>();
        sortinglanguages.addAll(languages.keySet());
        sortinglanguages.sort();
        
        for (String languageName : sortinglanguages) {
            Languages__c lang = languages.get(languageName);
            options.add(new SelectOption(lang.Language_Code__c, lang.Name));
        }
        }
        catch(Exception e){
        	ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while getting languages list '+e.getMessage());
            ApexPages.addMessage(errormsg);
        }  
        return options;
    }
    public void languageCheckAction() {
    	System.debug('Selected Language'+SelectedLanguage);
    }
}