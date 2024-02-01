public with Sharing class FollowOpportunityCtrl{
    
    public List<Opportunity> opportunityList{get;set;}
    private ApexPages.StandardSetController standardController;
    public string errorStr{get;set;}
    public string successStr{get;set;}
    
    public followOpportunityCtrl(ApexPages.standardSetController controller){
        errorStr = '';
        successStr = '';
        opportunityList = new List<Opportunity>();
        this.standardController = controller;
        
        opportunityList = (List<Opportunity>) controller.getSelected();
        
    }
    
    public void createSubscription(){
        
        if(opportunityList != Null && opportunityList.size() > 0){
            string loggedInUsedId = userInfo.getUserId();
            
            List<EntitySubscription> entitySubscriptionList = new List<EntitySubscription>();
            
            for(Opportunity op : opportunityList){
                EntitySubscription es = new EntitySubscription();
                es.ParentId = op.Id;
                es.SubscriberId = loggedInUsedId;
                if(op.Id != Null)
                    entitySubscriptionList.add(es);
            }
            
            if(entitySubscriptionList.size() > 0){
                Database.SaveResult[] entitySubscriptionResultList = Database.Insert(entitySubscriptionList, false);
                Integer count = 0;
                for( Integer i = 0; i < entitySubscriptionResultList.size(); i++ ){
                    
                     if(entitySubscriptionResultList.get(i).isSuccess()){
                         count ++;
                     }else if (!entitySubscriptionResultList.get(i).isSuccess()){
                         
                         for(Database.Error err : entitySubscriptionResultList.get(i).getErrors()){
                            errorStr += err.getMessage() + ', ';
                        }
                     }
                }
                
                if(count > 0){
                    successStr = 'You are now following '+ count + ' records.';
                }
                
            }
            
            
        }
        
    }
    
    public pageReference backBtn(){
        pageReference pg = new pageReference('/006');
        
        pg.setRedirect(true);
        return pg;
    }
    
}