<cfcomponent displayname="Site" hint="Represents a site on Prefiniti." extends="System.Framework">
	
    <cfset this.SiteName = "">
    <cfset this.Administrator = "">
    <cfset this.BillingPlan = "">
    <cfset this.SalesTaxRate = 0>
    <cfset this.Enabled = "">
    <cfset this.Industry = "">
    
    <cfset this.Logo = "">
    <cfset this.Slogan = "">
	<cfset this.About = "">
    <cfset this.Summary = "">
    <cfset this.MissionStatement = "">
	<cfset this.VisionStatement = "">
    
    <cfset this.Written = false>
	<cfset this.DBKey = "">
    
    
    <cffunction name="Open" displayname="Open" hint="Open a Prefiniti site" access="public" returntype="System.Site">
		<cfargument name="SiteName" type="string" required="yes">
		
        <cfquery name="qryOpenSite" datasource="#this.SitesDatasource#">
        	SELECT * FROM sites WHERE SiteName='#SiteName#'
		</cfquery>
        
        <cfscript>
			this.SiteName = qryOpenSite.SiteName;
			this.Administrator = createObject("component", "System.User").OpenByDBKey(qryOpenSite.admin_id);
			// this.BillingPlan		TODO: implement System.BillingPlan
			this.SalesTaxRate = qryOpenSite.salestax_rate;
			this.Enabled = qryOpenSite.enabled;
			// this.Industry		TODO: implement System.Industry
			// this.Logo			TODO: implement System.Image
			this.Slogan = qryOpenSite.slogan;
			this.About = qryOpenSite.about;
			this.Summary = qryOpenSite.Summary;
			this.MissionStatement = qryOpenSite.mission_statement;
			this.VisionStatement = qryOpenSite.vision_statement;			
			
			this.DBKey = qryOpenSite.SiteID;
			this.Written = true;
		</cfscript>			
			
		<cfreturn #this#>
	</cffunction>
    
     <cffunction name="OpenByDBKey" displayname="OpenByDBKey" hint="Open a Prefiniti site by its database PK." access="public" returntype="System.Site">
		<cfargument name="DBKey" type="numeric" required="yes">
		
        <cfquery name="qryOpenSite" datasource="#this.SitesDatasource#">
        	SELECT * FROM sites WHERE SiteID='#DBKey#'
		</cfquery>
        
        <cfscript>
			this.SiteName = qryOpenSite.SiteName;
			this.Administrator = createObject("component", "System.User").OpenByDBKey(qryOpenSite.admin_id);
			// this.BillingPlan		TODO: implement System.BillingPlan
			this.SalesTaxRate = qryOpenSite.salestax_rate;
			this.Enabled = qryOpenSite.enabled;
			// this.Industry		TODO: implement System.Industry
			// this.Logo			TODO: implement System.Image
			this.Slogan = qryOpenSite.slogan;
			this.About = qryOpenSite.about;
			this.Summary = qryOpenSite.Summary;
			this.MissionStatement = qryOpenSite.mission_statement;
			this.VisionStatement = qryOpenSite.vision_statement;			
			
			this.DBKey = qryOpenSite.SiteID;
			this.Written = true;
		</cfscript>			
			
		<cfreturn #this#>
	</cffunction>
    
    <cffunction name="Departments" displayname="Departments" hint="Array of departments in a Prefiniti site." access="public" returntype="array" output="no">
    	
        <cfparam name="tmpArray" default="">
        <cfset tmpArray = ArrayNew(1)>
        
        <cfquery name="qryDepartments" datasource="#this.SitesDatasource#">
        	SELECT id FROM departments WHERE site_id=#this.DBKey#
        </cfquery>
        
        <cfparam name="tDept" default="">      
        <cfoutput query="qryDepartments">
        	<cfset tDept = createObject("component", "System.Department").LoadByDBKey(id)>
            #ArrayAppend(tmpArray, tDept)#
        </cfoutput>
        
        <cfreturn #tmpArray#>
    </cffunction>
</cfcomponent>