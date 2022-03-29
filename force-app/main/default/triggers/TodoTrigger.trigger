trigger TodoTrigger on ToDo__c (before insert, before update, after update) {
    if (Trigger.isBefore && Trigger.isInsert) {
        TodoTriggerHandler.beforeInsert(Trigger.new);
    }

    if (Trigger.isBefore && Trigger.isUpdate) {
        TodoTriggerHandler.beforeUpdate(Trigger.new);
    }
    if (Trigger.isAfter && Trigger.isUpdate) {
        TodoTriggerHandler.afterUpdate(Trigger.new);
    }
}