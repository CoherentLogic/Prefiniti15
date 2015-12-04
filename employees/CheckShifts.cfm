<cfinclude template="/framework/framework_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">
<cfquery name="tl" datasource="webwarecl">
	SELECT * FROM time_lookup
</cfquery>     	

<cfparam name="times" default="">
<cfset times=ArrayNew(1)>

<cfoutput query="tl" >
	<cfset times[block_id] = time_12hour>
</cfoutput>    

<cfparam name="startBlock" default="">
<cfparam name="endBlock" default="">

<cfparam name="curTime" default="">
<cfparam name="msgText" default="">
<cfparam name="evtype" default="">
<cfparam name="evtime" default="">

<cfparam name="tse" default="">
<cfset tse = 0>

<cfset startBlock = attributes.beginBlock>
<cfset endBlock = startBlock + 3>

<cfloop from="#startBlock#" to="#endBlock#" index="i">
	<cfset curTime = times[i]>

	<cfquery name="gse" datasource="webwarecl">
    	SELECT * FROM shift_events 
        WHERE 	user_id=#attributes.user_id# 	
        AND		shift_date=#CreateODBCDate(attributes.date)#
        AND		(start_time=#CreateODBCTime(times[i])# OR end_time=#CreateODBCTime(times[i])#)
	</cfquery>
    
    <cfif gse.RecordCount GT 0>
    	<cfoutput query="gse">
        	<cfset tse = tse + 1>
            <cfif TimeFormat(start_time, "h:mm tt") EQ times[i]>
            	<cfset evtype = "begins">
                <cfset evtime = start_time>
			<cfelse>
            	<cfset evtype = "ends">
                <cfset evtime = end_time>
            </cfif>
                            
            <cfset msgText = msgText & "Shift " & evtype & " for " & getSiteNameByID(site_id) & " at " & TimeFormat(evtime, "h:mm tt") & ".<br>">
            
        </cfoutput>
	</cfif>
</cfloop>   

<cfif tse GT 0>
	<cfoutput>
	<img src="/graphics/clock.png" align="absmiddle" onmouseover="Tip('#msgText#');" onmouseout="UnTip();"> <span style="font-size:6px;">(#tse# events)</span>
    </cfoutput>
</cfif>    
    