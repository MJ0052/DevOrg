public class Email {
    public static void SendEMail(Map<String,String> emailMap){
    	List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
    	Messaging.SingleEmailMessage mail;
    	for(String email:emailMap.keySet()){ 
    		System.debug(emailMap.get(email));
    		if (email != null && emailMap.get(email) != null) {
    			mail = new Messaging.SingleEmailMessage();
    			List<String> sendTo = new List<String>();
      			sendTo.add(email);
      			mail.setToAddresses(sendTo);
      			mail.setReplyTo('mustafa.jhabuawala@extrapreneursindia.com');
      			mail.setSenderDisplayName('Zen4orce');
      			mail.setSubject('Zen4orce - Opportunity Notification');
      			String body = 'Dear ' + emailMap.get(email) + ', ';
      			mail.setHtmlBody(body);
      			mails.add(mail);
    		}
    	}
  		Messaging.sendEmail(mails);
   }
    public static void SendSingleEMail(String email,String subject, String body){
    	List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
    	Messaging.SingleEmailMessage mail;
    	if (email != null) {
    		mail = new Messaging.SingleEmailMessage();
    		List<String> sendTo = new List<String>();
      		sendTo.add(email);
      		mail.setToAddresses(sendTo);
      		mail.setReplyTo('mustafa.jhabuawala@extrapreneursindia.com');
      		mail.setSenderDisplayName('Zen4orce');
      		mail.setSubject(subject);
      		String mailBody = 'Dear User\n' + body + ', ';
      		mail.setHtmlBody(mailBody);
      		mails.add(mail);
    		}
    	
  		Messaging.sendEmail(mails);
   }
}