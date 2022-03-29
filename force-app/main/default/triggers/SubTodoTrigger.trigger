trigger SubTodoTrigger on Sub_ToDo__c (after update) {
    if (Trigger.isAfter && Trigger.isUpdate) {
        SubTodoTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
    }
}