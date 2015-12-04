<cfset Authenticator = CreateObject("webservice", "http://orms.prefiniti.com/Authentication.cfc?wsdl")>
<cfif NOT Authenticator.ValidateKey(URL.SessionKey)>
	<cfthrow message="Invalid session token." detail="The session token you passed to this service is not valid.">
</cfif>

