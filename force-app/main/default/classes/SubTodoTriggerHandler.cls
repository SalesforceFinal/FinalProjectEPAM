public with sharing class SubTodoTriggerHandler {
    public static void afterUpdate(List<Sub_ToDo__c> subTodos) {
        SubTodoService.markTodoAsCompleted(subTodos);
    }
}