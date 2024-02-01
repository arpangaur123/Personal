public class queueable_Ex3 implements Queueable{
    Public void Execute(QueueableContext qc){
        List<Account> accountsList = [SELECT Id, Name from Account WHERE Name = 'arpan sharma' limit 1];
        delete accountsList;
           
    }
}