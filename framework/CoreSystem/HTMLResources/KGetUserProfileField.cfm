<cfquery name="kgupf" datasource="webwarecl">
	SELECT #URL.field# FROM Users WHERE id=#URL.UserID#
</cfquery>

<cfoutput query="kgupf">
	#URL.field#
</cfoutput>