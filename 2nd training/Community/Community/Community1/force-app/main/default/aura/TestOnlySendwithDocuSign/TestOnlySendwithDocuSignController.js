({
    doInit : function(component, event, helper) {
        var sourceId = component.get("v.recordId");
        
        var sObjectName = component.get("v.sobjecttype");
        alert('== sObjectName '+sObjectName);
        var CRL;
        if(sObjectName == "artApp__Collector__c"){
            CRL = "";
        }else if(sObjectName == "Opportunity"){
            CRL = component.get("v.CRL");
        }
        
        var RC = component.get("v.RC");
        var RSL = component.get("v.RSL");
        var RSRO = component.get("v.RSRO");
        var RROS = component.get("v.RROS");
        var CCRM = component.get("v.CCRM");
        var CCTM = component.get("v.CCTM");
        var CCNM = component.get("v.CCNM");
        var CRCL = component.get("v.CRCL");
        var OCO = component.get("v.OCO");
        var DST = component.get("v.DST");
        var LA = component.get("v.LA");
        
        
        var CEM = component.get("v.CEM");
        var CES = component.get("v.CES");
        var STB = component.get("v.STB");
        var SSB = component.get("v.SSB");
        
        var SES = component.get("v.SES");
        var SEM = component.get("v.SEM");
        var SRS = component.get("v.SRS");
        var SCS = component.get("v.SCS");
        var RES = component.get("v.RES");
        
        var urls = "/apex/dsfs__DocuSign_CreateEnvelope?DSEID=0&SourceID="+sourceId+"&RC="+RC+"&RSL="+RSL+"&RSRO="+RSRO+"&RROS="+RROS+"&CCRM="+CCRM+"&CCTM="+CCTM+"&CRCL="+CRCL+"&CRL="+CRL+"&OCO="+OCO+"&DST="+DST+"&CCNM="+CCNM+"&LA="+LA+"&CEM="+CEM+"&CES="+CES+"&SRS="+SRS+"&STB="+STB+"&SSB="+SSB+"&SES="+SES+"&SEM="+SEM+"&SRS="+SRS+"&SCS="+SCS+"&RES="+RES;
        var urlEvent = $A.get("e.force:navigateToURL");
        alert('== urls '+urls);
        urlEvent.setParams({
            "url": urls
        });
        urlEvent.fire();
    }
})