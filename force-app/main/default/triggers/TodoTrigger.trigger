trigger TodoTrigger on Todo__c (before insert, before update) {
    if (Trigger.isBefore && Trigger.isInsert) {
        TodoTriggerHandler.beforeInsert(Trigger.new);
    }

    if (Trigger.isBefore && Trigger.isUpdate) {
        TodoTriggerHandler.beforeUpdate(Trigger.new);
    }
}