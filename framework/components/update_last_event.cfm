<cfquery name="udle" datasource="webwarecl">
	UPDATE Users SET online=1, last_event=#CreateODBCDateTime(Now())# WHERE id=#url.calledByUser#
</cfquery>
