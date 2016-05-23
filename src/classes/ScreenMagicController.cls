public with sharing class ScreenMagicController {

    @AuraEnabled
    public static String serverEcho(Boolean AppointmentConfirmation) {
        System.debug('AppointmentConfirmation' + AppointmentConfirmation);
        ScreenMagic__c  smCustomSetting = [SELECT id,Name,Confimration__c FROM ScreenMagic__c where Name = 'Appointment Confirmation'];  
		smCustomSetting.Confimration__c = AppointmentConfirmation;  
		//update smCustomSetting;  
        return ('Custom setting updated successfully with value - ' + AppointmentConfirmation);
    }
    @AuraEnabled
    public static List<Contact> getContacts() {
        List<Contact> contacts = [SELECT Id, Name FROM Contact];
        //Add isAccessible() check
        return contacts;
    }
}