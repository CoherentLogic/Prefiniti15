<!--- Generated by Adobe Dreamweaver CS4 10.0.0.4117 [en] (MacPPC) - Wed Jan 13 2010 17:46:20 GMT-0700 (MST) --->

<cfcomponent displayName="Framework" hint="Prefiniti Base">
	
    <cfset this.BaseDatasource = "webwarecl">
    <cfset this.SitesDatasource = "sites">
    <cfset this.CMSDatasource = "webware_cms">
    
    <cffunction name="EnumApps" access="public" hint="Enumerate all available Prefiniti apps." returntype="array" output="no">
    	<cfparam name="tmpArray" default="">
        <cfset tmpArray = ArrayNew(1)>
        
        <cfquery name="qryEnumApps" datasource="#this.BaseDatasource#">
        	SELECT AppID FROM apps ORDER BY AppName
		</cfquery>
        
        <cfparam name="tmpObj" default="">
        
        <cfoutput query="qryEnumApps">
        	<cfset tmpObj = createObject("component", "System.App").Open(AppID)>
            #ArrayAppend(tmpArray, tmpObj)#
        </cfoutput>            
        
        <cfreturn #tmpArray#>
    </cffunction>
    
</cfcomponent>