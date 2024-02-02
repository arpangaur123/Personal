trigger updateETDETD on Opportunity (before update) {
	
	opportunity o=trigger.new[0];
	
	Integer myDay = -1;
    Integer myDay2 = -1;
    Integer myMonth = -1;
    Integer myMonth2 = -1;
    Integer myYear = -1;
    Integer myYear2 = -1;
    if (o.ETA__c != null ) {
    	Date myDate = o.ETA__c;
    	myDay = myDate.day();
    	myMonth = myDate.month();
    	myYear = myDate.year();
    }
    if (o.ETD__c != null ) {
    	Date myDate2 = o.ETD__c;
    	myDay2 = myDate2.day();
    	myMonth2 = myDate2.month();
    	myYear2 = myDate2.year();
    }
    String ETAmonth = '';
    String ETDmonth = '';
    if ( myMonth != null) {
    	if (myMonth == 1) {
    		ETAmonth = 'January';
    	}
    	else if (myMonth == 2) {
    		ETAmonth = 'February';
    	}
    	else if (myMonth == 3) {
    		ETAmonth = 'March';
    	}
    	else if (myMonth == 4) {
    		ETAmonth = 'April';
    	}
    	else if (myMonth == 5) {
    		ETAmonth = 'May';
    	}
    	else if (myMonth == 6) {
    		ETAmonth = 'June';
    	}
    	else if (myMonth == 7) {
    		ETAmonth = 'July';
    	}
    	else if (myMonth == 8) {
    		ETAmonth = 'August';
    	}
    	else if (myMonth == 9) {
    		ETAmonth = 'September';
    	}
    	else if (myMonth == 10) {
    		ETAmonth = 'October';
    	}
    	else if (myMonth == 11) {
    		ETAmonth = 'November';
    	}
    	else if (myMonth == 12) {
    		ETAmonth = 'December';
    	}
    }
    if (myMonth2 != null) {
    	if (myMonth2 == 1) {
    		ETDmonth = 'January';
    	}
    	else if (myMonth2 == 2) {
    		ETDmonth = 'February';
    	}
    	else if (myMonth2 == 3) {
    		ETDmonth = 'March';
    	}
    	else if (myMonth2 == 4) {
    		ETDmonth = 'April';
    	}
    	else if (myMonth2 == 5) {
    		ETDmonth = 'May';
    	}
    	else if (myMonth2 == 6) {
    		ETDmonth = 'June';
    	}
    	else if (myMonth2 == 7) {
    		ETDmonth = 'July';
    	}
    	else if (myMonth2 == 8) {
    		ETDmonth = 'August';
    	}
    	else if (myMonth2 == 9) {
    		ETDmonth = 'September';
    	}
    	else if (myMonth2 == 10) {
    		ETDmonth = 'October';
    	}
    	else if (myMonth2 == 11) {
    		ETDmonth = 'November';
    	}
    	else if (myMonth2 == 12) {
    		ETDmonth = 'December';
    	}
    }
    if (myYear != -1) {
	    o.ETA_String__c = myDay.format() + ' ' + ETAmonth + ' ' + myYear.format().substring(0,1) + myYear.format().substring(2,5);
	    System.debug('========================   AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA  ========================' + o.ETA_String__c);
	}
	if (myYear2 != -1) {
	    o.ETD_String__c = myDay2.format() + ' ' + ETDmonth + ' ' + myYear2.format().substring(0,1) + myYear2.format().substring(2,5);
	    System.debug('========================   AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA  ========================' + o.ETD_String__c);
	}
}