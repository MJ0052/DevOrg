trigger InsertAccountOpportunities on Account(after insert, after update) {
    //if(Trigger.isAfter)
    //{
        //System.debug('Is after trigger');
        //if(Trigger.isInsert){
            //System.debug('Is insert trigger');
        //}
    //}
     
    for(Account a : Trigger.New) {
        Opportunity oppObj = new Opportunity(Name='Trigger Opportunity ' + a.Name ,CloseDate=Date.today(),StageName='Prospecting',AccountId=a.Id);
        insert oppObj;
        System.debug('Opportunity inserted for a.Id ' + a.Id + ' Opportunity id is ' + oppObj.Id);
    }
    
    List<Opportunity> oppList = new List<Opportunity>();
    System.debug('Printing trigger.new' + Trigger.New);
    Map<Id,Account> acctsWithOpps = new Map<Id,Account>([SELECT Id,(SELECT Id FROM Opportunities) FROM Account WHERE Id IN :Trigger.New]);
    System.debug('Printing Map' + acctsWithOpps);
    
    for(Account a : Trigger.New) {
        System.debug('acctsWithOpps.get(a.Id).Opportunities.size()=' + acctsWithOpps.get(a.Id).Opportunities.size());
        System.debug('acctsWithOpps.get(a.Id).Opportunities' + acctsWithOpps.get(a.Id).Opportunities);
        
        if (acctsWithOpps.get(a.Id).Opportunities.size() == 0) {
            oppList.add(new Opportunity(Name=a.Name + ' Opportunity',
                                       StageName='Prospecting',
                                       CloseDate=System.today().addMonths(1),
                                       AccountId=a.Id));
        }           
    }

    if (oppList.size() > 0) {
        insert oppList;
    }
}