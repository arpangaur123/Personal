({
	doInit : function(component, event, helper) {
        
		component.set("v.showSpinner",true);
        var action = component.get("c.apiPushInfo");
        action.setParams({
            "recordId":component.get("v.recordId")
        });
        action.setCallback(this,function(response){
            if(response.getState() === "SUCCESS"){
                //alert('res-->>'+response.getReturnValue());
                $A.get("e.force:closeQuickAction").fire();
                if(response.getReturnValue().includes('success')){
                    $A.get('e.force:refreshView').fire();
                    helper.showToast(component,event,'SUCCESS!',response.getReturnValue().split('@')[1],'success');
                }else if(response.getReturnValue().includes('Error')){
                    helper.showToast(component,event,'Error!',response.getReturnValue().split('@')[1],'error');
                }else
                    helper.showToast(component,event,'WARNING!',response.getReturnValue().split('@')[1],'WARNING');
            }else{
                helper.showToast(component,event,'Error!',response.getReturnValue().split('@')[1],'error');
            }
            component.set("v.showSpinner",false);
        });
        $A.enqueueAction(action);
	},
    isRefreshed: function(component, event, helper) {
        location.reload();
    }
})