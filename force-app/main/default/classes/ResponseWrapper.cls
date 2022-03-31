public with sharing class ResponseWrapper {
    public String id {get; set;}
    public String name { get; set; }
    public String descriprion { get; set; }
    public String category { get; set; }
    public String priority { get; set; }
    public String status { get; set; }
    public String externalId { get; set; }
    public String rectypeName { get; set; }
    public String owner { get; set; }
    

    public static ResponseWrapper doingMapping(ToDo__c todo) {
        ResponseWrapper wrapper = new ResponseWrapper();
        wrapper.id = todo.Id;
        wrapper.name = todo.Name;
        wrapper.owner = todo.OwnerId;
        wrapper.category = todo.Category__c;
        wrapper.priority = todo.Priority__c;
        wrapper.status = todo.Status__c;
        wrapper.externalId = todo.ExternalId__c;
        wrapper.rectypeName = [
                                SELECT Name 
                                FROM RecordType 
                                WHERE Id =: todo.RecordTypeId
            ].Name;
        return wrapper;
    }

    public static List<ResponseWrapper> doingMapperToWrappers(List<ToDo__c> todos) {
        List<ResponseWrapper> wrappers = new List<ResponseWrapper>();

        for(ToDo__c todo: todos) {
            ResponseWrapper wrapper = doingMapping(todo);
            wrappers.add(wrapper);
        }
        return wrappers;
    }
}