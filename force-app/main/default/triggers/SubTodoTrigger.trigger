trigger SubTodoTrigger on Sub_ToDo__c ( after insert, 
                                        after update, 
                                        after delete, 
                                        after undelete) {

    if (Trigger.isInsert && Trigger.isAfter) {
        SubTodoTriggerHandler.onAfterInsert(Trigger.new);
    } else 

    if (Trigger.isUpdate && Trigger.isAfter) {
        SubTodoTriggerHandler.onAfterUpdate(Trigger.new);
        SubTodoTriggerHandler.afterUpdate(Trigger.new);
    } else 

    if (Trigger.isDelete && Trigger.isAfter) {
        SubTodoTriggerHandler.onAfterDelete(Trigger.old);
    }
}