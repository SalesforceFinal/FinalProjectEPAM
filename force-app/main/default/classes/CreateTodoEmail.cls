global class CreateTodoEmail implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, Messaging.InboundEnvelope envelop) {
        ToDo__c todo;
        Id recordTypeId;
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        String myBody = email.plainTextBody;
        String todoName = email.Subject;
		String todoDescription = email.plainTextBody;
        if (myBody.containsIgnoreCase(Category.Today.name())) {
            recordTypeId = getRocordTypeIdByName(Category.Today.name());
            todo = new ToDo__c(Name = todoName, Description__c = todoDescription, Category__c = Category.Today.name(), RecordTypeId = recordTypeId);
        } else if (myBody.containsIgnoreCase(Category.Tomorrow.name())) {
            recordTypeId = getRocordTypeIdByName(Category.Tomorrow.name());
            todo = new ToDo__c(Name = todoName, Description__c = todoDescription, Category__c = Category.Tomorrow.name(), RecordTypeId = recordTypeId);
        } else {
            recordTypeId = getRocordTypeIdByName(Category.Later.name());
            todo = new ToDo__c(Name = todoName, Description__c = todoDescription, Category__c = Category.Later.name(), RecordTypeId = recordTypeId);
        }
		insert todo;
		return result;
    }

    private static Id getRocordTypeIdByName(String name) {
        Schema.DescribeSObjectResult describeTodoObject = Schema.SObjectType.ToDo__c;
        Map<String, Schema.RecordTypeInfo> recordTypeMapByName = describeTodoObject.getRecordTypeInfosByName();
        Schema.RecordTypeInfo recordTypeByName =  recordTypeMapByName.get(name);
        Id recordTypeId = recordTypeByName.getRecordTypeId();
        return recordTypeId;
    }
}