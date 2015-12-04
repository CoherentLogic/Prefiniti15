
<cffunction name="pmSiteProjects" returntype="query">
	<cfargument name="site_id" type="numeric" required="yes">
    
    <cfquery name="psp" datasource="webwarecl">
    	SELECT * FROM pm_master_projects WHERE site_id=#site_id#
	</cfquery>
    
    <cfreturn #psp#>
</cffunction>

<cffunction name="pmGetKeywordName" returntype="string">
	<cfargument name="keyword_id" type="numeric" required="yes">

	<cfquery name="pmGKN" datasource="webwarecl">
    	SELECT keyword_name FROM pm_searchable_keywords WHERE id=#keyword_id#
    </cfquery>	
    
    <cfreturn #pmGKN.keyword_name#>
    
</cffunction>

<cffunction name="pmWriteProjectKeyword" returntype="string">
	<cfargument name="project_id" type="numeric" required="yes">
    <cfargument name="keyword_id" type="numeric" required="yes">
    <cfargument name="keyword_value" type="string" required="yes">
    
    <cfquery name="pmWPK" datasource="webwarecl">
    	INSERT INTO pm_keyword_entries
        	(project_id,
            keyword_id,
            keyword_value)
		VALUES
        	(#project_id#,
            #keyword_id#,
            '#keyword_value#')
	</cfquery>
    
    <cfparam name="rv" default="">
    <cfset rv = "KEYWORD INSTALLED : " & pmGetKeywordName(keyword_id) & "-&gt;" & keyword_value & "<br>">
    <cfreturn #rv#>

</cffunction>           

<cffunction name="pmGetProjectTypes" returntype="query">
	<cfargument name="site_id" type="numeric">
    
    <cfquery name="pmGPT" datasource="webwarecl">
    	SELECT * FROM pm_project_types WHERE site_id=#site_id#
	</cfquery>
    
    <cfreturn #pmGPT#>
</cffunction>         

<cffunction name="pmGetProjectTypeKeywords" returntype="query">
	<cfargument name="project_type_id" type="numeric" required="yes">
    
    <cfquery name="pmGPTK" datasource="webwarecl">
    	SELECT * FROM pm_searchable_keywords WHERE project_type_id=#project_type_id#
	</cfquery>
    
    <cfreturn #pmGPTK#>        
</cffunction>    

<cffunction name="pmGetProjectTypeName" returntype="string">
	<cfargument name="project_type_id" type="numeric" required="yes">
    
    <cfquery name="pmGPTN" datasource="webwarecl">
    	SELECT typename FROM pm_project_types WHERE id=#project_type_id#
    </cfquery>
    
    <cfreturn #pmGPTN.typename#>
</cffunction>    