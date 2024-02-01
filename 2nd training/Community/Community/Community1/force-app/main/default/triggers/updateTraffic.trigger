trigger updateTraffic on Traffic__c (before insert, before update) {
	
	Traffic__c t = trigger.new[0];
	
	if (t.Load_1__c == true && t.Load_2__c != true && t.Quantity_of_Containers__c != null 
	&& t.Packages__c != null && t.Gross_Weight_KG__c != null && t.Volume_CBM__c != null) {
		t.Total_Content__c = t.Quantity_of_Containers__c.intValue() + ' x ' + t.Container_Type__c + ' STC ' 
		+ t.Packages__c.intValue() + ' PKGS*' + '\n' + '*' + t.Content__c;
		
		t.Gross_Weight_Combi__c = String.valueOf(t.Gross_Weight_KG__c.intValue());
		t.Volume_Combi__c = String.valueOf(t.Volume_CBM__c.intValue());
		t.Total_Gross_Weight_KG__c = t.Gross_Weight_KG__c;
		t.Total_Volume_CBM__c = t.Volume_CBM__c;
	}
	else if (t.Load_1__c == true && t.Load_2__c == true && t.Quantity_of_Containers__c != null 
	&& t.Packages__c != null && t.Quantity_of_Container_2__c != null && t.Packages_2__c!= null && t.Gross_Weight_KG__c != null 
	&& t.Gross_Weight_2_KG__c != null && t.Volume_CBM__c != null && t.Volume_2_CBM__c != null) {
		t.Total_Content__c = t.Quantity_of_Containers__c.intValue() + ' x ' + t.Container_Type__c + ' STC ' 
		+ t.Packages__c.intValue() + ' PKGS*' + '\n'
		+ t.Quantity_of_Container_2__c.intValue() + ' x ' + t.Container_Type_2__c + ' STC ' 
		+ t.Packages_2__c.intValue() + ' PKGS*' + '\n' + '*' + t.Content__c;
		
		t.Gross_Weight_Combi__c = String.valueOf(t.Gross_Weight_KG__c.intValue()) + '\n' + String.valueOf(t.Gross_Weight_2_KG__c.intValue());
		t.Volume_Combi__c = String.valueOf(t.Volume_CBM__c.intValue()) + '\n' + String.valueOf(t.Volume_2_CBM__c.intValue());
		t.Total_Gross_Weight_KG__c = t.Gross_Weight_KG__c + t.Gross_Weight_2_KG__c;
		t.Total_Volume_CBM__c = t.Volume_CBM__c + t.Volume_2_CBM__c;
	}
	
}