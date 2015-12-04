<cfquery name="sfp" datasource="webware_cms">
	UPDATE user_files SET access_level=#url.value# WHERE id=#url.file_id#
</cfquery>

<strong style="color:red;">Security settings updated.</strong>