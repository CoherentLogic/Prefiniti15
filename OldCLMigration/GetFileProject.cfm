<cfquery name="GetFileProject" datasource="centerline">
	SELECT * FROM projects WHERE id=#attributes.projectID#
</cfquery>

<cfoutput query="GetFileProject">
	<cfif Trim(clsJobNumber) NEQ "">
	#clsJobNumber#
    <cfelse>
    [no project number - you can skip this one]
    </cfif>
</cfoutput>    