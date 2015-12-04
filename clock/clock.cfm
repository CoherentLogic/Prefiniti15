<cfinclude template="/authentication/authentication_udf.cfm">

<cfoutput>#TimeFormat(pfLocalTime(URL.CalledByUser, Now()), "h:mm tt")#</cfoutput>