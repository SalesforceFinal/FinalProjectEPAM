public with sharing class CleanOldTodosBatch implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext BC) {
        Todo_Setting__mdt month = [
            SELECT Id, Months_For_Storing_Tasks__c, Label
            FROM Todo_Setting__mdt
            LIMIT 1
        ];
        DateTime  today = DateTime.now();
        DateTime  deletionDate = today.addMonths(-Integer.valueOf(month.Months_For_Storing_Tasks__c));
        return Database.getQueryLocator ('SELECT Id, Name FROM ToDo__c ' +
            'WHERE (Status__c = \'Completed\' OR Status__c = \'Failed\') AND CreatedDate <= :deletionDate');
    }

    public void execute(Database.BatchableContext BC, List<ToDo__c> todos) {
        delete todos;
    }

    public void finish(Database.BatchableContext BC) {
    }
}