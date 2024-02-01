@isTest
public class HttpSwaggerMockclass implements HttpCalloutMock{
    public String body;
    public HttpSwaggerMockclass(String body){
        this.body = body;
    }
    public HTTPResponse respond(HTTPRequest req){
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        String json = body;
        res.setBody(json);
        res.setStatusCode(200);
        return res;
    }
}