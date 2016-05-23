public class Day9Assignments {
    public static string FirstAssignment(Integer somenumber){
		If((somenumber/2)*2 == somenumber) 
        { 
            System.Debug('Even'); 
            return 'Even';
        }
        else{
        	System.Debug('Odd');  
            return 'Odd';
        }
    }
    public static void SecondAssignment(Integer somenumber){
        Integer[] myList = new List<Integer>();
        for(Integer count = 0; count <= somenumber; count++){
            myList.add(count);
        }
        System.debug(myList);
    }
     public static void ThirdAssignment(Integer[] someList){
       
    }
     public static void FourthAssignment(Integer num){
         Integer summation = 0;
         for(Integer i=0;i<= num;i++){
             summation = summation + i;
         }
         System.debug(summation);
    }
     public static void FifthAssignment(Integer principleAmount, Integer years, Integer interest){
         Integer si;
         si = (principleAmount * years * interest) / 100;
         System.debug(si);
    }
     public static Integer SixthAssignment(String operation, Integer num1, Integer num2){
         Integer result = 0;
         
         IF(operation == 'SUM'){
             result  = num1 + num2;
         }
         ELSE IF(operation == 'SUB'){
             result  = num1 - num2;
         }
         ELSE IF(operation == 'MUL'){
             result  = num1 * num2;
         }
         ELSE IF(operation == 'DIV'){
             result  = num1 / num2;
         }
         
         System.debug(operation +' result is '+ result);
         return result;
    }
    public static void SeventhAssignment(){
        Marker obj1, obj2;
		obj1 = new Marker();
		obj1.write();
		obj2 = new YellowMarker();
		obj2.write();
		Double d = obj2.discount();
    }
    public static void queryAccountObject_Traditional(){
        List<Account> accountList = [select Id,Name from Account];
        for(Integer i=0; i < accountList.size(); i++){
            System.debug(accountList[i]);
        }
    }
    public static void queryAccountObject_Advanced(){
        List<Account> accountList = [select Id,Name from Account];
        for(Account acc: accountList){
        	System.debug(acc);    
        }
        Integer count = 1;

		while (count < accountList.size()) {
    		System.debug(accountList[count]);
    		count++;
		}
    }
    public static void queryLead_Set(){
        List<Lead> leadList = [select Id,Name from Lead];
    	Set<String> s = new Set<String>();
        for(Lead obj:LeadList){
            s.add(obj.Id);
        }
        for(String name : s){
        	System.debug(name);
        }
    }
    public static void createAccount(){
        Account acct = new Account(Name = 'Zen4orce');
        insert acct;
        String accountID = acct.Id;
        
		Contact contactS = new Contact(
    		FirstName='Sourabh',
    		LastName='S',
    		Phone='7894561230',
    		AccountId=accountID);
        
        insert contactS;
        
        List<Contact> contactList = [select Id,Name from Contact where Account.Name ='Zen4orce'];
        
        Account acctobj =  [select Id,Name,Contact_Count__c from Account where Account.Name ='Zen4orce'];
        acctobj.Contact_Count__c = contactList.size();
        upsert acctobj;
        System.debug(acctobj);
    }
    public static void leadRecordsManipulate(){
        List<Lead> leadList = [select Id,Name,Status from Lead where Status = 'Closed - Converted'];
        System.debug(leadList);
    }
    public static void soql_AccountandContact(){
        List<contact> contactList = [select Id,Name from Contact where Account.Name = 'Zen4orce'];
        System.debug(contactList);
    }
    public static void soql_AccountsToday(){
        List<Account> accountList = [SELECT Id,Name,CreatedDate FROM Account where CreatedDate = Today];
        for(Account acct:accountList){
            System.debug(acct);
        }
    }
    public static void Array_Operations(Integer[] nums){
        Integer temp;
        //ascending order
        for (Integer i = 0; i < nums.size() - 1; i++)
        {
            for (Integer j = i + 1; j < nums.size(); j++)
            {
                if (nums[i] > nums[j])
                {
                    temp = nums[i];
                    nums[i] = nums[j];
                    nums[j] = temp;
                }
            }
        }
        System.debug('Ascending Order');
        System.debug(nums);
        
        //descending order
        for (Integer i = 0; i < nums.size() - 1; i++)
        {
            for (Integer j = i + 1; j < nums.size(); j++)
            {
                if (nums[i] < nums[j])
                {
                    temp = nums[j];
                    nums[j] = nums[i];
                    nums[i] = temp;
                }
            }
        }
        System.debug('Descending Order');
        System.debug(nums);
        
        //maximum and minimum value
        Integer small = nums[0];
        Integer large = nums[0];
        
        for (Integer i = 0; i < nums.size(); i++)
        {
        	if (large < nums[i])
            {
            	Integer tmp = large;
                large = nums[i];
                nums[i] = large;
            }
            if (small > nums[i])
            {
                Integer tmp = small;
                small = nums[i];
                nums[i] = small;
            }
         }
        System.debug('Minimum Value ' + small);
        System.debug('Maximum Value ' + large);
        
        //duplicates and occurence
        for (Integer i = 0; i < nums.size() - 1; i++)
        {
            for (Integer j = i + 1; j < nums.size(); j++)
            {
                if (nums[i] == nums[j])
                {
         			System.debug('Duplicate Value ' + nums[i]);           
                    System.debug('Duplicate Value Index ' + (i+1));           
                }
            }
        }
    }
}