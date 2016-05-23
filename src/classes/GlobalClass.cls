global with sharing class GlobalClass
{
    webservice static string myMethod() 
    { 
         return 'Success';
    }
    webservice static string UserCopy(){
    	User userObj = new User();
    	userObj.FirstName = 'Mustafa';
    	return 'Success';
    }
   // global PageReference saveAndCongrat() {
      //	User congratsPage = new User();
      	//return congratsPage;
   // }
    global PageReference UserCopy1() {
        //PageReference orderPage = new PageReference('https://www.google.com');
        //orderPage.setRedirect(true);
        PageReference pgref = new PageReference('http://www.google.com');
        pgref.setRedirect(false);
        return pgref;
    }
}