/*
*  Trigger : SapCallHelper
Description: A helper class Whenever an artApp__Artwork__c is created or button clicked will call  SAp API and push that data.
Author : Saifullah Saifi With Rajesh
Date: 17/08/2017

*/

global class SapCallHelper{
    
    @future(callout=true) 
    public static void callApi(List<string> artId, string act){
        SapCallHelper.DoCallout(artId,act);
    }
    
    
    public static String DoCallout(List<string> artId, string act){         
        List<sap_api__c> apiUrl = sap_api__c.getall().values();
        List<artApp__Collector__c> coll=[select id from artApp__Collector__c where name='Sotheby\'s Hong Kong Limited'];
        if(apiUrl.size()>0){
            List<artApp__Artwork__c> artLst = [select Item_No__c ,  artApp__Collector__c, artApp__Length__c,artApp__Width__c, Packed_Width__c,artApp__Height__c,artApp__UOM__c,Weight_kg__c,UOM_Wt__c from artApp__Artwork__c where id In:artId];
            
            if(artLst.size() > 0){
                List<Integration_Log__c> IntList = new List<Integration_Log__c>();
                 string err1;
                for(artApp__Artwork__c art : artLst){
                    if(coll.size()>0){
                        if(coll[0].id==art.artApp__Collector__c){
                           string err; 
                            if(art.artApp__Length__c==null)
                                art.artApp__Length__c=0;
                            if(art.artApp__Width__c==null)
                                art.artApp__Width__c=0;
                            if(art.artApp__Height__c==null)
                                art.artApp__Height__c=0;
                            if(art.Weight_kg__c==null)
                                art.Weight_kg__c=0;
                            
                            if(String.isBlank(art.artApp__UOM__c))
                                art.artApp__UOM__c = '';
                            if(String.isBlank(art.UOM_Wt__c))
                                art.UOM_Wt__c = '';
                            
                            String uomVal = art.artApp__UOM__c;
                            if(uomVal == 'INCH')
                                uomVal = '\\"';
                            
                            Integration_Log__c inl=new Integration_Log__c();
                            inl.Action__c = act;
                            inl.Artwork__c = art.id;
                            
                            try{
                                Http httpProtocol = new Http();
                                if(String.isBlank(art.Item_No__c))
                                    art.Item_No__c = '';
                                String url = apiUrl[0].Url__c+art.Item_No__c;
                                HttpRequest request = new HttpRequest();
                                request.setHeader('cache-control',apiUrl[0].Cache_Control__c);
                                request.setHeader('client_id', apiUrl[0].Client_Id__c);
                                request.setHeader('client_secret',apiUrl[0].Client_Secret__c);
                                request.setHeader('content-type', apiUrl[0].Content_Type__c);
                                request.setHeader('x-api-key',apiUrl[0].X_Api_Key__c);
                                request.setEndPoint(url);
                                request.setMethod('POST');
                                String strbody = '{"Item_No__c" : "'+art.Item_No__c +'", "artApp_Length_c" : "'+art.artApp__Length__c+'", "artApp__Width__c" : "'+art.artApp__Width__c+'", "artApp_Height_c" : "'+art.artApp__Height__c +'", "artApp_UOM_c" : "'+uomVal+'", "Weight__c" : "'+art.Weight_kg__c+'", "UOM_Wt__c" : "'+art.UOM_Wt__c+'" }';
                                
                                request.setBody(strbody);
                                request.setTimeout(120000);
                                HttpResponse response = new HttpResponse();
                                if(Test.isRunningTest()){
                                    response.setBody('{"updated":true}');
                                    response.setStatusCode(200);
                                }else{
                                    response = httpProtocol.send(request);
                                }
                                String jsonInput = response.getBody();
                                if(jsonInput != null){
                                    if(response.getStatusCode() == 200){
                                        inl.Status__c = 'Success';                                
                                    }else{                              
                                        inl.Status__c = 'Fail';
                                    }
                                    inl.Message__c= jsonInput;
                                }
                            } catch(exception e){
                                err = e.getMessage();
                            }
                            if(err != null){
                                inl.Message__c= err;
                                inl.Status__c = 'Fail';
                            }
                            
                            inl.Time__c = system.now();
                            IntList.add(inl);
                            err1='success';
                        }
                        else{
                            system.debug('diff');
                            err1= 'diff';
                        }
                    }
                    
                }
                if(IntList.size()>0)
                    insert IntList;
                
                if(act == 'From Button') {                    
                        return err1;
                    
                }
            }           
        }
        
        return '';
    }    
    
    public static boolean checkBlank(artApp__Artwork__c art){
    if(String.isBlank(art.artApp__Collector__c) || art.artApp__Length__c==null || art.artApp__Width__c==null || art.artApp__Height__c==null ||String.isBlank(art.artApp__UOM__c) || art.Weight_kg__c==null || String.isBlank(art.UOM_Wt__c))   
        return false;
    else
        return true;
    }
}