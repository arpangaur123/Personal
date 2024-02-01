public class AnimalsAPIClass {
    public static void AnimalGetAPIRequest(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        system.debug('response' +response.getBody());
        //  system.debug('response' +response.getBodyDocument());
        if(response.getStatusCode()== 200){
            Map<string,Object> result = (Map<string,Object>)JSON.deserializeUntyped(response.getBody());
            List<object> animals = (List<object>) result.get('animals');
            for(object animal : animals){
                system.debug('animal Name  : ' + animal);
            }
        }
    }
    public static void AnimalPostAPIRequest(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        
        HttpResponse response = http.send(request);
        request.setBody('{"name":"mighty moose"}');
        // Parse the JSON response
        if(response.getStatusCode() != 201) {
            System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }   
    }
    
}