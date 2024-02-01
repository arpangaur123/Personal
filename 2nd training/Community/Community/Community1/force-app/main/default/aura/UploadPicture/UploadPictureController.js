({
	doinit : function(component, event, helper) {
		var id = component.get("v.recordId");
        window.open("/apex/fileupload?id="+id,'_self');
	}
})