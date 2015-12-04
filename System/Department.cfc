<cfcomponent displayname="Department" hint="Handles business departments in Prefiniti" extends="System.Framework">
	<cfset this.DepartmentName = "">
    <cfset this.Manager = "">

    <cfset this.DBKey = "">
    
    <cffunction name="LoadByDBKey" hint="Load a department by its database primary key" returntype="System.Department" access="public">
    	<cfargument name="DBKey" type="numeric" required="yes" hint="The PK of the site">
        
        <cfquery name="qryLoadByDBKey" datasource="#this.SitesDatasource#">
        	SELECT * FROM departments WHERE id=#DBKey#
        </cfquery>
        
        <cfscript>
			this.DepartmentName = qryLoadByDBKey.department_name;
			this.Manager = createObject("component", "System.User").OpenByDBKey(qryLoadByDBKey.manager_id);
		</cfscript>
        
        <cfreturn #this#>
    </cffunction>
</cfcomponent>