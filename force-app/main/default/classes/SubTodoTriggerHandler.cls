public with sharing class SubTodoTriggerHandler {
    public static Boolean isFirstTime = true;

    public static void afterUpdate(List<Sub_ToDo__c> subTodos, Map<Id, Sub_ToDo__c> subTodoOldMap) {
        List<Sub_ToDo__c> isDoneSubTodos = new List<Sub_ToDo__c>();
        for (Sub_ToDo__c subTodo : subTodos) {
            if (subTodo.isDone__c &&  subTodoOldMap.get(subTodo.Id).isDone__c != subTodo.isDone__c) {
                isDoneSubTodos.add(subTodo);
            }
        }
        if (isFirstTime) {
            isFirstTime = false;
            SubTodoService.markTodoAsCompleted(isDoneSubTodos);
        }
        if (!Test.isRunningTest()) {
            SubTodoTriggerHelper.pushUpdated(subTodos);
        }
    }

    public static void onAfterInsert(List<Sub_ToDo__c> subs) {
        if (!Test.isRunningTest()) {
            SubTodoTriggerHelper.pushInserted(subs);
        }
    }

    public static void onAfterDelete(List<Sub_ToDo__c> subs) {
        if (!Test.isRunningTest()) {
            SubTodoTriggerHelper.pushDeleted(subs);
        }
    }
}