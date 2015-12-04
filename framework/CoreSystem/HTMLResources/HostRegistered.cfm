
<!--- HP_PrefinitiHostKey --->

<cfquery name="CheckHostRegistered" datasource="webwarecl">
	SELECT * FROM hosts WHERE HostKey='#URL.HP_PrefinitiHostKey#'
</cfquery>

<cfif CheckHostRegistered.HostName EQ "[New Host]">0<cfelse>1</cfif>