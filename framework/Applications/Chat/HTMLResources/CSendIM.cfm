<cfquery name="sendim" datasource="webwarecl">
	INSERT INTO chat_entries 	(FromUser,
    							ToUser,
                                Body,
                                CTimeStamp)
	VALUES						(#URL.FromUser#,
    							#URL.ToUser#,
                                '#URL.Text#',
                                #CreateODBCDateTime(Now())#)
</cfquery>                                                                
                                