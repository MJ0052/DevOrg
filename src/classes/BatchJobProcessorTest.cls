@isTest
private class BatchJobProcessorTest {

    @testSetup 
    static void setup() {
    	List<Opportunity> oppList = new List<Opportunity>();
    	Opportunity oppObj;
    	for(Integer i=0;i<200;i++){
    		oppObj = new Opportunity();
    		oppObj.CloseDate = Date.today();
    		oppObj.Name ='OPP TEST ' + i;
    		oppObj.StageName = 'Closed Won';
    		oppList.add(oppObj);
    	}
    	insert oppList;   
    }

    static testmethod void test() {           
        Test.startTest();
        Id batchId = Database.executeBatch(new BatchJobProcessor());
        Test.stopTest();
        System.assertEquals(0, [select count() from Opportunity where StageName = 'Closed Won' AND IsAggregated__c = false]);
    }
    
}