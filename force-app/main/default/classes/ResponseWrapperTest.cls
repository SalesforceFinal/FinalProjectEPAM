@IsTest
private class ResponseWrapperTest {
    public static ToDo__c todo = new ToDo__c(
        Name = 'Test01',
        ExternalId__c = 'a010900000nVG0NAAW',
        RecordTypeId = '012090000006M9QAAU',
        Status__c = 'Failed'
    );

    @IsTest
    static void testDoingMapping() {
        ResponseWrapper wrapper = new ResponseWrapper();
        wrapper.id = todo.Id;
        wrapper.name = todo.Name;
        wrapper.category = todo.Category__c;
        wrapper.descriprion = todo.Description__c;
        wrapper.priority = todo.Priority__c;
        wrapper.status = todo.Status__c;
        wrapper.externalId = todo.ExternalId__c;
        wrapper.rectypeName = [
            SELECT Name 
            FROM RecordType 
            WHERE Name =: todo.Name
        ].Name;
        System.debug('wrapper: ' + wrapper);

        Test.startTest();
        ResponseWrapper newWrapper = ResponseWrapper.doingMapping(todo);
        Test.stopTest();
        System.debug('new Wrapper ' + newWrapper);

        System.assertEquals(wrapper.id, newWrapper.id);
        System.assertEquals(wrapper.name, newWrapper.name);
        System.assertEquals(wrapper.status, newWrapper.status);
    }

    @IsTest
    static void testdoingMapperToWrappers() {
        ResponseWrapper wrapper = new ResponseWrapper();
        wrapper.id = todo.Id;
        wrapper.name = todo.Name;
        wrapper.status = todo.Status__c;
        wrapper.externalId = todo.ExternalId__c;

        List<ToDo__c> todos = new List<ToDo__c>();
        todos.add(todo);
        System.debug('todos: ' + todos);

        Test.startTest();
        List<ResponseWrapper> wrappers = ResponseWrapper.doingMapperToWrappers(todos);
        Test.stopTest();
        System.debug('wrappers: ' + wrappers);

        for (ResponseWrapper newWrapper : wrappers) {
            System.assertEquals(wrapper.id, newWrapper.id);
            System.assertEquals(wrapper.name, newWrapper.name);
            System.assertEquals(wrapper.status, newWrapper.status);
        }
    }
}