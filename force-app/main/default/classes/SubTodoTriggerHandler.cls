public with sharing class SubTodoTriggerHandler {

    public static void afterUpdate(List<Sub_ToDo__c> subTodos) {
        SubTodoService.markTodoAsCompleted(subTodos);
    }

    public static void onAfterInsert(List<Sub_ToDo__c> subs) {
        SubTodoTriggerHelper.pushInserted(subs);
    }

    public static void onAfterUpdate(List<Sub_ToDo__c> subs) {
        SubTodoTriggerHelper.pushUpdated(subs);
    }

    public static void onAfterDelete(List<Sub_ToDo__c> subs) {
        SubTodoTriggerHelper.pushDeleted(subs);
    }
}