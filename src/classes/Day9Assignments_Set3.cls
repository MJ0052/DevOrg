public class Day9Assignments_Set3 {
    public static void ReverseTheString(string ToReverse){
        Integer length = 0;
        string reverse = '';
        length = ToReverse.length();
        
        for (Integer i = length - 1; i >= 0; i-- ){
        	reverse = reverse + ToReverse.substring(i,i+1);
        }
        System.debug('Reverse of string '+ToReverse+ ' is - ' + reverse);
    }
    public static void StringManipulations(string Data){
        Data = Data.replace('@', 'A');
        Integer indexOfString =  Data.indexOf('Apex Programming');
        System.debug('After replacing @ with A, result is - ' + Data);
        System.debug('Printing specific string - ' + Data.substring(indexOfString, Data.length()));
        
        System.debug('After splitting the string using space result is - ' + Data.split(' '));
        //Data.deleteWhitespace()         
        System.debug('After removing space from the string - ' + Data.deleteWhitespace());
        
        System.debug('In Upper Case - ' + Data.toUpperCase());
        
        System.debug('In Lower Case - ' + Data.toLowerCase());
        
        string[] someChar = Data.split('');
        String toCompare = '';
        Integer count = 0;
         for(Integer i = 0; i< someChar.size();i++){
             toCompare = Data.substring(0,i);
             if(toCompare.contains(someChar[i])){continue;}
                 count = 0;
            for(Integer j = i; j< someChar.size();j++)
            {
                if(someChar[i] == someChar[j])
                   {count++;}
                   
            }
             if(count > 0){
                        System.debug('Occurence of ' + someChar[i] + ' found  ' + count + ' times');
             }
             
        }
    }
    public void NonStaticMethod(){
        System.debug('Hello World!...');
    }
    public static void QueryOnAccount(){
        List<Account> accountList = new List<Account>([SELECT Id,Name FROM Account]);
        List<Contact> contactList = new List<Contact>([SELECT Id,Name,AccountId FROM Contact]);
        for(Account aObj : accountList){
            System.debug('Account Details - ' + aObj);
            for(Contact cObj : contactList){
                if(cObj.AccountId == aObj.Id){
                    System.debug('Contact Details for account '+ aObj.Name +' - ' + cObj);
                }
            }
        }
    }
    public static void CreatingRecordUsingDML(){
        Account accountObj = new Account(Name='Automated Account');
        insert accountObj;
        System.debug('Account inserted');
        Contact contactObj = new Contact(FirstName='Automated',LastName='Contact',AccountId=accountObj.Id);
        insert contactObj;
        System.debug('Contact inserted');
        Lead leadObj = new Lead(FirstName = 'Automated',LastName = 'Lead',Status='Working - Contacted',Company='Auto');
        insert leadObj;
        System.debug('Lead inserted');
        Opportunity oppObj = new Opportunity(Name='Auto Opportunity',CloseDate=Date.today(),StageName='Prospecting');
        insert oppObj;
        System.debug('Opportunity inserted');
    }
}