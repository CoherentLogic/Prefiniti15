<cfquery name="shiftDay" datasource="webwarecl">
	SELECT 	* 	
    FROM 	shift_events
    WHERE 	user_id=#attributes.user_id# 
    AND 	site_id=#attributes.site_id# 
    AND		shift_date=#CreateODBCDate(attributes.targetDate)#
</cfquery>

<cfparam name="hrsSched" default="">
<cfset hrsSched = DateDiff("h", shiftDay.start_time, shiftDay.end_time)>


<cfif shiftDay.RecordCount EQ 0>
	<span style="color:red;">Not Scheduled</span>
<cfelse>    
	<cfoutput query="shiftDay">
		<strong>ON: </strong>#TimeFormat(start_time, "h:mm TT")#-#TimeFormat(end_time, "h:mm TT")# (#hrsSched# hrs.)<br />
	</cfoutput>
</cfif>            