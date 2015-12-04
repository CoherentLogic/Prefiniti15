<cfquery name="getEI" datasource="webwarecl">
	SELECT id FROM employee_info WHERE user_id=#attributes.user_id#
</cfquery>

<cfoutput>
	<cfif getEI.RecordCount EQ 0>
        <input type="button" class="normalButton" value="Create Employee Record" onclick="AjaxLoadPageToDiv('tcTarget', '/employees/EmployeeInfo.cfm?mode=create&user_id=#attributes.user_id#&site=#attributes.site_id#');" />
    <cfelse>
        <input type="button" class="normalButton" value="Edit Employee Record" onclick="AjaxLoadPageToDiv('tcTarget', '/employees/EmployeeInfo.cfm?mode=edit&user_id=#attributes.user_id#&site=#attributes.site_id#');" />
    </cfif>
</cfoutput>

