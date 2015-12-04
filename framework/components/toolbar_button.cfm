<cfinclude template="/authentication/authentication_udf.cfm">

<cfquery name="btn" datasource="webwarecl">
	SELECT * FROM toolbars WHERE id=#attributes.toolbar_id#
</cfquery>

<cfparam name="ButtonType" default="">
<cfset ButtonType = wwReadConfig(attributes.user_id, "PF_TOOLBAR_STYLE")>

	
<cfoutput query="btn"><span class="LargeButton" onclick="OpenLanding('#landing_page#');">
	<img src="#icon#" align="absmiddle" onmouseover="Tip('#toolbar_name#');" onmouseout="UnTip();">
</span></cfoutput>