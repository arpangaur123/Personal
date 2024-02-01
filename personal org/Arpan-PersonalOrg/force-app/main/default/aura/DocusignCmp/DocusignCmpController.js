({
	doInit : function(component, event, helper) {
		var sourceId = component.get('v.recordId');
        var rc = helper.GetRelContentIDs(component, event, helper,sourceId);
        var flagVar = false; 
        try {
                //flagVar =  (window.self !== window.top);
	    } catch (e) {
	        flagVar = true;
	    }
		if(flagVar){
			//window.open("{!BaseUrl}/apex/{!Namespace}DocuSign_CreateEnvelope?DSEID=0&amp;SourceID="+sourceId+"&amp;rc="+rc+"&amp;nw=1", "Popup", "location=1, status=1, scrollbars=1, resizable=1, directories=1, toolbar=1, titlebar=1, width=1200");
		} else {
			//window.location.href = "{!BaseUrl}/apex/{!Namespace}DocuSign_CreateEnvelope?DSEID=0&amp;SourceID="+sourceId+"&amp;rc="+rc;
		}
	}
})