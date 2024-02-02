@RestResource(urlMapping='/eportalApi/InvoiceCreateAPI/*')
global with sharing class InvoiceCreateAPI {
    
    @HttpPost
    global static void createInvoice() {
        Savepoint sp = Database.setSavepoint();
        RestRequest request = RestContext.request;
        try{
            if(String.isNotBlank(request.requestBody.toString())){
                List<RequestBodyWrapper> requestBody = (List<RequestBodyWrapper>)JSON.deserialize(request.requestBody.toString(),List<RequestBodyWrapper>.class);
                System.debug('requestBody ==>> ' +requestBody);
                
                set<string> jobrefidset = new set<string>();//to store job refrenceids
                
                if(requestBody!=null && requestBody.size() > 0){
                    System.debug('requestBody.size() ==>> ' +requestBody.size());
                    
                    List<AM_Invoice__c> invoice2insertlst = new List<AM_Invoice__c>();
                    
                    for(Integer i=0;i<requestBody.size();i++){
                        if(!jobrefidset.contains(requestBody[i].JobReferenceID))
                            jobrefidset.add(requestBody[i].JobReferenceID);
                    }
					
					Map<string,Job_Reference__c> jobRefMap = new Map<string,Job_Reference__c>();
					for(Job_Reference__c jr:[select Id,Name,Status__c,Opportunity__c from Job_Reference__c where Name in:jobrefidset]){
						jobRefMap.put(jr.Name,jr);
					}
					
					list<Job_Reference__c> jobref2update = new list<Job_Reference__c>(); //to update Job Reference
					
                    for(Integer i=0;i<requestBody.size();i++){
						if(jobRefMap.containsKey(requestBody[i].JobReferenceID)){
							Job_Reference__c jr = jobRefMap.get(requestBody[i].JobReferenceID);
							AM_Invoice__c aic = new AM_Invoice__c();
							aic.Job_Reference__c = jr.Id;
							aic.Opportunity__c = jr.Opportunity__c;
							aic.Name = requestBody[i].InvoiceID;
							aic.Billing_Party__c = requestBody[i].AccountName;
							aic.Invoice_Date__c = requestBody[i].InvoiceDate;
							aic.Job_Sub_Total__c = requestBody[i].JobSubTotal;
							aic.Invoice_Amount__c = requestBody[i].InvoiceTotalAmount;
                            aic.Recoverable__c = requestBody[i].Recoverable;
							aic.Revenue__c = requestBody[i].Revenue;
							aic.invoice_pdf_link__c = requestBody[i].invoicepdflink;
							invoice2insertlst.add(aic);
							
							If(jr.status__c!='Invoiced'){
								jr.status__c = 'Invoiced';
								jobref2update.add(jr);
							}
						}else{
							String jsonStr = '{"success" : false,"message" : "Job Reference Number '+requestBody[i].JobReferenceID+' is not found."}';
							RestContext.response.addHeader('Content-Type', 'application/json');
							RestContext.response.responseBody = Blob.valueOf(jsonStr);
                            
                            API_Error_Log__c apiError = new API_Error_Log__c();
                            apiError.API_Name__c = 'Invoice Api';
                            apiError.Error_Message__c = 'Job Reference Number '+requestBody[i].JobReferenceID+' is not found.';
                            apiError.Request__c = request.requestBody.toString();
                            insert apiError;
                            
							return;
						}
                    }
                    
                    System.debug('invoice2insertlst--->>>>'+invoice2insertlst.size());
                    if(invoice2insertlst!=null && invoice2insertlst.size() > 0){
                        
                        insert invoice2insertlst;
						
                        System.debug('jobref2update--->>>>'+jobref2update.size());
                         if(jobref2update!=null && jobref2update.size() > 0)
                            update jobref2update;
                        
                        String jsonStr = '{"success" : true,"message" : "Invoice created Successfully."}';
                        RestContext.response.addHeader('Content-Type', 'application/json');
                        RestContext.response.responseBody = Blob.valueOf(jsonStr);
                        return;
                    }
                }else{
                    String jsonStr = '{"success":"false","message":"Please provide request body"}';
                    RestContext.response.addHeader('Content-Type','application/json');
                    RestContext.response.responseBody = Blob.valueOf(jsonStr);
                    return;
                }
            }else{
                String jsonStr = '{"success":"false","message":"Please provide request body"}';
                RestContext.response.addHeader('Content-Type','application/json');
                RestContext.response.responseBody = Blob.valueOf(jsonStr);
                return;
            }
        }
        catch(Exception e){
            
            Database.rollback(sp);
            API_Error_Log__c apiError = new API_Error_Log__c();
            apiError.API_Name__c = 'Invoice Api';
            apiError.Error_Message__c = e.getMessage();
            apiError.Request__c = request.requestBody.toString();
            insert apiError;
            
            String jsonStr = '{"success" : false,"message" : "'+e.getMessage()+'"}';
            RestContext.response.addHeader('Content-Type', 'application/json');
            RestContext.response.responseBody = Blob.valueOf(jsonStr);
            return; 
        }
    }
    
    public class  RequestBodyWrapper{
        public String JobReferenceID; 
        public String InvoiceID; 
        public String AccountName; 
        public Date InvoiceDate; 
        public Decimal JobSubTotal;
        public Decimal InvoiceTotalAmount; 
        Public Decimal Recoverable;
        public Decimal Revenue;
        public String invoicepdflink; 
        public String JobReference;
    }
}