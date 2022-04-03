public with sharing class TodoTriggerHandler {
    public static Boolean isFirstTime = true;
    public static void beforeInsert(List<ToDo__c> newTodos) {
        TodoService.assignNewTodoToQueue(newTodos);
    }

    public static void onAfterInsert(List<ToDo__c> todos) {
        if (!Test.isRunningTest()) {
            TodoTriggerHelper.pushInsert(todos);
        }
    }

    public static void beforeUpdate(List<ToDo__c> newTodos, Map<Id, ToDo__c> oldTodosMap) {
        List<ToDo__c> changedOwnerTodo = new List<ToDo__c>();
        TodoService.reAssignTodoToQueue(newTodos);
        for (ToDo__c todo : newTodos) {
            if (todo.OwnerId != oldTodosMap.get(todo.Id).OwnerId) {
                changedOwnerTodo.add(todo);
            }
        }
        TodoService.changeStatusAfterAssignToUser(changedOwnerTodo);
    }

    public static void afterUpdate(List<ToDo__c> todos) {
        if (isFirstTime) {
            isFirstTime = false;
            TodoService.updateSubTodoIsdone(todos);
            if (!Test.isRunningTest()) {
                TodoTriggerHelper.pushUpdated(todos);
            }
        }
    }

    public static void onAfterDelete(List<ToDo__c> todos) {
        if (!System.isFuture() && !System.isBatch() && !Test.isRunningTest()) {
        	TodoTriggerHelper.pushDeleted(todos);
        }
    }
}