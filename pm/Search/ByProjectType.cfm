<cfinclude template="/pm/pm_udf.cfm">

<cfparam name="pks" default="">
<cfset pks = pmGetProjectTypeKeywords(URL.ProjectType)>

<cfparam name="rc" default="">
<cfset rc = 0>
<cfparam name="ac" default="">

<style>
.myTable td { background-color:transparent; }
</style>

<table width="100%" cellpadding="2" cellspacing="0" class="myTable">   
<cfoutput query="pks">
	<cfset rc = rc + 1>
 	
    <cfif rc EQ 1>
    	<cfset ac = false>
	<cfelse>
    	<cfset ac = true>
	</cfif>                
    
	<cfmodule template="/pm/Search/Keyword.cfm" keyword_name="#keyword_name#" keyword_id="#id#" allow_condition="#ac#">
</cfoutput>    
</table>

<input type="button" class="normalButton" value="Begin Search">