public with sharing class SubTodoTriggerHandler {


    public static void afterUpdate(List<Sub_ToDo__c> subTodos) {
        SubTodoService.markTodoAsCompleted(subTodos);
    }

    public static Boolean isFirstTime = true;
    public static void afterUpdate(List<Sub_ToDo__c> subTodos, Map<Id, Sub_ToDo__c> subTodoOldMap) {
      SubTodoTriggerHelper.pushUpdated(subTodos);
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
      SubTodoTriggerHelper.pushUpdated(subTodos);

    }

    public static void onAfterInsert(List<Sub_ToDo__c> subs) {
        SubTodoTriggerHelper.pushInserted(subs);
    }

    public static void onAfterDelete(List<Sub_ToDo__c> subs) {
        SubTodoTriggerHelper.pushDeleted(subs);
    }
}