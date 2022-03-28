public with sharing class ChangeCategoryBatch implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator ('SELECT Id, Category__c, RecordTypeId FROM ToDo__c ' +
            'WHERE Status__c != \'Completed\' AND Status__c != \'Failed\'');
    }

    public void execute(Database.BatchableContext BC, List<ToDo__c> todos) {
        Map<Category, Id> recordTypes = TodoService.getRocordTypeIdByName();
        List<ToDo__c> todosToUpdate = new List<ToDo__c>();
        for (ToDo__c todo : todos) {
            if (todo.Category__c == 'Today') {
                todo.Status__c = 'Failed';
                todosToUpdate.add(todo);
            }
            if (todo.Category__c == 'Tomorrow') {
                todo.RecordTypeId = recordTypes.get(Category.Today);
                todo.Category__c = 'Today';
                todosToUpdate.add(todo);
            }
        }
        update todosToUpdate;
    }

    public void finish(Database.BatchableContext BC) {
    }

}