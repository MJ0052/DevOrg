@isTest
public with sharing class StudentRegistrationExtensionTest {
	@testSetup 
    static void setup() {
        List<Languages__c> languageList = new List<Languages__c>();
    	Languages__c langObj;
    	for(Integer i = 0; i< 10;i++){
    		langObj = new Languages__c();
    		langObj.Name = String.valueOf(i);
    		langObj.Language_Code__c = String.valueOf(i) + '_LC';
    		languageList.Add(langObj);
    	}
    	insert languageList;
    }
    public static testMethod void testInitialLoad() {
     	Student__c studentObj = new Student__c();
    	StudentRegistrationExtension controller = new StudentRegistrationExtension(new ApexPages.StandardController(studentObj));
    	List<SelectOption> option = controller.getLanguageList();
    	controller.languageCheckAction();
    	System.assertEquals(option.size() > 0,true);
    }
    public static testMethod void testSubmitDetails() {
     	Student__c studentObj = new Student__c();
     	studentObj.Student_Name__c = 'Sample';
    	studentObj.H_S_C__c = 100;
    	studentObj.S_S_C__c = 100;
    	studentObj.Roll_Number__c = 123;
    	StudentRegistrationExtension controller = new StudentRegistrationExtension(new ApexPages.StandardController(studentObj));
    	controller.submitStudentDetails();
    	System.assertEquals([Select count() from Student__c],1);
    }
}