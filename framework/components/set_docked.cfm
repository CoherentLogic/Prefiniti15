<cfquery name="sdf" datasource="webwarecl">
	UPDATE favorites SET docked=#url.value# WHERE id=#url.id#
</cfquery>	