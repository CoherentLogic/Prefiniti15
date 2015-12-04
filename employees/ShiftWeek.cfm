<cfinclude template="/framework/framework_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<table border="1" style="margin:10px;">
	<tr>
    	<td>Sunday<br><hr>
         <cfmodule template="/employees/ShiftDay.cfm" user_id="#attributes.user_id#" site_id="#attributes.site_id#" pay_start="#attributes.pay_start#" pay_end="#attributes.pay_end#" day="0">
        </td>
       	<td>Monday<br><hr>
         <cfmodule template="/employees/ShiftDay.cfm" user_id="#attributes.user_id#" site_id="#attributes.site_id#"  pay_start="#attributes.pay_start#" pay_end="#attributes.pay_end#" day="1">
       </td>
        <td>Tuesday<br><hr>
         <cfmodule template="/employees/ShiftDay.cfm" user_id="#attributes.user_id#" site_id="#attributes.site_id#"  pay_start="#attributes.pay_start#" pay_end="#attributes.pay_end#" day="2">
       </td>
        <td>Wednesday<br><hr>
         <cfmodule template="/employees/ShiftDay.cfm" user_id="#attributes.user_id#" site_id="#attributes.site_id#"  pay_start="#attributes.pay_start#" pay_end="#attributes.pay_end#" day="3">
       </td>
        <td>Thursday<br><hr>
         <cfmodule template="/employees/ShiftDay.cfm" user_id="#attributes.user_id#" site_id="#attributes.site_id#"  pay_start="#attributes.pay_start#" pay_end="#attributes.pay_end#" day="4">
       </td>
        <td>Friday<br><hr>
         <cfmodule template="/employees/ShiftDay.cfm" user_id="#attributes.user_id#" site_id="#attributes.site_id#"  pay_start="#attributes.pay_start#" pay_end="#attributes.pay_end#" day="5">
       </td>
        <td>Saturday<br><hr>
         <cfmodule template="/employees/ShiftDay.cfm" user_id="#attributes.user_id#" site_id="#attributes.site_id#"  pay_start="#attributes.pay_start#" pay_end="#attributes.pay_end#" day="6">
       </td>
	</tr>
</table>    
<cfoutput>
<table>
<tr>
<td>
<strong>Apply to #getLongname(attributes.user_id)#'s Schedule</strong><br />
<hr />
<!--- function ER_ApplyShiftTemplate(user_id, site_id, units, unit_type, update_cal, tc_remind) --->
<label><input type="button" value="Apply" onclick="ER_ApplyShiftTemplate(#attributes.user_id#, #attributes.site_id#, GetSelectedValue('Sch_Units'), GetSelectedValue('Sch_UnitType'), IsChecked('chkCreateEvents'), IsChecked('chkCreateTCReminders'));"  > this shift template for the next</label><label>
<select id="Sch_Units">
	<option value="1">1</option>
    <option value="2">2</option>
    <option value="3">3</option>
    <option value="4">4</option>
    <option value="5">5</option>
    <option value="6">6</option>
    <option value="7">7</option>
    <option value="8">8</option>
    <option value="9">9</option>
    <option value="10">10</option>
    <option value="11">11</option>
    <option value="12">12</option>

</select>
</label>
<label>

<select id="Sch_UnitType">
	<option value="d">days</option>
    <option value="ww">weeks</option>
    <option value="m">months</option>
    <option value="q">quarters</option>
    <option value="yyyy">years</option>
</select>
</label><br>
<blockquote>
<label><input type="checkbox" name="chkCreateEvents" id="chkCreateEvents"> Create events on employee's calendar </label><br>
<label><input type="checkbox" name="chkCreateTCReminders" id="chkCreateTCReminders"> Generate automatic timesheet reminders </label><br>
</blockquote>
<strong>Adjust Template to Fit</strong><br />
<hr />        
</td>
<td>
<div id="ER_ShiftResults" style="width:500px; font-family:'Courier New', Courier, monospace; height:200px; color:white; background-color:black; overflow:auto;">Shift Scheduling Results</div>
</td>
</tr>
</table>
</cfoutput>
