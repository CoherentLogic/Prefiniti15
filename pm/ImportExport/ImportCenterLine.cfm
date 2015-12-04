<cfquery name="getOldProjects" datasource="webwarecl">
	SELECT * FROM projects WHERE site_id=1
</cfquery>

<cfoutput query="getOldProjects">
    <cfmodule template="/pm/ImportExport/CenterLineServices
</cfoutput>        