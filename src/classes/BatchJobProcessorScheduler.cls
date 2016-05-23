global class BatchJobProcessorScheduler implements Schedulable {
	global void execute(SchedulableContext ctx) {
        Id batchId = Database.executeBatch(new BatchJobProcessor());
    }
}