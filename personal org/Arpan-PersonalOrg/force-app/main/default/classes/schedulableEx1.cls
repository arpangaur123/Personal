public class schedulableEx1 implements Schedulable{
    public void execute(SchedulableContext sc){
        List<Account> accList = [SELECT Id, Name FROM Account Where CreatedDate = Last_Week];
        
        if(accList != NULL){
            delete accList;
            
        }
        system.enqueueJob(new queueable_ex1());
        system.enqueueJob(new queueable_Ex2());
        system.enqueueJob(new queueable_Ex3());
    }
}