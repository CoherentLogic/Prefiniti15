<cfquery name="mv" datasource="webwarecl">
	SELECT * FROM profile_visits WHERE source_age>=18 AND target_age < 18 AND source_id=#attributes.source_id#
</cfquery>

<cfoutput>Has visited #mv.RecordCount# minor's profiles.</cfoutput>