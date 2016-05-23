@isTest
public class BatchJobProcessorSchedulerTest {
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';

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
    static testmethod void testScheduledJob() {
        Integer count = [Select count() from Lead where Leadsource = ''];
        Test.startTest();
        String jobId = System.schedule('ScheduledApexTest',CRON_EXP,new BatchJobProcessorScheduler());    
        System.debug('jobId' + jobId);     
        Test.stopTest();
       // System.assertEquals(0, [select count() from Opportunity where StageName = 'Closed Won' AND IsAggregated__c = false]);
    }
}