<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfquery name="get_messages" datasource="webwarecl">
	SELECT * FROM messageinbox WHERE id=#attributes.id#
</cfquery>

<cfset rt = CreateObject("component", "Res")>
<cfoutput query="get_messages">
		<cfset rtype = "Mail Message">
		<cfset rowner = fromuser>
		<cfset rsite = 5>
		<cfset rname = tsubject>
		<cfset redit = 'javascript:ORMSNoAction();'>
		<cfset rview = 'javascript:viewMessage(#id#)'>
		<cfset rdel = "javascript:ORMSNoAction();">
		<cfset rthumb = "/graphics/prefmail.png">
		<cfset rpk = id>
		
		<cfswitch expression="#tread#">
			<cfcase value="yes">
				<cfset rstat = "Read">
			</cfcase>
			<cfcase value="no">
				<cfset rstat = "Unread">
			</cfcase>
		</cfswitch>
		<cfset rpar = "NONE">												
		
		<cfset rt.Crup(rtype, rowner, rsite, rname, redit, rview, rdel, rthumb, rpk, rstat, rpar)>	
		<cfscript>
			rt.AddPair("Message/Body", tbody);
			rt.AddPair("Message/Sender", getLongname(fromuser));
			rt.AddPair("Message/Recipient", getLongname(touser));
			rt.AddPair("Message/Subject", tsubject);			
		</cfscript>
</cfoutput>