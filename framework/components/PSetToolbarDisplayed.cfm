<!--
	toolbar_id
	value
-->

<cfquery name="setdisp" datasource="webwarecl">
	UPDATE installed_toolbars SET display=#url.value#
	WHERE	user_id=#url.user_id#
	AND		toolbar_id=#url.toolbar_id#
</cfquery>	