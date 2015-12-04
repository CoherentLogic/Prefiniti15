<cfquery name="cda" datasource="webware_cms">
	DELETE FROM file_associations WHERE id=#url.assoc_id#
</cfquery>

    