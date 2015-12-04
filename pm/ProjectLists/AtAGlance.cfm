<cfinclude template="/pm/pm_udf.cfm">

<cfparam name="allSiteProjects" default="">
<cfset allSiteProjects = pmSiteProjects(URL.current_site_id)>
<style type="text/css">
	.projBtn {
		background-color:white;
		color:black;
		float:left;
		width:66px;
		height:66px;
		text-align:center;
		font-size:7px;
		text-transform:uppercase;
		letter-spacing:1px;
		vertical-align:middle;
		padding-top:7px;
	}
	
	.projBtn img {
		vertical-align:middle;
	}
	
	.projBtn:hover {
		background-color:#2957A2;
		color:white;
		letter-spacing:normal;
		font-weight:bold;
	}
	
	#viewTypeBar a {
		font-size:16px;
		
		
		text-decoration:none;
		
	}
	
	#viewTypeBar a:hover {
		color:#2957A2;
	}
	
	#viewTypeBar {
		font-size:16px;
		
	}
	
</style>

<!--
	<wwafcomponent>Projects</wwafcomponent>
-->

<table width="800" cellpadding="0" cellspacing="0">
	<tr>
    	<td <cfoutput>width="200"</cfoutput> align="center" style="background-color:#C0C0C0;">
        	<h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="absmiddle"> Projects</h3>
           
            <hr style="width:150px;">
            
            <cfoutput>
            	#allSiteProjects.RecordCount# Projects Tracked<br><br><br><br>
            
            </cfoutput>
            
            <div style="width:200px; height:200px; background-color:white; overflow:hidden; border:1px groove #999999;">
        		<div class="projBtn" onclick="PM_CreateProject();">
                	<img src="/graphics/AppIconResources/crystal_project/32x32/actions/filenew.png"><br>
                    Create New
                </div> 
        		<div class="projBtn" onclick="PM_Search();">
                	<img src="/graphics/AppIconResources/crystal_project/32x32/actions/search.png"><br>
                    Search
                </div> 
        		<div class="projBtn">
                	<img src="/graphics/AppIconResources/crystal_project/32x32/actions/kalarm.png"><br>
                    Time Entry
                </div> 
        		<div class="projBtn">
                	<img src="/graphics/AppIconResources/crystal_project/32x32/actions/info.png"><br>
                    Statistics
                </div> 
        		<div class="projBtn">
                	<img src="/graphics/AppIconResources/crystal_project/32x32/actions/money.png"><br>
                    Invoicing
                </div> 
        		<div class="projBtn">
                	<img src="/graphics/AppIconResources/crystal_project/32x32/actions/todo.png"><br>
                    Crews &amp; Dispatch
                </div> 
        		<div class="projBtn">
                	<img src="/graphics/AppIconResources/crystal_project/32x32/actions/utilities.png"><br>
                    Utilities
                </div> 
       			
        
            
            </div>
            
            <br><br><br>
        	<div style="padding:20px;" id="SideCalDiv">
            <cfparam name="todayDate" default="">
            <cfset todayDate = DateFormat(Now(), "mm/dd/yyyy")>
            <cfmodule template="/controls/monthCalendar.cfm" viewer="/pm/CalendarViewers/SideCal.cfm" view="small" date="#todayDate#" width="200" onDateChange="PM_SetDate">
        	</div>
            
        </td>
       	<td width="700" valign="top">
        	<input type="hidden" id="PM_CalMode" name="PM_CalMode" value="month">
            <div style="width:100%; padding-top:5px; padding-bottom:5px; background-color:#C0C0C0;" align="center" id="viewTypeBar">
            	<cfoutput>
                <input type="button" class="normalButton" onclick="PM_SetViewMode('day')" value="Day"> <input class="normalButton" type="button" onclick="PM_SetViewMode('week')" value="Week"> <input class="normalButton" type="button" onclick="PM_SetViewMode('month')" value="Month"> <input class="normalButton" type="button" onclick="PM_SetDate('#DateFormat(Now(), 'mm/dd/yyyy')#');" value="Today">
                </cfoutput>
                
            </div>
        	<div id="MainCalDiv">
        	<cfmodule template="/controls/monthCalendar.cfm" viewer="/pm/CalendarViewers/MonthCal.cfm" view="large" date="#DateFormat(Now(), 'mm/dd/yyyy')#" width="700" onDateChange="PM_SetDate">
            </div>
            <div id="projInfoW" style="display:block; width:700px; border:1px solid #C0C0C0; background-color:#C0C0C0;">
            	<div id="projInfo" style="height:100px; padding:0px; background-color:#C0C0C0; overflow:auto;">
                	
                    <div style="padding:40px;">
                	<img src="/graphics/error.png" align="absmiddle"> Please select a project from the calendar.
                    </div>
                
                </div>
            </div>
        </td>
	</tr>
</table>            
