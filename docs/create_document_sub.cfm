<cfquery name="create_document" datasource="webwarecl">
	INSERT INTO documents
    	(help_context_id,
        author_id,
        doc_title,
        doc_body,
        keywords,
        created_date,
        catalog_id)
    VALUES
    	(#form.help_context_id#,
        #session.userid#,
        '#form.doc_title#',
        '#form.doc_body#',
        '#form.keywords#',
        #CreateODBCDateTime(Now())#,
        #form.catalog_id#)
</cfquery>

<strong>Document Created</strong>        

<script>
	hideSplash();
</script>	        
        