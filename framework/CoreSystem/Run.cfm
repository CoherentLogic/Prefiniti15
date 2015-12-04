<head>
	<title>The Prefiniti Network</title>
</head>
<cfif IsDefined("URL.FW_RUNLEVEL")>
<body style="background-color:#2957A2;" id="PGlobalScreen" onResize="handleAppResize();">	

<center>
<div id="PrefinitiLogo" style="top:150px; position:absolute;" align="center">
	<img src="/graphics/prefinitispl.jpg"><br>
	<strong>Version 2.0 (Beta Release 1)</strong><br>
	Copyright &copy; 2009, AJL Intel-Properties LLC<br>
	Patent Pending.
</div>
</center>
<script>
	

	
	var imgWidth = 425;
	var imgHeight = 450;
	var screenWidth = 0;
	var screenHeight = 0;
	
	if (window.innerWidth) {
		screenWidth = window.innerWidth;
		screenHeight = window.innerHeight;
	}
	else if (document.all) {
		screenWidth = document.body.clientWidth;
		screenHeight = document.body.clientHeight;
	}
	
	var leftPos = (screenWidth / 2) - (imgWidth / 2);
	var leftPosX = (screenWidth / 2) - (317 / 2);
	var topPos = (screenHeight / 2) - (imgHeight / 2);
	
	
	var lbRef = AjaxGetElementReference('HostInfo');
	var ldRef = AjaxGetElementReference('PrefinitiLogo');
	ldRef.style.left = leftPosX + "px";
	
	var lbWidth = lbRef.clientWidth;
	var lbHeight = lbRef.clientHeight;
	
	var lbLeftPos = (screenWidth / 2) - (lbWidth / 2);
	lbRef.style.left = lbLeftPos + "px";
	lbRef.style.top = topPos + 180 + "px";
	
</script>

</body>
</cfif>