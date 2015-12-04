<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfquery name="ges" datasource="webwarecl">
	SELECT *
    FROM	shift_events
    WHERE	site_id=#attributes.site_id#
    AND		shift_date=#CreateODBCDate(attributes.date)#
</cfquery>



<cfif ges.RecordCount GT 0>
<strong>HR Available:</strong><br /><br />

<cfparam name="shiftTime" default="">
	
<cfoutput query="ges">
	<cfset shiftTime = TimeFormat(start_time, "h:mm tt") & "-" & TimeFormat(end_time, "h:mm tt")>
    
	<a href="##" onmouseover="Tip('#shiftTime#');" onmouseout="UnTip();" onclick="viewProfile15(#user_id#);">#getLongname(user_id)#</a><br>
</cfoutput>
</cfif>
