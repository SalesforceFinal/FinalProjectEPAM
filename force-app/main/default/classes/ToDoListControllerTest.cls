@isTest
private class ToDoListControllerTest {
    
    @IsTest
    static void testgetToDos() {
        ToDo__c todo = new ToDo__c(
                Name = 'Test01',
                Category__c = 'Later'
        );
        
        Test.setMock(HttpCalloutMock.class, new TodoHttpCalloutMock());
        Test.startTest();
       	insert todo;
        update todo;
        Test.stopTest();
        
        List<Todo__c> listTodos = ToDoListController.getItems();
        
        System.assertNotEquals(null, listTodos);
        System.assertEquals(1, listTodos.size());
        System.assertEquals('Later', listTodos.get(0).Category__c);
    }
    
    @IsTest
    static void searchTest(){
       ToDo__c todo = new ToDo__c(
                Name = 'test',
                Category__c = 'Later'
        );
        String searchKey = 'test';
        
        Test.setMock(HttpCalloutMock.class, new TodoHttpCalloutMock());
        Test.startTest();
       	insert todo;
        update todo;
        Test.stopTest();
        
        List<Todo__c> listTodos = ToDoListController.searchItems(searchKey);
        
        System.assertNotEquals(null, listTodos);
        System.assertEquals(1, listTodos.size());
        System.assertEquals('test', listTodos.get(0).Name);
        System.assertEquals('Later', listTodos.get(0).Category__c);
    }
   }