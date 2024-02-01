global class PortalAPIUtility{
    global static Opportunity pushOpportunity(list<Opportunity> opplst){
        
        Opportunity opp2update = new Opportunity(Id=opplst[0].id);
        opp2update.API_Error__c = null;
        try{
            TokenUtilityClass.getToken();
            String token = TokenUtilityClass.token;
            System.debug('token--->>>'+token);
            if(TokenUtilityClass.IsSuccess){
                
                HttpRequest reqst = new HttpRequest();
                System.debug('endpoint---->>>>'+TokenUtilityClass.endpoint);
                reqst.setEndpoint(TokenUtilityClass.endpoint+'/Interaction1');
                
                reqst.setMethod('POST');
                reqst.setHeader('Content-Type', 'application/json');
                reqst.setHeader('Authorization', 'Bearer '+token);
                reqst.setHeader('Accept', 'application/json');
                //reqst.setTimeout(60000);
                System.debug('Bearer---->>>>'+'Bearer '+token); 
                
                string reqBody='{'+
                    +'"opportunity_id":"'+opplst[0].Id+'",'+
                    +'"Opportunity_Account_Name":"'+opplst[0].Account.Name+'",'+
                    +'"Quotation_number":"'+opplst[0].Quote_test_sfdc__c+'",'+
                    +'"contactperson":"'+opplst[0].OpportunityContactRoles[0].Contact.Name+'",'+
                    +'"description_of_items":"'+opplst[0].Description+'",'+
                    +'"currency":"'+opplst[0].CurrencyIsoCode+'",'+
                    +'"terms_of_payment":"'+opplst[0].Payment_Terms__c+'",'+
                    +'"job_type":"'+opplst[0].AM_Job_Type__c+'"'+
                    +'}';
                System.debug('-reqBody->>>'+reqBody);
                reqst.setBody(reqBody);
                Http http = new Http();
                HTTPResponse res = new HTTPResponse();   
                res = http.send(reqst);
                
                System.debug('***RESPONSE*** >>>'+  res.getbody());
                System.debug('***status*** >>>'+  res.getStatusCode());
                if(res.getStatusCode()==200){
                    if(res.getBody()!=null){
                        
                        Map<String,Object> rspnsebody = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
                        if(rspnsebody.containsKey('status')){
                            
                            if((String)rspnsebody.get('status')=='Success')
                                opp2update.Push_Opportunity_Info__c=true;
                            
                            if((String)rspnsebody.get('status')=='Error' && rspnsebody.containsKey('data')){
                                opp2update.API_Error__c = JSON.serialize(rspnsebody.get('data'));
                            }
                            
                        }
                    }
                }else{
                    if(res.getBody()!=null){
                        Map<String,Object> rspnsebody = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
                        if(rspnsebody.containsKey('message'))
                            opp2update.API_Error__c = (String)rspnsebody.get('message');
                    }
                }
            }else
                opp2update.API_Error__c = token;   
        }catch(Exception e){
            opp2update.API_Error__c = String.valueOf(e.getMessage());   
        }
        checkRecursion.run = false;
        update opp2update;
        return opp2update;
    }
    global static Opportunity pushStatus(list<Opportunity> opplst){
        Opportunity opp2update = new Opportunity(Id=opplst[0].id);
        opp2update.API_Error__c = null;
        try{
            TokenUtilityClass.getToken();
            String token = TokenUtilityClass.token;
            System.debug('token--->>>'+token);
            if(TokenUtilityClass.IsSuccess){
                
                String reason;
                if(opplst[0].StageName=='Cancelled')
                    reason = opplst[0].Reason_for_Cancelled__c;
                if(opplst[0].StageName=='Closed Lost')
                    reason = opplst[0].Reason_Lost__c;
                
                System.debug('token---->>>>'+token); 
                HttpRequest reqst = new HttpRequest();
                System.debug('endpoint---->>>>'+TokenUtilityClass.endpoint);
                reqst.setEndpoint(TokenUtilityClass.endpoint+'/Interaction3A');
                
                reqst.setMethod('POST');
                reqst.setHeader('Content-Type', 'application/json');
                reqst.setHeader('Authorization', 'Bearer '+token);
                reqst.setHeader('Accept', 'application/json');
                //reqst.setTimeout(60000);
                System.debug('Bearer---->>>>'+'Bearer '+token); 
                
                string reqBody='{'+
                    +'"Opportunity_Id":"'+opplst[0].Id+'",'+
                    +'"Quotation_number":"'+opplst[0].Quote_test_sfdc__c+'",'+
                    +'"Opportunity_Reason":"'+reason+'",'+
                    +'"Opportunity_Status":"'+opplst[0].StageName+'"'+
                    +'}';
                
                System.debug('-reqBody->>>'+reqBody);
                reqst.setBody(reqBody);
                Http http = new Http();
                HTTPResponse res = new HTTPResponse();   
                res = http.send(reqst);
                
                System.debug('***RESPONSE*** >>>'+  res.getbody());
                if(res.getStatusCode()==200){
                    if(res.getBody()!=null){
                        Map<String,Object> rspnsebody = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
                        if(rspnsebody.containsKey('status')){
                            if((String)rspnsebody.get('status')=='Success')
                                opp2update.Push_Lost_Cancelled_Status__c=true;
                            if((String)rspnsebody.get('status')=='Error' && rspnsebody.containsKey('data'))
                                opp2update.API_Error__c = JSON.serialize(rspnsebody.get('data'));
                        }
                    }
                }else{
                    if(res.getBody()!=null){
                        Map<String,Object> rspnsebody = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
                        if(rspnsebody.containsKey('message'))
                            opp2update.API_Error__c = (String)rspnsebody.get('message');
                    }
                }
            }else
                opp2update.API_Error__c = token;      
        }catch(Exception e){
            opp2update.API_Error__c = String.valueOf(e.getMessage());  
        }
        checkRecursion.run = false;
        update opp2update;
        return opp2update;
    }
    global static Job_Reference__c pushJobReference(list<Job_Reference__c> jbReflst){
        
        Job_Reference__c job2update = new Job_Reference__c(Id=jbReflst[0].id);
        job2update.API_Error__c = null;
        
        if(jbReflst[0].Opportunity__c==null || !(jbReflst[0].Opportunity__r.Push_Opportunity_Info__c))
            job2update.API_Error__c = 'Please push the linked Opportunity to portal first.';
        else If(jbReflst[0].Opportunity__c!=null && (jbReflst[0].Opportunity__r.Approved_Costing_Sheet__c==null || jbReflst[0].Opportunity__r.Approved_Costing_Sheet__r.Costing_Sheet_Id__c==null)){
            job2update.API_Error__c = 'Please select the Approved Costing Sheet on the Opportunity before pushing the Job reference to portal.';   
        }else{
            try{
                TokenUtilityClass.getToken();
                String token = TokenUtilityClass.token;
                System.debug('token--->>>'+token);
                if(TokenUtilityClass.IsSuccess){
                    
                    System.debug('token---->>>>'+token); 
                    HttpRequest reqst = new HttpRequest();
                    System.debug('endpoint---->>>>'+TokenUtilityClass.endpoint);
                    reqst.setEndpoint(TokenUtilityClass.endpoint+'/Interaction3B');
                    
                    reqst.setMethod('POST');
                    reqst.setHeader('Content-Type', 'application/json');
                    reqst.setHeader('Authorization', 'Bearer '+token);
                    //reqst.setTimeout(60000);
                    
                    System.debug('Bearer---->>>>'+'Bearer '+token); 
                    String exb = jbReflst[0].ExhibitionN__c;
                    System.debug('exb---->>>>'+exb); 
                    if(exb!=null && exb.Contains('"'))
                        exb = exb.replace('"','');
                    System.debug('exb---->>>>'+exb); 
                    string reqBody='{'+
                        +'"Opportunity_Id":"'+jbReflst[0].Opportunity__c+'",'+
                        +'"Job_Reference_Status":"'+jbReflst[0].Status__c+'",'+
                        +'"Job_Reference_Unique_Id":"'+jbReflst[0].Id+'",'+
                        +'"costing_sheet_no":"'+jbReflst[0].Opportunity__r.Approved_Costing_Sheet__r.Costing_Sheet_Id__c+'",'+
                        +'"revision_no":"'+(jbReflst[0].Opportunity__r.Approved_Costing_Sheet__r.Revision_ID__c!=null?jbReflst[0].Opportunity__r.Approved_Costing_Sheet__r.Revision_ID__c:'0')+'",'+
                        +'"Job_Ref":"'+jbReflst[0].Name+'",'+
                        +'"Project_Name":"'+exb+'"'+
                        +'}';
                    
                    System.debug('-reqBody->>>'+reqBody);
                    reqst.setBody(reqBody);
                    Http http = new Http();
                    HTTPResponse res = new HTTPResponse();   
                    res = http.send(reqst);
                    
                    System.debug('***RESPONSE*** >>>'+  res.getbody());
                    
                    if(res.getStatusCode()==200){
                        if(res.getBody()!=null){
                            Map<String,Object> rspnsebody = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
                            if(rspnsebody.containsKey('status')){
                                
                                if((String)rspnsebody.get('status')=='Success')
                                    job2update.Push_Job_Info__c=true;
                                
                                if((String)rspnsebody.get('status')=='Error' && rspnsebody.containsKey('data'))
                                    job2update.API_Error__c = JSON.serialize(rspnsebody.get('data'));
                            }
                        }
                    }else{
                        if(res.getBody()!=null){
                            Map<String,Object> rspnsebody = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
                            if(rspnsebody.containsKey('message'))
                                job2update.API_Error__c = (String)rspnsebody.get('message');
                        }
                    }
                }else
                    job2update.API_Error__c = token;   
            }catch(Exception e){
                job2update.API_Error__c=String.valueOf(e.getMessage());   
            }
        }
        
        update job2update;
        return job2update;
    }
    
}