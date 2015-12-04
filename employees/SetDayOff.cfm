<!---var url = "/employees/SetDayOff.cfm?user_id=" + escape(user_id);
	url += "&site_id=" + escape(site_id);
	url += "&day=" + escape(day);
	url += "&value=" + escape(value);--->
<cfparam name="fval" default="">
<cfif URL.value EQ "true">
	<cfset fval = 1>
<cfelse>
	<cfset fval = 0>
</cfif>        

<cfquery name="UpdateShift" datasource="webwarecl">
	UPDATE 	shift_day
    SET		day_off=#fval#
    WHERE 	day_code=#URL.day#
    AND		user_id=#URL.user_id#
    AND		site_id=#URL.site_id#
</cfquery>

<cfoutput>Days off have been changed.</cfoutput>