
<html>
<head>
	<title>Prefiniti - The Next Generation</title>
	<link rel="stylesheet" href="Prefiniti.css">
    <script src="/System/ClientScripts/prefiniti.js" type="text/javascript"></script>
    <script src="/System/ClientScripts/Apps.js" type="text/javascript"></script>
</head>
    
<body <cfoutput> onload="PrefinitiApp('#URL.AppID#', #session.User.LoginSession.ActiveMembership.IsAppInstalled(URL.AppID)#)"  </cfoutput>>    

<cfset session.User.LoginSession.CurrentApp = createObject("component", "System.App").Open(URL.AppID)>
	     
<cfinclude template="/System/FrontEnds/Web/Forms/Authentication/Toolbar.cfm">	
<cfinclude template="/System/FrontEnds/Web/Forms/Authentication/LogoutDialog.cfm">	

<cfdiv id="RenderingCanvas" style="width:100%;height:auto; margin:0px;">
	Virgin rendering canvas
</cfdiv>    


<!---<cflayout type="border" style="height:100%;width:100%; border:none;">
    <cflayoutarea position="top" style="height:80px; border:none;">
 
    </cflayoutarea>
    <cflayoutarea position="left" style="width:220px;" collapsible="true" title="Navigation">
    
    </cflayoutarea>
    
    <cflayoutarea position="center" style="height:300px;width:400px">
    
    
  <!--- <cftry>
    	           <cfform>

              <cfgrid name="memberships" format="html" bind="cfc:System.SiteMembership.EnumerateGrid(session.User, {cfgridpage}, {cfgridpagesize}, {cfgridsortcolumn}, {cfgridsortdirection})">
            
              <cfgridcolumn name="SiteID" header="Site ##" width="10"/>
            
              <cfgridcolumn name="SiteName" header="Site Name" width="300"/>
            
              <cfgridcolumn name="MembershipType" header="Member Type" width="100"/>
            
              
              </cfgrid>
            
              </cfform>  
		<cfcatch>
        	<cfoutput>#cfcatch.Message#</cfoutput>
		</cfcatch>
        </cftry> --->         
    </cflayoutarea>
<!---    <cflayoutarea position="right" style="height:80px;">
    RIGHT
    </cflayoutarea>--->
    <cflayoutarea position="bottom" style="height:30px;">
    Copyright &copy; 2010 AJL Intel-Properties LLC<br>
    All rights reserved.
    </cflayoutarea>
 </cflayout>--->

	


 </body>
 </html>