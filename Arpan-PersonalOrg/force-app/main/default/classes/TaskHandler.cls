public class TaskHandler {
    
    public static void changeDueDateonInsert(List<Task> newTaskList){
        for(Task task : newTaskList){
            //system.debug('in');
            if(task.ActivityDate != NULL){
                Datetime dt = (DateTime)task.ActivityDate;
                String dayOfWeek = dt.format('EEEE'); 
                // system.debug(dayOfWeek);
                if(dayOfWeek == 'Saturday' || dayOfWeek == 'Sunday'){
                    task.ActivityDate = task.ActivityDate + 3;   
                    //system.debug(task.ActivityDate);
                }
            }
        } 
    }
    public static void changeDueDateonUpdate(List<Task> newTaskList, map<Id, Task> idToTaskMap){
        for(Task task : newTaskList){
            //system.debug('in1');
            if(task.ActivityDate != NULL && task.ActivityDate != idToTaskMap.get(task.Id).ActivityDate){
                Datetime dt = (DateTime)task.ActivityDate;
                String dayOfWeek = dt.format('EEEE'); 
                //system.debug(dayOfWeek);
                if(dayOfWeek == 'Saturday' || dayOfWeek == 'Sunday'){
                    task.ActivityDate = task.ActivityDate + 3;   
                    // system.debug(task.ActivityDate);
                }
            }
        } 
    } 
}