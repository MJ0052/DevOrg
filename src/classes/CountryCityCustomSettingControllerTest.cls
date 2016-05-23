@isTest
public with sharing class CountryCityCustomSettingControllerTest {
	@testSetup 
    static void setup() {
    	List<Country__c> countryList = new List<Country__c>();
    	Country__c countryObj;
    	for(Integer i = 0; i< 10;i++){
    		countryObj = new Country__c();
    		countryObj.Name = String.valueOf(i);
    		countryList.Add(countryObj);
    	}
    	insert countryList;
    	
    	List<City__c> cityList = new List<City__c>();
    	City__c cityObj;
    	for(Integer i = 0; i< 10;i++){
    		cityObj = new city__c();
    		cityObj.Name = String.valueOf(i) + '.1';
    		cityObj.Country__c = String.valueOf(i);
    		cityList.Add(cityObj);
    	}
    	insert cityList;
    	
    }
    
    static testmethod void testFirstLoad(){
    	CountryCityCustomSettingController controller = new CountryCityCustomSettingController();
    	List<SelectOption> soption = new List<SelectOption>();
    	soption = controller.getCountriesSelectList();
    	System.assertEquals(soption.size(),11);
    	soption = controller.getCitiesSelectList();
    	System.assertEquals(soption.size(),1);
    }
    static testmethod void testSelectCountry(){
    	CountryCityCustomSettingController controller = new CountryCityCustomSettingController();
    	List<SelectOption> soption = new List<SelectOption>();
    	soption = controller.getCountriesSelectList();
    	controller.country = '1';
    	System.assertEquals(soption.size(),11);
    	soption = controller.getCitiesSelectList();
    	System.assertEquals(soption.size(),2);
    	//System.assertEquals(soption[1].Name,'1.1');
    }
}