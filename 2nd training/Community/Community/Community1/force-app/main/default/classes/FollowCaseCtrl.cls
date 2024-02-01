public with Sharing class FollowCaseCtrl{
    
    public List<Case> caseList{get;set;}
    private ApexPages.StandardSetController standardController;
    public string errorStr{get;set;}
    public string successStr{get;set;}
    
    public followCaseCtrl(ApexPages.standardSetController controller){
        errorStr = '';
        successStr = '';
        caseList = new List<Case>();
        this.standardController = controller;
        
        caseList = (List<Case>) controller.getSelected();
        
    }
    
    public void createSubscription(){
        
        if(caseList != Null && caseList.size() > 0){
            string loggedInUsedId = userInfo.getUserId();
            
            List<EntitySubscription> entitySubscriptionList = new List<EntitySubscription>();
            
            for(Case ca : caseList){
                EntitySubscription es = new EntitySubscription();
                es.ParentId = ca.Id;
                es.SubscriberId = loggedInUsedId;
                if(ca.Id != Null)
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
        pageReference pg = new pageReference('/500');
        
        pg.setRedirect(true);
        return pg;
    }
    
}