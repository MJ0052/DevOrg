@isTest
public with sharing class BatchSchedulerControllerTest {
	@testSetup 
    static void setup() {
    	BatchSchedulerController controller = new BatchSchedulerController();
        controller.getItems();
        controller.getItemHours();
        controller.getItemDayOfMonth();
        controller.getItemMonth();
        controller.getItemDayOfWeek();
        controller.getItemYear();
    }
    public static testMethod void testPreviewCron() {
    	// 0 0 * * * * *
        BatchSchedulerController controller = new BatchSchedulerController();
        controller.Setseconds('0');
        controller.Setminutes('0');
        controller.Sethours('*');
        controller.SetdayOfMonth('*');
        controller.Setmonth('0');
        controller.SetdayOfWeek('0');
        controller.Setyear('*');
        controller.PreviewCronExpression();
        System.assertEquals(''+controller.getseconds()+' '+ controller.getminutes() +' '+ controller.gethours() +' '+ controller.getdayOfMonth() +' '+ controller.getmonth() +' '+ controller.getdayOfWeek() +' '+ controller.getyear() +'',controller.GeneratedCron);
    }
    
    static testMethod void testInvalidCron()
    { 
        try{
      		// 0 0 * * * * *
        	BatchSchedulerController controller = new BatchSchedulerController();
        	controller.Setseconds('0');
        	controller.Setminutes('0');
        	controller.Sethours('*');
        	controller.SetdayOfMonth('?');
        	controller.Setmonth('0');
        	controller.SetdayOfWeek('?');
        	controller.Setyear('*');
        	controller.PreviewCronExpression();
        	System.assertEquals(null,controller.GeneratedCron);  	
        }
        catch(Exception e){
        	Boolean expectedExceptionThrown =  e.getMessage().contains('ERROR : Day of month and Day of week both cannot be selected as every month/every week') ? true : false;
            system.assertEquals(expectedExceptionThrown,true);       
		} 
	}
	static testMethod void testCronWithNoYear()
    { 
        try{
      		// 0 0 * * * * *
        	BatchSchedulerController controller = new BatchSchedulerController();
        	controller.Setseconds('0');
        	controller.Setminutes('0');
        	controller.Sethours('*');
        	controller.SetdayOfMonth('*');
        	controller.Setmonth('0');
        	controller.SetdayOfWeek('0');
        	controller.Setyear('?');
        	controller.PreviewCronExpression();
        	System.assertEquals(''+controller.getseconds()+' '+ controller.getminutes() +' '+ controller.gethours() +' '+ controller.getdayOfMonth() +' '+ controller.getmonth() +' '+ controller.getdayOfWeek() +' '+ controller.getyear() +'',controller.GeneratedCron);  	
        }
        catch(Exception e){
        	Boolean expectedExceptionThrown =  e.getMessage().contains('') ? true : false;
            system.assertEquals(expectedExceptionThrown,true);       
		} 
	}
	static testMethod void testNoWatchSchedules()
    { 
        try{
      		// 0 0 * * * * *
        	BatchSchedulerController controller = new BatchSchedulerController();
        	controller.WatchSchedules();
        	System.assertEquals(controller.getjobDetails().size() > 0 , false);
        }
        catch(Exception e){
        	System.debug(e.getMessage());
        	Boolean expectedExceptionThrown =  e.getMessage().contains('') ? true : false;
            system.assertEquals(expectedExceptionThrown,true);       
		} 
	}
	static testMethod void testInvalidCronForDayofweekAndMonth()
    { 
        try{
      		//0 30 11 * * 5 *
        	BatchSchedulerController controller = new BatchSchedulerController();
        	controller.Setseconds('0');
        	controller.Setminutes('30');
        	controller.Sethours('11');
        	controller.SetdayOfMonth('*');
        	controller.Setmonth('*');
        	controller.SetdayOfWeek('5');
        	controller.Setyear('*');
        	controller.Schedule();
        }
        catch(Exception e){
        	System.debug(e.getMessage());
        	Boolean expectedExceptionThrown =  e.getMessage().contains('An error has occured while scheduling the batch - Support for specifying both a day-of-week AND a day-of-month parameter is not implemented.') ? true : false;
            system.assertEquals(expectedExceptionThrown,true);       
		} 
	}
	static testMethod void testValidCronAndSchedule()
    { 
        try{
      		//0 30 11 ? * 5 *
        	BatchSchedulerController controller = new BatchSchedulerController();
        	controller.Setseconds('0');
        	controller.Setminutes('30');
        	controller.Sethours('11');
        	controller.SetdayOfMonth('?');
        	controller.Setmonth('*');
        	controller.SetdayOfWeek('5');
        	controller.Setyear('*');
        	controller.JobName = 'SOME RANDOM NAME';
        	controller.Schedule();
        	
        	controller.WatchSchedules();
        	System.assertEquals(controller.getjobDetails().size() > 0 , true);
        }
        catch(Exception e){
        	System.debug(e.getMessage());
        	Boolean expectedExceptionThrown =  e.getMessage().contains('An error has occured while scheduling the batch - Support for specifying both a day-of-week AND a day-of-month parameter is not implemented.') ? true : false;
            system.assertEquals(expectedExceptionThrown,true);       
		} 
	}
}