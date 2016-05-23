trigger ChatterFeedForOpportunity on Opportunity (after insert, after update) {
    List<FeedItem> feedItems = new List<FeedItem>();
   
    Set<ID> ownerIds = new Set<ID>();
    for (Opportunity t : Trigger.new) {
    	ownerIds.add(t.ownerId);
    }
    
    Map<ID,User> userMap = new Map<ID,User>([SELECT ID, Name FROM User WHERE ID IN :ownerIds]);

    Opportunity oldOpp = new Opportunity();
    Boolean flag = true;
    
    for(Opportunity oppObj: trigger.new){
        if(Trigger.IsUpdate){
            oldOpp = Trigger.oldMap.get(oppObj.Id);
            if(oppObj.StageName == oldOpp.StageName){
                flag = false;
            }
            else{
                flag = true;
            }
        }
        else{
            flag = true;
        }
        if(flag && oppObj.StageName == 'Closed Won'){
            FeedItem fObj = new FeedItem();
            fObj.type = 'LinkPost';
            fObj.ParentId = oppObj.Id;
            fObj.LinkUrl = '/' + oppObj.id; 
            fObj.Title = 'View';  
            
            User assignedTo = userMap.get(oppObj.ownerId);

            fObj.Body = ((Trigger.isInsert) ? 'New' : 'Updated') 
                        + '\nAssigned To: ' + ((assignedTo != null) ? assignedTo.name : 'Unknown')
                        + '\nStatus: ' + oppObj.StageName;

            feedItems.add(fObj);
        }
    }
    
    if (feedItems.size() > 0) {
        Database.insert(feedItems,false);
    }
}