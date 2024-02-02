public class queueable_Ex2 implements Queueable{
    public void execute(QueueableContext qc){
        List<Account> listAccs = [SELECT Id, Name from Account WHERE Name = 'arpan Gaur'];
        for(Account acc: listAccs){
            acc.Name = 'arpan sharma';
            update acc;
            
            queueable_Ex3 ex1 = new queueable_Ex3();
            Id jobId2 = system.enqueueJob(ex1);
        }
        
        
    }
}