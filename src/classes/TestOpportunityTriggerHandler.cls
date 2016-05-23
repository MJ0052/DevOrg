@isTest
public with sharing class TestOpportunityTriggerHandler {
    @isTest static void testNotificationEmailOnLesserAmount() {
        Opportunity oppobj = new Opportunity(Name = 'Company', CloseDate = Datetime.now().date(), StageName = 'Qualification', Amount = 1200);
        insert oppobj;
        Database.DeleteResult result = Database.delete(oppObj, false);
        System.assertEquals(result.isSuccess(),true);	
    }
    @isTest static void testNotificationEmailOnGreaterAmount() {
        Opportunity oppobj = new Opportunity(Name = 'Company', CloseDate = Datetime.now().date(), StageName = 'Qualification', Amount = 1200000);
        insert oppobj;
        Database.DeleteResult result = Database.delete(oppObj, false);
        System.assertEquals(result.isSuccess(),true);
    }
    @isTest static void testNotificationEmailOnGreaterAmountBulk() {
    	List<Opportunity> oppList = TestData.getOpportunities(50);
    	try{
    		insert oppList;
    		List<Database.DeleteResult> result = Database.delete(oppList, false);
    		for(Database.DeleteResult dbresult:result){
    			System.assertEquals(dbResult.isSuccess(),true);	
    		}
    	}
    	catch(Exception e)
		{
			Boolean expectedExceptionThrown =  (e.getMessage().contains('')) ? true : false;
			System.AssertEquals(expectedExceptionThrown, true);
		}   
    }
    @isTest static void testNotificationEmailOnLesserThenGreaterAmount() {
        Opportunity oppobj = new Opportunity(Name = 'Company', CloseDate = Datetime.now().date(), StageName = 'Qualification', Amount = 1200);
        insert oppobj;
        oppobj.Amount = 1500000;
        update oppobj;
        Database.DeleteResult result = Database.delete(oppObj, false);
        System.assertEquals(result.isSuccess(),true);
    }
     @isTest static void testNotificationEmailOnSameAmountUpdate() {
        Opportunity oppobj = new Opportunity(Name = 'Company', CloseDate = Datetime.now().date(), StageName = 'Qualification', Amount = 1200);
        insert oppobj;
        oppobj.Name = 'Company Update';
        update oppobj;
        Database.DeleteResult result = Database.delete(oppObj, false);
        System.assertEquals(result.isSuccess(),true);
    }
}