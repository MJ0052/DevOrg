trigger AccountDeletion on Account (before delete) {
    System.debug('Trigger.New is  ' + Trigger.New);
    System.debug('Trigger.old is  ' + Trigger.old);
    
    for (Account a : [SELECT Id FROM Account WHERE Id IN (SELECT AccountId FROM Opportunity) AND Id IN :Trigger.old]) {
        Trigger.oldMap.get(a.Id).addError('Cannot delete account with related opportunities.');
        System.debug('Trigger oldmap - ' + Trigger.oldMap);
        System.debug('Trigger oldmap get Id - '+ Trigger.oldMap.get(a.Id));
    }
}