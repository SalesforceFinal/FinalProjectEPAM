public with sharing class TodoTriggerHelper {

    public static Http http = new Http();
    public static HttpRequest request;
    public static HttpResponse response;
    public static final String URL_TODO = 'callout:sForceIntegration/services/apexrest/ToDo__c'; 

    @Future(callout = true)
    public static void doingRequest(String contentBody, String httpMethod) {
        request = new HttpRequest();
        request.setMethod(httpMethod);
        request.setEndpoint(URL_TODO);
        request.setHeader('Content-Type', 'application/json');
        request.setBody(contentBody);
        response = http.send(request);
        System.debug(response.getBody());
        System.debug(contentBody);
    }

    public static void pushInsert(List<ToDo__c> todos) {
        List<responseWrapper> wrappers = ResponseWrapper.doingMapperToWrappers(todos);
        doingRequest(JSON.serialize(wrappers), 'POST');
    }

    public static void pushUpdated(List<ToDo__c> todos) {
        List<ResponseWrapper> wrappers = ResponseWrapper.doingMapperToWrappers(todos);
        doingRequest(JSON.serialize(wrappers), 'PUT');
    }

    public static void pushDeleted(List<ToDo__c> todos) {
        List<ResponseWrapper> wrappers = ResponseWrapper.doingMapperToWrappers(todos);
        doingRequest(JSON.serialize(wrappers), 'DELETE');
    }
}