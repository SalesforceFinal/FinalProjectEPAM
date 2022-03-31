@isTest
global class SubHttpCalloutMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json;charset=UTF-8');
        response.setBody('{"relatedExternal":"a010900000obuFnAAI"}');
        response.setStatusCode(200);
        return response;
    }
}