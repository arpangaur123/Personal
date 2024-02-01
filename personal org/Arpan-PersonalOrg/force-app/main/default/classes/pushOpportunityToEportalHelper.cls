public class pushOpportunityToEportalHelper {
    public static void pushOpportunityStatus(){
        
        Map<Id,Opportunity> oldmap;
        if(trigger.old!=null)
            oldmap = new Map<Id,Opportunity>((list<Opportunity>)trigger.old);
        
        Set<Id> oppIdSet = new Set<Id>();
        
        for(Opportunity opp : (list<Opportunity>)trigger.new){
            if((opp.StageName=='Cancelled' ||  opp.StageName=='Closed Lost') && opp.StageName!=oldmap.get(opp.id).StageName)
                oppIdSet.add(opp.id);
        }
        
        if(oppIdSet!=null && oppIdSet.size() > 0)
            Database.executeBatch(new pushOpportunityStatusToEportalBatch(oppIdSet), 1);
    }
}