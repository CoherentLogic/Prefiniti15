
<cfquery name="ChkShiftDay" datasource="webwarecl">
	SELECT * FROM shift_day WHERE day_code=#attributes.day# AND user_id=#attributes.user_id# AND site_id=#attributes.site_id#
</cfquery>   

<cfquery name="getTimes" datasource="webwarecl">
	SELECT * FROM time_lookup
</cfquery>

<cfif ChkShiftDay.RecordCount EQ 0>
	<cfquery name="CrtShftDay" datasource="webwarecl">
    	INSERT INTO shift_day 
        	(day_code,
            start_time,
            end_time,
            day_off,
            pay_day,
            user_id,
            site_id)
		VALUES
        	(#attributes.day#,
            #CreateODBCTime('8:00 AM')#,
            #CreateODBCTime('5:00 PM')#,
            <cfswitch expression="#attributes.day#">
            	<cfcase value="0">
                1,
                </cfcase>
                <cfcase value="6">
                1,
                </cfcase>
                <cfdefaultcase>
                0,
                </cfdefaultcase>
			</cfswitch>
            0,
            #attributes.user_id#,
            #attributes.site_id#)
	</cfquery>
</cfif>                                       

<cfquery name="GetShiftDay" datasource="webwarecl">
	SELECT * FROM shift_day WHERE day_code=#attributes.day# AND user_id=#attributes.user_id# AND site_id=#attributes.site_id#
</cfquery>         


<div>

<label>Start: 
	<select <cfoutput>name="ShiftStart_#attributes.day#" id="ShiftStart_#attributes.day#" onchange="ER_UpdateShift('start_time', #attributes.user_id#, #attributes.site_id#, #attributes.day#, this.value, 'time');"</cfoutput> <cfif GetShiftDay.day_off EQ 1>disabled</cfif>>
    	<cfoutput query="getTimes">
            <option value="#time_12hour#" <cfif time_12hour EQ TimeFormat(GetShiftDay.start_time, "h:mm TT")>selected</cfif>>#time_12hour#</option>
        </cfoutput>
    </select></label><br> 
    <label>End:
    <select <cfoutput>name="ShiftEnd_#attributes.day#" id="ShiftEnd_#attributes.day#"  onchange="ER_UpdateShift('end_time', #attributes.user_id#, #attributes.site_id#, #attributes.day#, this.value, 'time');"</cfoutput> <cfif GetShiftDay.day_off EQ 1>disabled</cfif>>
    	<cfoutput query="getTimes">
            <option value="#time_12hour#" <cfif time_12hour EQ TimeFormat(GetShiftDay.end_time, "h:mm TT")>selected</cfif>>#time_12hour#</option>
        </cfoutput>
    </select></label><br> 
<cfoutput>    
<label><input type="checkbox" name="DayOff_#attributes.day#" id="DayOff_#attributes.day#" onclick="ER_SetDayOff(#attributes.user_id#, #attributes.site_id#, #attributes.day#, IsChecked('DayOff_#attributes.day#'));" <cfif GetShiftDay.day_off EQ 1>checked</cfif>>Off</label>
</cfoutput>


</div>
