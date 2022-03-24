public with sharing class TodoTriggerHandler {
    public static void beforeInsert(List<Todo__c> newTodos) {
        TodoService.assignNewTodoToQueue(newTodos);
    }

    public static void beforeUpdate(List<Todo__c> todos) {
        TodoService.reAssignTodoToQueue(todos);
    }
}