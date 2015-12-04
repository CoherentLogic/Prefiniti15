<cfwindow name="LogoutDialog" title="Log Out" 
draggable="false"
resizable="false" 
initshow="false" 
height="250" 
width="350"
modal="true"
center="true">
<div style="width:100%;height:auto;" align="left">
	<h1>Log Out of Prefiniti</h1>
    
    <cfoutput>
    <p>This will sign you out of The Prefiniti Network. Your session time today was <strong>#DateDiff("h", session.User.LoginSession.DateOpened, Now())# hours.</strong></p>
    
    <p><label><input type="checkbox">Send all pending notifications now</label></p>
   
   	<br><br>
    <p><input type="button" value="Cancel" onclick="ColdFusion.Window.hide('LogoutDialog');">
    	<input type="button" value="Log Out" onclick="location.replace('/System/FrontEnds/Web/Forms/Authentication/Logout.cfm');"></p>
	</cfoutput>        
    
</div>
</cfwindow>