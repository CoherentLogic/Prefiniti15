
<!--- view options --->
	<cfparam name="monthNameFormat" default="">
    <cfparam name="dayNameFormat" default="">
    
    <cfswitch expression="#attributes.view#">
    	<cfcase value="small">
        	<cfset monthNameFormat = "mmm">
            <cfset dayStyle="font-size:8px; color:##C0C0C0; border:1px solid ##C0C0C0;">
		</cfcase>
        <cfcase value="medium">
        	<cfset monthNameFormat = "mmm">
            <cfset dayStyle="font-size:12px; color:##C0C0C0; border:1px solid ##C0C0C0;">
        </cfcase>
        <cfcase value="large">
        	<cfset monthNameFormat = "mmmm">
            <cfset dayStyle="font-size:16px; color:##C0C0C0; border:1px solid ##C0C0C0;">
		</cfcase>
	</cfswitch>            
    
                        

<!--- date calcs --->
<cfparam name="dateToFetch" default="">
<cfset dateToFetch = attributes.date>

<cfoutput>
	<cfparam name="fdom" default="">
    <cfparam name="monthStartsOn" default="">
   	<cfparam name="monthEndsOn" default="">
    
    <cfparam name="startDateCode" default="">
    <cfparam name="endDateCode" default="">
    
    <cfparam name="previousMonth" default="">
    <cfset previousMonth = DateFormat(DateAdd("m", -1, dateToFetch), "mm/dd/yyyy")>
    <cfparam name="nextMonth" default="">
    <cfset nextMonth = DateFormat(DateAdd("m", 1, dateToFetch), "mm/dd/yyyy")>
    
	<cfset fdom = CreateDate(Year(dateToFetch), Month(dateToFetch), 1)>
    <cfset ldom = (DateAdd("m", 1, fdom) - 1)>
    
    <cfset monthStartsOn = DateFormat(fdom, "ddd")>
    <cfset monthEndsOn = DateFormat(ldom, "d")>
    
    <cfswitch expression="#monthStartsOn#">
    	<cfcase value="Sun">
        	<cfset startDateCode = 1>
		</cfcase>            
    	<cfcase value="Mon">
        	<cfset startDateCode = 2>
		</cfcase>            
    	<cfcase value="Tue">
        	<cfset startDateCode = 3>
		</cfcase>            
    	<cfcase value="Wed">
        	<cfset startDateCode = 4>
		</cfcase>            
    	<cfcase value="Thu">
        	<cfset startDateCode = 5>
		</cfcase>            
    	<cfcase value="Fri">
        	<cfset startDateCode = 6>
		</cfcase>            
    	<cfcase value="Sat">
        	<cfset startDateCode = 7>
		</cfcase>            
    
    </cfswitch>
   
    
</cfoutput>    


<cfparam name="dayIndex" default="">
<cfset dayIndex = 0>
<cfparam name="inMonth" default="">
<cfset inMonth = false>
<cfparam name="moreRows" default="">
<cfset moreRows = true>
<cfparam name="currentDate" default="">

<div <cfoutput> style="border:1px solid ##999999; width:#attributes.width#px;" </cfoutput>>
<table width="100%"  cellpadding="2" cellspacing="0" border="0" >
<tr>
	<th colspan="7"><cfoutput><img src="/graphics/resultset_previous.png" align="absmiddle" onclick="#attributes.onDateChange#('#previousMonth#')"> #DateFormat(dateToFetch, "#monthNameFormat# yyyy")# <img src="/graphics/resultset_next.png" align="absmiddle" onclick="#attributes.onDateChange#('#nextMonth#')"></cfoutput></th>    
</tr>
	<cfif attributes.view EQ "small">
        <tr>
        <th>S</th>
        <th>M</th>
        <th>T</th>
        <th>W</th>
        <th>T</th>
        <th>F</th>
        <th>S</th>
        </tr>
    </cfif>
    <cfif attributes.view EQ "medium">
        <tr>
        <th>Sun</th>
        <th>Mon</th>
        <th>Tue</th>
        <th>Wed</th>
        <th>Thu</th>
        <th>Fri</th>
        <th>Sat</th>
        </tr>
	</cfif>
    <cfif attributes.view EQ "large">        
        <tr>
        <th>Sunday</th>
        <th>Monday</th>
        <th>Tuesday</th>
        <th>Wednesday</th>
        <th>Thursday</th>
        <th>Friday</th>
        <th>Saturday</th>
        </tr>
	</cfif>        
<cfloop from="1" to="6" index="calCol">
	<cfif moreRows EQ true>
	<tr>
		<cfloop from="1" to="7" index="calRow">
	    	<cfif calCol EQ 1>
            	<cfif calRow EQ startDateCode>
                	<cfset inMonth = true>
					<cfset dayIndex = 1>
                </cfif>
			<cfelse>
            	                  
            </cfif>                
                
			<cfif inMonth EQ true>
                <td <cfoutput>style="#dayStyle#"</cfoutput>>
					<cfoutput>
					
					<cfset currentDate = DateFormat(CreateDate(Year(dateToFetch), Month(dateToFetch), dayIndex), "mm/dd/yyyy")>

					
                    <cfif currentDate EQ DateFormat(Now(), "mm/dd/yyyy")>
                    
						<strong style="color:red;">#dayIndex#</strong>
					<cfelse>
                    	#dayIndex#
					</cfif>
                    
                    <cfmodule template="#attributes.viewer#" attributecollection="#attributes#" targetDate="#currentDate#">
                    
					</cfoutput>                                                
                </td>
                <cfset dayIndex = dayIndex + 1>
            <cfelse>
                <td>&nbsp;</td>
            </cfif>    
            
            <cfif dayIndex GT monthEndsOn>
               	<cfset inMonth = false>
                
                	<cfset moreRows = false>
				                    
			</cfif>                  
           	                   	
    	</cfloop>
	</tr> 
    </cfif>       
</cfloop>
</table> 
</div>   

