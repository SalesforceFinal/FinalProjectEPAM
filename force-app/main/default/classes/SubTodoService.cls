public with sharing class SubTodoService {
    public static void markTodoAsCompleted(List<Sub_ToDo__c> subTodos) {
        List<ToDo__c> todoToUpdate = new List<ToDo__c>();
        Set<Id> todoIds = new Set<Id>();
        for (Sub_ToDo__c subTodo : subTodos) {
            todoIds.add(subTodo.ToDo__c);
        }
        for (Sub_ToDo__c subTodo : [
            SELECT Id, Name, ToDo__c, isDone__c, ToDo__r.Status__c
            FROM Sub_ToDo__c
            WHERE ToDo__c IN :todoIds
            AND (isDone__c = false
            OR ToDo__r.Status__c = 'Completed')
        ]) {
            if (todoIds.contains(subTodo.ToDo__c) || subTodo.ToDo__r.Status__c == 'Completed') {
                todoIds.remove(subTodo.ToDo__c);
            }
        }
        for (Id todoId : todoIds) {
            todoToUpdate.add(new ToDo__c(
                Id = todoId,
                Status__c = 'Completed'
            ));
        }
        update todoToUpdate;
    }
}