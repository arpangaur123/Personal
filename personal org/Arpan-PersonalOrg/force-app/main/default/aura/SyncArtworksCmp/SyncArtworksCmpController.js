({
    doInit : function(component, event, helper) {
        
        var action = component.get('c.getArtAppCount');
        var sobjectId = component.get('v.recordId');
        
        action.setParams({
            sobjectId : sobjectId
        });
        action.setCallback(this,function(response){
            
            var state = response.getState();
            if(state === 'SUCCESS'){
                var resp = response.getReturnValue();
                console.log(resp);
                if(resp){
                    console.log('redirect to url');
                    var urlEvent = $A.get("e.force:navigateToURL");
                    var urls = "/apex/CratetoArtworksSync?id="+sobjectId;
                    urlEvent.setParams({
                        "url": urls
                    });
                    urlEvent.fire();
                }else{
                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                        "type" : "warning",
                        "title": "Unable to Open",
                        "message": "No Artwork records are defined for this Crate, please define at least one Artwork record to proceed further"
                    });
                    resultsToast.fire();
                    
                    var dismissActionPanel = $A.get("e.force:closeQuickAction");
                    dismissActionPanel.fire();
                }
            }else{
                
            }
        });
        $A.enqueueAction(action);
    }
})