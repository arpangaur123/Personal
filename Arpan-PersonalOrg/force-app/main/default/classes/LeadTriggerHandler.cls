public class LeadTriggerHandler {
    public static void checkDuplicateEmail(list<Lead> listOfLead){
        // checking email duplicacy in lead 
        group g = [select id, name from group where name = 'Corporate Queue'];
        group g1 = [select id, name from group where name = 'Capital' ];
        set<string> listOfEmail = new set<string>();
        for(lead l:[SELECT email FROM lead WHERE email <> null]){
            listOfEmail.add(l.email);
        }
        system.debug(listOfEmail);
        if(!listOfEmail.isEmpty()){
            // checking Duplicate email
            for(Lead leadRecord : listOfLead){
                if(leadRecord.Email != Null){
                    if(listOfEmail.contains(leadRecord.Email)){
                        leadRecord.Email.adderror('This email is already exist');
                    }   
                }
            }
        }
        
        for(Lead leadRecord :listOfLead){
            if(leadRecord.Email != Null){
                if(listOfEmail.contains(leadRecord.Email)){
                    leadRecord.Email.adderror('This email is already exist');
                }   
            }
            if(leadRecord.industry == 'Banking' ){// When 'industry' is  Banking then assign owner to Group named as'Corporate'.
                leadRecord.Rating = 'Hot';
                leadRecord.OwnerId = g.id;
            }
            else{
                leadRecord.OwnerId = g1.Id;// When 'industry' is other than Banking then assign owner to Group named as'Capital'.
                leadRecord.Rating = 'Warm';
            }
        }  
    }
    public static void sendEmial(List<Lead> listOfLead){
        
    }
}