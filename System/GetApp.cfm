
<cfsetting showdebugoutput="no">
<cfcontent type="application/x-javascript">

<cfscript>
	theJSON = createObject("component", "System.App").Open(URL.AppID).GetJSON();
	writeOutput(theJSON);
</cfscript>	