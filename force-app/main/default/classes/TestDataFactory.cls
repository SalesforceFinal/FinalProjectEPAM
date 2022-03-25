@IsTest
public class TestDataFactory {
    public static List<ToDo__c> todoCreator (Integer amount, Id recordTypeId, Boolean needInsert, Category category) {
        List<ToDo__c> testTodos = new List<ToDo__c>();
        for (Integer i = 0; i < amount; i++) {
            testTodos.add(new ToDo__c(
                Name = 'Test Todo ' + i,
                RecordTypeId = recordTypeId,
                Category__c = category.name()
            ));
        }
        if (needInsert) {
            insert testTodos;
        }
        return testTodos;
    }

    public static Map<Category, Id> getRocordTypeIdByName() {
        Map<Category, Id> recordTypes = new Map<Category, Id>();
        Schema.DescribeSObjectResult describeTodoObject = Schema.SObjectType.ToDo__c;
        Map<String, Schema.RecordTypeInfo> recordTypeMapByName = describeTodoObject.getRecordTypeInfosByName();
        Schema.RecordTypeInfo todayRecordTypeByName =  recordTypeMapByName.get(Category.Today.name());
        Id todayRecordTypeId = todayRecordTypeByName.getRecordTypeId();
        Schema.RecordTypeInfo tomorrowRecordTypeByName =  recordTypeMapByName.get(Category.Tomorrow.name());
        Id tomorrowRecordTypeId = tomorrowRecordTypeByName.getRecordTypeId();
        Schema.RecordTypeInfo laterRecordTypeByName =  recordTypeMapByName.get(Category.Later.name());
        Id laterRecordTypeId = laterRecordTypeByName.getRecordTypeId();
        recordTypes.put(Category.Today, todayRecordTypeId);
        recordTypes.put(Category.Tomorrow, tomorrowRecordTypeId);
        recordTypes.put(Category.Later, laterRecordTypeId);
        return recordTypes;
    }
}