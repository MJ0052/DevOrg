//trigger HelloWorldTrigger on Account (after insert) {
    //System.debug('New World!');
    //System.debug(Trigger.New);
//}
trigger ContextExampleTrigger on Account (before insert, after insert, after delete) {
    if (Trigger.isInsert) {
        if (Trigger.isBefore) {
            System.debug('Process before insert');
        } else if (Trigger.isAfter) {
            System.debug('Process after insert');
        }        
    }
    else if (Trigger.isDelete) {
        System.debug('Process after delete');
    }
}