public class MailApiCallOut {
    
    @AuraEnabled
    public static string PostCallout(string recieverEmail ,string subject, string body){
        //fetching metadataO
        Mail_API__mdt metadata = [SELECT Id, User_Name__c, Password__c, Email_Form__c, End_Point__c, Set_Method__c, Header_Parameters__c FROM Mail_API__mdt];
        System.debug('metadata : ' + metadata);
        string username = metaData.User_Name__c;
        string password = metaData.Password__c;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(metaData.End_Point__c);
        request.setMethod(metaData.Set_Method__c);
        
        requestHeader reqObj = parseRequest(metaData.Header_Parameters__c);
        System.debug('Wrapper : ' + reqObj);
        request.setHeader('Authorization', reqObj.Authorization);
        request.setHeader('Content-Type', reqObj.ContentType);
        request.setBody('{"Messages":[{"From":{"Email":"arpangaur123@gmail.com","Name":"Arpan"},"To":[{"Email":"'
                        +recieverEmail+'","Name":"You"}],"cc":[{"Email":"suraj.k@techmatrixconsulting.com","Name":"You"}],"Subject":"'
                        +subject+'","Body":"'+body+'","TextPart":"","HTMLPart":"<h3>Dear, welcome to TMC </h3><br>"}]}');
        system.debug('body  '+ request.getBody());
        HttpResponse response = http.send(request);
        if(response.getStatusCode() != 200){
            System.debug('The status code return was not expected : ' +response.getStatusCode() +'Status : '+response.getStatus());
            
        }else{
            System.debug('response : '+ response.getBody());
            system.debug('status : '+ response.getStatus());
            
        }
        return response.getStatus();
        
    }
    
    public class requestHeader{
        public String Authorization;
        public String ContentType;
    }
    
    public static requestHeader parseRequest(String json){
        return (requestHeader)System.JSON.deserialize(json, requestHeader.class);
    }
    
}