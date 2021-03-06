<!--- 
	PrefinitiNG
	
	User.cfc
	 The Prefiniti User object
	
	Created by J Willis
	Created on 1/16/2010
 
 	Copyright (C) 2010 AJL Intel-Properties LLC
 --->
 

<cfcomponent displayName="User" hint="Represents a Prefiniti User" extends="System.Framework">
	<!--- FIELDS TO BE USED IN NEXT GEN FRAMEWORK --->
    <cfset this.Username = "">
    <cfset this.HashedPassword = "">
    <cfset this.FirstName = "">
    <cfset this.MiddleInitial = "">
    <cfset this.LastName = "">
    <cfset this.EMailAddress = "">
    <cfset this.Gender = "">
    <cfset this.SMSNumber = "">
    <cfset this.AccountEnabled = 0>
    <cfset this.Confirmed = 0>
    <cfset this.PostalCode = "">
	<cfset this.DBKey = 0>
    <cfset this.SiteMemberships = "">
    <cfset this.Authenticated = false>
    <cfset this.CreationDate = CreateODBCDateTime(Now())>
    <cfset this.LoginSession = "">
    <cfset this.SessionReady = false>
    
    <cfset this.Written = false>
    
    <cffunction name="Create" displayName="Create" hint="Create a new user and write it to the database" access="public" returnType="System.User" output="false">
    	<cfargument name="Username" hint="The name with which the user will log in" type="string" required="yes">
        <cfargument name="FirstName" hint="The user's given name" type="string" required="yes">
        <cfargument name="LastName" hint="The user's surname" type="string" required="yes">
        <cfargument name="EMailAddress" hint="The user's e-mail address" type="string" required="yes">
        <cfargument name="Gender" hint="The user's gender" type="string" required="yes">
        <cfargument name="Birthday" hint="The user's birthday" type="date" required="yes">
        <cfargument name="PostalCode" hint="The user's postal code" type="date" required="yes">
        
        <cfif this.Written>
        	<cfreturn #this#>
		</cfif>            
        
        <cfset this.Username = Username>
        <cfset this.HashedPassword = Hash("h4989jgsduifjobui9384yodjfhojvb084w8h59o8uhnv")>
        <cfset this.FirstName = FirstName>
        <cfset this.MiddleInitial = "">
		<cfset this.LastName = LastName>
        <cfset this.EMailAddress = EMailAddress>
        <cfset this.Gender = Gender>
        <cfset this.Birthday = Birthday>
        <cfset this.PostalCode = PostalCode>
        <cfset this.SMSNumber = "">
        <cfset this.Confirmed = 0>
     	<cfset this.CreationDate = CreateODBCDateTime(Now())>
 		<cfset this.SessionReady = false>
     	<cfset this.Written = false>

		<!--- Create body --->
		<cfreturn #this#>
	</cffunction>
    
    
	<cffunction name="Save" displayName="Save" hint="Save this user account to the database" access="public" returnType="boolean" output="false">
		
        <cfparam name="retVal" default="">
       	<cfif NOT this.Written>
        	<cfset retVal = this.WriteAsNewRecord()>
		<cfelse>
        	<cfset retVal = this.UpdateExistingRecord()>
		</cfif>                        
        
		<cfreturn #retVal#>
	</cffunction>
    
	<cffunction name="Delete" displayName="Delete" hint="Delete this user account" access="public" returnType="boolean" output="false">
		
        <cfif NOT this.Written>
        	<cfreturn false>
		</cfif>            
        
        <cfquery name="qryDeleteUser" datasource="#this.BaseDatasource#">
        	DELETE FROM users WHERE username='#this.Username#'
		</cfquery>            
        
		<cfreturn true>
	</cffunction>
    
	<cffunction name="Open" displayName="Load" hint="Read a user account from the database" access="public" output="false" returntype="boolean">
		<cfargument name="Username" type="string" required="yes">
        
        <cfquery name="qryLoadUser" datasource="#this.BaseDatasource#">
        	SELECT * FROM users WHERE username='#Username#'
		</cfquery>
        
        <cfset this.HashedPassword = qryLoadUser.password>
    	<cfset this.FirstName = qryLoadUser.firstName>
    	<cfset this.MiddleInitial = qryLoadUser.middleInitial>
   		<cfset this.LastName = qryLoadUser.lastName>
		<cfset this.EMailAddress = qryLoadUser.email>
        <cfset this.Gender = qryLoadUser.gender>
        <cfset this.SMSNumber = qryLoadUser.smsNumber>
        <cfset this.AccountEnabled = qryLoadUser.account_enabled>
        <cfset this.Confirmed = qryLoadUser.confirmed>
        <cfset this.PostalCode = qryLoadUser.zip_code>
        <cfset this.DBKey = qryLoadUser.id>
        <cfset this.SiteMemberships = "">
        <cfset this.Authenticated = false>
        <cfset this.CreationDate = qryLoadUser.CreationDate>
        <cfset this.Username = qryLoadUser.username>
        
        <cfset this.Written = true>
        
        <cfreturn true>            
	</cffunction>

    <cffunction name="OpenByDBKey" displayName="OpenByDBKey" hint="Read a user account from the database by its database key" access="public" output="false" returntype="System.User">
            <cfargument name="DBKey" hint="The PK field for this user account" type="numeric" required="yes">
            
            <cfquery name="qryLoadUser" datasource="#this.BaseDatasource#">
                SELECT * FROM users WHERE id=#DBKey#
            </cfquery>
            
            <cfset this.HashedPassword = qryLoadUser.password>
            <cfset this.FirstName = qryLoadUser.firstName>
            <cfset this.MiddleInitial = qryLoadUser.middleInitial>
            <cfset this.LastName = qryLoadUser.lastName>
            <cfset this.EMailAddress = qryLoadUser.email>
            <cfset this.Gender = qryLoadUser.gender>
            <cfset this.SMSNumber = qryLoadUser.smsNumber>
            <cfset this.AccountEnabled = qryLoadUser.account_enabled>
            <cfset this.Confirmed = qryLoadUser.confirmed>
            <cfset this.PostalCode = qryLoadUser.zip_code>
            <cfset this.DBKey = qryLoadUser.id>
            <cfset this.SiteMemberships = "">
            <cfset this.Authenticated = false>
            <cfset this.CreationDate = qryLoadUser.CreationDate>
            <cfset this.Username = qryLoadUser.username>
            
            <cfset this.Written = true>
            
            <cfreturn #this#>            
            
    </cffunction>
        
    <cffunction name="Authenticate" displayname="Authenticate" hint="Authenticate this user object" access="public" output="no" returntype="boolean">
    	<cfargument name="password" type="string" required="yes">
        
        <cfif NOT this.Written>
        	<cfreturn false>
		</cfif>
        
        <cfif Hash(password) EQ this.HashedPassword>
        	<cfset this.Authenticated = true>
            <cfreturn true>
		<cfelse>
        	<cfreturn false>            
		</cfif>                    
    </cffunction>
    
    <cffunction name="OpenSession" displayname="GetSession" hint="Open a login session on the Prefiniti server." access="public" output="no" returntype="System.PrefinitiSession">
   		<cfargument name="NetAddress" displayName="NetAddress" hint="The user's IP address" type="string" required="true">
		<cfargument name="NetHostname" displayName="NetHostname" hint="The user's hostname" type="string" required="true">
		<cfargument name="NetBrowser" displayName="NetBrowser" hint="The user's web browser" type="string" required="true">
    
    	
		<cfset this.LoginSession = createObject("component", "System.PrefinitiSession").Open(this.Username, this.HashedPassword, NetAddress, NetHostname, NetBrowser)>
       
		<cfset this.SessionReady = true>
        <cfreturn #this.LoginSession#>
        
    </cffunction>
    
    <cffunction name="CloseSession" displayname="CloseSession" hint="Closes the active login session on the Prefiniti server." access="public" output="no" returntype="System.PrefinitiSession">
    	<cfscript>
			this.LoginSession.Close();
			this.SessionReady = false;
		</cfscript>
    
    	<cfreturn #this.LoginSession#>
    </cffunction>
    
    <cffunction name="FullName" displayname="FullName" hint="Get a formatted display of the Prefiniti user's full name." access="public" output="no" returntype="string">
    	<cfparam name="tmpS" default="">
        <cfset tmpS = this.FirstName & " " & this.LastName>
        
        <cfreturn #tmpS#>
    </cffunction>
    
    <cffunction name="WriteAsNewRecord" displayname="WriteAsNewRecord" hint="Write this user object to the database" access="private" output="no" returntype="boolean">
    	<cfparam name = "LocatorUUID" default="">
        <cfset LocatorUUID = CreateUUID()>
        
        <cfquery name="qryWriteAsNewRecord" datasource="#this.BaseDatasource#">
        	INSERT INTO Users
            	(username,
                password,
                firstName,
                lastName,
                longName,
                customerNumber,
                email,
                confirm_id,
                account_enabled,
                gender,
                confirmed,
                webware_admin,
                middleInitial,
                birthday,
                zip_code,
                smsNumber,
                CreationDate)
            VALUES
            	('#this.Username#'),
                '#this.HashedPassword#',
                '#this.FirstName#',
                '#this.LastName#',
                '#this.FirstName# #this.LastName#',
                0,
                '#this.EMailAddress#',
                '#LocatorUUID#',
                #this.AccountEnabled#,
                '#this.Gender#',
                #this.Confirmed#,
                0,
                '#this.MiddleInitial#',
                #this.Birthday#,
                '#this.PostalCode#',
                '#this.SMSNumber#',
                #this.CreationDate#)
		</cfquery>   
        
        <cfquery name="qryGetDBKey" datasource='#this.BaseDatasource#'>
        	SELECT id FROM users WHERE confirm_id='#LocatorUUID#'
        </cfquery>               
        
        <cfset this.DBKey = qryGetDBKey.id>
        <cfset this.Written = true>
        
        <cfreturn true>
    </cffunction>
    
    <cffunction name="UpdateExistingRecord" displayname="UpdateExistingRecord" hint="Update this user object in the database" returntype="boolean" access="private">
    
    	<cfif NOT this.Written>
        	<cfreturn false>
        </cfif>
        
    	<cfquery name="qryUpdateExistingRecord" datasource="#this.BaseDatasource#">
        	UPDATE Users
            	SET username='#this.Username#',
                password='#this.HashedPassword#',
                firstName='#this.FirstName#',
                middleInitial='#this.MiddleInitial#',
                lastName='#this.LastName#',
                longName='#this.FirstName# #this.MiddleInitial#. #this.LastName#',
                email='#this.EMailAddress#',
                accountEnabled=#this.AccountEnabled#,
                gender='#this.Gender#',
                confirmed=#this.Confirmed#,
                birthday=#this.Birthday#,
                zip_code='#this.PostalCode#',
                smsNumber='#this.SMSNumber#',
                CreationDate=#this.CreationDate#
			WHERE id=#this.DBKey#
		</cfquery>
        
        <cfreturn true>
	</cffunction>                                    
                
                
                
                
</cfcomponent> 