global class DailyLeadProcessor implements Schedulable {
	global void execute(SchedulableContext ctx) {
        List<Lead> leadList = new List<Lead>([Select Id,LeadSource from Lead where LeadSource = '' LIMIT 200]);
        List<Lead> leadToUpdate = new List<Lead>();
        for(Lead leadObj : leadList){
            leadObj.LeadSource = 'Dreamforce';
            leadToUpdate.add(leadObj);
        }
        update leadToUpdate;
    }
}