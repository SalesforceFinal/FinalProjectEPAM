@IsTest
private class ChangeCategoryBatchTest {
    @IsTest
    static void testChangeCategory() {
        List<ToDo__c> testTodos = new List<ToDo__c>();
        Map<Category, Id> recordTypes = TodoService.getRocordTypeIdByName();
        testTodos.addAll(TestDataFactory.todoCreator(50, recordTypes.get(Category.Today), true, Category.Today));
        for (ToDo__c todo : testTodos) {
            todo.Status__c = 'Completed';
        }
        update testTodos;
        testTodos.addAll(TestDataFactory.todoCreator(50, recordTypes.get(Category.Tomorrow), true, Category.Tomorrow));
        testTodos.addAll(TestDataFactory.todoCreator(50, recordTypes.get(Category.Today), true, Category.Today));
        Test.startTest();
        ChangeCategoryBatch batch = new ChangeCategoryBatch();
        Database.executeBatch(batch);
        Test.stopTest();
        List<ToDo__c> tomorrowTodos = new List<ToDo__c>();
        List<ToDo__c> todayFailedTodos = new List<ToDo__c>();
        List<ToDo__c> todayCompletedTodos = new List<ToDo__c>();
        for (ToDo__c todo : [SELECT Id, Category__c, Status__c FROM ToDo__c]) {
            if (todo.Category__c == 'Tomorrow') {
                tomorrowTodos.add(todo);
            }
            if (todo.Category__c == 'Today' && todo.Status__c == 'Failed') {
                todayFailedTodos.add(todo);
            }
            if (todo.Category__c == 'Today' && todo.Status__c == 'Completed') {
                todayCompletedTodos.add(todo);
            }
        }
        System.assertEquals(0, tomorrowTodos.size());
        System.assertEquals(50, todayFailedTodos.size());
        System.assertEquals(50, todayCompletedTodos.size());
    }
}