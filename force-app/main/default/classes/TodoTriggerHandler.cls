public with sharing class TodoTriggerHandler {
    public static void beforeInsert(List<ToDo__c> newTodos) {
        TodoService.assignNewTodoToQueue(newTodos);
    }

    public static void beforeUpdate(List<ToDo__c> todos) {
        TodoService.reAssignTodoToQueue(todos);
    }
}