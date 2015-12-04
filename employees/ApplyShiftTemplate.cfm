<cfinclude template="/framework/framework_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">


<cfquery name="getShifts" datasource="webwarecl">
	SELECT * FROM shift_day WHERE user_id=#url.user_id# AND site_id=#url.site_id# ORDER BY day_code
</cfquery>

<cfparam name="TodayDate" default="">
<cfparam name="TerminusDate" default="">
<cfparam name="TotalDays" default="">

<cfset TodayDate = Now()>
<cfset TerminusDate = DateAdd(URL.unit_type, URL.units, TodayDate)>

<cfset TotalDays = DateDiff("d", TodayDate, TerminusDate)>

<!---
var url = "/employees/ApplyShiftTemplate.cfm?user_id=" + escape(user_id);
	url += "&site_id=" + escape(site_id);
	url += "&units=" + escape(units);
	url += "&unit_type=" + escape(unit_type);
	url += "&update_cal=" + escape(update_cal);
	url += "&tc_remind=" + escape(tc_remind);
	--->

<cfparam name="sm" default="">

<cfset sm="<strong>****EMPLOYEE SCHEDULE FOR " & UCase(getSiteNameByID(URL.site_id)) & "****</strong><br><br>">

<span style="color:red; font-weight:bold;">*** APPLYING SHIFT TEMPLATE ***</span><br><br>
<cfoutput>
<strong>USER: </strong>#getLongname(url.user_id)#<br>
<cfset sm = sm & "<strong>USER: </strong>#getLongname(url.user_id)#<br>">

<strong>START DATE: </strong>#DateFormat(TodayDate, "mm/dd/yyyy")#<br>
<cfset sm = sm & "<strong>START DATE: </strong>#DateFormat(TodayDate, "mm/dd/yyyy")#<br>">

<strong>END DATE: </strong>#DateFormat(TerminusDate, "mm/dd/yyyy")#<br>
<cfset sm = sm & "<strong>END DATE: </strong>#DateFormat(TerminusDate, "mm/dd/yyyy")#<br>">

<strong>TOTAL DAYS TO SCHEDULE: </strong>#TotalDays#<br>
<cfset sm = sm & "<strong>TOTAL DAYS SCHEDULED: </strong>#TotalDays#<br>">

</cfoutput>


<cfparam name="dn" default="">

<cfoutput query="getShifts">
	<cfswitch expression="#day_code#">
    	<cfcase value="0">
			<cfset dn = "Sun">
        </cfcase>
		<cfcase value="1">
			<cfset dn = "Mon">
        </cfcase>
		<cfcase value="2">
			<cfset dn = "Tue">
        </cfcase>
		<cfcase value="3">
			<cfset dn = "Wed">
        </cfcase>
		<cfcase value="4">
			<cfset dn = "Thu">
        </cfcase>
		<cfcase value="5">
			<cfset dn = "Fri">
        </cfcase>
		<cfcase value="6">
			<cfset dn = "Sat">
        </cfcase>
	
    </cfswitch>
                        	
	<cfset sm = sm & "<strong>#UCase(dn)#:</strong>">
    <cfif day_off EQ 0>
	    <cfset sm = sm & " #TimeFormat(start_time, "h:mm tt")# - #TimeFormat(end_time, "h:mm tt")#<br>">
    <cfelse>
    	<cfset sm = sm & " OFF<br>">
	</cfif>        
</cfoutput>

<cfset sm = sm & "<br><br>**** PLEASE DISREGARD ANY PRIOR SCHEDULE ****">

<cfparam name="curDay" default="">
<cfparam name="curDayCode" default="">
<cfparam name="dtStrStart" default="">
<cfparam name="dtStrEnd" default="">

<br>
<strong>CLEARING EXISTING SCHEDULE...</strong><br>
<cfquery name="clrExist" datasource="webwarecl">
  	DELETE FROM shift_events
    WHERE 	user_id=#url.user_id#
    AND		site_id=#url.site_id#
</cfquery> 
<strong>CLEARING EXISTING TIMESHEET REMINDERS...</strong><br>
<cfquery name="clrTSR" datasource="webwarecl">
	DELETE FROM scheduled_notifications
    WHERE		user_id=#url.user_id#
    AND			(event_key='TC_REMIND_STARTSHIFT' OR event_key='TC_REMIND_ENDSHIFT')
</cfquery> 
<cfquery name="clrMT" datasource="webwarecl">
	DELETE FROM scheduled_business_notifications
    WHERE		concerning_user=#url.user_id#
    AND			event_key='TC_MISSING_TS'
</cfquery>                     
<strong>SCHEDULING...</strong><br>
<cfloop from="1" to="#TotalDays#" index="currentOffset">
	<cfoutput><br>#currentOffset# of #TotalDays#</cfoutput>
	<cfset curDay = DateAdd("d", currentOffset, TodayDate)>
	
    <cfswitch expression="#DateFormat(curDay, 'dddd')#">
    	<cfcase value="Sunday">
        	<cfset curDayCode = 0>
		</cfcase>               	
    	<cfcase value="Monday">
        	<cfset curDayCode = 1>
		</cfcase>               	
    	<cfcase value="Tuesday">
        	<cfset curDayCode = 2>
		</cfcase>               	
    	<cfcase value="Wednesday">
        	<cfset curDayCode = 3>
		</cfcase>               	
        <cfcase value="Thursday">
        	<cfset curDayCode = 4>
		</cfcase>               	
    	<cfcase value="Friday">
        	<cfset curDayCode = 5>
		</cfcase>               	
    	<cfcase value="Saturday">
        	<cfset curDayCode = 6>
		</cfcase>  
	</cfswitch>                     	
    
    
    <cfoutput>#DateFormat(curDay, "mm/dd/yyyy")# [Code #curDayCode#]<br></cfoutput>
    
    <cfquery name="getDayShift" datasource="webwarecl">
    	SELECT * FROM shift_day WHERE user_id=#url.user_id# AND site_id=#url.site_id# AND day_code=#curDayCode#
	</cfquery>        
    
    
    <cfoutput> &gt;&gt;&gt;
       	<cfif getDayShift.day_off EQ 0>
           	<strong>DAY ON:</strong> Scheduling #TimeFormat(getDayShift.start_time, "h:mm tt")# - #TimeFormat(getDayShift.end_time, "h:mm tt")#<br>
            &gt;&gt;&gt; <strong>ADD TO EMPLOYEE CALENDAR...</strong>
            <cfif URL.update_cal EQ "true">
                 <span style="color:green;"> [yes]</span><br>
                 
                                   
                 
                 <cfquery name="atc" datasource="webwarecl">
                 	INSERT INTO shift_events
                    	(user_id,
                        site_id,
                        shift_date,
                        start_time,
                        end_time)
					VALUES
                    	(#url.user_id#,
                        #url.site_id#,
                        #CreateODBCDate(curDay)#,
                        #CreateODBCTime(getDayShift.start_time)#,
                        #CreateODBCTime(getDayShift.end_time)#)
				</cfquery>                                            
            <cfelse>
                 <span style="color:red;"> [no]</span><br>	
            </cfif>                                                
            
            &gt;&gt;&gt; <strong>ADD AUTOMATED TIMESHEET REMINDERS...</strong>
            <cfif URL.tc_remind EQ "true">
                <span style="color:green;"> [yes]</span><br>
                <!---<cffunction name="ntScheduleNotification" returntype="string">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="sender_id" type="numeric" required="yes">
    <cfargument name="event_key" type="string" required="yes">
    <cfargument name="body_text" type="string" required="yes">
    <cfargument name="date_time" type="string" required="yes">
	
	<cffunction name="ntScheduleBusinessNotification" returntype="string">
    <cfargument name="site_id" type="numeric" required="yes">
    <cfargument name="event_key" type="string" required="yes">
    <cfargument name="body_text" type="string" required="yes">
    <cfargument name="date_time" type="string" required="yes">
    <cfargument name="concerning_user" type="numeric" required="yes">
	
	--->
               
                	<cfset dtStrStart = DateFormat(curDay, "mm/dd/yyyy") & " " & TimeFormat(DateAdd("n", 15, getDayShift.start_time), "h:mm tt")>
                    <cfset dtStrEnd = DateFormat(curDay, "mm/dd/yyyy") & " " & TimeFormat(DateAdd("n", -15, getDayShift.end_time), "h:mm tt")>
                    <cfset dtStrStartB = DateFormat(curDay, "mm/dd/yyyy") & " " & TimeFormat(DateAdd("n", 30, getDayShift.start_time), "h:mm tt")>
                    
                    <cfparam name="uln" default="">
                    <cfset uln = getLongname(URL.user_id)>
                    
                    START-OF-SHIFT NOTIFICATION: #dtStrStart#<br>
                    END-OF-SHIFT NOTIFICATION: #dtStrEnd#<br>
                    START-OF-SHIFT MISSING TIME CARD BUSINESS EVENT: #dtStrStartB#<br />
                    
                    
                    START-OF-SHIFT SCHEDULER TASK ID: #ntScheduleNotification(URL.user_id, URL.user_id, "TC_REMIND_STARTSHIFT", "Please begin a timesheet for today.", dtStrStart)#<br>
                    END-OF-SHIFT SCHEDULER TASK ID: #ntScheduleNotification(URL.user_id, URL.user_id, "TC_REMIND_ENDSHIFT", "Please sign your timesheets for today.", dtStrEnd)#<br>
                    START-OF-SHIFT MISSING TIME CARD BUSINESS EVENT SCHEDULER TASK ID: #ntScheduleBusinessNotification(URL.site_id, "TC_MISSING_TS", uln & " has not opened a timesheet for today.", dtStrStartB, URL.user_id)#<br />
                    
                    
                    
            <cfelse>
                <span style="color:red;"> [no]</span><br>
            </cfif>  
        <cfelse>
           	<strong>DAY OFF:</strong> not scheduling any events for today<br>
		</cfif>
	</cfoutput>   
	                                              
    
</cfloop>

<cfoutput>
#ntNotify(URL.user_id, "SC_SHIFT_UPDATED", "Your work schedule has been updated.", "")#
</cfoutput>

<cfquery name="crScheduleMail" datasource="webwarecl">
	INSERT INTO webwarecl.messageinbox
    	(fromuser,
        touser,
        tsubject,
        tbody,
        tdate,
        tread,
        req_id)
	VALUES
    	(743,
        #url.user_id#,
        'YOUR WORK SCHEDULE FOR #UCase(getSiteNameByID(url.site_id))#',
        '#sm#',
        #CreateODBCDateTime(Now())#,
        0,
        '#CreateUUID()#')
</cfquery>                
	        