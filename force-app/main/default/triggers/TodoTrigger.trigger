trigger TodoTrigger on ToDo__c (before insert,
                                before update,
                                after insert,
                                after delete,
                                after undelete) {


    if (Trigger.isBefore && Trigger.isInsert) {
        TodoTriggerHandler.beforeInsert(Trigger.new);
    }

    if (Trigger.isBefore && Trigger.isUpdate) {
        TodoTriggerHandler.beforeUpdate(Trigger.new);
    }

    if (Trigger.isInsert && Trigger.isAfter) {
        TodoTriggerHandler.onAfterInsert(Trigger.new);
    }

    if (Trigger.isUpdate && Trigger.isAfter) {
        TodoTriggerHandler.afterUpdate(Trigger.new);
    }

    if (Trigger.isDelete && Trigger.isAfter) {
        TodoTriggerHandler.onAfterDelete(Trigger.old);
    }
}