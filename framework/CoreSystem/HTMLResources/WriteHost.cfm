<cfquery name="WriteHost" datasource="webwarecl">
	UPDATE hosts
	SET		HostName='#URL.HostName#',
			HostDescription='#URL.HostDescription#',
			DefaultRunLevel=#URL.DefaultRunLevel#,
			BootTimeout=#URL.BootTimeout#
	WHERE	HostKey='#URL.HostKey#'
</cfquery>
Update complete.