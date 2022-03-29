public with sharing class TodoService {
    public static void assignNewTodoToQueue(List<ToDo__c> newTodos) {
        Map<String, Id> queueMap = getQueueMap();
        for (ToDo__c todo : newTodos) {
            if (todo.Status__c == 'Ready to Take' || todo.Status__c == null) {
                todo.Status__c = 'Ready to Take';
                switch on Category.valueOf(todo.Category__c) {
                    when Today {
                        todo.OwnerId = queueMap.get('Today Queue');
                    }
                    when Tomorrow {
                        todo.OwnerId = queueMap.get('Tomorrow Queue');
                    }
                    when else {
                        todo.OwnerId = queueMap.get('Later Queue');
                    }
                }
            }
        }
    }

    public static void reAssignTodoToQueue(List<ToDo__c> todos) {
        Map<String, Id> queueMap = getQueueMap();
        List<Id> queueIds = queueMap.values();
        for (ToDo__c todo : todos) {
            if (queueIds.contains(todo.OwnerId)) {
                switch on Category.valueOf(todo.Category__c) {
                    when Today {
                        todo.OwnerId = queueMap.get('Today Queue');
                    }
                    when Tomorrow {
                        todo.OwnerId = queueMap.get('Tomorrow Queue');
                    }
                    when else {
                        todo.OwnerId = queueMap.get('Later Queue');
                    }
                }
            }
        }
    }

    public static void updateSubTodoIsdone(List<ToDo__c> todos) {
        List<ToDo__c> completedTodo = new List<ToDo__c>();
        List<Sub_ToDo__c> subTodoToUpdate = new List<Sub_ToDo__c>();
        for (ToDo__c todo : todos) {
            if (todo.Status__c == 'Completed') {
                completedTodo.add(todo);
            }
        }
        for (Sub_ToDo__c subTodo : [
            SELECT Id, isDone__c
            FROM Sub_ToDo__c
            WHERE ToDo__c IN :completedTodo
        ]) {
            subTodo.isDone__c = true;
            subTodoToUpdate.add(subTodo);
        }
        update subTodoToUpdate;
    }

    public static Map<Category, Id> getRocordTypeIdByName() {
        Map<Category, Id> recordTypes = new Map<Category, Id>();
        List<String> categoriesToString = new List<String>();
        Schema.DescribeSObjectResult describeTodoObject = Schema.SObjectType.ToDo__c;
        List<Schema.RecordTypeInfo> recordTypeInfos = describeTodoObject.getRecordTypeInfos();
        List<Category> categories = Category.values();
        for (Category category : categories) {
            categoriesToString.add(category.name());
        }
        for (Schema.RecordTypeInfo recordType : recordTypeInfos) {
            if (categoriesToString.contains(recordType.getName())) {
                recordTypes.put(Category.valueOf(recordType.getName()), recordType.getRecordTypeId());
            }
        }
        return recordTypes;
    }

    private static Map<String, Id> getQueueMap() {
        Map<String, Id> queueMap = new Map<String, Id>();
        List<Group> queues = [
            SELECT Id, Name
            FROM Group
            WHERE Type = 'Queue'
        ];
        for (Group queue : queues) {
            queueMap.put(queue.Name, queue.Id);
        }
        return queueMap;
    }

    public static Map<Category, Id> getRocordTypeIdByName() {
        Map<Category, Id> recordTypes = new Map<Category, Id>();
        List<String> categoriesToString = new List<String>();
        Schema.DescribeSObjectResult describeTodoObject = Schema.SObjectType.ToDo__c;
        List<Schema.RecordTypeInfo> recordTypeInfos = describeTodoObject.getRecordTypeInfos();
        List<Category> categories = Category.values();
        for (Category category : categories) {
            categoriesToString.add(category.name());
        }
        for (Schema.RecordTypeInfo recordType : recordTypeInfos) {
            if (categoriesToString.contains(recordType.getName())) {
                recordTypes.put(Category.valueOf(recordType.getName()), recordType.getRecordTypeId());
            }
        }
        return recordTypes;
    }
}