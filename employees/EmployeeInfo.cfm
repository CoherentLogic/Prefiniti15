<cfinclude template="/framework/framework_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">


<cfparam name="EmployeeName" default="">

<cfset EmployeeName = getLongname(URL.user_id)>

<cfoutput>
<!--
<wwafcomponent>Employee Record - #EmployeeName#</wwafcomponent>
<wwaficon>group_edit.png</wwaficon>
-->
</cfoutput>

<style type="text/css">
	form#EmployeeRecord {
		/*background-color:#CCCCCC;*/
		color:#000000;
		/*border:1px solid #999999;*/
		font-family:Verdana, Arial, Helvetica, sans-serif;
		font-size:10px;
		padding:15px;
		
		height:auto;
	}
	
	.FormSection {
		background-color:#C0C0C0;
		color:#000000;
		
		border:1px solid #3399cc;
		display:block;
		margin-left:5px;
		margin-top:0px;
		width:900px;
		height:400px;
	}
	
	.ButtonBar {
		background-color:white;
		color:#000000;
		
		border:none;
		display:block;
		margin:5px;
		width:910px;
		height:32px;
		text-align:right;
	}
	
	.SectionHeader {
		display:block;
		margin:3px;
	}
	
	.FormSection label {
		text-align:right;
	}
	
	.FormSection td {
		background-color:transparent;
		padding:5px;
	}
	
	.ST_TAB_ACTIVE {
		color:black;
		background-color:#EFEFEF;
		display:block;
		padding:2px;
		float:left;
	}
	
	.ST_TAB_INACTIVE {
		color:white;
		background-color:#999;
			display:block;
		padding:2px;
		float:left;
	
	}

</style>

<cfparam name="eid" default="">

<cfif URL.mode EQ "create">
	<cfparam name="om_uuid" default="">
    <cfset om_uuid=CreateUUID()>
    
	<cfquery name="createInitialRecord" datasource="webwarecl">
    	INSERT INTO employee_info (user_id, om_uuid, site_id) VALUES (#URL.user_id#, '#om_uuid#', #url.site#)
    </cfquery>
    
    <cfquery name="getEID" datasource="webwarecl">
    	SELECT id FROM employee_info WHERE om_uuid='#om_uuid#'
    </cfquery>
    
    <cfset eid = getEID.id>
<cfelse>
	<cfquery name="getEIDe" datasource="webwarecl">
    	SELECT id FROM employee_info WHERE user_id=#URL.user_id# AND site_id=#url.site#
	</cfquery>
    
    <cfset eid = getEIDe.id>            
</cfif>   

<cfquery name="getEmployeeRecord" datasource="webwarecl">
	SELECT * FROM employee_info WHERE id=#eid#
</cfquery>     


<table>
	<tr>
    	<td><div class="ST_TAB_ACTIVE"> <a href="##" onclick="ER_ShowTab('BasicInformation');">Employee Information</a></div></td>
        <td><div class="ST_TAB_INACTIVE"> <a href="##" onclick="ER_ShowTab('PayrollInformation');">Payroll</a></div></td>
        <td><div class="ST_TAB_INACTIVE"> <a href="##" onclick="ER_ShowTab('ShiftScheduling');">Shift Scheduling</a></div></td>
        <!---<td><div class="ST_TAB_INACTIVE"> <a href="##" onclick="ER_ShowTab('Permissions');">Permissions</a></div></td>
        <td><div class="ST_TAB_INACTIVE"> <a href="##" onclick="ER_ShowTab('Departments');">Department Membership</a></div></td>--->
	</tr>
</table>           
        
        
        
<cfoutput query="getEmployeeRecord">
<form name="EmployeeRecord" id="EmployeeRecord">
<div class="FormSection" style="display:block;" id="BasicInformation">
	<strong class="SectionHeader">Basic Information</strong>
    <table>
    <tr>
    <td>Name:</td><td><strong>#getLongname(URL.user_id)#</strong></td><td>Hired:</td><td><cfmodule template="/controls/date_picker.cfm" ctlname="ER_HireDate" startdate="#hire_date#"></td>
    </tr>
    <tr><td>Title:</td><td><input type="text" id="ER_Title" name="ER_Title" value="#title#"></td><td>&nbsp;</td><td><label><input type="checkbox" name="ER_Active" id="ER_Active" <cfif active EQ 1>checked</cfif>>Active</label></td>
    </tr>
    <tr><td>Employee Type:</td><td><input type="text" name="ER_EmpType" id="ER_EmpType" value="#emp_type#"></td><td>Terminated:</td><td><cfmodule template="/controls/date_picker.cfm" ctlname="ER_HireDate" startdate="#release_date#">
    </td></tr>
    </table>
</div>

<div class="FormSection" style="display:none;" id="PayrollInformation">
	<strong class="SectionHeader">Payroll Information</strong>
   
    <table>
    <tr><td>Wage:</td><td><input type="text" name="ER_Wage" id="ER_Wage" value="#wage#"> per 
    <select name="ER_WageType">
    	<option value="Hour" <cfif wage_type EQ "Hour">selected</cfif>>Hour</option>
        <option value="Hour" <cfif wage_type EQ "Year">selected</cfif>>Year</option>
	</select>
    </td></tr>
    
    <tr>
    	<td>Pay Period Begins:</td>
    	<td>
        	<select name="ER_WorkWeekStart">
               	<option value="1" <cfif work_week_start EQ 1>selected</cfif>>Monday</option>
                <option value="2" <cfif work_week_start EQ 2>selected</cfif>>Tuesday</option>
                <option value="3" <cfif work_week_start EQ 3>selected</cfif>>Wednesday</option>
                <option value="4" <cfif work_week_start EQ 4>selected</cfif>>Thursday</option>
                <option value="5" <cfif work_week_start EQ 5>selected</cfif>>Friday</option>
                <option value="6" <cfif work_week_start EQ 6>selected</cfif>>Saturday</option>
                <option value="0" <cfif work_week_start EQ 0>selected</cfif>>Sunday</option>
			</select>
		</td>
        <td>Pay Period Ends:</td>
        <td>
        	<select name="ER_WorkWeekEnd">
               	<option value="1" <cfif work_week_end EQ 1>selected</cfif>>Monday</option>
                <option value="2" <cfif work_week_end EQ 2>selected</cfif>>Tuesday</option>
                <option value="3" <cfif work_week_end EQ 3>selected</cfif>>Wednesday</option>
                <option value="4" <cfif work_week_end EQ 4>selected</cfif>>Thursday</option>
                <option value="5" <cfif work_week_end EQ 5>selected</cfif>>Friday</option>
                <option value="6" <cfif work_week_end EQ 6>selected</cfif>>Saturday</option>
                <option value="0" <cfif work_week_end EQ 0>selected</cfif>>Sunday</option>
			</select>
		</td>
        
	</tr>                                    

    </table>        
        
        
</div>

<div class="FormSection" style="display:none;" id="ShiftScheduling">
	<strong class="SectionHeader">Shift Scheduling</strong>
    
    <label><input type="radio" name="ShiftViewType" value="Template" onclick="ER_SetShiftView();" checked/> View As Template</label> <label><input type="radio" name="ShiftViewType" value="Applied" onclick="ER_SetShiftView();" /> View As Currently Applied</label>
	
    <div id="ViewAsTemplate" style="display:block;">
    <cfmodule template="/employees/ShiftWeek.cfm" user_id="#URL.user_id#" site_id="#URL.current_site_id#" mode="schedule" pay_start="#work_week_start#" pay_end="#work_week_end#" >
    </div>
    <div id="ViewAsApplied" style="display:none;">
    <cfmodule template="/employees/EmployeeSchedule.cfm" user_id="#URL.user_id#" site_id="#URL.current_site_id#" mode="schedule" pay_start="#work_week_start#" pay_end="#work_week_end#" >
    
    </div>
</div>
</form>

<div id="ButtonBar" class="ButtonBar">
	<span style="color:red;" id="ER_Changes"></span>
    <input type="button" value="Apply">
    <input type="button" value="Cancel" onclick="closeCurrentTab();">
    
</div>

</cfoutput>




