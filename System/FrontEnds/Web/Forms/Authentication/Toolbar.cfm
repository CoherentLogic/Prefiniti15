 
    <div style="width:100%;">
	<cfif session.User.SessionReady>
		<cfset tEnum = createObject("component", "System.SiteMembership")>
	    <cfset tQry = tEnum.Enumerate(session.User)>
    	
        <cfset currentApp = createObject("component", "System.App").Open(URL.AppID)>
        
        <cfparam name="deptArray" default="">
        <cfset deptArray = session.User.LoginSession.ActiveMembership.Site.Departments()>
        
        <cfparam name="appArray" default="">
        <cfset appArray = session.User.LoginSession.ActiveMembership.InstalledApps()>
        
        <cfmenu type="horizontal">
        	<cfmenuitem display="" image="/graphics/pi-16x16.png">
           		<cfmenuitem display="Search..." image="/graphics/zoom.png"/>
                <cfmenuitem divider />
                <cfif ArrayLen(appArray) EQ 0>
                	<cfmenuitem display="No apps installed"/>
				<cfelse>
                	
                    
                	<cfloop array="#appArray#" index="app">
                    	
                    	<cfoutput>
                        	<cfmenuitem display="#app.AppName#" image="#app.Icon#" href="/System/default.cfm?AppID=#app.AppID#&View=Home">
                            	                                    
                            </cfmenuitem>
						</cfoutput>                                             
					</cfloop>
				</cfif>    
                <cfmenuitem divider />                
                <cfmenuitem display="Manage Apps" href="javascript:GetMoreApps()" />
                <cfmenuitem divider />
                <cfmenuitem display="About Prefiniti" image="/graphics/pi-16x16.png"/>
            </cfmenuitem>
            
        	<cfmenuitem display="#session.User.FullName()#" image="/graphics/user.png">
            	<cfmenuitem display="My Files" image="/graphics/folder.png"/>
                <cfmenuitem display="My Memberships">  
                <cfmenuitem display="Find More Sites &amp; Companies" image="/graphics/zoom.png"/>
                <cfmenuitem divider />              
				<cfoutput query="tQry">
                	<cfmenuitem display="#SiteName# - #MembershipType#" href="/System/FrontEnds/Web/Forms/Authentication/ChangeSite.cfm?MembershipID=#MembershipID#"/>
				</cfoutput>
                </cfmenuitem>
                <cfmenuitem divider />
                <cfmenuitem display="Edit Profile"/>
                <cfmenuitem display="View Profile"/>
				<cfmenuitem divider />
                <cfmenuitem display="Edit Account"/> 
                <cfmenuitem display="Change Password"/>              
                <cfmenuitem divider />
                <cfmenuitem display="Log Out" href="javascript:LogOut();" image="/graphics/door_out.png"/>                    
            </cfmenuitem>
            
            <cfmenuitem display="#session.User.LoginSession.ActiveMembership.SiteName#">
            	<cfmenuitem display="#session.User.FirstName#: <strong>#session.User.LoginSession.ActiveMembership.MembershipType#</strong> of this company"/>
           		<cfmenuitem divider />
                <cfmenuitem display="Departments">
                	<cfloop array="#deptArray#" index="dept">
	                    <cfoutput>
                        <cfmenuitem display="#dept.DepartmentName#"/>
                        </cfoutput>
                    </cfloop>
				</cfmenuitem>
                <cfmenuitem divider />
                <cfmenuitem display="Products and Services" image="/graphics/cart.png"/>
                <cfmenuitem display="Contact This Company" image="/graphics/email.png"/>
                <cfmenuitem divider />
                <cfmenuitem display="Projects" image="/graphics/timeline_marker.png"/>
                <cfmenuitem display="Scheduling" image="/graphics/calendar.png"/> 
                <cfmenuitem display="Time Collection" image="/graphics/clock.png"/>                    
                    
            </cfmenuitem>
            <cfparam name="appViews" default="">
            <cfset appViews = session.User.LoginSession.CurrentApp.Connect(session.User.LoginSession.SessionToken).EnumViews()>
            <cfmenuitem display="#currentApp.AppName#" image="#currentApp.Icon#">
            	<cfmenuitem display="About #currentApp.AppName#" image="/graphics/information.png" href="javascript:AboutApp('#currentApp.AppID#');"
                />
                <cfmenuitem display="Preferences"/>
                <cfmenuitem display="Report Bug" image="/graphics/bug_add.png"/>                
                <cfmenuitem divider />
                <cfmenuitem display="Recent Documents" image="/graphics/page_white.png">
                	<cfmenuitem display="Recent documents here"/>
                </cfmenuitem>				
                <cfmenuitem display="Views">
                <cfloop array="#appViews#" index="view">
                   	<cfoutput>
                    <cfmenuitem display="#view#" href="/System/default.cfm?AppID=#URL.AppID#&View=#view#"/>
                    </cfoutput>
				</cfloop>            	                                        
                </cfmenuitem>
                <cfmenuitem divider />
                <cfoutput>
                <cfmenuitem display="Remove #currentApp.AppName#" image="/graphics/application_delete.png"/>
                </cfoutput>
            </cfmenuitem>
                 
    	</cfmenu>
        
     
    
    
    	
	<cfelse>
    	 <cfmenu type="horizontal">
        	<cfmenuitem display="" image="/graphics/pi-16x16.png">
           		<cfmenuitem display="Log In..." image="/graphics/door_in.png" href="/System/FrontEnds/Web/Forms/Authentication/Login.cfm"/>
                <cfmenuitem display="Create New Account..." image="/graphics/user_add.png"/>
                <cfmenuitem divider />
                <cfmenuitem display="About Prefiniti..." image="/graphics/pi-16x16.png"/>
            </cfmenuitem>
            <cfmenuitem display="You are not logged in." image="/graphics/lock_break.png"/>
		</cfmenu>            
	</cfif>                  
    </div>

