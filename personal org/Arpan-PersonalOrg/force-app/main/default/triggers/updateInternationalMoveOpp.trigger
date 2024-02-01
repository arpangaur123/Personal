trigger updateInternationalMoveOpp on Opportunity (before update, before insert) {

    opportunity o=trigger.new[0];
    
    try {
        OpportunityContactRole ocr = 
        [SELECT OpportunityId, Contact.Name, Contact.Salutation, Contact.FirstName, Contact.LastName
        FROM OpportunityContactRole WHERE (OpportunityId =: o.Id AND Role = 'Shipper')
        OR (OpportunityId =: o.Id AND Role = 'Shipper\'s Spouse') ORDER BY Role limit 1];
        
        Account a = [SELECT Id, Name FROM Account 
        WHERE Id IN (SELECT AccountId FROM Contact WHERE Name =: ocr.Contact.Name) limit 1];
        
        o.Shipper_First_Name__c = ocr.Contact.Salutation + ' ' + ocr.Contact.FirstName;
        o.Shipper_Last_Name__c = ocr.Contact.LastName;
        o.Shipper_Account__c = a.Name;
                
    } catch (System.QueryException e) {
        System.debug('Opportunity Contact Role (Shipper Contact) Query Issue: =============================================' + e);
    }
    
    
    
    
    /// Added By Prabhat TMC
    
    if(trigger.Isbefore){
        set<DateTime> dt = new set<DateTime>();
        if(trigger.IsInsert || trigger.IsUpdate){
            for(Opportunity opp : trigger.new){
                if(opp.Enquiry_Acknowledged__c!=null && opp.Enquiry_received__c!=null){
                    if(opp.Enquiry_received__c.date().daysBetween(opp.Enquiry_Acknowledged__c.date())==0){
                        system.debug('opp.Enquiry_Acknowledged__c-->'+opp.Enquiry_Acknowledged__c.hour());
                        system.debug('opp.Enquiry_received__c-->'+opp.Enquiry_received__c.hour());
                        if(opp.Enquiry_Acknowledged__c.hour()<=18 && opp.Enquiry_received__c.hour()>=9){
                           opp.Acknowledgement_Time_New__c  = opp.Enquiry_Acknowledged__c.hour() - opp.Enquiry_received__c.hour();
                        }else{
                            Integer ackhr=opp.Enquiry_Acknowledged__c.hour();
                            Integer ackrec=opp.Enquiry_received__c.hour();
                            
                            if(opp.Enquiry_Acknowledged__c.hour()>18){
                                ackhr = 18;
                            }
                            if(opp.Enquiry_received__c.hour()<9){
                                ackrec = 9;
                            }
                            opp.Acknowledgement_Time_New__c = ackhr - ackrec;
                        }                         
                    }
                    else if(opp.Enquiry_received__c.date().daysBetween(opp.Enquiry_Acknowledged__c.date())>0){
                        set<Date> businessDays = getDiffBusinessDays(opp.Enquiry_received__c.date(), opp.Enquiry_Acknowledged__c.date());
                        system.debug('businessDays-->'+businessDays);
                        Integer firstDay = 0;
                        Integer midDays =0;
                        Integer lastDay = 0;
                        Date stdt = opp.Enquiry_received__c.date();
                        Date endt = opp.Enquiry_Acknowledged__c.date();
                        for(Date dte = stdt;dte<=endt;dte=dte.addDays(1)){
                            if(businessDays.contains(dte)){
                                if(dte==opp.Enquiry_received__c.date()){
                                    Integer ackrec=opp.Enquiry_received__c.hour();
                                    system.debug('ackrec-->'+ackrec);
                                    if(ackrec<9){
                                        ackrec = 9;
                                    }
                                    if(ackrec>18){
                                        ackrec = 18;
                                    }
                                    system.debug('ackrec-->'+ackrec);
                                    firstDay = 18 - ackrec;
                                    system.debug('firstDay -->'+firstDay );
                                }
                                else if(dte==opp.Enquiry_Acknowledged__c.date()){
                                    Integer ackhr=opp.Enquiry_Acknowledged__c.hour();
                                    system.debug('ackhr-->'+ackhr);
                                    if(ackhr<9){
                                        ackhr= 9;
                                    }
                                    if(ackhr>18){
                                        ackhr= 18;
                                    }
                                    system.debug('ackhr-->'+ackhr);
                                    lastDay = ackhr - 9;
                                    system.debug('lastDay -->'+lastDay );
                                }
                                else{
                                    midDays+=9;
                                    system.debug('midDays-->'+midDays);
                                }
                            }
                        }
                        opp.Acknowledgement_Time_New__c = firstDay + midDays + lastDay;
                    }
                }
            }
        }
    }
    
    
    
    public static set<Date> getDiffBusinessDays(Date startdt, Date enddt) {
        Date tempdate = null;
        set<Date> businessDaysSet = new set<Date>();
        
        if (startdt > enddt) {
        tempdate = enddt;
        enddt = startdt;
        startdt = tempdate;
        }
        
        for(Date dt = startdt; dt < = enddt; dt = dt.AddDays(1)){
            DateTime dtm =DateTime.newInstance(dt.year(), dt.month(), dt.day());
            if(dtm.format('EEEE')!='Sunday' && dtm.format('EEEE')!='Saturday'){
                Date newdt = dtm.date();
                businessDaysSet.add(newdt); 
            }
        }
            
        return businessDaysSet;
    }
        
        
        
    
}