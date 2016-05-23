public with sharing class DataTransferController {

    @AuraEnabled
    public static void serverEcho(Boolean checkboxValue,string textboxValue) {
     System.debug('checkboxValue - ' + checkboxValue);
      System.debug('textboxValue - ' + textboxValue);
    }
}