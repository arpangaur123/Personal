trigger rateReplyRecordCounter on Rate_Reply__c (before insert, before update) {
    
    Rate_Reply__c rr = trigger.new[0];

    /* DS record type */
    if (rr.RecordTypeId == '01220000000TsdvAAC' || rr.RecordTypeId == '01220000000TtitAAC' || 
    rr.RecordTypeId == '01220000000TtiyAAC' || rr.RecordTypeId == '01220000000Ttj3AAC') {       
        if (Trigger.isInsert) {
            List<Record_Type_Counter__c> rtcs = [select Count__c, Name 
                                                 from Record_Type_Counter__c where Name = '01220000000TsdvAAC' limit 1 ];
            Record_Type_Counter__c rtc = (rtcs != null && rtcs.size() > 0)?rtcs[0]:null;
            //Record_Type_Counter__c rtc = [select Count__c, Name 
            //from Record_Type_Counter__c where Name = '01220000000TsdvAAC' limit 1 ];
            if(rtc!=null){
            rtc.count__c++;
            String tempCounter = String.valueOf(rtc.count__c);
            
            Date myDate = date.today();
            String yearString = myDate.year().format();
            System.debug('debug date year  ====================================== ' + yearString.substring(3,5));
            String monthString = myDate.month().format();
            System.debug('deBUG date month ============================================= ' + monthString.length());
            
            /* Generate quote number for DS rate reply */
            if (monthString.length() > 1 ) {
                    rr.quote_number__c = 'IB/'+ yearString.substring(3,5) + '/' + monthString 
                    + '/' + tempCounter.substring(0,4) + '/' + rr.Initials__c;
            } else {
                    rr.quote_number__c = 'IB/'+ yearString.substring(3,5) + '/' + '0' + monthString 
                    + '/' + tempCounter.substring(0,4) + '/' + rr.Initials__c;
            }
            update rtc;
            }
        }
        
        if (Trigger.isUpdate) {
            String temp1 = rr.quote_number__c;
            if (rr.Quote_Revision__c != null && !temp1.contains('-')) {
                rr.quote_number__c = rr.quote_number__c + '-' + rr.Quote_Revision__c;
            }
            else if (rr.Quote_Revision__c != null && temp1.contains('-')) {
                String temp = rr.quote_number__c.substring(0, temp1.length()-2);
                rr.quote_number__c = temp + '-' + rr.Quote_Revision__c;
            }
        }
    }//end of DS rate reply record counter
    
    /* OS record type */
    else if (rr.RecordTypeId == '01220000000Tse0AAC') {
        
        if (Trigger.isInsert) {
            List<Record_Type_Counter__c> rtcs = [select Count__c, Name 
                                                 from Record_Type_Counter__c where Name = :rr.recordtypeid limit 1 ];
            Record_Type_Counter__c rtc = (rtcs != null && rtcs.size() > 0)?rtcs[0]:null;
            //Record_Type_Counter__c rtc = [select Count__c, Name 
            //from Record_Type_Counter__c where Name = :rr.recordtypeid limit 1 ];
            if(rtc!=null){
            rtc.count__c++;
            String tempCounter = String.valueOf(rtc.count__c);
            
            Date myDate = date.today();
            String yearString = myDate.year().format();
            System.debug('debug date year  ====================================== ' + yearString.substring(3,5));
            String monthString = myDate.month().format();
            System.debug('deBUG date month ============================================= ' + monthString.length());
            
            /* Generate quote number for OS rate reply */
            if (monthString.length() > 1 ) {
                    rr.quote_number__c = 'OS/'+ yearString.substring(3,5) + '/' + monthString 
                    + '/' + tempCounter.substring(0,4) + '/' + rr.Initials__c;
            } else {
                    rr.quote_number__c = 'OS/'+ yearString.substring(3,5) + '/' + '0' + monthString 
                    + '/' + tempCounter.substring(0,4) + '/' + rr.Initials__c;
            }
            update rtc;
            }
        }
        if (Trigger.isUpdate) {
            String temp1 = rr.quote_number__c;
            if (rr.Quote_Revision__c != null && !temp1.contains('-')) {
                rr.quote_number__c = rr.quote_number__c + '-' + rr.Quote_Revision__c;
            }
            else if (rr.Quote_Revision__c != null && temp1.contains('-')) {
                String temp = rr.quote_number__c.substring(0, temp1.length()-1);
                rr.quote_number__c = temp + '-' + rr.Quote_Revision__c;
            }
        }
        
    }//end of OS rate reply record counter

}