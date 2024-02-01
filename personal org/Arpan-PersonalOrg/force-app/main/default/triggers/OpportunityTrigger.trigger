trigger OpportunityTrigger on Opportunity ( after insert, after update, after Delete) {
    
    List<Opportunity> oppAccUpdateList = new List<Opportunity>();
    if(trigger.isafter){
        if(trigger.isInsert){
            OpportunityHandler.updateStatusOfAccount(Trigger.new);
        }
        
        if(Trigger.isUpdate){
            for(Opportunity opp : Trigger.new){
                if(opp.StageName != trigger.oldMap.get(opp.Id).StageName)
                    oppAccUpdateList.add(opp);
            }
            if(!oppAccUpdateList.isEmpty())
                OpportunityHandler.updateStatusOfAccount(oppAccUpdateList);
        }
        if(trigger.isDelete){
            OpportunityHandler.updateStatusOfAccount(Trigger.old);
        }
    }
}



















//trigger OpportunityTrigger on Opportunity ( after insert,after update,after undelete,after delete, before insert, before update) {

/*if(Trigger.isbefore && (Trigger.isinsert || Trigger.isupdate)){
OpportunityHandlerClass.change_Close_Date(Trigger.New);
OpportunityHandlerClass.countNoOpportunity(Trigger.New);

}
if( Trigger.isafter && (trigger.isupdate || Trigger.isinsert || Trigger.isUpdate ||Trigger.isUndelete)){
OpportunityHandlerClass.shareOpp(Trigger.new);
OpportunityHandlerClass.updateAllOppStage(Trigger.new);
OpportunityHandlerClass.createTask(Trigger.new);
}
if(trigger.isAfter){
if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete|| Trigger.isdelete){
OpportunityHandlerClass.countNoOppOnAccount(Trigger.new , Trigger.old);

}
}
OpportunityHandlerClass.countNoOppOnAccount(Trigger.new , Trigger.old);*/

/*
trigger opportunityTriggerPractice on Opportunity ( after update) {
If( trigger.isupdate){
list<opportunity> oppUpdate = new list<opportunity>();
List<opportunity> oppList = [SELECT id, StageName from opportunity ];
system.debug('call in');
for (opportunity opp:oppList){
if(opp.StageName!='Qualification'){
opp.StageName='Qualification'; 
oppUpdate.add(opp); 
}
}      
update oppUpdate;
}
}
*/
/* Map<id, opportunity> oldMap = Trigger.oldMap;
Map<id, opportunity> newMap = Trigger.newMap;
set<id> keys=Trigger.oldMap.keySet();
for(id key:keys){
opportunity oldOpp = oldMap.get(key);
opportunity newOpp = oldMap.get(key);
if(oldOpp.StageName != 'Qualification'){
newOpp.StageName = 'Qualification' ;
}
}

*/


/* public class OpportunityUpdateAll {
public static void updateOpportunity(List<Opportunity> newList){
List<Opportunity> oppList = new List<Opportunity>();
oppList=[SELECT Id ,StageName FROM Opportunity LIMIT 200];


for(Opportunity each : newList){
each.StageName = 'Qualification';
}
}
}
*/