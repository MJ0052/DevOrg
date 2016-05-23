@isTest
private class DailyLeadProcessorTest {
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';

     @testSetup 
    static void setup() {
       List<Lead> leadList = new List<Lead>();
        Lead obj;
        for(Integer i=0;i<300;i++){
		    obj = new Lead();
		    obj.lastName = 'LEAD '+i;
		    obj.Company = 'Company ' + i;
		    obj.Status = 'Closed-Converted';
		    leadList.add(obj);
        }
        insert leadList;
    }
    static testmethod void testScheduledJob() {
        Integer count = [Select count() from Lead where Leadsource = ''];
        Test.startTest();
        String jobId = System.schedule('ScheduledApexTest',CRON_EXP,new DailyLeadProcessor());         
        Test.stopTest();
        System.assertEquals(count - 200, [Select count() from Lead where LeadSource = '']);
    }
}