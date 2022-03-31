trigger SubTodoTrigger on Sub_ToDo__c ( after insert, 
                                        after update, 
                                        after delete, 
                                        after undelete) {

    if (Trigger.isInsert && Trigger.isAfter) {
        SubTodoTriggerHandler.onAfterInsert(Trigger.new);
    }

    if (Trigger.isUpdate && Trigger.isAfter) {
        SubTodoTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
    }

    if (Trigger.isDelete && Trigger.isAfter) {
        SubTodoTriggerHandler.onAfterDelete(Trigger.old);
    }
}