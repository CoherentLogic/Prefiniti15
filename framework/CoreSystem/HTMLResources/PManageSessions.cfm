<cfquery name="GetSessions" datasource="webwarecl">
	SELECT * FROM auth_tokens WHERE active=1 ORDER BY login_date DESC
</cfquery>

<div style="width:100%; height:100%; background-color:#999999; color:white;">
<div style="padding:20px;">
	<strong><img src="/graphics/connect.png" align="absmiddle" /> Manage Sessions</strong><br />
	<hr />
	<br><br><br>
	<div id="Sessions_Target" style="background-color:white; border:1px solid black; width:100%; height:300px; color:black; overflow:auto;">
		<table width="100%" class="ModTable" cellpadding="3" cellspacing="0">
			<tr>
				<th>Username</th>
				<th>Network Node</th>
				<th>Browser</th>
				<th>Operating System</th>
				<th>Active Since</th>
			</tr>
			<cfoutput query="GetSessions">
			<tr>
				<td><a href="####" onclick="SetValue('ActiveSession', '#session_key#'); showDivBlock('MS_Controls');">#username#</a></td>
				<td>#HP_CGI_NetworkNode#</td>
				<td>#HP_CGI_Browser#</td>
				<td>#HP_OS#</td>
				<td>#DateFormat(login_date, "mm/dd/yyyy")# #TimeFormat(login_date, "h:mm tt")#</td>
			</tr>
			</cfoutput>
		</table>
	</div>
	<div id="MS_Controls" style="display:none;">
	<input type="text" id="ActiveSession"><input type="button" class="normalButton" value="End Session" onclick="KillSession(GetValue('ActiveSession'));">
	</div>
	<div id="MS_Status" style="color:red;">
	
	</div>
</div>
</div>