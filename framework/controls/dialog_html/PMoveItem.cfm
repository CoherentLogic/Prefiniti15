<!--
	URL Parameters:
    FolderItemID
    TargetFolderID
-->

<cfquery name="pmi" datasource="webwarecl">
	UPDATE	folder_items
    SET		ContainingFolder=#URL.TargetFolderID#
    WHERE	id=#URL.FolderItemID#
</cfquery>