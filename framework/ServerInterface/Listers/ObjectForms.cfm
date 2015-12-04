<cfquery name="GetForms" datasource="webwarecl">
	SELECT * FROM Forms WHERE ObjectTypeID=#attributes.id#
</cfquery>
<br />
<cfoutput query="GetForms">
	<a href="####" onclick="RenderForm(#id#);">#FormDescription#</a><br />
</cfoutput>	