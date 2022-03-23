global class CreateTodoEmail implements Messaging.InboundEmailHandler {
    private static final String today = 'Today';
    private static final String tomorrow = 'Tomorrow';
    private static final String later = 'Later';

    global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, Messaging.InboundEnvelope envelop) {
        Todo__c todo;
        Id recordTypeId;
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        String myBody = email.plainTextBody;
        String todoName = email.Subject;
		String todoDescription = email.plainTextBody;
        if (myBody.containsIgnoreCase(today)) {
            recordTypeId = getRocordTypeIdByName(today);
            todo = new Todo__c(Name = todoName, Description__c = todoDescription, Category__c = today, RecordTypeId = recordTypeId);
        } else if (myBody.containsIgnoreCase(tomorrow)) {
            recordTypeId = getRocordTypeIdByName(tomorrow);
            todo = new Todo__c(Name = todoName, Description__c = todoDescription, Category__c = tomorrow, RecordTypeId = recordTypeId);
        } else {
            recordTypeId = getRocordTypeIdByName(later);
            todo = new Todo__c(Name = todoName, Description__c = todoDescription, Category__c = later, RecordTypeId = recordTypeId);
        }
		insert todo;
		return result;
    }

    private static Id getRocordTypeIdByName(String name) {
        Schema.DescribeSObjectResult describeTodoObject = Schema.SObjectType.Todo__c;
        Map<String, Schema.RecordTypeInfo> recordTypeMapByName = describeTodoObject.getRecordTypeInfosByName();
        Schema.RecordTypeInfo recordTypeByName =  recordTypeMapByName.get(name);
        Id recordTypeId = recordTypeByName.getRecordTypeId();
        return recordTypeId;
    }
}