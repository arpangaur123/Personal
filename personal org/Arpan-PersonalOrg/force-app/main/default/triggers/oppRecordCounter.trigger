trigger oppRecordCounter on Opportunity (before insert) {
    map<String,RecordType> rtMap = new map<String,RecordType>();
    for(RecordType rt:[SELECT SobjectType, NamespacePrefix, Name, Id FROM RecordType where SobjectType ='Opportunity' OR SobjectType='Rate_Reply__c' limit 1000]){
        rtMap.put(rt.Name,rt);          
    } 
    list<Record_Type_Counter__c> objRecord_Type_Counter = new list<Record_Type_Counter__c>();
    for(Opportunity o: trigger.new){
        /* Inbound Record Counter */
        if (rtMap.get('Inbound') != null && o.RecordTypeId == rtMap.get('Inbound').Id ){//012200000008avZAAQ') {
            list<Record_Type_Counter__c> ort1 = [select Count__c, Name 
            from Record_Type_Counter__c where Name = 'Inbound'];
            if(ort1.size() > 0){
                Record_Type_Counter__c ort = ort1.get(0);
                ort.count__c++;
                String tempCounter = String.valueOf(ort.count__c);
                Date myDate = date.today();
                String dateString = myDate.year().format();
                System.debug('debug ================ INBOUND RECORD COUNTER ====================== ' + dateString.substring(3,5));
                o.IB_Job_number_2__c = 'DS/'+ dateString.substring(3,5) + '/' + tempCounter.substring(0,4); 
                //update ort;
                objRecord_Type_Counter.add(ort);
            }
        }//end of inbound record counter
        /* Artmove Record Counter For SG */
        else if (rtMap.get('Artmove') != null && o.RecordTypeId == rtMap.get('Artmove').Id){//012200000008bhJ') {
            list<Record_Type_Counter__c> ort1 = [select Count__c, Name 
            from Record_Type_Counter__c where Name ='Artmove'];// '012200000008bhJ'];
            /* :o.recordtypeid */
            if(ort1.size() > 0){
                Record_Type_Counter__c ort = ort1.get(0);
                ort.count__c++;
                String tempCounter = String.valueOf(ort.count__c);
                /* o.myCounter__c = 'DS/'+ dateString.substring(3,5) + '/' + tempCounter.substring(0,4); */
                o.myCounter__c =tempCounter.removeEnd('.0');
                //update ort;
                objRecord_Type_Counter.add(ort);
            }
        }//end of Artmove Record Counter For SG
        /* Artmove Record Counter For FP */
        else if (rtMap.get('ArtmoveFP') != null && o.RecordTypeId == rtMap.get('ArtmoveFP').Id){//01220000000JTCx') {
            list<Record_Type_Counter__c> ort1 = [select Count__c, Name 
            from Record_Type_Counter__c where Name ='ArtmoveFP'];
            /* :o.recordtypeid */
            if(ort1.size() > 0){
                Record_Type_Counter__c ort = ort1.get(0);
                ort.count__c++;
                String tempCounter = String.valueOf(ort.count__c);
                /* o.myCounter__c = 'DS/'+ dateString.substring(3,5) + '/' + tempCounter.substring(0,4); */
                o.myCounter__c =tempCounter.removeEnd('.0');
                //update ort;
                objRecord_Type_Counter.add(ort);
            }
        }//end of Artmove Record Counter For FP
        /* Artmove Record Counter For HK */
        else if (rtMap.get('ArtmoveHK') != null && o.RecordTypeId == rtMap.get('ArtmoveHK').Id){//01220000000JTD7') {
        list<Record_Type_Counter__c> ort1 = [select Count__c, Name 
            from Record_Type_Counter__c where Name =:'ArtmoveHK'];// '01220000000JTD7'];
            /* :o.recordtypeid */
            if(ort1.size() > 0){
                Record_Type_Counter__c ort = ort1.get(0);
                ort.count__c++;
                String tempCounter = String.valueOf(ort.count__c);
                /* o.myCounter__c = 'DS/'+ dateString.substring(3,5) + '/' + tempCounter.substring(0,4); */
                o.myCounter__c =tempCounter.removeEnd('.0');
                //update ort;
                objRecord_Type_Counter.add(ort);
            }
        }//end of Artmove Record Counter For HK
         /* Artmove Record Counter For JP */
       else if (rtMap.get('HTTR') != null && o.RecordTypeId == rtMap.get('HTTR').Id){//01220000000JTD2') {
            list<Record_Type_Counter__c> ort1 = [select Count__c, Name 
            from Record_Type_Counter__c where Name ='ArtmoveJP'];// '01220000000JTD2'];
            /* :o.recordtypeid */
            if(ort1.size() > 0){
                Record_Type_Counter__c ort = ort1.get(0);
                ort.count__c++;
                String tempCounter = String.valueOf(ort.count__c);
                /* o.myCounter__c = 'DS/'+ dateString.substring(3,5) + '/' + tempCounter.substring(0,4); */
                String i;
                String tempcountervalue = tempCounter.removeEnd('.0');
                /*if(tempcountervalue.length() == 1)                //commented by vijay because counter length will be always 3 or 3+.
                {
                 i= '10';
                }
                else if(tempcountervalue.length() == 2)
                {
                 i= '1';
                }
                o.QuoteCounter__c=i+ tempcountervalue ;*/
                o.QuoteCounter__c= tempcountervalue ;
                //update ort;
                objRecord_Type_Counter.add(ort); 
                system.debug(o+'>>>>'+objRecord_Type_Counter);
            }
        }//end of Artmove Record Counter For JP 
      /* Artmove Record Counter For BJ */
        else if (rtMap.get('ArtmoveBJ') != null && o.RecordTypeId == rtMap.get('ArtmoveBJ').Id){//01220000000JTDC') {
            list<Record_Type_Counter__c> ort1 = [select Count__c, Name 
            from Record_Type_Counter__c where Name ='ArtmoveBJ'];
            /* :o.recordtypeid */
            if(ort1.size() > 0){
                Record_Type_Counter__c ort = ort1.get(0);
                ort.count__c++;
                String tempCounter = String.valueOf(ort.count__c);
                /* o.myCounter__c = 'DS/'+ dateString.substring(3,5) + '/' + tempCounter.substring(0,4); */
                o.myCounter__c =tempCounter.removeEnd('.0');
                //update ort;
                objRecord_Type_Counter.add(ort);
            }
        }//end of Artmove Record Counter For BJ
        /* HHG Record Counter For HHG IM */
        else if (o.Shipment_Details__c =='IM Door to Door' || o.Shipment_Details__c =='IM Door to Port'||
        o.Shipment_Details__c =='IM DTD Inbound' || o.Shipment_Details__c =='3rd Country Move') {
            list<Record_Type_Counter__c> ort1 = [select Count__c, Name 
            from Record_Type_Counter__c where Name = 'HHG IM'];
            /* :o.recordtypeid */
            if(ort1.size() > 0){
                Record_Type_Counter__c ort = ort1.get(0);
                ort.count__c++;
                String tempCounter = String.valueOf(ort.count__c);
                /* o.myCounter__c = 'DS/'+ dateString.substring(3,5) + '/' + tempCounter.substring(0,4); */
                o.myCounter__c =tempCounter.removeEnd('.0');
                //update ort;
                objRecord_Type_Counter.add(ort);
            }
        }//end of HHG Record Counter For HHG IM
        /* HHG Record Counter For HHG LM */
        else if (o.Shipment_Details__c =='Local Move') {
        list<Record_Type_Counter__c> ort1 = [select Count__c, Name 
            from Record_Type_Counter__c where Name = 'HHG LM'];
            /* :o.recordtypeid */
            if(ort1 != null  && ort1.size()>0){
                Record_Type_Counter__c ort = ort1.get(0);
                ort.count__c++;
                String tempCounter = String.valueOf(ort.count__c);
                /* o.myCounter__c = 'DS/'+ dateString.substring(3,5) + '/' + tempCounter.substring(0,4); */
                o.myCounter__c =tempCounter.removeEnd('.0');
                //update ort;
                objRecord_Type_Counter.add(ort);
            }
        }//end of HHG Record Counter For HHG LM
        
        /* HHG Record Counter For HHG WA */
        else if (o.Shipment_Details__c =='Warehousing') {
        list<Record_Type_Counter__c> ort1 = [select Count__c, Name 
            from Record_Type_Counter__c where Name = 'HHG WA'];
            /* :o.recordtypeid */
            if(ort1.size() > 0){
                Record_Type_Counter__c ort = ort1.get(0);
                ort.count__c++;
                String tempCounter = String.valueOf(ort.count__c);
                /* o.myCounter__c = 'DS/'+ dateString.substring(3,5) + '/' + tempCounter.substring(0,4); */
                o.myCounter__c =tempCounter.removeEnd('.0');
                //update ort;
                objRecord_Type_Counter.add(ort);
            }
        }//end of HHG Record Counter For HHG WA
        
        /* HHG Record Counter For HHG OS */
        else if (o.Shipment_Details__c =='Origin Services') {
        list<Record_Type_Counter__c> ort1 = [select Count__c, Name 
            from Record_Type_Counter__c where Name = 'HHG OS'];
            /* :o.recordtypeid */
            if(ort1.size() > 0){
                Record_Type_Counter__c ort = ort1.get(0);
                 System.debug('Origin Services'+ ort.count__c);
                ort.count__c++;
                  System.debug('Origin Services++'+ ort.count__c++);
                String tempCounter = String.valueOf(ort.count__c);
                /* o.myCounter__c = 'DS/'+ dateString.substring(3,5) + '/' + tempCounter.substring(0,4); */
                o.myCounter__c =tempCounter.removeEnd('.0');
                //update ort;
                objRecord_Type_Counter.add(ort);
            }
        }//end of HHG Record Counter For HHG OS
        
        /* HHG Record Counter For HHG OM */
        else if (o.Shipment_Details__c =='Office Move') {
        list<Record_Type_Counter__c> ort1 = [select Count__c, Name 
            from Record_Type_Counter__c where Name = 'HHG OM'];
            /* :o.recordtypeid */
            if(ort1.size() > 0){
                Record_Type_Counter__c ort = ort1.get(0);
                ort.count__c++;
                String tempCounter = String.valueOf(ort.count__c);
                /* o.myCounter__c = 'DS/'+ dateString.substring(3,5) + '/' + tempCounter.substring(0,4); */
                o.myCounter__c =tempCounter.removeEnd('.0');
                //update ort;
                objRecord_Type_Counter.add(ort);
            }
        }//end of HHG Record Counter For HHG OM
        /* HHG Quote Record Counter */
        if (o.Quote_Mode__c =='IM' || o.Quote_Mode__c =='LM'||
        o.Quote_Mode__c =='WA' || o.Quote_Mode__c =='OS' || o.Quote_Mode__c =='OM') {
        list<Record_Type_Counter__c> ort3 = [select Count__c, Name 
            from Record_Type_Counter__c where Name = 'HHG Quote'];
            if(ort3.size() > 0){
                Record_Type_Counter__c ort2 = ort3.get(0);
                System.debug('Record_Type_Counter__c'+ ort2.count__c);
                ort2.count__c++;
                System.debug('Record_Type_Counter__c'+ ort2.count__c++);
                String tempCounter2 = String.valueOf(ort2.count__c);
                o.QuoteCounter__c =tempCounter2.removeEnd('.0');
                //update ort2;
                objRecord_Type_Counter.add(ort2);
            }
        }//end of HHG Record Counter For HHG Quote
        /* Artmove Quote Counter For ALL AM Div */
        else if ((rtMap.get('ArtmoveHK') != null && o.RecordTypeId == rtMap.get('ArtmoveHK').Id) || (rtMap.get('Artmove') != null && o.RecordTypeId == rtMap.get('Artmove').Id) 
        || (rtMap.get('ArtmoveFP') != null && o.RecordTypeId == rtMap.get('ArtmoveFP').Id) || (rtMap.get('ArtmoveSH') != null && o.RecordTypeId == rtMap.get('ArtmoveSH').Id) 
        || (rtMap.get('ArtmoveBJ') != null && o.RecordTypeId == rtMap.get('ArtmoveBJ').Id) && o.Tariff_Rate__c == False) {
            list<Record_Type_Counter__c> ort3 = [select Count__c, Name 
            from Record_Type_Counter__c where Name = 'AM ALL Quote' limit 1];
            if(ort3.size() > 0){
                Record_Type_Counter__c ort2 = ort3.get(0);
                ort2.count__c++;
                String tempCounter2 = String.valueOf(ort2.count__c);
                o.QuoteCounter__c =tempCounter2.removeEnd('.0');
                //update ort2;
                objRecord_Type_Counter.add(ort2);
            }
        }//end of Artmove Quote Counter For ALL AM Div
    }
    if(!objRecord_Type_Counter.isEmpty() && !Test.isRunningTest()) update objRecord_Type_Counter;
    system.debug('-------------'+objRecord_Type_Counter);
    //opportunity o=trigger.new[0];
    /* Artmove Record Counter For BJ 
    else if (o.RecordTypeId =='01220000000JTDC') {
    Record_Type_Counter__c ort = [select Count__c, Name 
        from Record_Type_Counter__c where Name = '01220000000JTDC'];
        //:o.recordtypeid 
        ort.count__c++;
        String tempCounter = String.valueOf(ort.count__c);
        
        // o.myCounter__c = 'DS/'+ dateString.substring(3,5) + '/' + tempCounter.substring(0,4); 
        o.myCounter__c =tempCounter.removeEnd('.0');
        update ort;
    }//end of Artmove Record Counter For BJ*/
}