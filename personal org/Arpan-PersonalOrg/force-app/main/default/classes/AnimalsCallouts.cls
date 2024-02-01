public class AnimalsCallouts {
    Public static HttpResponse makeGetCallout(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        system.debug('response : '+ response );
        //if the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200){
            Map<String,Object> result = (Map<String, object>) JSON.deserializeUntyped(response.getBody());
            List<object> animals = (List<object>) result.get('animals');
            System.debug('Received the following animals:');
            for(object animal : animals){
                System.debug(animal);
            }
        }
        return response;
    } 
    public static HttpResponse makePostCallout(){
        Http http  = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"name":"mighty moose"}');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() != 201){
            System.debug('The status code return was not expected : ' +response.getStatusCode() +'Status : '+response.getStatus());
            
        }else{
            System.debug('response : '+ response.getBody());
        }
        return response;  
    }
}