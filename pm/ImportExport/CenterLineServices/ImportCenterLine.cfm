<cfquery name="getOldProjects" datasource="webwarecl">
	SELECT id, clsJobNumber FROM projects WHERE site_id=1
</cfquery>

<cfquery name="clrMP" datasource="webwarecl">
	DELETE FROM pm_master_projects WHERE site_id=1
</cfquery>   

<cfquery name="clrMP" datasource="webwarecl">
	DELETE FROM pm_keyword_entries
</cfquery> 

<h1>Center Line Services Project Import</h1>
<hr />
Importing <cfoutput>#getOldProjects.RecordCount#</cfoutput> projects into new pm tables...
<blockquote>
<cfoutput query="getOldProjects">
	Importing project #clsJobNumber#...<br />
    <cfmodule template="/pm/ImportExport/CenterLineServices/WriteSingleProject.cfm" project_id="#id#">
    Project #clsJobNumber# imported.<br /><br />
</cfoutput> 
</blockquote>
Completed.       