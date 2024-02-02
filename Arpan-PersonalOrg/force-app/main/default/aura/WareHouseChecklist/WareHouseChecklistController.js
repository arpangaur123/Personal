({	
    init : function(component, event, helper) {
        helper.showSpinner(component, event);
        helper.callServerData(component, event);
    },
    
    handleSave : function(component, event, helper){
        helper.showSpinner(component, event);
        console.log(component.get("v.answersList"));
        var ansLst = component.get("v.answersList");
        // console.log(JSON.stringify(component.get("v.Master_Checklist_Item__c")));
        var requiredcount = 0;
        for(var i = 0; i < ansLst.length; i++){
            //console.log(ansLst[i].id);
            //console.log(ansLst[i].picklist);
            //console.log(ansLst[i].remarks.length);
            if(ansLst[i].picklist == 'No' && typeof ansLst[i].remarks === "undefined"){
                document.getElementById(ansLst[i].id).style.display = 'block';
                requiredcount++;
                // document.getElementById(ansLst[i].id+'rem').style.border = '1px solid rgb(194, 57, 52)';
            } else if(ansLst[i].picklist == 'No' &&  ansLst[i].remarks == ''){
                document.getElementById(ansLst[i].id).style.display = 'block';
                requiredcount++;
                // document.getElementById(ansLst[i].id+'rem').style.border = '1px solid rgb(194, 57, 52)';
            }
                else{
                    
                    document.getElementById(ansLst[i].id).style.display = 'none';
                }
        }
        //console.log(requiredcount);
        var isValid = helper.checkValidate(component, event, helper);        
        if(isValid == 'true'){
            if($A.util.isEmpty(component.get("v.answersList"))) {
                component.set("v.fillMinAns","true");
                component.set("v.showMessage","false");
                var staticLabel = $A.get("$Label.c.CheckList_Form");
                //alert(staticLabel);
                helper.hideSpinner(component, event);
            } else {
                if(requiredcount == 0){
                    
                    
                    //console.log('--error->'+JSON.stringify(component.get("v.answersList")));
                    var action = component.get("c.saveRec");
                    component.set("v.fillMinAns","false");
                    component.set("v.showMessage","false");
                    console.log('WareHouse details--- '+component.get('v.recId'));
                    //console.log('list'+JSON.stringify(component.get("v.answersList")));
                    action.setParams({"masterAnswers":JSON.stringify(component.get("v.answersList")),
                                      "WarehouseDetails" : component.get('v.recId'),
                                      "InspectedBy" : component.get('v.InspectedByUser'),
                                      "frequencyPicklist" : component.get("v.selectedFrequency"),
                                     });
                    action.setCallback(this,function(response){
                        if(response.getState()==='SUCCESS'){
                            var result = response.getReturnValue();
                            //console.log('result--->'+result);
                            if(!$A.util.isEmpty(result)){
                                window.location.href="/"+result;
                            }else{
                                alert('Error occurred please try after sometime');
                                var RecId = component.get('v.recId');
                                window.location.href="/"+RecId;
                            }
                        }
                        else{
                            var errors = action.getError();
                            alert('Error occurred please try after sometime');
                            var RecId = component.get('v.recId');
                            window.location.href="/"+RecId;
                        }
                        helper.hideSpinner(component, event);
                    });
                    $A.enqueueAction(action);
                } else{
                    helper.hideSpinner(component, event);
                }
            }
        } else {
            component.set("v.showMessage","true");
            helper.hideSpinner(component, event);
        }
    },
    
    onSelectchange: function(component, event, helper) {
        try{
            //var frequenctyPicklsitValue = component.get("v.selectedFrequency");
            //alert(frequenctyPicklsitValue);
            var RecValue = event.getSource().get("v.value");
            var elementName = event.getSource().get("v.name");
            var accKey = event.getSource().get("v.accesskey");
            var objData = {};
            if(elementName==='picklist'){
                objData.id=accKey;
                objData.picklist=RecValue;
                helper.setdata(component,objData,elementName);
            }else if(elementName==='remarks'){
                objData.id=accKey;
                objData.remarks=RecValue;
                helper.setdata(component,objData,elementName);
            }
        }catch(error){
            //console.log('err-------:?'+error);
        }
        
    },
    
    handleCancel : function(component, event, helper){
        var RecId = component.get('v.recId');
        window.location.href="/"+RecId;
    },
    
    setInspectedBy : function(component, event, helper){
        var inspctdBy = event.getSource().get("v.value");
        component.set("v.InspectedByUser",inspctdBy);
    }    
})