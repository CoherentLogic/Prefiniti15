<cfquery name="DelFave" datasource="webwarecl">
	DELETE FROM favorites WHERE id=#url.id#
</cfquery>    