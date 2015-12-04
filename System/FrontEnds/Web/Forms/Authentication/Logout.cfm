<cftry>
<cfscript>
	session.User.CloseSession();
</cfscript>
<cfcatch>
<cfoutput>#cfcatch.Message#</cfoutput>
</cfcatch>
</cftry>

<cflocation url="/System/FrontEnds/Web/Forms/Authentication/Login.cfm" addtoken="no">