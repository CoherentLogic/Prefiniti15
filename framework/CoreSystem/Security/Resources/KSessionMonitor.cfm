<cfquery name="gsess" datasource="webwarecl">
	SELECT active FROM auth_tokens WHERE session_key='#URL.HP_SessionKey#'
</cfquery>
<cfoutput>#gsess.active#</cfoutput>