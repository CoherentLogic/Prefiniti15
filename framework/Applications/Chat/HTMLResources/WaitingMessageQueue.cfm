<cfinclude template="/socialnet/socialnet_udf.cfm">


<cfquery name="GetWaitingConversations" datasource="webwarecl">
	SELECT DISTINCT FromUser, ToUser FROM chat_entries WHERE ToUser=#URL.calledByUser# AND PRead=0
</cfquery>

<cfif GetWaitingConversations.RecordCount NEQ 0>
	<br>
    <h3>Waiting for Chat Response:</h3>

	<blockquote>
	<cfoutput query="GetWaitingConversations">
        <img src="/graphics/AppIconResources/crystal_project/32x32/apps/chat.png" width="16" height="16" align="absmiddle" /> <a href="####" onclick="CGetChatWindow(#FromUser#, #ToUser#, '#getLongname(FromUser)#', '#getLongname(ToUser)#');">#getLongname(FromUser)#</a><br />
    </cfoutput>
    </blockquote>
</cfif>        
