<cfquery name="GetRole" datasource="webwarecl">
	SELECT * FROM workflow_roles WHERE role_uuid='#url.role_uuid#'
</cfquery>


<cfoutput query="GetRole">
	TODO: build role editor (#role_name#)
</cfoutput>	
		