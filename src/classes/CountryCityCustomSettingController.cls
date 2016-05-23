public with sharing class CountryCityCustomSettingController {

    public String city { get; set; }
    public String country {get; set;}   

    public List<SelectOption> getCountriesSelectList() {
    	List<SelectOption> options = new List<SelectOption>();
    	try{
        options.add(new SelectOption('', 'Select'));        
        Map<String, Country__c> countries = Country__c.getAll();
        //SORTING BY NAME - NOT NEEDED - EXTRA FUNCTIONALITY
        List<String> countryNames = new List<String>();
        countryNames.addAll(countries.keySet());
        countryNames.sort();
        
        for (String countryName : countryNames) {
            Country__c country = countries.get(countryName);
            options.add(new SelectOption(country.Name, country.Name));
        }
        }
         catch(Exception e){
                 ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while getting country list '+e.getMessage());
                ApexPages.addMessage(errormsg);
         }  
        return options;
    }
    public List<SelectOption> getCitiesSelectList() {
    	List<SelectOption> options = new List<SelectOption>();
    	try{
    	
        Map<String, City__c> allCities = City__c.getAll();

        Map<String, City__c> cities = new Map<String, City__c>();
        for(City__c city : allCities.values()) {
            if (city.Country__c == this.country) {
                cities.put(city.name, city);
            }
        }
        
        List<String> cityNames = new List<String>();
        cityNames.addAll(cities.keySet());
        cityNames.sort();
        
        for (String cityName : cityNames) {
            City__c city = cities.get(cityName);
            options.add(new SelectOption(city.Name, city.Name));
        }
        if (options.size() > 0) {
            options.add(0, new SelectOption('', 'Select'));
        } else {
            options.add(new SelectOption('', 'NA'));
        }
        
    	}
         catch(Exception e){
                 ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while getting country list '+e.getMessage());
                ApexPages.addMessage(errormsg);
         }  
        return options;
    }
}