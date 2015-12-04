<cfparam name="startVal" default="1">
<cfparam name="endVal" default="7">



<cfset dow[1]=#DateAdd("d", "-#DayOfWeek(Now()) - 1#", attributes.date)#>

<cfoutput>
	<cfloop index="idx" from="2" to="8">
		<cfset dow[idx]=DateAdd("d", idx - 1, dow[1])>
	</cfloop>
</cfoutput>


<cfswitch expression="#attributes.view#">
    	<cfcase value="small">
        	<cfset monthNameFormat = "mmm">
            <cfset dayStyle="font-size:8px; color:##C0C0C0;">
		</cfcase>
        <cfcase value="medium">
        	<cfset monthNameFormat = "mmm">
            <cfset dayStyle="font-size:12px; color:##C0C0C0;">
        </cfcase>
        <cfcase value="large">
        	<cfset monthNameFormat = "mmmm">
            <cfset dayStyle="font-size:16px; color:##C0C0C0;">
		</cfcase>
	</cfswitch>

<div <cfoutput> style="border:1px solid ##999999; width:#attributes.width#px; min-height:450px;" </cfoutput>>
<table width="100%">
	<cfoutput>
    <tr style="min-height:250px;">
		<cfloop index="ctr" from="#startVal#" to="#endVal#">
			<td style="border:1px solid <cfif CreateODBCDate(Now()) EQ CreateODBCDate(dow[ctr])>red;<cfelse>silver;</cfif>" valign="top">
				<table width="100%">
					<tr>
						<td valign="top">
                        	<table width="100%">
                         		<tr>
                                	<td align="left">#DayOfWeekAsString(ctr)#</td>
                                    <td align="right" style="#dayStyle#">
                                    
                                    	#DateFormat(dow[ctr],"d")#
                                    
                                    </td>
								</tr>
                            </table>
                                                                
					</tr>
					<tr>
						<td valign="bottom"><cfmodule template="#attributes.viewer#" attributecollection="#attributes#" targetDate="#dow[ctr]#"></td>
					</tr>
				</table>
			</td>
		</cfloop>
	</tr>
    </cfoutput>
</table>
</div>
