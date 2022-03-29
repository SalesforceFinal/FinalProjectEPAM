@IsTest
private class SubTodoServiceTest {

    @IsTest
    static void testMarkTodoAsCompleted() {
        List<ToDo__c> testTodos = new List<ToDo__c>();
        List<Sub_ToDo__c> testSubTodos = new List<Sub_ToDo__c>();
        Map<Category, Id> recordTypes = TodoService.getRocordTypeIdByName();
        testTodos.addAll(TestDataFactory.todoCreator(10, recordTypes.get(Category.Today), true, Category.Today));
        testSubTodos.addAll(TestDataFactory.subTodoCreator(3, testTodos, true));
        for (Sub_ToDo__c subTodo : testSubTodos) {
            subTodo.isDone__c = true;
        }
        Test.startTest();
        update testSubTodos;
        Test.stopTest();
        List<ToDo__c> result = [
            SELECT Id, Status__c
            FROM ToDo__c
        ];
        for (ToDo__c todo : result) {
            System.assertEquals('Completed', todo.Status__c);
        }
    }

    @IsTest
    static void testCompletedOneSubTodo() {
        List<Sub_ToDo__c> testSubTodos = new List<Sub_ToDo__c>();
        Map<Category, Id> recordTypes = TodoService.getRocordTypeIdByName();
        ToDo__c testTodo = TestDataFactory.createOneTodo(recordTypes.get(Category.Today), true, Category.Today);
        testSubTodos.addAll(TestDataFactory.subTodoCreator(3, testTodo, true));
        testSubTodos[0].isDone__c = true;
        Test.startTest();
        update testSubTodos;
        Test.stopTest();
        ToDo__c resultTodo = [
            SELECT Id, Status__c
            FROM ToDo__c
            LIMIT 1
        ];
        System.assertEquals('Ready to Take', resultTodo.Status__c);
    }
}