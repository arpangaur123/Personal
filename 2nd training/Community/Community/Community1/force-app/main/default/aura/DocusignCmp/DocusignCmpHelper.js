({
	helperMethod : function(component, event, helper,curObjID) {
		
		var relContElem = curObjID + "_ContentDocumentRelatedList_body";
		var rc = "";
		var relatedContentElem = document.getElementById(relContElem);
	
		if (relatedContentElem != null)
		{ 
			var aList = relatedContentElem.getElementsByTagName("a");
			for (var i = 0; aList.length; i++)
            		{
		                var alink = aList[i].getAttribute("href");
		                if ( (alink !=null) && (alink != undefined) &&  (alink.indexOf("/068") === 0/* || (alink.indexOf("javascript:srcUp(%27%2F068")) === 0 */) )
		                {   
		                    rc = rc + alink.substr(alink.indexOf("068"), 15) + ",";
		                }
            		} 
			if (rc.indexOf("068") > -1)
			{
				rc = rc.substring(0, rc.lastIndexOf(","));
			}
		}
        component.set('v.rcValue',rc);
		
	
	}
})