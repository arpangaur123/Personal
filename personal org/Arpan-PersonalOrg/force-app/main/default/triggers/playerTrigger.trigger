trigger playerTrigger on Player__c (After insert, after update, after delete, after undelete) {
    set<id> setofTeamId = new set<id>();
    if(trigger.isafter){
        if(trigger.isinsert){
            for(Player__c player: trigger.new){
                if(player.Team__c != null){
                    setofTeamId.add(player.Team__c);
                }
            }
        }
     /*   if(trigger.isupdate || trigger.isdelete){
            for(Player__c player: trigger.old){
                if(player.Team__c != null){
                    setofTeamId.add(player.Team__c);
                }
            }
        } */
        
        list<Team__c>listTeamToUpdate = new list<Team__c>();
        if(setofTeamId.size()>0){
            map<id,Decimal> teamIdtoScore = new map<id,Decimal>();
            for(Team__c tmObj : [select id,  Total_Score__c from team__c where id In:setofTeamId ]){
                teamIdtoScore.put(tmObj.id, tmObj.Total_Score__c);
            }
            system.debug('map-->'+teamIdtoScore);
            if(teamIdtoScore.keyset().size()>0){
                for(Player__c plyrObj : trigger.new){
                    Team__c tm = new Team__c();
                    tm.id= plyrObj.Team__c;
                    tm.Total_Score__c = teamIdtoScore.get(plyrObj.Team__c) + plyrObj.Score__c;
                    listTeamToUpdate.add(tm);
                }
                if(listTeamToUpdate.size()>0){
                    update listTeamToUpdate;
                }
            }
        }
    }
}