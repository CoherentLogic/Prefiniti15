<cfcomponent displayname="Project" hint="The containing object for Prefiniti projects.">
	<cffunction name="init" access="public" output="no" returntype="Project">
		<cfargument name="myArgument" type="string" required="yes">
		<cfset myResult="foo">
		<cfreturn myResult>
	</cffunction>
</cfcomponent>