<cfquery name="PostFavorite" datasource="webwarecl">
	INSERT INTO favorites(user_id,
    					url,
                        title,
						docked)
	VALUES		(#url.user_id#,
    			'#url.urlval#',
                '#url.title#',
				#url.docked#)                        
</cfquery>