<cfquery name="GetFiles" datasource="centerline">
	SELECT 
    	projectID, 
        filePath, 
        longName, 
        clientID 
    FROM 
    	centerline.files
</cfquery>


<cfoutput query="GetFiles">
	File <strong>#filePath#</strong> is associated with project number <strong>
	<cfmodule template="/OldCLMigration/GetFileProject.cfm" projectID="#projectID#"> </strong>
    <br>
</cfoutput>           