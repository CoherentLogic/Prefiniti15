<cfquery name="addCrew" datasource="webwarecl">
	INSERT INTO crews (name) VALUES ('#url.name#');
</cfquery>

<p style="color:red">Crew created.</p>
<input type="button" class="normalButton" onclick="javascript:loadCrewManager();" value="Refresh Crew Manager">
