<cfset tmpMember = createObject("component", "System.SiteMembership").LoadByID(URL.MembershipID)>
<cfset session.User.LoginSession.ActiveMembership = tmpMember>

<cflocation url="/System/default.cfm?AppID=#session.User.LoginSession.CurrentApp.AppID#&View=Home" addtoken="no">