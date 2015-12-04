<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfquery name="ges" datasource="webwarecl">
	SELECT *
    FROM	shift_events
    WHERE	site_id=#url.current_site_id#
    AND		shift_date=#CreateODBCDate(attributes.targetDate)#
</cfquery>
<cfparam name="sh" default="">
<cfoutput query="ges">
	<cfset sh = sh & getLongname(user_id) & ": " & TimeFormat(start_time, "h:mm tt") & " - " & TimeFormat(end_time, "h:mm tt") & "<br>">
</cfoutput>

<cfif ges.RecordCount GT 0>
	<cfoutput>
    <img src="/graphics/group.png" onmouseover="Tip('#sh#');" onmouseout="UnTip();">
    </cfoutput>
</cfif>    

<cfif url.permissionlevel EQ 1>
    <cfquery name="ppbd" datasource="webwarecl">
        SELECT * FROM projects WHERE DATE_SUB(CURDATE(), INTERVAL 7 DAY) < dueDate AND status=0 AND rfp!=1 AND DATE(dueDate)=#CreateODBCDate(attributes.targetDate)#  AND site_id=#url.current_site_id# ORDER BY dueDate ASC
    </cfquery>
<cfelse>
    <cfquery name="ppbd" datasource="webwarecl">
        SELECT * FROM projects WHERE DATE_SUB(CURDATE(), INTERVAL 7 DAY) < dueDate AND status=0 AND rfp!=1 AND DATE(dueDate)=#CreateODBCDate(attributes.targetDate)#  AND site_id=#url.current_site_id# AND clientID=#url.calledByUser# ORDER BY dueDate ASC
    </cfquery>
</cfif>


<div style="height:60px; width:80px; font-size:8px;">
<cfif #ppbd.RecordCount# GT 0>
<cfoutput query="ppbd">
	
    <a href="javascript:AjaxLoadPageToDiv('projInfo', '/workFlow/components/projectSummaryURL.cfm?id=#id#');"><cfif #clsJobNumber# NEQ "">#clsJobNumber#<cfelse>[No project number]</cfif></a>
</cfoutput>
<cfelse>
	
</cfif>

    



</div>