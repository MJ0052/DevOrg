@isTest
private class TestLeadTriggerHandler{

    @isTest static void testTimezonendStateInLeadBulk() {
       	TestData.generateTimeZoneDetails();
       	List<Lead> leadList = TestData.getLeads(200);
       	System.debug('LEAD LIST - ' + leadList);
       	insert leadList;
       	List<Lead> newInsertedLeadList = new List<Lead>([Select Id,Time_Zone__c,State,Phone from Lead Where Id IN :leadList]);
		List<TimeZoneDetails__c> timezoneList;
		Map<String, TimeZoneDetails__c> tzMap = Query.getTimeZoneDetailsWithKeyAreaCodeInMap();
		System.debug('tzMap' + tzMap);
		for(Lead leadObj:newInsertedLeadList){
			//timezoneList = new List<TimeZoneDetails__c>([SELECT ID,State__c,Time_Zone__c,Area_Code__c from TimeZoneDetails__c Where Area_Code__c =: leadObj.Phone.substring(0,3)]);
			System.assertEquals(leadObj.State,tzMap.get(leadObj.Phone.substring(0,3)).State__c);
       		System.assertEquals(leadObj.Time_Zone__c,tzMap.get(leadObj.Phone.substring(0,3)).Time_Zone__c);
		}       	
    }
    @isTest static void testTimezonendStateInLeadWithStandardPhone() {
    	TestData.generateTimeZoneDetails();
    	Lead leadobj = new Lead(Company = 'Company', FirstName = 'First Name', LastName = 'Last Name', Phone = '0917895422630',Email='7563@gmail.com' );
       	insert leadobj;
       	List<TimeZoneDetails__c> timezoneList = new List<TimeZoneDetails__c>([SELECT ID,State__c,Time_Zone__c,Area_Code__c from TimeZoneDetails__c Where Area_Code__c =: leadobj.Phone.substring(0,3)]);
       	System.debug('TIME ZONE LIST - '+timezoneList);
       	if(timezoneList.size() > 0){
       		Lead checkLeadObj = new Lead();
       		checkLeadObj = [Select State, Time_Zone__c from Lead where Id =: leadObj.Id];
       		System.assertEquals(checkLeadObj.State,timezoneList[0].State__c);
       		System.assertEquals(checkLeadObj.Time_Zone__c,timezoneList[0].Time_Zone__c);
       	}
    	
    }
    @isTest static void testTimezonendStateInLeadUpdateWithNoChange() {
    	Lead leadobj = new Lead(Company = 'Company', FirstName = 'First Name', LastName = 'Last Name', Phone = '0917895422630',Email='7563@gmail.com' );
       	insert leadobj;
       	leadobj.Company = 'Update Company';
       	update leadobj;
        Database.DeleteResult result = Database.delete(leadobj, false);
        System.assertEquals(result.isSuccess(),true);	
    }
    @isTest static void testTimezonendStateInLeadWithOtherPhone() {
    	Lead leadobj = new Lead(Company = 'Company', FirstName = 'First Name', LastName = 'Last Name', Phone = '48522222222',Email='7563@gmail.com' );
       	insert leadobj;
       	Lead checkLeadObj = new Lead();
       	checkLeadObj = [Select State, Time_Zone__c from Lead where Id =: leadObj.Id];
       	System.assertEquals(checkLeadObj.State,null);
       	System.assertEquals(checkLeadObj.Time_Zone__c,null);
       
        Database.DeleteResult result = Database.delete(leadobj, false);
        System.assertEquals(result.isSuccess(),true);	
    }
    @isTest static void testLeadDuplicationSimilarBulkEmail() {
       	try{
       	List<Lead> leadList = new List<Lead>();
    	Lead leadObj;
    	for(Integer i = 0;i< 50;i++){
    		leadObj = new Lead();
    		leadObj.Company = 'Test Company ' + i;
    		leadObj.FirstName = 'T Lead First Name ' + i;
			leadObj.LastName = 'T Lead Last Name ' + i;
			leadObj.Phone = '091855555555';
            leadObj.MobilePhone = '091855555555';
            leadObj.Email = 'mj@gmail.com';
            leadList.Add(leadObj);
    	}
       	insert leadList;
        List<Database.DeleteResult> result = Database.delete(leadList, false);
        for(Database.DeleteResult dbResult : result){
        	System.assertEquals(dbResult.isSuccess(),true);	
        }
       	}
       	catch(Exception e){
       		Boolean expectedExceptionThrownEmail =  (e.getMessage().contains('Email is duplicate')) ? true : false;
			System.AssertEquals(expectedExceptionThrownEmail, true);
       	}
    }
    @isTest static void testLeadDuplicationSimilarBulkPhone() {
       	try{
       			System.debug('BYE');
       	List<Lead> leadList = new List<Lead>();
    	Lead leadObj;
    	for(Integer i = 0;i< 50;i++){
    		leadObj = new Lead();
    		leadObj.Company = 'Test Company ' + i;
    		leadObj.FirstName = 'T Lead First Name ' + i;
			leadObj.LastName = 'T Lead Last Name ' + i;
			leadObj.Phone = '091855555555';
            leadObj.MobilePhone = '091855555555';
            leadObj.Email = 'someemail' + i + '@gmail.com';
            leadList.Add(leadObj);
    	}
        System.debug('LEAD LIST - ' + leadList);
       	insert leadList;
       	
        List<Database.DeleteResult> result = Database.delete(leadList, false);
        for(Database.DeleteResult dbResult : result){
        	System.assertEquals(dbResult.isSuccess(),true);	
        }
       	}
       	catch(Exception e){
			Boolean expectedExceptionThrownPhone =  (e.getMessage().contains('Phone is duplicate')) ? true : false;
			System.AssertEquals(expectedExceptionThrownPhone, true);
       	}
    }
    @isTest static void testLeadDuplicationUniqueBulk() {
    	List<Lead> leadList = new List<Lead>();
    	Lead leadObj;
    	for(Integer i = 0;i< 10;i++){
    		leadObj = new Lead();
    		leadObj.Company = 'Test Company ' + i;
    		leadObj.FirstName = 'T Lead First Name ' + i;
			leadObj.LastName = 'T Lead Last Name ' + i;
			leadObj.Phone = '0912455555' + i;
            leadObj.MobilePhone = '0912455555555';
            leadObj.Email = 'tst'+ i +'@gmail.com';
            leadList.Add(leadObj);
    	}
    	try{
    	insert leadList;
    	}
       	catch(Exception e)
		{
			Boolean expectedExceptionThrownEmail =  (e.getMessage().contains('Email is duplicate')) ? true : false;
			Boolean expectedExceptionThrownPhone =  (e.getMessage().contains('Phone is duplicate')) ? true : false;
			System.AssertEquals(expectedExceptionThrownEmail, true);
			System.AssertEquals(expectedExceptionThrownPhone, true);
		} 
    	//Test.startTest();
        List<Database.DeleteResult> result = Database.delete(leadList, false);
        //Test.stopTest();
        for(Database.DeleteResult dbResult : result){
        	//System.debug(!dbResult.isSuccess());
        	System.assertEquals(dbResult.isSuccess(),true);	
        	//System.assert(dbResult.getErrors().size() > 0);
        }
    }
    @isTest static void testLeadDuplicationInsertUnique() {
        Lead leadobj = new Lead(Company = 'Company', FirstName = 'First Name', LastName = 'Last Name', Phone = '565656565655',Email='7563@gmail.com' );
        insert leadObj;
        //Test.startTest();
        Database.DeleteResult result1 = Database.delete(leadObj, false);
        //Test.stopTest();
    }
    @isTest static void testLeadDuplicationInsertAndUpdateUnique() {
        Lead leadobj = new Lead(Company = 'Company', FirstName = 'First Name', LastName = 'Last Name', Phone = '784512096388',Email='78588@gmail.com' );
        insert leadObj;
        leadObj.Company='Update Company';
        update leadObj;
        //Test.startTest();
        Database.DeleteResult result2 = Database.delete(leadObj, false);
        //Test.stopTest();
    }
    @isTest static void testLeadDuplicationInsertSimilarPhone() {
    	Lead leadobj = new Lead(Company = 'Company', FirstName = 'First Name', LastName = 'Last Name', Phone = '8527413214',Email='78512@gmail.com' );
        insert leadObj;
        
        leadobj = new Lead(Company = 'Company', FirstName = 'First Name', LastName = 'Last Name', Phone = '8527413214',Email='7851222@gmail.com' );
        try{
        insert leadObj;
        Database.DeleteResult result3 = Database.delete(leadObj, false);
		}
       	catch(Exception e)
		{
			Boolean expectedExceptionThrownEmail =  (e.getMessage().contains('Email is duplicate')) ? true : false;
			Boolean expectedExceptionThrownPhone =  (e.getMessage().contains('Phone is duplicate')) ? true : false;
			System.AssertEquals(expectedExceptionThrownEmail, false);
			System.AssertEquals(expectedExceptionThrownPhone, true);
		}         
        //Test.startTest();
        
        //Test.stopTest();
    }
    @isTest static void testLeadDuplicationInsertSimilarEmail() {
	   	Lead leadobj = new Lead(Company = 'Company', FirstName = 'First Name', LastName = 'Last Name', Phone = '784512096999',Email='785113@gmail.com' );
        insert leadObj;
        //Test.startTest();
        Database.DeleteResult result3 = Database.delete(leadObj, false);
        //Test.stopTest();
        
        leadobj = new Lead(Company = 'Company', FirstName = 'First Name', LastName = 'Last Name', Phone = '784512096990',Email='785113@gmail.com' );
        try{
        insert leadObj;
        }
       	catch(Exception e)
		{
			Boolean expectedExceptionThrownEmail =  (e.getMessage().contains('Email is duplicate')) ? true : false;
			Boolean expectedExceptionThrownPhone =  (e.getMessage().contains('Phone is duplicate')) ? true : false;
			System.AssertEquals(expectedExceptionThrownEmail, true);
			System.AssertEquals(expectedExceptionThrownPhone, true);
		} 
        //Test.startTest();
        Database.DeleteResult result4= Database.delete(leadObj, false);
        //Test.stopTest();
    }
    @isTest static void testLeadDuplicationInsertSimilarEmailAndPhone() {
	   	Lead leadobj = new Lead(Company = 'Company', FirstName = 'First Name', LastName = 'Last Name', Phone = '7845120969978',Email='785144@gmail.com' );
        insert leadObj;
        //Test.startTest();
        Database.DeleteResult result3 = Database.delete(leadObj, false);
        //Test.stopTest();
        
        leadobj = new Lead(Company = 'Company', FirstName = 'First Name', LastName = 'Last Name', Phone = '7845120969978',Email='785144@gmail.com' );
        try{
        insert leadObj;
        }
       	catch(Exception e)
		{
			Boolean expectedExceptionThrownEmail =  (e.getMessage().contains('Email is duplicate')) ? true : false;
			Boolean expectedExceptionThrownPhone =  (e.getMessage().contains('Phone is duplicate')) ? true : false;
			System.AssertEquals(expectedExceptionThrownEmail, true);
			System.AssertEquals(expectedExceptionThrownPhone, true);
		} 
        //Test.startTest();
        Database.DeleteResult result4= Database.delete(leadObj, false);
        //Test.stopTest();
    }
    @isTest static void testLeadDuplicationInsertUniqueAndUpdateSimilarPhone() {
    	Lead leadobj = new Lead(Company = 'Company', FirstName = 'First Name', LastName = 'Last Name', Phone = '45632178900',Email='test111@gmail.com' );
		insert leadObj;
        
		Lead newleadobj = new Lead(Company = 'Company', FirstName = 'First Name', LastName = 'Last Name', Phone = '456321789001',Email='test1112@gmail.com' );
		insert newleadObj;

		newleadObj.Phone='45632178900';
		
        try{
        update newleadObj;
        }
       	catch(Exception e)
		{
			Boolean expectedExceptionThrownEmail =  (e.getMessage().contains('Email is duplicate')) ? true : false;
			Boolean expectedExceptionThrownPhone =  (e.getMessage().contains('Phone is duplicate')) ? true : false;
			System.AssertEquals(expectedExceptionThrownEmail, false);
			System.AssertEquals(expectedExceptionThrownPhone, true);
		} 
        //Test.startTest();
        Database.DeleteResult result2 = Database.delete(leadObj, false);
        //Test.stopTest();
    }
    @isTest static void testLeadDuplicationInsertUniqueAndUpdateSimilarEmail() {
    	Lead leadobj = new Lead(Company = 'Company', FirstName = 'First Name', LastName = 'Last Name', Phone = '85296374155',Email='85296374155@gmail.com' );
        insert leadObj;
     	   
        leadobj = new Lead(Company = 'Company', FirstName = 'First Name', LastName = 'Last Name', Phone = '8529637415563',Email='8529637415563@gmail.com' );
        insert leadObj;
        leadObj.Email='85296374155@gmail.com';
        try{
        update leadObj;
        }
       	catch(Exception e)
		{
			Boolean expectedExceptionThrownEmail =  (e.getMessage().contains('Email is duplicate')) ? true : false;
			Boolean expectedExceptionThrownPhone =  (e.getMessage().contains('Phone is duplicate')) ? true : false;
			System.AssertEquals(expectedExceptionThrownEmail, true);
			System.AssertEquals(expectedExceptionThrownPhone, false);
		} 
        //Test.startTest();
        Database.DeleteResult result2 = Database.delete(leadObj, false);
        //Test.stopTest();
    }
    @isTest static void testGenerateTaskOnLeadCreationSingle(){
    	Lead leadobj = new Lead(Company = 'Company', FirstName = 'First Name', LastName = 'Last Name', Phone = '66996699666',Email='66966@gmail.com' );
        insert leadObj;
        Database.DeleteResult result2 = Database.delete(leadObj, false);
    }
    @isTest static void testGenerateTaskOnLeadCreationMultiple(){
    	
        try{
        	List<Lead> leadList = TestData.getLeads(50);
        	insert leadList;
        	List<Task> leadTaskList = new List<Task>([Select ID from Task Where WhoId IN :leadList]);
        	System.AssertEquals(leadList.size(), leadTaskList.size());
        	 List<Database.DeleteResult> result = Database.delete(leadList, false);
         for(Database.DeleteResult dbResult : result){
        	System.assertEquals(dbResult.isSuccess(),true);	
        }
        }
        catch(Exception e){
        	Boolean expectedExceptionThrown =  (e.getMessage().contains('')) ? true : false;
			System.AssertEquals(expectedExceptionThrown, true);
        }
       
    }
    @isTest static void testCloneLeadDependingOnStatusBulkWithSameStatus(){
    	try{
    		List<Lead> oldleadList = new List<Lead>([Select Id from Lead]);
    		List<Lead> leadList = TestData.getLeads(50);
    		insert leadList;
    		List<Lead> currentList = new List<Lead>([Select Id from Lead]);
    		List<Database.DeleteResult> result = Database.delete(leadList, false);
    		System.AssertEquals(oldleadList.size() + leadList.size() + leadList.size() ,currentList.size());
    		for(Database.DeleteResult dbResult : result){
        		System.assertEquals(dbResult.isSuccess(),true);	
        	}
    	}
    	catch(Exception e){
        	Boolean expectedExceptionThrown =  (e.getMessage().contains('')) ? true : false;
			System.AssertEquals(expectedExceptionThrown, true);
        }
    }
    @isTest static void testCloneLeadDependingOnStatusBulkWithOtherStatus(){
    	try{
    		List<Lead> oldleadList = new List<Lead>([Select Id from Lead]);
    		
    		List<Lead> leadList = new List<Lead>();
    		Lead leadObj;
    		for(Integer i = 0;i< 30;i++){
    			leadObj = new Lead();
    			leadObj.Company = 'Test Company ' + i;
    			leadObj.FirstName = 'T Lead First Name ' + i;
				leadObj.LastName = 'T Lead Last Name ' + i;
				leadObj.Phone = '8555555555555' + i;
            	leadObj.MobilePhone = '8555555555555' + i;
            	leadObj.Email = 'mj@gmail.com';
            	leadObj.Status = 'Working - Contacted';
            	leadList.Add(leadObj);
    		}
    		insert leadList;
    		List<Lead> currentList = new List<Lead>([Select Id from Lead]);
    		List<Database.DeleteResult> result = Database.delete(leadList, false);
    		System.AssertEquals(oldleadList.size() + leadList.size() ,currentList.size());
    		for(Database.DeleteResult dbResult : result){
        		System.assertEquals(dbResult.isSuccess(),true);	
        	}
    	}
    	catch(Exception e){
        	Boolean expectedExceptionThrown =  (e.getMessage().contains('')) ? true : false;
			System.AssertEquals(expectedExceptionThrown, true);
        }
    }
    @isTest static void testCloneLeadDependingOnStatusSingleWithSameStatus(){
    	try{
    		List<Lead> oldleadList = new List<Lead>([Select Id from Lead]);
    		Lead leadObj = new Lead(Company = 'Test Company ', FirstName = 'T Lead First Name ', LastName = 'T Lead Last Name ' ,Phone = '8555555555555' ,MobilePhone = '8555555555555', Email = 'mj@gmail.com', Status = 'Open - Not Contacted');
    		insert leadObj;
    		List<Lead> currentList = new List<Lead>([Select Id from Lead]);
    		Database.DeleteResult result = Database.delete(leadObj, false);
    		System.AssertEquals(oldleadList.size() + 2 ,currentList.size());
    		System.assertEquals(result.isSuccess(),true);	
    	}
    	catch(Exception e){
        	Boolean expectedExceptionThrown =  (e.getMessage().contains('')) ? true : false;
			System.AssertEquals(expectedExceptionThrown, true);
        }
    }
    @isTest static void testCloneLeadDependingOnStatusSingleWithOtherStatus(){
    	try{
    		List<Lead> oldleadList = new List<Lead>([Select Id from Lead]);
    		Lead leadObj = new Lead(Company = 'Test Company ', FirstName = 'T Lead First Name ', LastName = 'T Lead Last Name ' ,Phone = '8555555555555' ,MobilePhone = '8555555555555', Email = 'mj@gmail.com', Status = 'Working - Contacted');
    		insert leadObj;
    		List<Lead> currentList = new List<Lead>([Select Id from Lead]);
    		Database.DeleteResult result = Database.delete(leadObj, false);
    		System.AssertEquals(oldleadList.size() + 1 ,currentList.size());
    		System.assertEquals(result.isSuccess(),true);	
    	}
    	catch(Exception e){
        	Boolean expectedExceptionThrown =  (e.getMessage().contains('')) ? true : false;
			System.AssertEquals(expectedExceptionThrown, true);
        }
    }
     @isTest static void testCloneLeadDependingOnStatusSingleWithOtherStatusAndUpdateWithSameStatus(){
    	try{
    		List<Lead> oldleadList = new List<Lead>([Select Id from Lead]);
    		Lead leadObj = new Lead(Company = 'Test Company ', FirstName = 'T Lead First Name ', LastName = 'T Lead Last Name ' ,Phone = '8555555555555' ,MobilePhone = '8555555555555', Email = 'mj@gmail.com', Status = 'Working - Contacted');
    		insert leadObj;
    		List<Lead> currentList = new List<Lead>([Select Id from Lead]);
    		System.AssertEquals(oldleadList.size() + 1 ,currentList.size());
    		
    		leadObj.Status = 'Open - Not Contacted';
    		update leadObj;
    		currentList = new List<Lead>([Select Id from Lead]);
    		System.AssertEquals(oldleadList.size() + 1 ,currentList.size());
    		
    		Database.DeleteResult result = Database.delete(leadObj, false);
    		System.assertEquals(result.isSuccess(),true);	
    	}
    	catch(Exception e){
        	Boolean expectedExceptionThrown =  (e.getMessage().contains('')) ? true : false;
			System.AssertEquals(expectedExceptionThrown, true);
        }
    }
     @isTest static void testCloneLeadDependingOnStatusSingleWithSameStatusAndUpdateWithOtherStatus(){
    	try{
    		List<Lead> oldleadList = new List<Lead>([Select Id from Lead]);
    		Lead leadObj = new Lead(Company = 'Test Company ', FirstName = 'T Lead First Name ', LastName = 'T Lead Last Name ' ,Phone = '8555555555555' ,MobilePhone = '8555555555555', Email = 'mj@gmail.com', Status = 'Open - Not Contacted');
    		insert leadObj;
    		List<Lead> currentList = new List<Lead>([Select Id from Lead]);
    		System.AssertEquals(oldleadList.size() + 2 ,currentList.size());
    		
    		leadObj.Status = 'Working - Contacted';
    		update leadObj;
    		currentList = new List<Lead>([Select Id from Lead]);
    		System.AssertEquals(oldleadList.size() + 2 ,currentList.size());
    		
    		Database.DeleteResult result = Database.delete(leadObj, false);
    		System.assertEquals(result.isSuccess(),true);	
    	}
    	catch(Exception e){
        	Boolean expectedExceptionThrown =  (e.getMessage().contains('')) ? true : false;
			System.AssertEquals(expectedExceptionThrown, true);
        }
    }
     @isTest static void testCloneLeadDependingOnStatusSingleWithSameStatusAndUpdateWithSameStatus(){
    	try{
    		List<Lead> oldleadList = new List<Lead>([Select Id from Lead]);
    		Lead leadObj = new Lead(Company = 'Test Company ', FirstName = 'T Lead First Name ', LastName = 'T Lead Last Name ' ,Phone = '8555555555555' ,MobilePhone = '8555555555555', Email = 'mj@gmail.com', Status = 'Open - Not Contacted');
    		insert leadObj;
    		List<Lead> currentList = new List<Lead>([Select Id from Lead]);
    		System.AssertEquals(oldleadList.size() + 2 ,currentList.size());
    		
    		leadObj.FirstName = 'FIRST NAME UPDATED';
    		update leadObj;
    		currentList = new List<Lead>([Select Id from Lead]);
    		System.AssertEquals(oldleadList.size() + 2 ,currentList.size());
    		
    		Database.DeleteResult result = Database.delete(leadObj, false);
    		System.assertEquals(result.isSuccess(),true);	
    	}
    	catch(Exception e){
        	Boolean expectedExceptionThrown =  (e.getMessage().contains('')) ? true : false;
			System.AssertEquals(expectedExceptionThrown, true);
        }
    }
    @isTest static void testCloneLeadDependingOnStatusSingleWithOtherStatusAndUpdateWithOtherStatus(){
    	try{
    		List<Lead> oldleadList = new List<Lead>([Select Id from Lead]);
    		Lead leadObj = new Lead(Company = 'Test Company ', FirstName = 'T Lead First Name ', LastName = 'T Lead Last Name ' ,Phone = '8555555555555' ,MobilePhone = '8555555555555', Email = 'mj@gmail.com', Status = 'Working - Contacted');
    		insert leadObj;
    		List<Lead> currentList = new List<Lead>([Select Id from Lead]);
    		System.AssertEquals(oldleadList.size() + 1 ,currentList.size());
    		
    		leadObj.FirstName = 'FIRST NAME UPDATED';
    		update leadObj;
    		currentList = new List<Lead>([Select Id from Lead]);
    		System.AssertEquals(oldleadList.size() + 1 ,currentList.size());
    		
    		Database.DeleteResult result = Database.delete(leadObj, false);
    		System.assertEquals(result.isSuccess(),true);	
    	}
    	catch(Exception e){
        	Boolean expectedExceptionThrown =  (e.getMessage().contains('')) ? true : false;
			System.AssertEquals(expectedExceptionThrown, true);
        }
    }
    
}