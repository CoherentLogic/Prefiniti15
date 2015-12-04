<cfinclude template="/framework/framework_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfmodule template="/controls/weekCalendar.cfm" viewer="/employees/DaySchedule.cfm" showWeekend="false" startDate="firstDayOfWeek" user_id="#attributes.user_id#" site_id="#attributes.site_id#">