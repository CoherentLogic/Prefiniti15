<cfparam name="fval" default="">

<cfswitch expression="#url.special_field#">
	<cfcase value="time">
    	<cfset fval = CreateODBCTime(URL.value)>
    </cfcase>
    <cfdefaultcase>
    	<cfset fval = "'" & URL.value & "'">
    </cfdefaultcase>
</cfswitch>    
    
<cfquery name="UpdateShift" datasource="webwarecl">
	UPDATE 	shift_day
    SET		#URL.field#=#fval#
    WHERE 	day_code=#URL.day#
    AND		user_id=#URL.user_id#
    AND		site_id=#URL.site_id#
</cfquery>

Changes Saved.    