public with sharing class ToDoListController {

    @AuraEnabled(Cacheable=true)
    public static List<ToDo__c> getItems() {
        return [
            SELECT Name, Description__c, Creation_Date__c, Category__c, Priority__c, Status__c,
                (
                    SELECT Name, isDone__c, ToDo__c
                    FROM Sub_ToDos__r
                    ORDER BY isDone__c
                )
            FROM ToDo__c
            ORDER BY Category__c
            LIMIT 5
        ];
    }

    @AuraEnabled
    public static String setRecordTypeId() {
        Map<String, Id> mapRecordType = new Map<String, Id>();
        List<String> recordTypeName = new List<String>{
                'Today',
                'Tomorrow',
                'Later'
        };

        for (String recType : recordTypeName) {
            mapRecordType.put(recType, Schema.SObjectType.ToDo__c.getRecordTypeInfosByName()
                    .get(recType).getRecordTypeId());
        }
        System.debug('Id for record types Todo__c = ' + mapRecordType.keySet());
        System.debug(mapRecordType);
        return JSON.serialize(mapRecordType);
    }
    

    @AuraEnabled(Cacheable=true)
    public static List<ToDo__c> searchItems(string searchKey) {
        return [
            SELECT Name, Description__c, Creation_Date__c, Category__c, Priority__c, Status__c
            FROM ToDo__c
            WHERE Name LIKE : '%' + searchKey + '%'
            OR Category__c LIKE : '%' + searchKey + '%'
            OR Status__c LIKE : '%' + searchKey + '%'
            ORDER BY Category__c
        ];
    }

    @AuraEnabled()
    public static void updateOwner(String idOwner, String recordId) {
        ToDo__c todo = new ToDo__c(Id = recordId, OwnerId = idOwner);
        update todo;
    }

}