@IsTest
private class CleanOldTodosBatchTest {
    @IsTest
    static void testDeleteTodo() {
        List<ToDo__c> testTodos = new List<ToDo__c>();
        Map<Category, Id> recordTypes = TodoService.getRocordTypeIdByName();
        testTodos.addAll(TestDataFactory.todoCreator(100, recordTypes.get(Category.Today), true, Category.Today));
        for (ToDo__c todo : testTodos) {
            todo.Status__c = 'Completed';
            Test.setCreatedDate(todo.Id, DateTime.newInstance(2020,12,12));
        }
        update testTodos;
        testTodos.addAll(TestDataFactory.todoCreator(100, recordTypes.get(Category.Today), true, Category.Today));
        Test.startTest();
        CleanOldTodosBatch batch = new CleanOldTodosBatch();
        Database.executeBatch(batch);
        Test.stopTest();
        System.assertEquals(100, [SELECT COUNT() FROM ToDo__c]);
    }
}