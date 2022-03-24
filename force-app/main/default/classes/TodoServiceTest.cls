@IsTest
private class TodoServiceTest {

    @IsTest
    static void testAssignNewTodoToQueue() {
        List<Todo__c> testTodos = new List<Todo__c>();
        Map<Category, Id> recordTypes = TestDataFactory.getRocordTypeIdByName();
        testTodos.addAll(TestDataFactory.todoCreator(10, recordTypes.get(Category.Today), false, Category.Today));
        testTodos.addAll(TestDataFactory.todoCreator(10, recordTypes.get(Category.Tomorrow), false, Category.Tomorrow));
        testTodos.addAll(TestDataFactory.todoCreator(10, recordTypes.get(Category.Later), false, Category.Later));
        Test.startTest();
        insert testTodos;
        Test.stopTest();
        List<Todo__c> insertedTodos = [
            SELECT Id, OwnerId, Name, Category__c, Status__c
            FROM ToDo__c
        ];
        List<Group> queues = [
            SELECT Id, Name
            FROM Group
            WHERE Type = 'Queue'
        ];
        List<Id> queuesIds = new List<Id>();
        for (Group queue : queues) {
            queuesIds.add(queue.Id);
        }
        for (Todo__c todo : insertedTodos) {
            System.assertEquals(true, queuesIds.contains(todo.OwnerId));
            System.assertEquals('Ready to Take', todo.Status__c);
        }
        System.assertEquals(testTodos.size(), insertedTodos.size());
        System.assertEquals(30, testTodos.size());
    }

    @IsTest
    static void testReAssignTodoToQueue() {
        Map<String, Id> queueMap = new Map<String, Id>();
        Map<Category, Id> recordTypes = TestDataFactory.getRocordTypeIdByName();
        List<Todo__c> testTodosToday = TestDataFactory.todoCreator(50, recordTypes.get(Category.Today), true, Category.Today);
        List<Todo__c> testTodosTomorrow = TestDataFactory.todoCreator(50, recordTypes.get(Category.Tomorrow), true, Category.Tomorrow);
        List<Todo__c> testTodosLater = TestDataFactory.todoCreator(50, recordTypes.get(Category.Later), true, Category.Later);
        List<Todo__c> testTodos = new List<Todo__c>();
        for (Todo__c todo : testTodosToday) {
            todo.RecordTypeId = recordTypes.get(Category.Later);
            todo.Category__c = Category.Later.name();
        }
        for (Todo__c todo : testTodosTomorrow) {
            todo.RecordTypeId = recordTypes.get(Category.Today);
            todo.Category__c = Category.Today.name();
        }
        for (Todo__c todo : testTodosLater) {
            todo.RecordTypeId = recordTypes.get(Category.Tomorrow);
            todo.Category__c = Category.Tomorrow.name();
        }
        testTodos.addAll(testTodosToday);
        testTodos.addAll(testTodosTomorrow);
        testTodos.addAll(testTodosLater);
        Test.startTest();
        update testTodos;
        Test.stopTest();
        List<Todo__c> insertedTodos = [
            SELECT Id, OwnerId, Name, Category__c, Status__c
            FROM ToDo__c
        ];
        List<Group> queues = [
            SELECT Id, Name
            FROM Group
            WHERE Type = 'Queue'
        ];
        for (Group queue : queues) {
            queueMap.put(queue.Name, queue.Id);
        }
        for (Todo__c todo : insertedTodos) {
            System.assertEquals(queueMap.get(todo.Category__c + ' Queue'), todo.OwnerId);
        }
    }
}