function includeTimbaBox(filename, isJs) {
	var head = document.getElementsByTagName('head')[0];
	if(isJs) {
		script = document.createElement('script');
		script.src = filename;
		script.type = 'text/javascript';
		head.appendChild(script);
	}
	else {
		link = document.createElement('link');
		link.href = filename;
		link.type = 'text/css';
		link.rel = "stylesheet";
		head.appendChild(link);
	}
	
}

includeTimbaBox("https://emea.salesforce.com/resource/1404982220000/zmulti/css/zmulti.css", false);
includeTimbaBox("https://emea.salesforce.com/resource/1404982220000/zmulti/js/jquery-1.4.2.js", true);
includeTimbaBox("/soap/ajax/18.0/connection.js", true);
includeTimbaBox("https://emea.salesforce.com/resource/1404982220000/zmulti/js/zmulti.js", true);