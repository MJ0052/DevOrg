@isTest
private class LeadProcessorTest {

   // @testSetup 
    //static void setup() {
       
    //}

    static testmethod void test() {   
        
         List<Lead> leadList = new List<Lead>();
        for (Integer i=0;i<200;i++) {
            leadList.add(
                new Lead(LastName='Lead '+i, Company='Company '+i, Status='Closed-Converted'));
        }
        insert leadList;
        Test.startTest();
        LeadProcessor uca = new LeadProcessor();
        Id batchId = Database.executeBatch(uca);
        Test.stopTest();
        System.assertEquals([Select count() from Lead], [select count() from Lead where LeadSource = 'Dreamforce']);
    }
    
}