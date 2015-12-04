<cfcontent type="text/xml">
<cfquery name="ObjDef" datasource="webwarecl">
	SELECT DefaultView FROM exportedobjects WHERE id=#URL.ObjectTypeID#
</cfquery>

<cfquery name="v" datasource="webwarecl">
	SELECT XSLT FROM object_views WHERE id=#ObjDef.DefaultView#
</cfquery>

<cfoutput query="v">#XSLT#</cfoutput>    