/*
Author : Uzair
Date : 13th April 2020
Description : Create Costing And Categories
*/
@RestResource(urlMapping='/eportalApi/createCosting/*')
global class CostingApiController {
    @HttpPost
    global static void doCreateRecords(){
        Savepoint sp = Database.setSavepoint();
        RestRequest request = RestContext.request;
        try{
            if(String.isNotBlank(request.requestBody.toString())){
                Map<String,Object> mapkeytoValue = (Map<String,Object>)JSON.deserializeUntyped(request.requestBody.toString());
                List<Object> oppinfolst = (List<Object>)mapkeytoValue.get('OppInfo');  //to get list of opportunities
                
                if(oppinfolst!=null && oppinfolst.size() > 0){
                    
                    list<Opportunity> opp2updatelst = new list<Opportunity>();  //lst to update opportunity info
                    map<string,Costing_Sheet__c> cst2costnginst = new map<string,Costing_Sheet__c>();  //map indexes(opp+costing) with costing sheet
                    map<string,list<Costing_Sheet_Category__c>> mapcostng2ctgrsinsert = new 
                        map<string,list<Costing_Sheet_Category__c>>();   //map indexes (costing+categories) with lst of categories
                    
                    for(Integer i=0;i<oppinfolst.size();i++){
                        
                        Map<String,Object> opp2mapinfo = (Map<String,Object>)oppinfolst[i]; 
                        if(opp2mapinfo!=null && opp2mapinfo.keyset().size() > 0){
                            
                            Opportunity opp = new Opportunity();
                            if(opp2mapinfo.containsKey('Id')){
                                opp.id = (string)opp2mapinfo.get('Id');
                                if(opp2mapinfo.containsKey('QuoteStatus'))
                                    opp.Quote_Status__c = (string)opp2mapinfo.get('QuoteStatus');
                                if(opp2mapinfo.containsKey('QuoteLink'))
                                    opp.Quote_Link__c = (string)opp2mapinfo.get('QuoteLink');
                                opp2updatelst.add(opp);
                                
                                //to get list of Costing records corresponding to each opportinity
                                if(opp2mapinfo.containsKey('Costing')){ 
                                    
                                    List<Object> costinfolst = (List<Object>)opp2mapinfo.get('Costing');
                                    if(costinfolst!=null && costinfolst.size() > 0){
                                        //System.debug('costinfolst--->>>'+costinfolst);
                                        for(Integer j=0;j<costinfolst.size();j++){
                                            Map<String,Object> cst2mapinfo = (Map<String,Object>)costinfolst[j];
                                            //System.debug('CostingId>>>'+(String)cst2mapinfo.get('CostingId'));
                                            
                                            Costing_Sheet__c cst = new Costing_Sheet__c();
                                            cst.Opportunity__c = opp.id;
                                            if(cst2mapinfo.containsKey('CostingId'))
                                                cst.Costing_Sheet_Id__c = (String)cst2mapinfo.get('CostingId');
                                            if(cst2mapinfo.containsKey('CostingLink'))
                                                cst.Costing_Link__c = (string)cst2mapinfo.get('CostingLink');
                                            if(cst2mapinfo.containsKey('RevisionId'))
                                                cst.Revision_ID__c = (string)cst2mapinfo.get('RevisionId');
                                            cst2costnginst.put(i+''+j,cst);
                                            
                                            //get List of Categories corresponding to each Costing
                                            
                                            List<Object> ctgrinfolst = (List<Object>)cst2mapinfo.get('Categories');
                                            System.debug('costinfolst--->>>'+costinfolst.size());
                                            
                                            if(ctgrinfolst!=null && ctgrinfolst.size() > 0){
                                                
                                                for(Integer k=0;k<ctgrinfolst.size();k++){
                                                    
                                                    Map<String,Object> categoty2mapinfo = (Map<String,Object>)ctgrinfolst[k];
                                                    if(!mapcostng2ctgrsinsert.containsKey(i+''+j))
                                                        mapcostng2ctgrsinsert.put(i+''+j, new list<Costing_Sheet_Category__c>());
                                                    Costing_Sheet_Category__c categry = new Costing_Sheet_Category__c();
                                                    if(categoty2mapinfo.containsKey('Id'))
                                                        categry.Category_ID__c = (string)categoty2mapinfo.get('Id');
                                                    if(categoty2mapinfo.containsKey('Description'))
                                                        categry.Description__c = (string)categoty2mapinfo.get('Description');
                                                    if(categoty2mapinfo.containsKey('Currency'))
                                                        categry.CurrencyIsoCode = (string)categoty2mapinfo.get('Currency');
                                                    if(categoty2mapinfo.containsKey('Amount'))
                                                        categry.Amount__c = Decimal.valueof(categoty2mapinfo.get('Amount')+'');
                                                    if(categoty2mapinfo.containsKey('Cost'))
                                                        categry.Cost__c = Decimal.valueof((String)categoty2mapinfo.get('Cost'));
                                                    mapcostng2ctgrsinsert.get(i+''+j).add(categry);
                                                    System.debug('categry--->>>'+categry);
                                                }
                                            }
                                        }
                                    }
                                }
                            }else{
                                String jsonStr = '{"success":"false","message":"Opportunity Id should not be blank"}';
                                RestContext.response.addHeader('Content-Type','application/json');
                                RestContext.response.responseBody = Blob.valueOf(jsonStr);
                                return;
                            }
                        }
                    }
                    
                    System.debug('opp2updatelst--->>>'+opp2updatelst.size());
                    
                    if(opp2updatelst!=null && opp2updatelst.size() > 0){
                        
                        System.debug('cst2costnginst-size-->>>'+cst2costnginst.size());
                        //insert Costing List Records
                        if(cst2costnginst!=null && cst2costnginst.values().size() > 0){
                            
                            insert cst2costnginst.values();
                            
                            list<Costing_Sheet_Category__c> categorylst2insert = new list<Costing_Sheet_Category__c>();
                            
                            //map categories with costing sheet based on Keys of Costing Sheet and Categories
                            for(String cstId : mapcostng2ctgrsinsert.keyset()){
                                for(Costing_Sheet_Category__c ctg : mapcostng2ctgrsinsert.get(cstId)){
                                    if(cst2costnginst.containskey(cstId) && cst2costnginst.get(cstId).Id!=null){
                                        ctg.Costing_Sheet__c = cst2costnginst.get(cstId).Id;
                                        categorylst2insert.add(ctg);
                                    }
                                }
                            }
                            
                            //insert Category List Records
                            if(categorylst2insert!=null && categorylst2insert.size() > 0)
                                insert categorylst2insert;
                            
                            //update opportunity info
                            update opp2updatelst;   
                            
                            String jsonStr = '{"success" : true,"message" : "Costing And Categories Created Successfully!"}';
                            RestContext.response.addHeader('Content-Type', 'application/json');
                            RestContext.response.responseBody = Blob.valueOf(jsonStr);
                            return;
                            
                        }else{
                            String jsonStr = '{"success":"false","message":"Costing Sheet Records Not Inserted"}';
                            RestContext.response.addHeader('Content-Type','application/json');
                            RestContext.response.responseBody = Blob.valueOf(jsonStr);
                            return;
                        }
                    }
                    else{
                        String jsonStr = '{"success":"false","message":"Opportunity Not Found"}';
                        RestContext.response.addHeader('Content-Type','application/json');
                        RestContext.response.responseBody = Blob.valueOf(jsonStr);
                        return;
                    }
                }else{
                    String jsonStr = '{"success":"false","message":"Provide Atlease one Record"}';
                    RestContext.response.addHeader('Content-Type','application/json');
                    RestContext.response.responseBody = Blob.valueOf(jsonStr);
                    return;
                }
            }else{
                String jsonStr = '{"success":"false","message":"Provide Body"}';
                RestContext.response.addHeader('Content-Type','application/json');
                RestContext.response.responseBody = Blob.valueOf(jsonStr);
                return;
            }
        }catch(Exception e){
            
            Database.rollback(sp);
            API_Error_Log__c apiError = new API_Error_Log__c();
            apiError.API_Name__c = 'Costing Api';
            apiError.Error_Message__c = e.getMessage();
            apiError.Request__c = request.requestBody.toString();
            insert apiError;
            
            String jsonStr = '{"success" : false,"message" : "'+e.getMessage()+'"}';            
            RestContext.response.addHeader('Content-Type', 'application/json');
            RestContext.response.responseBody = Blob.valueOf(jsonStr);
            return;      
        }
    }
}