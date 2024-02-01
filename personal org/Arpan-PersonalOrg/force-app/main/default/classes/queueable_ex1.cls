public class queueable_ex1 implements Queueable{
    public void execute(QueueableContext qc){
        Account acc = new Account(Name= 'arpan Gaur', Phone='4635743443');
        insert acc;
        queueable_Ex2 ex = new queueable_Ex2();
        Id jobId = system.enqueueJob(ex);
    }
}