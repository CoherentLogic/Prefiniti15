<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfquery name="GChatContents" datasource="webwarecl">
	SELECT * FROM chat_entries WHERE (FromUser=#URL.FromUser# AND ToUser=#URL.ToUser#) OR (ToUser=#URL.FromUser# AND FromUser=#URL.ToUser#)  ORDER BY CTimeStamp
</cfquery>

<cfquery name="SetRead" datasource="webwarecl">
	UPDATE chat_entries SET PRead=1 WHERE (FromUser=#URL.FromUser# AND ToUser=#URL.ToUser#) OR (ToUser=#URL.FromUser# AND FromUser=#URL.ToUser#)
</cfquery>
<cfoutput query="GChatContents">
	<p><strong>#getLongname(FromUser)#:</strong> #Body#<br /></p>    
</cfoutput>    


    