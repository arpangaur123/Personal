public with Sharing class FollowAccountCtrl{
    
    public List<Account> accountList{get;set;}
    private ApexPages.StandardSetController standardController;
    public string errorStr{get;set;}
    public string successStr{get;set;}
    
    public followAccountCtrl(ApexPages.standardSetController controller){
        errorStr = '';
        successStr = '';
        accountList = new List<Account>();
        this.standardController = controller;
        
        accountList = (List<Account>) controller.getSelected();
        
    }
    
    public void createSubscription(){
        system.debug('asjkdhas>>'+accountList);
       
        if(accountList != Null && accountList.size() > 0){
            string loggedInUsedId = userInfo.getUserId();
            
            List<EntitySubscription> entitySubscriptionList = new List<EntitySubscription>();
            
            for(Account acc : accountList){
                EntitySubscription es = new EntitySubscription();
                es.ParentId = acc.Id;
                es.SubscriberId = loggedInUsedId;
                if(acc.Id != Null)
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
        pageReference pg = new pageReference('/001');
        
        pg.setRedirect(true);
        return pg;
    }
    
}