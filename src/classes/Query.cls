public with sharing class Query {
    public static Map<String, TimeZoneDetails__c> getTimeZoneDetailsWithKeyAreaCodeInMap(){
        List<TimeZoneDetails__c> tzList = new List<TimeZoneDetails__c>([SELECT ID,State__c,Time_Zone__c,Area_Code__c from TimeZoneDetails__c]);
		Map<String, TimeZoneDetails__c> tzMap=new Map<String, TimeZoneDetails__c>();
		for (TimeZoneDetails__c tzObj : tzList)
		{
        	tzMap.put(tzObj.Area_Code__c, tzObj); 
		}
        return tzMap;
    }
}