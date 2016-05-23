public class Day9Assignments_Set2 {
    public static String CheckForPrime(Integer num){
    	Integer i;
    	for (i = 2; i <= num - 1; i++)
        {
        	if (Math.mod(num, i) == 0)
            {
            	return 'Is not a prime number';
            }
        }
        if (i == num)
        {
           return 'Is a prime number';
        }
        return 'Is not a prime number';
    }
    public static void CheckForPalindrome(String palindrome){
        palindrome.reverse();
        Integer length = 0;
        string reverse = '';
        length = palindrome.length();
        
        for (Integer i = length - 1; i >= 0; i-- ){
        	reverse = reverse + palindrome.substring(i,i+1);
        }
       
      	if (palindrome.equals(reverse))
      	{
         	System.debug('Is palindrome');
      	}
      	else
      	{
        	System.debug('Is not a palindrome');
      	}
    }
    public static void ReplaceCharacterFromString(string CharToReplace,String[] Data){
        for(Integer i = 0; i < Data.size(); i++ ){
        	String[] chars = Data[i].split('');
            string afterReplacing = '';
            for(Integer j = 0; j < chars.size();j++){
                
                if(chars[j] == CharToReplace){
                    chars[j] = '$';
                }
                afterReplacing = afterReplacing + chars[j];
            }
            Data[i] = afterReplacing;
            System.debug(Data[i]);
        }
    }
    public static void CountLengthOfString(string param){
        String[] chars = param.split('');
        Integer length = chars.size();
        System.debug(length);
    }
    public static void GetUniqueNumbers(Integer[] nums){
        //doubtfull
        List<Integer> numList = nums;
        List<Integer> uniqueNum = new List<Integer>();
        for(Integer num:numList){
            for(Integer secNum:numList){
                if(num != secNum){
                    uniqueNum.add(secNum);
                }
            }
        }
        System.debug(uniqueNum);
    }
    public static void opportunity_Operations(){
        List<Opportunity> opportunityList = [select Id,Account.Id from Opportunity  where Account.Id = null AND StageName = 'Closed Won'];
       
        List<Account> accountList = [select Id from Account];
      	Set<Account> accountSet = new Set<Account>( [SELECT Id, Name FROM Account] );
        for(Account acct: accountSet){
            //System.debug(acct.Id);
        }
		Map<ID, Opportunity> opportunityMap = new Map<ID, Opportunity>([SELECT Id, Account.Id FROM Opportunity]);
        for(Opportunity opp : opportunityMap.values()) 
        {
            System.debug('Opportunity ID - ' + opp.Id + ' ,Account ID - ' + opp.AccountId); 
        }
    }
    public static void AccountStartsWith(){
        List<Account> accountList = [SELECT Id, Name FROM Account where Name LIKE 'a%'];
        System.debug('Count of account starting with a - ' + accountList.size());
        Integer count = 1;
        for(Account acct : accountList){
            acct.Name = 'Updated via update DML operation - ' + count;
            count++;
        }
        System.debug(accountList);
        update(accountList);
    }
    public static void CampaignManipulation(){
        System.debug([SELECT Id, Name FROM Campaign ORDER BY Name DESC LIMIT 10]);
        System.debug([SELECT Id, Name FROM Campaign ORDER BY Name ASC LIMIT 10]);
    }
    public static void ContactManipulation(){
        System.debug([SELECT Id, Name, LastModifiedDate FROM Contact where LastModifiedDate = TODAY]);
        //Day9Assignments_Set3.StringManipulations('Welcome @pex Programming');
    }
}