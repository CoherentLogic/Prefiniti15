<cfinclude template="/pm/pm_udf.cfm">

<cfparam name="projectTypes" default="">
<cfset projectTypes = pmGetProjectTypes(URL.current_site_id)>

<div style="width:700px; height:450px; background-color:#C0C0C0; border:1px solid #C0C0C0;">
	<h3 class="stdHeader">Search Projects</h3>
	<div style="padding:20px;">
    <div style="border:1px solid black; padding:5px;">
    	<strong>Project Type:</strong> 
        
        <select id="PM_SearchProjectType">
        	<cfoutput query="projectTypes">
            	<option value="#id#">#typename#</option>
			</cfoutput>                
        </select>
        
        <input type="button" class="normalButton" value="Go" onclick="PM_BeginSearch(GetSelectedValue('PM_SearchProjectType'));">
        
        <div id="PM_SearchKeywords">
        
        </div>
    </div>
    </div>
</div>