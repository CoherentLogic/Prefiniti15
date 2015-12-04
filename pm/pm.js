
function PM_Initialize()
{
	//PM_tmpTime = new Date();
	//PM_tmpDate = PM_tmpTime.getMonth() + "/" + PM_tmpTime.getDay() + "/" + PM_tmpTime.getFullYear();
	PM_SelectedDate = GetValue('PMF_CurrentDate');
	writeConsole("PM2 initialized with date " + PM_SelectedDate);
}
	

function PM_GetViewMode()
{
	return GetValue('PM_CalMode');	
}

function PM_SetViewMode(new_mode)
{
	SetValue('PM_CalMode', new_mode);
	PM_SetDate(PM_SelectedDate);
}

function PM_SetDate(newDate)
{
	PM_SelectedDate = newDate;
	PM_LoadProjectsView(newDate);
}

function PM_LoadProjectsView(date)
{
	
	// viewer="/pm/CalendarViewers/MonthCal.cfm" view="large" date="#URL.date#" width="700" onDateChange="PM_SetDate">
	
	var urlTail = "?date=" + escape(date);
	urlTail += "&onDateChange=PM_SetDate";
	urlTail += "&width=700";
	
	
	switch(PM_GetViewMode()) {
		case 'day':
		var url = '/pm/CalendarLoaders/DayView.cfm';
		break;
		
		case 'week':
		var url = '/pm/CalendarLoaders/WeekView.cfm';
		break;
		
		case 'month':
		var url = '/pm/CalendarLoaders/MonthView.cfm';
		break;
	}
	
	var tUrl = url + urlTail;

	AjaxLoadPageToDiv('MainCalDiv', tUrl);
	
	tUrl = "/pm/CalendarLoaders/SideCal.cfm";
	urlTail = "?date=" + escape(date);
	urlTail += "&onDateChange=PM_SetDate";
	urlTail += "&width=200";
	
	AjaxLoadPageToDiv('SideCalDiv', tUrl + urlTail);
	
}

function PM_Search()
{
	var url = '/pm/Search/Search.cfm';
	AjaxLoadPageToDiv('MainCalDiv', url);
}

function PM_BeginSearch(ProjectType)
{
	var url = '/pm/Search/ByProjectType.cfm?ProjectType=' + escape(ProjectType);
	
	AjaxLoadPageToDiv('PM_SearchKeywords', url);
}

function PM_CreateProject()
{
	var url = '/pm/CreateProject/CreateProject.cfm';
	
	AjaxLoadPageToDiv('MainCalDiv', url);
}

function PM_BeginCreateProject(ProjectType)
{
	var url = '/pm/CreateProject/CreateProjectByType.cfm?ProjectType=' + escape(ProjectType);
	
	AjaxLoadPageToDiv('PM_CreateProject', url);
}