({
    callServerData : function(component, event) {
        var action = component.get("c.fetchChecklistItems");
        action.setParams({"wareHouseLoc" : component.get("v.locationName")
                         });
        //console.log('locationName'+component.get("v.locationName"));
        action.setCallback(this,function(response){
            if(response.getState()==='SUCCESS'){
                var pickList = ($A.get("$Label.c.Picklist").split(';'));
                component.set("v.pickListOption",pickList);
                var result = response.getReturnValue();
                //console.log(JSON.stringify(result));
                component.set("v.Master_Checklist_Item__c",response.getReturnValue());
                
                this.hideSpinner(component, event);
            }
            else{
                this.hideSpinner(component, event);
                var errors = action.getError();
                alert('Error occurred please try after sometime');
                var RecId = component.get('v.recId');
                window.location.href="/"+RecId;
            }
        });
        $A.enqueueAction(action);
    },
    
    setdata : function(component, answerObj,name) {
        let dt = component.get("v.answersList");
        let notFound = true;
        let rc = [];
        for(let i=0;i<dt.length;i++){
            if(dt[i].id===answerObj.id){
                if(name==='picklist'){
                    dt[i].picklist=answerObj.picklist;
                }else if(name==='remarks'){
                    dt[i].remarks=answerObj.remarks;
                }
                
                notFound=false;
            }
            rc.push(dt[i]);
            //alert(dt[i]);
        }
        if(notFound){
            console.log('This');
            dt.push(answerObj);
            component.set("v.answersList",dt);
        }else{
            component.set("v.answersList",rc);
        }
        //console.log('answerlist------>',component.get("v.answersList"));
    },
    
    showSpinner: function (component, event) {
        var spinner = component.find("mySpinner");
        $A.util.removeClass(spinner, "slds-hide");
    },
    
    hideSpinner: function (component, event) {
        var spinner = component.find("mySpinner");
        $A.util.addClass(spinner, "slds-hide");
    },
    
    checkValidate: function (component, event, helper) {
        //console.log('inside helper');
        var allValid = component.find('field').reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && !inputCmp.get('v.validity').valueMissing;
        }, true);
        //console.log('allvalid'+allValid);
        if (allValid) {
            return "true";
        } else {
            return "false";
        }
    }
})