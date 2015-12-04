<cfquery name="CloseSession" datasource="webwarecl">
	UPDATE auth_tokens
	SET		active=0,
			logout_date=#CreateODBCDateTime(Now())#
	WHERE	session_key='#URL.HP_SessionKey#'
</cfquery>