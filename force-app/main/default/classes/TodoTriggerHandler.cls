public with sharing class TodoTriggerHandler {
    public static Boolean isFirstTime = true;
    public static void beforeInsert(List<ToDo__c> newTodos) {
        TodoService.assignNewTodoToQueue(newTodos);
    }

    public static void beforeUpdate(List<ToDo__c> todos) {
        TodoService.reAssignTodoToQueue(todos);
    }
    public static void afterUpdate(List<ToDo__c> todos) {
        if (isFirstTime) {
            isFirstTime = false;
            TodoService.updateSubTodoIsdone(todos);
        }
    }
}