/*
* employees.js
* employee management functions
*
* Created: 9/13/2009
* Author: jpw
*
* Copyright (C) 2009 AJL Intel-Properties LLC
*/


function ER_HideTabs() 
{
	hideDiv('BasicInformation');
	hideDiv('PayrollInformation');
	hideDiv('ShiftScheduling');
	setClass('ER_Tabs_BasicInformation', 'ST_TAB_INACTIVE');
	setClass('ER_Tabs_PayrollInformation', 'ST_TAB_INACTIVE');
	setClass('ER_Tabs_ShiftScheduling', 'ST_TAB_INACTIVE');
	
}

function ER_ShowTab(section) 
{
	
	tab_active = 'ER_Tabs_' + section.toString();
	ER_HideTabs();
	
	setClass(tab_active, 'ST_TAB_ACTIVE');
	showDivBlock(section);
	
}

function ER_UpdateShift(field, user_id, site_id, day, value, special_field)
{
	//alert("Updating " + field + " for user " + user_id + " on site " + site_id + " for day number " + day + " with new value of " + value);
	
	var url = '/employees/UpdateShift.cfm?user_id=' + escape(user_id);
	url += '&site_id=' + escape(site_id);
	url += '&day=' + escape(day);
	url += '&field=' + escape(field);
	url += '&value=' + escape(value);
	url += '&special_field=' + escape(special_field);
	
	AjaxLoadPageToDiv('ER_Changes', url);
	
	
}

function ER_ApplyShiftTemplate(user_id, site_id, units, unit_type, update_cal, tc_remind)
{
	var url = "/employees/ApplyShiftTemplate.cfm?user_id=" + escape(user_id);
	url += "&site_id=" + escape(site_id);
	url += "&units=" + escape(units);
	url += "&unit_type=" + escape(unit_type);
	url += "&update_cal=" + escape(update_cal);
	url += "&tc_remind=" + escape(tc_remind);
	
	AjaxLoadPageToDiv('ER_ShiftResults', url);
	
}

function ER_SetDayOff(user_id, site_id, day, value) 
{
	var url = "/employees/SetDayOff.cfm?user_id=" + escape(user_id);
	url += "&site_id=" + escape(site_id);
	url += "&day=" + escape(day);
	url += "&value=" + escape(value);
	
	
	var startC = document.getElementById('ShiftStart_' + day);
	var endC = document.getElementById('ShiftEnd_' + day);
		
	if(!value) {
		startC.disabled = false;
		endC.disabled = false;
	}
	else {
		startC.disabled = true;
		endC.disabled = true;
	}
		
	AjaxLoadPageToDiv('ER_Changes', url);	
}

function ERgetRadioCheckedValue(radio_name) 
{
	var oRadio = document.getElementsByName(radio_name);
	
	for(var i = 0; i < oRadio.length; i++) {
		if(oRadio[i].checked) {
			return oRadio[i].value;
		}
	}
	
	return '';
}

function ER_SetShiftView()
{
	// ShiftViewType is the radio button.
	// "Template" and "Applied" are the values.
	// div id's are ViewAsTemplate and ViewAsApplied
	
	var vt = ERgetRadioCheckedValue('ShiftViewType');
	
	switch(vt) {
		case 'Template':
			showDivBlock('ViewAsTemplate');
			hideDiv('ViewAsApplied');
			break;
		case 'Applied':
			showDivBlock('ViewAsApplied');
			hideDiv('ViewAsTemplate');
	}
}