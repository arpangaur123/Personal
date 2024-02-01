public class RFIDIntegrationUtility {
    public RFIDIntegrationUtility() {
    }
    
    public static Map<String,Object> RFIDCreateCrate(list<Crate__c> CrateList){
        try{
            String instance_url = RFIDCredentials__mdt.getInstance('RFIDCredentials').instance_url__c;
            String apiKey = RFIDCredentials__mdt.getInstance('RFIDCredentials').apiKey__c;
            system.debug('instance_url>>>'+instance_url);
            system.debug('apiKey>>>'+apiKey);
            if(CrateList.size() == 0){
                Map<String,Object> responseError = new Map<String,Object>();
                responseError.put('status', 'false');
                responseError.put('message', 'Crate Map is empty');
                return responseError;
            }
            
            String json;
            String body = '[';
            Boolean withLegs;
            Boolean IPPCStamp;
            Boolean emptyOrLoaded;
            Decimal Length;
            Decimal Width;
            Decimal Height;
            for(Crate__c Crate : CrateList){  
                body += '{';
                body += Crate.Job_Reference__c != null ? '"jobReferenceId": "'+Crate.Job_Reference__c+'",' : '"jobReferenceId": null,';
                body += Crate.myCollector__c != null ? '"collectorReferenceId": "'+Crate.myCollector__c+'",' : '"collectorReferenceId": null,';
                body += Crate.UOM__C != null ? '"unitOfMeasurementReferenceId": "'+Crate.UOM__C+'",' : '"unitOfMeasurementReferenceId": null,';
                body += Crate.Location__c != null ? '"locationId": "'+Crate.Location__c+'",' : '"locationId": null,';
                body += Crate.Id != null ? '"referenceId": "'+Crate.Id+'",' : '"referenceId": null,';
                body += Crate.Name != null ? '"crateBarcode": "'+Crate.Name+'",' : '"crateBarcode": null,';
                
                
                IPPCStamp = RFIDIntegrationUtility.ConvertToBoolean(Crate.IPPC_Stamp__c,'No');
                withLegs = RFIDIntegrationUtility.ConvertToBoolean(Crate.With_Legs__c,'No');
                emptyOrLoaded = RFIDIntegrationUtility.ConvertToBoolean(Crate.Status__c,'Empty');
                
                body += '"withLegs": "'+withLegs+'",';
                body += '"ippcStamp": "'+IPPCStamp+'",';
                body += '"emptyOrLoaded": "'+emptyOrLoaded+'",';
                body += '"active": "'+Crate.IsActive__c+'",';
                
                Length = RFIDIntegrationUtility.ConvertToDouble(Crate.Length__c);
                Width = RFIDIntegrationUtility.ConvertToDouble(Crate.Width__c);
                Height = RFIDIntegrationUtility.ConvertToDouble(Crate.Height__c);
                
                body += '"length": "'+Length+'",';
                body += '"width": "'+Width+'",';
                body += '"height": "'+Height+'",';
                
                Long DateInTime = RFIDIntegrationUtility.GenerateTimestamp(Crate.Date_In__c);
                Long DateOutTime = RFIDIntegrationUtility.GenerateTimestamp(Crate.Date_Out__c);
                Long cycleCountOnTime = RFIDIntegrationUtility.GenerateTimestamp(Crate.Cycle_Count__c);
                
                body += '"dateIn": "'+DateInTime+'",';
                body += '"dateOut": "'+DateOutTime+'",';
                body += '"cycleCountOn": "'+cycleCountOnTime+'",';
                body += Crate.Keep_Id__c != null ? '"keepId": "'+Crate.Keep_Id__c+'",' : '"keepId": null';
                body += '},';
            }
            
            body += ']';
            
            system.debug('body>>>>>>'+body);
            
            HTTP http = new HTTP();
            HTTPRequest request = new HTTPRequest();
            request.setEndpoint(instance_url+'/api/synchronizations/crate');
            request.setHeader('x-api-key', apiKey);
            request.setHeader('Content-Type', 'application/json');
            request.setMethod('POST');
            request.setTimeOut(120000);
            request.setBody(body);
            HTTPResponse response = http.send(request);
            json = response.getBody();
            system.debug(response);
            system.debug('response=='+response.getBody());
            
            Map<String,Object> responseMap = (Map<String, Object>) System.JSON.deserializeUntyped(json);
            
            String Status;
            if(response.getStatus() == 'OK'){
                Status = 'Success';
            }else{
                Status = 'Error';
            }
            SaveAPILog(responseMap,body,response.getStatusCode(),'Crate__c',Status);
            system.debug('responseMap====>'+responseMap);
            return responseMap;
            
        }catch(Exception e){
            System.debug('Error=====>'+e.getMessage());
            System.debug('Error=====>'+e.getLineNumber());
            Map<String,Object> responseMapS = new Map<String,Object>();
            return responseMapS;
        }
    }
    
    public static Map<String,Object> RFIDCreateArtwork(list<artApp__Artwork__c> ArtworkList){
        try{
            system.debug('artwork method');
            String instance_url = RFIDCredentials__mdt.getInstance('RFIDCredentials').instance_url__c;
            String apiKey = RFIDCredentials__mdt.getInstance('RFIDCredentials').apiKey__c;
            if(ArtworkList.size() == 0){
                Map<String,Object> responseError = new Map<String,Object>();
                responseError.put('status', 'false');
                responseError.put('message', 'Crate Map is empty');
                return responseError;    
            }
            
            String json;
            Decimal Length;
            Decimal packedLength;
            Decimal Width;
            Decimal packedWidth;
            Decimal Height;
            Decimal packedHeight;
            Long DateInTime;
            Long DateOutTime;
            Long cycleCountOnTime;
            String body = '[';
            for(artApp__Artwork__c Artwork : ArtworkList){
                body += '{';
                body += Artwork.Job_Reference__c != null ? '"jobReferenceId": "'+Artwork.Job_Reference__c+'",' : '"jobReferenceId": null,';
                body += Artwork.artApp__Collector__c != null ? '"collectorReferenceId": "'+Artwork.artApp__Collector__c+'",' : '"collectorReferenceId": null,';
                body += Artwork.artApp__Artist__c != null ? '"artistReferenceId": "'+Artwork.artApp__Artist__c+'",' : '"artistReferenceId": null,';
                body += Artwork.Packing_Method__c != null ? '"packingMethodReferenceId": "'+Artwork.Packing_Method__c+'",' : '"packingMethodReferenceId": null,';
                body += Artwork.artApp__UOM__c != null ? '"unitOfMeasurementReferenceId": "'+Artwork.artApp__UOM__c+'",' : '"unitOfMeasurementReferenceId": null,';
                body += Artwork.Crate__c != null ? '"crateReferenceId": "'+Artwork.Crate__c+'",' : '"crateReferenceId": null,';
                body += Artwork.Internal_Location__c != null ? '"locationId": "'+Artwork.Internal_Location__c+'",' : '"locationId": null,';
                body += Artwork.Id != null ? '"referenceId": "'+Artwork.Id+'",' : '"referenceId": null,';
                body += Artwork.Item_No__c != null ? '"itemId": "'+Artwork.Item_No__c+'",' : '"itemId": null,';
                
                if(!String.isBlank(Artwork.Name)){
                    Artwork.Name = Artwork.Name.replaceAll('"', '');
                }
                
                
                body += '"name": "'+Artwork.Name+'",';
                body += '"description": "",';
                
                if(!String.isBlank(Artwork.Shared_Crate__c)){
                    Artwork.Shared_Crate__c = Artwork.Shared_Crate__c.replaceAll('"', '');
                }
                
                body += Artwork.Shared_Crate__c != null ? '"sharedCrate": "'+Artwork.Shared_Crate__c+'",' : '"sharedCrate": null,';
                
                DateInTime = RFIDIntegrationUtility.GenerateTimestamp(Artwork.Date_In__c);
                DateOutTime = RFIDIntegrationUtility.GenerateTimestamp(Artwork.Date_Out__c);
                cycleCountOnTime = RFIDIntegrationUtility.GenerateTimestamp(Artwork.Cycle_Count__c);
                Length = RFIDIntegrationUtility.ConvertToDouble(Artwork.artApp__Length__c);
                Width = RFIDIntegrationUtility.ConvertToDouble(Artwork.artApp__Width__c);
                Height = RFIDIntegrationUtility.ConvertToDouble(Artwork.artApp__Height__c);
                packedLength = RFIDIntegrationUtility.ConvertToDouble(Artwork.Packed_Length__c);
                packedWidth = RFIDIntegrationUtility.ConvertToDouble(Artwork.Packed_Width__c);
                packedHeight = RFIDIntegrationUtility.ConvertToDouble(Artwork.Packed_Height__c);
                
                body += '"dateOut": "'+DateOutTime+'",';
                body += '"dateIn": "'+DateInTime+'",';
                body += '"length": "'+Length+'",';
                body += '"width": "'+Width+'",';
                body += '"height": "'+Height+'",';
                body += '"packedLength": "'+packedLength+'",';
                body += '"packedWidth": "'+packedWidth+'",';
                body += '"packedHeight": "'+packedHeight+'",';
                body += Artwork.Barcode_ID__c != null ? '"barcodeId": "'+Artwork.Barcode_ID__c+'",' : '"barcodeId": null,';
                body += '"cycleCountOn": "'+cycleCountOnTime+'",';
                body += '"active": "'+Artwork.IsActive__c+'",';
                body += '"title": "'+Artwork.Name+'",';
                body += Artwork.Keep_Id__c != null ? '"keepId": "'+Artwork.Keep_Id__c+'",' : '"keepId": null';
                
                body += '},';
            }
            
            body += ']';
            
            system.debug('body>>>>>>'+body);
            HTTP http = new HTTP();
            HTTPRequest request = new HTTPRequest();
            
            request.setEndpoint(instance_url+'/api/synchronizations/artwork');
            request.setHeader('x-api-key', apiKey);
            request.setHeader('Content-Type', 'application/json');
            request.setMethod('POST');
            request.setTimeOut(120000);
            request.setBody(body);
            HTTPResponse response = http.send(request);
            json = response.getBody();
            system.debug(response);
            system.debug('response=='+response.getBody());
            Map<String,Object> responseMap = (Map<String, Object>) System.JSON.deserializeUntyped(json);
            String Status;
            if(response.getStatus() == 'OK'){
                Status = 'Success';
            }else{
                Status = 'Error';
            }
            SaveAPILog(responseMap,body,response.getStatusCode(),'artApp__Artwork__c',Status);
            return responseMap;
            
        }catch(Exception e){
            System.debug('Error=====>'+e.getMessage());
            System.debug('Line=====>'+e.getLineNumber());
            Map<String,Object> responseMapS = new Map<String,Object>();
            return responseMapS;
        }
    }
    
    public static Map<String,Object> RFIDCreateJobReference(list<Job_Reference__c> JobReferenceList){
        try{
            String instance_url = RFIDCredentials__mdt.getInstance('RFIDCredentials').instance_url__c;
            String apiKey = RFIDCredentials__mdt.getInstance('RFIDCredentials').apiKey__c;
            if(JobReferenceList.size() == 0){
                Map<String,Object> responseError = new Map<String,Object>();
                responseError.put('status', 'false');
                responseError.put('message', 'Crate Map is empty');
                return responseError;    
            }
            String json;
            String body = '[';
            
            for(Job_Reference__c JobReference : JobReferenceList){
                body += '{';
                body += '"name": "'+JobReference.Name+'",';
                body += '"description": "",';
                body += '"referenceId": "'+JobReference.Id+'",';
                body += '"active": "'+JobReference.isActive__c+'",';
                body += '},';
            }
            
            body += ']';
            system.debug('body>>>>>>'+body);
            HTTP http = new HTTP();
            HTTPRequest request = new HTTPRequest();
            request.setEndpoint(instance_url+'/api/synchronizations/jobreference');
            request.setHeader('x-api-key', apiKey);
            request.setHeader('Content-Type', 'application/json');
            request.setMethod('POST');
            request.setTimeOut(120000);
            request.setBody(body);
            HTTPResponse response = http.send(request);
            json = response.getBody();
            system.debug(response);
            system.debug('response=='+response.getBody());
            Map<String,Object> responseMap = (Map<String, Object>) System.JSON.deserializeUntyped(json);
            system.debug('responseMap====>'+responseMap);
            String Status;
            if(response.getStatus() == 'OK'){
                Status = 'Success';
            }else{
                Status = 'Error';
            }
            SaveAPILog(responseMap,body,response.getStatusCode(),'Job_Reference__c',Status);
            return responseMap;
            
        }catch(Exception e){
            System.debug('Error=====>'+e.getMessage());
            Map<String,Object> responseMapS = new Map<String,Object>();
            return responseMapS;
        }
    }
    
    public static Map<String,Object> RFIDCreateLocation(list<Location__c> LocationList){
        try{
            String instance_url = RFIDCredentials__mdt.getInstance('RFIDCredentials').instance_url__c;
            String apiKey = RFIDCredentials__mdt.getInstance('RFIDCredentials').apiKey__c;
            if(LocationList.size() == 0){
                Map<String,Object> responseError = new Map<String,Object>();
                responseError.put('status', 'false');
                responseError.put('message', 'Crate Map is empty');
                return responseError;    
            }
            String json;
            String body = '[';
            
            for(Location__c Location : LocationList){  
                body += '{';
                body += '"name": "'+Location.Name+'",';
                body += '"description": "",';
                body += '"referenceId": "'+Location.Id+'",';
                body += '"active": '+Location.isActive__c;
                body += '},';
            }
            body += ']';
            
            HTTP http = new HTTP();
            HTTPRequest request = new HTTPRequest();
            request.setEndpoint(instance_url+'/api/synchronizations/location');
            request.setHeader('x-api-key', apiKey);
            request.setHeader('Content-Type', 'application/json');
            request.setMethod('POST');
            request.setTimeOut(120000);
            request.setBody(body);
            HTTPResponse response = http.send(request);
            json = response.getBody();
            system.debug(response);
            system.debug('response=='+response.getBody());
            
            Map<String,Object> responseMap = (Map<String, Object>) System.JSON.deserializeUntyped(json);
            system.debug('responseMap====>'+responseMap);
            String Status;
            if(response.getStatus() == 'OK'){
                Status = 'Success';
            }else{
                Status = 'Error';
            }
            SaveAPILog(responseMap,body,response.getStatusCode(),'Location__c',Status);
            return responseMap;
            
        }catch(Exception e){
            System.debug('Error=====>'+e.getMessage());
            Map<String,Object> responseMapS = new Map<String,Object>();
            return responseMapS;
        }
    }
    
    public static Map<String,Object> RFIDCreateCollector(list<artApp__Collector__c> CollectorList){
        try{
            String instance_url = RFIDCredentials__mdt.getInstance('RFIDCredentials').instance_url__c;
            String apiKey = RFIDCredentials__mdt.getInstance('RFIDCredentials').apiKey__c;
            if(CollectorList.size() == 0){
                Map<String,Object> responseError = new Map<String,Object>();
                responseError.put('status', 'false');
                responseError.put('message', 'Crate Map is empty');
                return responseError;    
            }
            String json;
            String body = '[';
            
            for(artApp__Collector__c Collector : CollectorList){
                body += '{';
                body += '"name": "'+Collector.Name+'",';
                body += '"description": "",';
                body += '"referenceId": "'+Collector.Id+'",';
                body += '"active": "'+Collector.isActive__c+'"';
                body += '},';
            }
            body += ']';
            
            HTTP http = new HTTP();
            HTTPRequest request = new HTTPRequest();
            request.setEndpoint(instance_url+'/api/synchronizations/collector');
            request.setHeader('x-api-key', apiKey);
            request.setHeader('Content-Type', 'application/json');
            request.setMethod('POST');
            request.setTimeOut(120000);
            request.setBody(body);
            HTTPResponse response = http.send(request);
            json = response.getBody();
            system.debug(response);
            system.debug('response=='+response.getBody());
            Map<String,Object> responseMap = (Map<String, Object>) System.JSON.deserializeUntyped(json);
            system.debug('responseMap====>'+responseMap);
            String Status;
            if(response.getStatus() == 'OK'){
                Status = 'Success';
            }else{
                Status = 'Error';
            }
            SaveAPILog(responseMap,body,response.getStatusCode(),'artApp__Collector__c',Status);
            return responseMap;
            
        }catch(Exception e){
            System.debug('Error=====>'+e.getMessage());
            Map<String,Object> responseMapS = new Map<String,Object>();
            return responseMapS;
        }
    }
    
    public static Map<String,Object> RFIDCreateArtist(list<artApp__Artist__c> ArtistList){
        try{
            String instance_url = RFIDCredentials__mdt.getInstance('RFIDCredentials').instance_url__c;
            String apiKey = RFIDCredentials__mdt.getInstance('RFIDCredentials').apiKey__c;
            if(ArtistList.size() == 0){
                Map<String,Object> responseError = new Map<String,Object>();
                responseError.put('status', 'false');
                responseError.put('message', 'Crate Map is empty');
                return responseError;    
            }
            String json;
            String body = '[';
            
            for(artApp__Artist__c Artist : ArtistList){           
                body += '{';
                body += '"name": "'+Artist.Name+'",';
                body += '"description": "",';
                body += '"referenceId": "'+Artist.Id+'",';
                body += '"active": "'+Artist.isActive__c+'"';
                body += '},';
            }
            body += ']';
            
            HTTP http = new HTTP();
            HTTPRequest request = new HTTPRequest();
            request.setEndpoint(instance_url+'/api/synchronizations/artist');
            request.setHeader('x-api-key', apiKey);
            request.setHeader('Content-Type', 'application/json');
            request.setMethod('POST');
            request.setTimeOut(120000);
            request.setBody(body);
            HTTPResponse response = http.send(request);
            json = response.getBody();
            system.debug(response);
            system.debug('response=='+response.getBody());
            Map<String,Object> responseMap = (Map<String, Object>) System.JSON.deserializeUntyped(json);
            system.debug('responseMap====>'+responseMap);
            String Status;
            if(response.getStatus() == 'OK'){
                Status = 'Success';
            }else{
                Status = 'Error';
            }
            SaveAPILog(responseMap,body,response.getStatusCode(),'artApp__Artist__c',Status);
            return responseMap;
            
        }catch(Exception e){
            System.debug('Error=====>'+e.getMessage());
            Map<String,Object> responseMapS = new Map<String,Object>();
            return responseMapS;
        }
    }
    
    /*public static Map<String,Object> RFIDCreateTransaction(list<artApp__Transaction__c> TransactionList){
try{
String instance_url = RFIDCredentials__mdt.getInstance('RFIDCredentials').instance_url__c;
String apiKey = RFIDCredentials__mdt.getInstance('RFIDCredentials').apiKey__c;
Set<Id> TransactionIds = new Set<Id>();

for(artApp__Transaction__c TransactionObj : TransactionList){
TransactionIds.add(TransactionObj.Id);
}

List <Crate_Line_Item__c> crateLineList = [SELECT Id, Crate_ID_barcode__c,Transaction__c from Crate_Line_Item__c WHERE Transaction__c IN : TransactionIds];
List <artApp__Line_Item__c> artworkLineList = [SELECT Id, Barcode_ID__c,artApp__Transaction__c from artApp__Line_Item__c WHERE artApp__Transaction__c IN : TransactionIds];

if(TransactionList.size() == 0){
Map<String,Object> responseError = new Map<String,Object>();
responseError.put('status', 'false');
responseError.put('message', 'Crate Map is empty');
return responseError;    
}
String json;
String body = '{';

for(artApp__Transaction__c TransactionObj : TransactionList){
//body += '{';
body += '"name": "'+TransactionObj.Name+'",';
body += '"description": "",';
body += '"referenceId": "'+TransactionObj.Id+'",';
body += '"lineItems": [';
for(Crate_Line_Item__c crateObj : crateLineList){
if(TransactionObj.Id == crateObj.Transaction__c){
body += '{';
body += '"barcode": "'+crateObj.Crate_ID_barcode__c+'",';
body += '"referenceId": "'+crateObj.Id+'",';
body += '},';
}
}
for(artApp__Line_Item__c artWorkObj : artworkLineList){
if(TransactionObj.Id == artWorkObj.artApp__Transaction__c){
body += '{';
body += '"barcode": "'+artWorkObj.Barcode_ID__c+'",';
body += '"referenceId": "'+artWorkObj.Id+'",';
body += '},';
}
}
body += ']';
}
body += '}';

HTTP http = new HTTP();
HTTPRequest request = new HTTPRequest();
request.setEndpoint(instance_url+'/api/synchronizations/transaction');
request.setHeader('x-api-key', apiKey);
request.setHeader('Content-Type', 'application/json');
request.setMethod('POST');
request.setTimeOut(120000);
request.setBody(body);
HTTPResponse response = http.send(request);
json = response.getBody();
system.debug(response);
system.debug('response=='+response.getBody());
Map<String,Object> responseMap = (Map<String, Object>) System.JSON.deserializeUntyped(json);
system.debug('responseMap====>'+responseMap);
String Status;
if(response.getStatus() == 'OK'){
Status = 'Success';
}else{
Status = 'Error';
}
SaveAPILog(responseMap,body,response.getStatusCode(),'artApp__Transaction__c',Status);
return responseMap;

}catch(Exception e){
System.debug('Error=====>'+e.getMessage());
Map<String,Object> responseMapS = new Map<String,Object>();
return responseMapS;
}
}*/
    
    public static Map<String,Object> RFIDCreateTransaction(list<artApp__Transaction__c> TransactionList,Map<String,List<Crate_Line_Item__c>> crateLineMap,Map<String,List<artApp__Line_Item__c>> artworkLineMap){
        try{
            String instance_url = RFIDCredentials__mdt.getInstance('RFIDCredentials').instance_url__c;
            String apiKey = RFIDCredentials__mdt.getInstance('RFIDCredentials').apiKey__c;
            Map<String,Object> responseMap = new Map<String,Object>(); 
            
            if(TransactionList.size() == 0){
                Map<String,Object> responseError = new Map<String,Object>();
                responseError.put('status', 'false');
                responseError.put('message', 'Crate Map is empty');
                return responseError;    
            }
            
            //for(artApp__Transaction__c TransactionObj : TransactionList){	
            
            
            
            String json;
            String body = '{';
            
            for(artApp__Transaction__c TransactionObj : TransactionList){
                List <Crate_Line_Item__c> crateLineList = crateLineMap.get(TransactionObj.Id);
                List <artApp__Line_Item__c> artworkLineList = artworkLineMap.get(TransactionObj.Id);
                //body += '{';
                body += '"name": "'+TransactionObj.Name+'",';
                body += '"description": "",';
                body += '"referenceId": "'+TransactionObj.Id+'",';
                body += '"lineItems": [';
                for(Crate_Line_Item__c crateObj : crateLineList){
                    if(TransactionObj.Id == crateObj.Transaction__c){
                        body += '{';
                        body += '"barcode": "'+crateObj.Crate_ID_barcode__c+'",';
                        body += '"referenceId": "'+crateObj.Crate__c+'"';
                        body += '},';
                    }
                }
                for(artApp__Line_Item__c artWorkObj : artworkLineList){
                    if(TransactionObj.Id == artWorkObj.artApp__Transaction__c){
                        body += '{';
                        body += '"barcode": "'+artWorkObj.Barcode_ID__c+'",';
                        body += '"referenceId": "'+artWorkObj.artApp__Artwork__c+'"';
                        body += '},';
                    }
                }
                body += ']';
            }
            body += '}';
            
            HTTP http = new HTTP();
            HTTPRequest request = new HTTPRequest();
            request.setEndpoint(instance_url+'/api/synchronizations/transaction');
            request.setHeader('x-api-key', apiKey);
            request.setHeader('Content-Type', 'application/json');
            request.setMethod('POST');
            request.setTimeOut(120000);
            request.setBody(body);
            HTTPResponse response = http.send(request);
            json = response.getBody();
            system.debug(response);
            system.debug('response=='+response.getBody());
            responseMap = (Map<String, Object>) System.JSON.deserializeUntyped(json);
            system.debug('responseMap====>'+responseMap);
            String Status;
            if(response.getStatus() == 'OK'){
                Status = 'Success';
            }else{
                Status = 'Error';
            }
            SaveAPILog(responseMap,body,response.getStatusCode(),'artApp__Transaction__c',Status);
            return responseMap;
            //}
            
            //return responseMap;
            
        }catch(Exception e){
            System.debug('Error=====>'+e.getMessage());
            Map<String,Object> responseMapS = new Map<String,Object>();
            return responseMapS;
        }
    }
    
    public static Long GenerateTimestamp(Date DateString){
        Long DateTimeStamp;
        if(DateString != null){
            String[] date_string = String.valueOf(DateString).split('-');
            String selectedDay = date_string[2];
            String month = date_string[1];
            String year = date_string[0];
            DateTime DateValue;
            DateValue = date.newinstance(Integer.valueOf(year), Integer.valueOf(month), Integer.valueOf(selectedDay));
            DateTimeStamp = DateValue.getTime();
        }else{
            DateTimeStamp = 0;
        }
        return DateTimeStamp;
    }
    
    public static Decimal ConvertToDouble(Decimal Dimension){
        system.debug('Dimension>>>>>'+Dimension);
        Decimal convertedDimension;
        if(Dimension == null || Dimension == 0){
            convertedDimension = 0;
        }else{
            convertedDimension = Dimension;
        }
        return convertedDimension;
    }
    
    public static Boolean ConvertToBoolean(String StringValue,String CompareFalseValue){
        Boolean BooleanFlag;
        if(StringValue == CompareFalseValue){
            BooleanFlag = false;
        }else{
            BooleanFlag = true;
        }
        return BooleanFlag;
    }
    
    public static Boolean SaveAPILog(Map<String,Object> responseMap,String requestBody,Integer StatusCode,String ObjAPIName,String status){
        RFIDApiLogs__c apiLogs = new RFIDApiLogs__c();
        apiLogs.Request__c = requestBody;
        apiLogs.RequestTime__c = System.now();
        apiLogs.ObjectType__c = ObjAPIName;
        apiLogs.Response__c = String.valueOf(responseMap);
        apiLogs.Status__c = status;
        apiLogs.StatusCode__c = String.valueOf(StatusCode);
        system.debug('apiLogs>>>>'+apiLogs);
        insert  apiLogs;
        return true;
    }
    
    public class Result{
        public String status;
        public String message;
    }
}