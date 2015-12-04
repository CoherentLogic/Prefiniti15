<cfcomponent displayname="App" hint="Represents a Prefiniti App" extends="System.Framework" output="no">
	<cfset this.AppID = "">
	<cfset this.AppName = "">
    <cfset this.Description = "">
    <cfset this.AppVersion = "">
    <cfset this.Vendor = "">
    <cfset this.Authorized = false>
    <cfset this.WSDLURL = "">
    <cfset this.RemoteService = "">
    
    <cfset this.Written = false>

	<cffunction name="Create" hint="Create a Prefiniti application." access="public" returntype="System.App">
		<cfargument name="AppName" type="string" required="yes">
		<cfargument name="Description" type="string" required="yes">
        <cfargument name="WSDLURL" type="string" required="yes">
        <cfargument name="Vendor" type="System.Site" required="yes">
        <cfargument name="Icon" type="string" required="yes">
        
		<cfset this.AppID = CreateUUID()>
        <cfset this.AppName = AppName>
        <cfset this.Description = Description>
        <cfset this.WSDLURL = WSDLURL>
        <cfset this.Version = "0.9">
        <cfset this.Written = false>
        <cfset this.Authorized = false>
        <cfset this.Icon = Icon>
        <cfset this.Vendor = Vendor>
        
		<cfreturn #this#>
	</cffunction>
    
    <cffunction name="Open" hint="Open a Prefiniti application." access="public" returntype="System.App">
    	<cfargument name="AppID" hint="The UUID-format application ID." type="string" required="yes">
        
        <cfquery name="qryOpenApp" datasource="#this.BaseDatasource#">
        	SELECT * FROM apps WHERE AppID='#AppID#'
		</cfquery>
        
        <cfset this.AppID = qryOpenApp.AppID>
        <cfset this.Vendor = createObject("component", "System.Site").OpenByDBKey(qryOpenApp.VendorDBKey)>
        <cfset this.AppName = qryOpenApp.AppName>
        <cfif qryOpenApp.Authorized EQ 0>
        	<cfset this.Authorized = false>
		<cfelse>
        	<cfset this.Authorized = true>
		</cfif>
        <cfset this.Version = qryOpenApp.Version>
        <cfset this.Description = qryOpenApp.Description>
        <cfset this.WSDLURL = qryOpenApp.WSDLURL>
        <cfset this.Icon = qryOpenApp.Icon>
        <cfset this.Written = true>
        
        <cfreturn #this#>
	</cffunction>
    
    
    <cffunction name="Install" hint="Install a Prefiniti application." access="public" returntype="System.App">
    	<cfargument name="Membership" hint="The membership to which the application will be installed." type="System.SiteMembership" required="yes">
        
        <cfquery name="qryInstallApp" datasource="#this.BaseDatasource#">
        	INSERT INTO apps_installed
            	(AppID,
                MembershipID)
			VALUES
            	('#this.AppID#',
                #Membership.MembershipID#)                
        </cfquery>
        
        <cfreturn #this#>
    </cffunction>
    
    <cffunction name="Connect" hint="Connect to this application's webservice and return a reference to it." access="public" returntype="any">
    	<cfparam name="tmpWS" default="">
		<cfscript>
			tmpWS = CreateObject("webservice", this.WSDLURL);
		</cfscript>
        <cfreturn #tmpWS#>
    </cffunction>
    
    <cffunction name="GetJSON" hint="Get the JSON structure for this application." returntype="string" access="public">
    	<cfparam name="theJSON" default="">
        <cfset theJSON = SerializeJSON(this)>
        <cfreturn #theJSON#>
    </cffunction>
    
    <cffunction name="Save" hint="Save this app to the database" access="public" returntype="System.App">
    	<cfparam name="retVal" default="">
        	            
		<cfif NOT this.Written>
			<cfset retVal = this.WriteAsNewRecord()>
		</cfif>            			                    	                
               
		<cfreturn #this#>                                         
    </cffunction>
    
    <cffunction name="WriteAsNewRecord" hint="Write this app to the database as a new record." access="private" returntype="boolean">
    	
        <cfquery name="qryWriteApp" datasource="#this.BaseDatasource#">
        	INSERT INTO apps
            	(AppID,
                AppName,
                VendorDBKey,
                Authorized,
                Version,
                Description,
                WSDLURL,
                Icon)
			VALUES
            	('#this.AppID#',
                '#this.AppName#',
                #this.Vendor.DBKey#,
                <cfif this.Authorized>
                	1,
				<cfelse>
                	0,
				</cfif>
                '#this.Version#',
                '#this.Description#',
                '#this.WSDLURL#',
                '#this.Icon#')                                                                   
        </cfquery>
        
        <cfset this.Written = true>
        
        <cfreturn true>
    </cffunction>
</cfcomponent>