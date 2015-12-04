<cfquery name="gusers" datasource="webwarecl">
	SELECT * FROM Users WHERE id < 700
</cfquery>


<cfoutput query="gusers">
	<cfmodule template="/migration/addfirst.cfm" uid="#id#">
</cfoutput>