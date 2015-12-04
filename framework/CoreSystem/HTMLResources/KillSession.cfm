<cfquery name="ks" datasource="webwarecl">
	UPDATE auth_tokens SET active=0 WHERE session_key='#URL.SessionID#'
</cfquery>
Session ended.