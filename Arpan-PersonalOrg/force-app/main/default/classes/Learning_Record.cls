public class Learning_Record {
    
    //Lead
  
    
    //isblank
/*
trigger test_lead_trigger on Lead (before update, before insert) {


for(Lead leadrecord : trigger.new){
if(leadrecord.Industry == 'other'){
leadrecord.addError('Industry value should not be other');
}

}

}
*/
    
  
    
    /*
trigger test_lead_trigger on Lead (before update) {
    
    for(Lead leadrecord : trigger.new){
        if(string.isNotBlank(leadrecord.LeadSource)){
        leadrecord.LeadSource= leadrecord.LeadSource.toUpperCase();
        }           
    }   
}
*/
}