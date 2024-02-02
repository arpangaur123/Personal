trigger Job_Reference_tgr on Job_Reference__c (before insert) {
    map<String,RecordType> rtMap = new map<String,RecordType>();
    map<String,Record_Type_Counter__c> rtcMap = new map<String,Record_Type_Counter__c>();
    set<Id> OpportunityIds = new set<Id>();
    list<Record_Type_Counter__c> objRecord_Type_Counter = new list<Record_Type_Counter__c>();
    
    for(Job_Reference__c jro: trigger.new){
        if(jro.Opportunity__c != null){
            OpportunityIds.add(jro.Opportunity__c);
        }
    }
    
    map<Id, Opportunity> opps = new map<Id, Opportunity>();
    
    if(OpportunityIds.size() > 0){
        opps = new Map<Id,Opportunity>([Select Tariff_Rate__c,Quote_Mode__c,RecordTypeId,Shipment_Details__c,SAMJobType__c,SAM__c,SAMAssign__c, Name,Sales_Person_HHG__c,CS_Shipping_HHG__c,Person_In_Charge__c,Sales_Person__c From Opportunity WHERE Id IN:OpportunityIds]);
    }
    
    for(RecordType rt:[SELECT SobjectType, NamespacePrefix, Name, Id FROM RecordType where SobjectType ='Opportunity' OR SobjectType='Rate_Reply__c' limit 1000]){
        rtMap.put(rt.Name.toUpperCase(),rt);          
    }
    
    for(Record_Type_Counter__c rtc:[select Count__c, Name from Record_Type_Counter__c limit 9999]){
        rtcMap.put(rtc.Name.toUpperCase(),rtc);
    }
    
    for(Job_Reference__c jr: trigger.new){
        if(jr.Name!= null && jr.Name != '' && !jr.Name.contains('-')){
            Opportunity jrOpp = new Opportunity();
            
            if(jrOpp != null && opps.containsKey(jr.Opportunity__c)){
                jrOpp = opps.get(jr.Opportunity__c);
            }
            
            /* Inbound Record Counter */
            if (rtMap.get('INBOUND') != null && jrOpp.RecordTypeId == rtMap.get('INBOUND').Id ){//012200000008avZAAQ           
                if(rtcMap.containsKey('INBOUND')){
                    Record_Type_Counter__c ort = rtcMap.get('INBOUND');
                    ort.count__c++;
                    jr.Name = 'AM'+((jrOpp.SAMJobType__c!= null && jrOpp.SAMJobType__c != '')?jrOpp.SAMJobType__c:'')+ (''+System.TODAY().year()).subString(2,4)+ort.count__c+((jrOpp.SAM__c != null && jrOpp.SAM__c != '')?jrOpp.SAM__c:'')+((jrOpp.SAMAssign__c != null && jrOpp.SAMAssign__c != '')?jrOpp.SAMAssign__c:'');
                    objRecord_Type_Counter.add(ort);
                }
            }
            
            /* Artmove Record Counter For SG */
            else if (rtMap.get('ARTMOVE') != null && jrOpp.RecordTypeId == rtMap.get('ARTMOVE').Id){//012200000008bhJ
                if(rtcMap.containsKey('ARTMOVE')){
                    Record_Type_Counter__c ort = rtcMap.get('ARTMOVE');
                    ort.count__c++;
                    jr.Name = 'AM'+jrOpp.SAMJobType__c+ (''+System.TODAY().year()).subString(2,4)+ort.count__c+((jrOpp.SAM__c != null && jrOpp.SAM__c != '')?jrOpp.SAM__c:'')+((jrOpp.SAMAssign__c != null && jrOpp.SAMAssign__c != '')?jrOpp.SAMAssign__c:'');
                    objRecord_Type_Counter.add(ort);
                }
            }
            
            /* Artmove Record Counter For HTTR */
            else if (rtMap.get('HTTR') != null && jrOpp.RecordTypeId == rtMap.get('HTTR').Id){//01220000000JTCx
                if(rtcMap.containsKey('JAPAN JOB REFERENCE COUNT')){
                    Record_Type_Counter__c ort = rtcMap.get('JAPAN JOB REFERENCE COUNT');
                    ort.Count__c++;
                    String tempCounter = String.valueOf(ort.Count__c);
                    /*String i;                                        Commented by vijay on 6 Jan 17.
                    if(tempCounter.length()  == 1){
                     i='100';
                    }
                    else{
                     i= '10';
                    }*/
                    if(jrOpp.Person_In_Charge__c != Null){
                     jr.Name = 'JP'+jrOpp.SAMJobType__c+ (''+System.TODAY().year()).subString(2,4)/*+i*/+ort.Count__c+((jrOpp.Sales_Person__c!= null && jrOpp.Sales_Person__c!= '')?jrOpp.Sales_Person__c:'')+((jrOpp.Person_In_Charge__c!= null && jrOpp.Person_In_Charge__c!= '')?jrOpp.Person_In_Charge__c:'');
                    }
                    else{
                    jr.Name = 'JP'+jrOpp.SAMJobType__c+ (''+System.TODAY().year()).subString(2,4)/*+i*/+ort.Count__c+((jrOpp.Sales_Person__c!= null && jrOpp.Sales_Person__c!= '')?jrOpp.Sales_Person__c:'')+((jrOpp.Person_In_Charge__c== null && jrOpp.Person_In_Charge__c == '')?jrOpp.Person_In_Charge__c:'HT');
                    }
                    objRecord_Type_Counter.add(ort);
                }
            }
            
            /* Artmove Record Counter For HK */
            else if (rtMap.get('ARTMOVEHK') != null && jrOpp.RecordTypeId == rtMap.get('ARTMOVEHK').Id){//01220000000JTD7
                if(rtcMap.containsKey('ARTMOVEHK')){
                    Record_Type_Counter__c ort = rtcMap.get('ARTMOVEHK');
                    ort.count__c++;
                    jr.Name = 'AM'+jrOpp.SAMJobType__c+ (''+System.TODAY().year()).subString(2,4)+ort.count__c+((jrOpp.SAM__c != null && jrOpp.SAM__c != '')?jrOpp.SAM__c:'')+((jrOpp.SAMAssign__c != null && jrOpp.SAMAssign__c != '')?jrOpp.SAMAssign__c:'');
                    objRecord_Type_Counter.add(ort);
                }
            }
            
            /* Artmove Record Counter For SH */
            else if (rtMap.get('ARTMOVESH') != null && jrOpp.RecordTypeId == rtMap.get('ARTMOVESH').Id){//01220000000JTD2
                if(rtcMap.containsKey('ARTMOVESH')){
                    Record_Type_Counter__c ort = rtcMap.get('ARTMOVESH');
                    ort.count__c++;
                    jr.Name = 'AM'+jrOpp.SAMJobType__c+ (''+System.TODAY().year()).subString(2,4)+ort.count__c+((jrOpp.SAM__c != null && jrOpp.SAM__c != '')?jrOpp.SAM__c:'')+((jrOpp.SAMAssign__c != null && jrOpp.SAMAssign__c != '')?jrOpp.SAMAssign__c:'');
                    objRecord_Type_Counter.add(ort);
                    system.debug('objRecord_Type_Counter>>'+objRecord_Type_Counter);                
                }
                system.debug('SH>>'+rtMap.get('ARTMOVESH'));       
            }
            
            /* Artmove Record Counter For BJ */
            else if (rtMap.get('ARTMOVEBJ') != null && jrOpp.RecordTypeId == rtMap.get('ARTMOVEBJ').Id){//01220000000JTDC
                 if(rtcMap.containsKey('ARTMOVEBJ')){
                    Record_Type_Counter__c ort = rtcMap.get('ARTMOVEBJ');
                    ort.count__c++;
                    jr.Name = 'AM'+jrOpp.SAMJobType__c+ (''+System.TODAY().year()).subString(2,4)+ort.count__c+((jrOpp.SAM__c != null && jrOpp.SAM__c != '')?jrOpp.SAM__c:'')+((jrOpp.SAMAssign__c != null && jrOpp.SAMAssign__c != '')?jrOpp.SAMAssign__c:'');
                    objRecord_Type_Counter.add(ort);
                }
            }
            
            /* Artmove Record Counter For BJ */
            else if (rtMap.get('ARTMOVEFP') != null && jrOpp.RecordTypeId == rtMap.get('ARTMOVEFP').Id){//01220000000JTDC
                 if(rtcMap.containsKey('ARTMOVEFP')){
                    Record_Type_Counter__c ort = rtcMap.get('ARTMOVEFP');
                    ort.count__c++;
                    jr.Name = 'FP'+jrOpp.SAMJobType__c+ (''+System.TODAY().year()).subString(2,4)+ort.count__c+((jrOpp.SAM__c != null && jrOpp.SAM__c != '')?jrOpp.SAM__c:'')+((jrOpp.SAMAssign__c != null && jrOpp.SAMAssign__c != '')?jrOpp.SAMAssign__c:'');
                    objRecord_Type_Counter.add(ort);
                }
            }
            
            /* HHG Record Counter For HHG IM */
            else if (jrOpp.Shipment_Details__c =='IM Door to Door' || jrOpp.Shipment_Details__c =='IM Door to Port'||
            jrOpp.Shipment_Details__c =='IM DTD Inbound' || jrOpp.Shipment_Details__c =='3rd Country Move') {
                if(rtcMap.containsKey('HHG IM')){
                    Record_Type_Counter__c ort = rtcMap.get('HHG IM');
                    ort.count__c++;
                    jr.Name = 'AM'+jrOpp.SAMJobType__c+ (''+System.TODAY().year()).subString(2,4)+ort.count__c+((jrOpp.SAM__c != null && jrOpp.SAM__c != '')?jrOpp.SAM__c:'')+((jrOpp.SAMAssign__c != null && jrOpp.SAMAssign__c != '')?jrOpp.SAMAssign__c:'');
                    objRecord_Type_Counter.add(ort);
                }
            }
            
            /* HHG Record Counter For HHG LM */
            else if (jrOpp.Shipment_Details__c =='Local Move') {
                if(rtcMap.containsKey('HHG LM')){
                    Record_Type_Counter__c ort = rtcMap.get('HHG LM');
                    ort.count__c++;
                    jr.Name = 'AM'+jrOpp.SAMJobType__c+ (''+System.TODAY().year()).subString(2,4)+ort.count__c+((jrOpp.SAM__c != null && jrOpp.SAM__c != '')?jrOpp.SAM__c:'')+((jrOpp.SAMAssign__c != null && jrOpp.SAMAssign__c != '')?jrOpp.SAMAssign__c:'');
                    objRecord_Type_Counter.add(ort);
                }
            }        
            
            /* HHG Record Counter For HHG WA */
            else if (jrOpp.Shipment_Details__c =='Warehousing') { 
                 if(rtcMap.containsKey('HHG WA')){
                    Record_Type_Counter__c ort = rtcMap.get('HHG WA');
                    ort.count__c++;
                    jr.Name = 'AM'+jrOpp.SAMJobType__c+ (''+System.TODAY().year()).subString(2,4)+ort.count__c+((jrOpp.SAM__c != null && jrOpp.SAM__c != '')?jrOpp.SAM__c:'')+((jrOpp.SAMAssign__c != null && jrOpp.SAMAssign__c != '')?jrOpp.SAMAssign__c:'');
                    objRecord_Type_Counter.add(ort);
                }
            }
            
                /* HHG Record Counter For HHG OS */
            else if (jrOpp.Shipment_Details__c =='Origin Services') {
                if(rtcMap.containsKey('HHG OS')){
                    Record_Type_Counter__c ort = rtcMap.get('HHG OS');
                    ort.count__c++;
                    jr.Name = 'AM'+jrOpp.SAMJobType__c+ (''+System.TODAY().year()).subString(2,4)+ort.count__c+((jrOpp.SAM__c != null && jrOpp.SAM__c != '')?jrOpp.SAM__c:'')+((jrOpp.SAMAssign__c != null && jrOpp.SAMAssign__c != '')?jrOpp.SAMAssign__c:'');
                    objRecord_Type_Counter.add(ort);
                }
            }        
            
            /* HHG Record Counter For HHG OM */
            else if (jrOpp.Shipment_Details__c =='Office Move') {
                if(rtcMap.containsKey('HHG OM')){
                    Record_Type_Counter__c ort = rtcMap.get('HHG OM');
                    ort.count__c++;
                    jr.Name = 'AM'+jrOpp.SAMJobType__c+ (''+System.TODAY().year()).subString(2,4)+ort.count__c+((jrOpp.SAM__c != null && jrOpp.SAM__c != '')?jrOpp.SAM__c:'')+((jrOpp.SAMAssign__c != null && jrOpp.SAMAssign__c != '')?jrOpp.SAMAssign__c:'');
                    objRecord_Type_Counter.add(ort);
                }
            }
            
            /* HHG Quote Record Counter */
            else if (jrOpp.Quote_Mode__c =='IM' || jrOpp.Quote_Mode__c =='LM'||
            jrOpp.Quote_Mode__c =='WA' || jrOpp.Quote_Mode__c =='OS' || jrOpp.Quote_Mode__c =='OM') {
                if(rtcMap.containsKey('HHG QUOTE')){
                    Record_Type_Counter__c ort = rtcMap.get('HHG QUOTE');
                    ort.count__c++;
                    jr.Name = 'AM'+jrOpp.SAMJobType__c+ (''+System.TODAY().year()).subString(2,4)+ort.count__c+((jrOpp.SAM__c != null && jrOpp.SAM__c != '')?jrOpp.SAM__c:'')+((jrOpp.SAMAssign__c != null && jrOpp.SAMAssign__c != '')?jrOpp.SAMAssign__c:'');
                    objRecord_Type_Counter.add(ort);
                }
            }
            
            /* Artmove Quote Counter For ALL AM Div */
            else if ((rtMap.get('ArtmoveHK') != null && jrOpp.RecordTypeId == rtMap.get('ArtmoveHK').Id) || (rtMap.get('Artmove') != null && jrOpp.RecordTypeId == rtMap.get('Artmove').Id) 
            || (rtMap.get('ArtmoveFP') != null && jrOpp.RecordTypeId == rtMap.get('ArtmoveFP').Id) || (rtMap.get('ArtmoveSH') != null && jrOpp.RecordTypeId == rtMap.get('ArtmoveSH').Id) 
            || (rtMap.get('ArtmoveBJ') != null && jrOpp.RecordTypeId == rtMap.get('ArtmoveBJ').Id) && jrOpp.Tariff_Rate__c == False) {
                if(rtcMap.containsKey('AM ALL QUOTE')){
                    Record_Type_Counter__c ort = rtcMap.get('AM ALL QUOTE');
                    ort.count__c++;
                    jr.Name = 'AM'+jrOpp.SAMJobType__c+ (''+System.TODAY().year()).subString(2,4)+ort.count__c+((jrOpp.SAM__c != null && jrOpp.SAM__c != '')?jrOpp.SAM__c:'')+((jrOpp.SAMAssign__c != null && jrOpp.SAMAssign__c != '')?jrOpp.SAMAssign__c:'');
                    objRecord_Type_Counter.add(ort);
                }
            }
        }
    }    
    if(!objRecord_Type_Counter.isEmpty()) update objRecord_Type_Counter; 

    
    
}