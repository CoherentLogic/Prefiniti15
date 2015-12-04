<!--- 
	PrefinitiNG
	
	Application.cfc
	 The Prefiniti base object
	
	Created by J Willis
	Created on 1/16/2010
 
 	Copyright (C) 2010 AJL Intel-Properties LLC
 --->

<cfcomponent displayname="PrefinitiNG" output="true" hint="Base object for PrefinitiNG">


	<!--- Set up the application. --->
	<cfset this.Name = "PrefinitiNG" />
	<cfset this.ApplicationTimeout = CreateTimeSpan( 0, 0, 1, 0 ) />
	<cfset this.SessionManagement = true />
	<cfset this.SetClientCookies = true />

	<cfset session.User = "">
    <cfset session.UserInterface = "Web">
    
	<!--- Define the page request properties. --->
	<cfsetting requesttimeout="20" showdebugoutput="true" enablecfoutputonly="false"/>

 	<cffunction	name="OnApplicationStart" access="public" returntype="boolean" output="false" hint="Fires when the application is first created.">

		<!--- Return out. --->

		<cfreturn true />

	</cffunction>

	<cffunction	name="OnSessionStart" access="public" returntype="void" output="false" hint="Fires when the session is first created.">

		<cfset session.User = "">
        <cfset session.LoggedIn = false>

		<cfreturn />

	</cffunction>

 

 

	<cffunction

		name="OnRequestStart"

		access="public"

		returntype="boolean"

		output="false"

		hint="Fires at first part of page processing.">

 

		<!--- Define arguments. --->

		<cfargument

			name="TargetPage"

			type="string"

			required="true"

			/>

 

		<!--- Return out. --->

		<cfreturn true />

	</cffunction>

 

 

	<cffunction

		name="OnRequest"

		access="public"

		returntype="void"

		output="true"

		hint="Fires after pre page processing is complete.">

 

		<!--- Define arguments. --->

		<cfargument

			name="TargetPage"

			type="string"

			required="true"

			/>

 

		<!--- Include the requested page. --->

		<cfinclude template="#ARGUMENTS.TargetPage#" />


		<!--- Return out. --->

		<cfreturn />

	</cffunction>

 

 

	<cffunction

		name="OnRequestEnd"

		access="public"

		returntype="void"

		output="true"

		hint="Fires after the page processing is complete.">

 

		<!--- Return out. --->

		<cfreturn />

	</cffunction>

 

 

	<cffunction

		name="OnSessionEnd"

		access="public"

		returntype="void"

		output="false"

		hint="Fires when the session is terminated.">

 

		<!--- Define arguments. --->

		<cfargument

			name="SessionScope"

			type="struct"

			required="true"

			/>

 

		<cfargument

			name="ApplicationScope"

			type="struct"

			required="false"

			default="#StructNew()#"

			/>

 

		<!--- Return out. --->

		<cfreturn />

	</cffunction>

 

 

	<cffunction

		name="OnApplicationEnd"

		access="public"

		returntype="void"

		output="false"

		hint="Fires when the application is terminated.">

 

		<!--- Define arguments. --->

		<cfargument

			name="ApplicationScope"

			type="struct"

			required="false"

			default="#StructNew()#"

			/>

 

		<!--- Return out. --->

		<cfreturn />

	</cffunction>

 

 

	<cffunction	name="OnError" access="public" returntype="void" output="true" hint="Fires when an exception occures that is not caught by a try/catch.">
		<cfargument name="Exception" type="any"	required="true"/>
		<cfargument name="EventName" type="string" required="false" default=""/>
		
        <div style="margin-top:80px; margin-left:auto; margin-right:auto; width:700px; height:auto; background-color:##666; padding:80px; color:white; font-size:8px;" align="center">
		<img src="/System/Resources/Graphics/Prefiniti-Logo-white.png">
        <h1>Gosh Durnit!</h1>
        <p>Looks like something went wrong, and I don't know what to do with myself. I need therapy. But in the meantime, will you please look at what I dumped out below and see if you can help me!</p>
		
        <a href="####" onclick="document.getElementById('PErrorDetails').style.display='block'">Show Error Details</a>
        
        <div id="PErrorDetails" style="display:none; width:600px; height:200px; overflow:auto;">
        <h1>Exception Dump</h1>
        <cfdump var="#Exception#">
        <h1>Session Dump</h1>
        <cfdump var="#session#">
        </div>
		</div>
		<cfreturn />

	</cffunction>

 

</cfcomponent>