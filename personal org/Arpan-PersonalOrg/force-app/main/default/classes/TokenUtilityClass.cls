public class TokenUtilityClass {
    public static String endpoint;
    public static Boolean IsSuccess = false;
    public static String token = '';
    
    public static void getToken(){
        
        List<Swagger_Credential__c> swaglst =[SELECT Name,End_Point__c,Email__c,Password__c,Country__c,
                                              Company_Name__c from Swagger_Credential__c where Name='SwaggerToken' 
                                              LIMIT 1];
        if(swaglst!=null && swaglst.size() > 0){
            
            endpoint = swaglst[0].End_Point__c;
            HttpRequest reqst = new HttpRequest();
            reqst.setEndpoint(endpoint+'/login');
            reqst.setMethod('POST');
            reqst.setHeader('Content-Type', 'application/json');
            reqst.setHeader('Accept', 'application/json');
            reqst.setTimeout(60000);
            String body = '{"email":"'+swaglst[0].Email__c+'","password":"'+swaglst[0].Password__c+'","company_name":"'+swaglst[0].Company_Name__c+'"}';
            reqst.setBody(body);
            
            Http http = new Http();
            HttpResponse response = new HttpResponse();
            if(!Test.isRunningTest())
            response = http.send(reqst);
            System.debug('***RESPONSE*** >>>'+  response.getbody());
            System.debug('***response.getStatusCode()*** >>>'+  response.getStatusCode());
            if(Test.isRunningTest()){
            response.setBody('{"token":""}');
            response.setStatusCode(200);
            }
            if(response.getStatusCode()==200){
                if(response.getBody()!=null){
                    Map<String,Object> rspnsebody = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
                    if(rspnsebody.containsKey('token')){
                        token = (String)rspnsebody.get('token');
                        IsSuccess = true;
                    }
                }
            }else{
                if(response.getBody()!=null){
                    
                    Map<String,Object> rspnsebody = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
                    if(rspnsebody.containsKey('message'))
                        token = (String)rspnsebody.get('message');
                }
            }
        }
    }
}