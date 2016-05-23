public with sharing class BatchSchedulerController {
   
	public String seconds;
	public String minutes;
	public String hours;
	public String dayOfMonth;
	public String month;
	public String dayOfWeek;
	public String year;
	public String GeneratedCron;
	public String JobName {get; set;}
	public List<CronJobDetail> jobDetails;
	
	public List<CronJobDetail> getJobDetails()
    {
        if (jobDetails!= NULL)
            if (jobDetails.size() > 0)
                return jobDetails;
            else
                return null;                    
        else
            return null;
    }  
	private static Map<Integer, String> monthsMap = new Map<Integer, String>{
	0 => 'Monthly',
  	1  => 'January',
	2  => 'February',
	3  => 'March',
	4  => 'April',
	5  => 'May',
	6  => 'June',
	7  => 'July',
	8  => 'August',
	9  => 'September',
	10  => 'October',
	11  => 'November',
	12  => 'December'};
	private static Map<Integer, String> weeksMap = new Map<Integer, String>{
  	0  => 'Weekly',
  	1  => 'MON',
	2  => 'TUE',
	3  => 'WED',
	4  => 'THUR',
	5  => 'FRI',
	6  => 'SAT',
	7  => 'SUN'};
	//SELECT ITEMS FOR SECONDS AND MINUTES
	public List<SelectOption> getItems() {
    	List<SelectOption> options = new List<SelectOption>();
    	for(Integer i=0;i<60;i++){
        	options.add(new SelectOption(String.valueof(i),String.valueof(i)));
    	}
        return options;
	}
	//HOURS
	public List<SelectOption> getItemHours() {
    	List<SelectOption> options = new List<SelectOption>();
    	options.add(new SelectOption('*','Hourly'));
    	for(Integer i=0;i<24;i++){
        	options.add(new SelectOption(String.valueof(i),String.valueof(i)));
    	}
        return options;
	}
	//DAY OF MONTH
	public List<SelectOption> getItemDayOfMonth() {
    	List<SelectOption> options = new List<SelectOption>();
    	options.add(new SelectOption('*','Daily'));
    	for(Integer i=1;i<=31;i++){
        	options.add(new SelectOption(String.valueof(i),String.valueof(i)));
    	}
    	options.add(new SelectOption('?','None'));
        return options;
	}
	//MONTH
	public List<SelectOption> getItemMonth() {
    	List<SelectOption> options = new List<SelectOption>();
    	for(Integer i=0;i<=12;i++){
        	options.add(new SelectOption(String.valueof(i),monthsMap.get(i)));
    	}
        return options;
	}
	//DAY OF WEEK
	public List<SelectOption> getItemDayOfWeek() {
		List<SelectOption> options = new List<SelectOption>();
    	for(Integer i=0;i<=7;i++){
        	options.add(new SelectOption(String.valueof(i),weeksMap.get(i)));
    	}
    	options.add(new SelectOption('?','None'));
        return options;
	}
	//YEAR
	public List<SelectOption> getItemYear() {
		List<SelectOption> options = new List<SelectOption>();
		options.add(new SelectOption('*','Yearly'));
    	for(Integer i=1970;i<=Date.today().year();i++){
        	options.add(new SelectOption(String.valueof(i),String.valueof(i)));
    	}
    	options.add(new SelectOption('?','None'));
        return options;
	}
            
    public String getSeconds() {
    	return seconds;
    }
   	public void setSeconds(String seconds) {
    	this.seconds = seconds;
    }
    public String getMinutes() {
    	return minutes;
    }
   	public void setMinutes(String minutes) {
    	this.minutes = minutes;
    }
    public String getHours() {
    	return hours;
    }
   	public void setHours(String hours) {
    	this.hours = hours;
    }
	public String getDayOfMonth() {
    	return dayOfMonth;
    }
   	public void setDayOfMonth(String dayOfMonth) {
    	this.dayOfMonth = dayOfMonth;
    }
    public String getMonth() {
    	return month;
    }
   	public void setMonth(String month) {
    	this.month = month;
    }
    public String getDayOfWeek() {
    	return dayOfWeek;
    }
   	public void setDayOfWeek(String dayOfWeek) {
    	this.dayOfWeek = dayOfWeek;
    }
    public String getYear() {
    	return year;
    }
   	public void setYear(String year) {
    	this.year = year;
    }
  
    
    public BatchSchedulerController() {
       
    }
    private string GenerateCron(){
    	try{
    	if(month == '0'){
    		month = '*';
    	}
    	if(dayOfWeek == '0'){
    		dayOfWeek = '*';
    	}
    	if(year == '?'){
    		year = ' ';
    	}
    	if(dayOfMonth == '?' && dayOfWeek == '?'){
    		ApexPages.Message myMsg1 = new ApexPages.Message(ApexPages.Severity.ERROR,'ERROR : Day of month and Day of week both cannot be selected as every month/every week');
    		ApexPages.addMessage(myMsg1);
    	}
    	else{
    		GeneratedCron = seconds+' '+minutes +' '+ hours +' '+dayOfMonth+' '+ month +' '+ dayOfWeek+' '+year;
    		ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO,'CRON EXPRESSION : ' + GeneratedCron);
    		ApexPages.addMessage(myMsg);
    	}
    	}
         catch(Exception e){
                 ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while previewing the cron expression '+e.getMessage());
                ApexPages.addMessage(errormsg);
         } 
         return GeneratedCron; 
    }
    public void PreviewCronExpression(){
    	try{
    		GenerateCron();
    	}
         catch(Exception e){
                 ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while previewing the cron expression '+e.getMessage());
                ApexPages.addMessage(errormsg);
         }  
    }
    private Boolean Validation(){
    	Boolean submitFlag = true;
    	if(JobName == '' || JobName == null){
    		submitFlag = false;
    	}
    	return submitFlag;
    }
    public void Schedule(){
    	try{
    	if(Validation()){
    		String sch = GenerateCron();
    	System.debug('GENERATED CRON ' + sch);
		String jobID = System.schedule(JobName, sch, new BatchJobProcessorScheduler());
		if(jobID != '' && jobID != null){
			ApexPages.Message succesmsg = new ApexPages.Message(ApexPages.severity.CONFIRM,'JOB has been scheduled having job id - '+jobID);
            ApexPages.addMessage(succesmsg);
        }
    	}
    	else{
    		ApexPages.Message validationmsg = new ApexPages.Message(ApexPages.severity.ERROR,'Job name is required');
            ApexPages.addMessage(validationmsg);
    	}
    	
		}
         catch(Exception e){
                 ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while scheduling the batch - '+e.getMessage());
                ApexPages.addMessage(errormsg);
         }
    }
    public void WatchSchedules(){
    	try{
    		jobDetails = new List<CronJobDetail>();
    	 	jobDetails = [SELECT Id,JobType,Name FROM CronJobDetail];
		}
        catch(Exception e){
        	ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while watching the schedules- '+e.getMessage());
            ApexPages.addMessage(errormsg);
        }
    }
/*
    public PageReference save() {
        update account;
        return null;
    }*/
}