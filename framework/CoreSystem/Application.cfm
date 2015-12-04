<!--
	Prefiniti Version 2.0
    Application.cfm
    
    Loads base JavaScript support, sets up the ColdFusion session, and prepares Prefiniti to run.

-->
<cfapplication name="Prefiniti" sessionmanagement="yes">
<cfinclude template="/console.cfm">
<cfinclude template="/Framework/CoreSystem/HTMLResources/ConfigureRSS.cfm">
<cfparam name="session.PrefinitiHostKey" default="">

<cfif IsDefined("cookie.PrefinitiHostKey")>
	<cfset session.PrefinitiHostKey = cookie.PrefinitiHostKey>
<cfelse>
	<cfset session.PrefinitiHostKey = CreateUUID()>
	<cfcookie name="PrefinitiHostKey" expires="never" value="#session.PrefinitiHostKey#">
	<cfquery name="WriteNewHost" datasource="webwarecl">
		INSERT INTO hosts
			(HostKey,
			HostName,
			HostDescription,
			DefaultRunLevel,
			BootTimeout)
		VALUES
			('#session.PrefinitiHostKey#',
			'[New Host]',
			'You will be asked configure this host when you log in.',
			3,
			10)
	</cfquery>
</cfif>

<cfquery name="GetHost" datasource="webwarecl">
	SELECT * FROM hosts WHERE HostKey='#session.PrefinitiHostKey#'
</cfquery>

<cfquery name="GetSessions" datasource="webwarecl">
	SELECT * FROM auth_tokens WHERE HP_PrefinitiHostKey='#session.PrefinitiHostKey#' ORDER BY login_date DESC
</cfquery>

<div id="HostInfo" style="display:none; width:450px; height:auto; background-color:black; color:white; top:8px; left:8px; position:fixed; border:1px solid white; padding:5px; -moz-border-radius:5px;">
	
	<cfoutput query="GetHost">
	<table width="100%" cellpadding="5" cellspacing="0" style="border:1px solid blue;">
	<tr>
		<td width="84"><img src="/graphics/AppIconResources/crystal_project/64x64/devices/Globe.png" align="absmiddle" style="padding:10px;"> </td>
		<td align="center">
			<h1>#HostName#</h1>
			<p>#HostDescription#</p>
		</td>
	</tr>
	</table>
	
	
	</cfoutput>
	<div style="width:100%; height:100px; overflow:auto; background-color:white;">
		<table width="100%" class="ModTable">
			<tr>
				<th>User</th>
				<th>Login Date</th>
				<th>Logout Date</th>
			</tr>
		<cfoutput query="GetSessions">
			<tr>
				<td><a href="####" onClick="SetValue('UserName', '#username#'); SetValue('Password', ''); AjaxGetElementReference('Password').focus();">#username#</a></td>
				<td>#DateFormat(login_date, "mm/dd/yyyy")# #TimeFormat(login_date, "h:mm tt")#</td>
				<td>#DateFormat(logout_date, "mm/dd/yyyy")# #TimeFormat(logout_date, "h:mm tt")#</td>
			</tr>
				
		
		</cfoutput>
		</table>
	</div><br>
	
	<cfinclude template="/Framework/CoreSystem/HTMLResources/LoginDialog.cfm">
	
</div>
<link href="/Framework/CoreSystem/Styles/Base.css" rel="stylesheet">

<div id="soundmanager-debug" style="display:none; position:absolute; left:0px; top:0px; z-index:50000; width:300px; height:auto;"></div>
<div id="dev-null" style="display:none"></div>
<cfif IsDefined("URL.FW_RUNLEVEL")>
<cfquery name="GetBase" datasource="webwarecl">
	SELECT * FROM basescripts WHERE RunAt <= #URL.FW_RUNLEVEL# ORDER BY RunAt, id 
</cfquery>

<script>
	function SetLoaded(id, text) {
		document.getElementById('LS_' + id.toString()).style.backgroundColor = "#3399CC";
		document.getElementById('LoadInfo').innerHTML = text;
		writeConsole("LOADER:   module " + text + ' <strong style="color:green;">(ok)</strong>');
	}
</script>
<cfparam name="iWidth" default="">
<cfset iWidth = Int(330 / GetBase.RecordCount)>
<div id="loadstatus">

    <div class="LoadWrapper" align="left">
    	<img src="/graphics/prefiniti-small.png" /><br /><br />
        <strong>Loading: </strong><span id="LoadInfo"></span><br /><br />
        
        <cfoutput query="GetBase">
        	<div id="LS_#id#" style="float:left; background-color:##999999; margin:0px; width:#iWidth#px;">
            &nbsp;
            </div>
        </cfoutput><br /><br />
        
        
      	
    </div>
</div>

<cfoutput query="GetBase">
	<script>
		SetLoaded(#id#, '#ScriptName#');
	</script>		
	<script type="text/javascript" src="#ScriptPath#"></script>
</cfoutput>

<cfoutput>
<script>
	try {
	soundManager.onload = function() {
		soundManager.createSound({
		 id:'SND_SIGNON',
		 url:'/audio/pregreet.mp3'
		});
		soundManager.createSound({
		 id:'SND_OBJECTCLICK',
		 url:'/audio/click.mp3'
		});
		soundManager.createSound({
		 id:'SND_ERROR',
		 url:'/audio/error.mp3'
		});
		soundManager.createSound({
		 id:'SND_WEEOOPP',
		 url:'/audio/weeoopp.mp3'
		})
		
		
	
	};
	}
	catch (ex) {}
	
	hideDiv('loadstatus');
	
	var HP_CGI_Browser = '#CGI.HTTP_USER_AGENT#';
	var HP_CGI_NetworkNode = '#CGI.REMOTE_ADDR#';
	
	var HP_Browser = null;
	var HP_OS = null;
	
	var HPB_FIREFOX = 'Mozilla Firefox';
	var HPB_MSIE = 'Microsoft Internet Explorer';
	var HPB_SAFARI = 'Apple Safari';
	var HPB_OPERA = 'Opera';
	
	var HPOS_WINDOWS = 'Microsoft Windows';
	var HPOS_MACOS = 'MacOS';
	var HPOS_LINUX = 'Linux';
	var HPOS_OS2 = 'IBM OS/2';
	
	if(HP_CGI_Browser.indexOf('Firefox') != -1) {
		HP_Browser = HPB_FIREFOX;
	}
	
	if(HP_CGI_Browser.indexOf('Internet Explorer') != -1) {
		HP_Browser = HPB_MSIE;
	}
	
	if(HP_CGI_Browser.indexOf('Safari') != -1) {
		HP_Browser = HPB_SAFARI;
	}
	
	if(HP_CGI_Browser.indexOf('Opera') != -1) {
		HP_Browser = HPB_OPERA;
	}
	
	if(HP_CGI_Browser.indexOf('Windows') != -1) {
		HP_OS = HPOS_WINDOWS;
	}
	
	if(HP_CGI_Browser.indexOf('Mac') != -1) {
		HP_OS = HPOS_MACOS;
	}
	
	if(HP_CGI_Browser.indexOf('Linux') != -1) {
		HP_OS = HPOS_LINUX;
	}
	
	if(HP_CGI_Browser.indexOf('OS/2') != -1) {
		HP_OS = HPOS_OS2;
	}
	
	var HP_PrefinitiHostKey = '#session.PrefinitiHostKey#';
	showDiv('HostInfo');

	hideDiv('prefiniti_console_wrapper');
</script>
</cfoutput>
    



<!-- google maps crap -->
<cfif cgi.HTTP_HOST EQ "www.webwarecl.com">
	<!--Google Maps API key for webwarecl.com-->
	<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAANDvmFaqAegt0QYIzYW9D3BS9InrnI581krHDS1IjuwzeaQviEhQBz53weq4VDYr1p0Sz1v1fM1skIA"
      type="text/javascript"></script>
<cfelseif cgi.HTTP_HOST EQ "www.webwarecl.net">
	<!--Google Maps API key for webwarecl.net-->	
    <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAANDvmFaqAegt0QYIzYW9D3BTjBSsxbgXyRVXCz3Y1iKPokBykHhQlDq4lMFFgzKoxkPrLb2CAxQNfDw"
      type="text/javascript"></script>
<cfelseif cgi.HTTP_HOST EQ "prefiniti15.prefiniti.com">
	<!--Google Maps API key for prefiniti.com-->
	<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAitf3smSCpQmUBy6Q7jMVfRRcY8x492SRAD9sfLbE7Hvo6yBMoxR3dXXSY-V2dgUzr31XDxsPAlWb3w"
      type="text/javascript"></script>      
<cfelseif cgi.HTTP_HOST EQ "www.prefiniti.net">
	<!--Google Maps API key for prefiniti.net-->
    <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAANDvmFaqAegt0QYIzYW9D3BRvWbUCKD0fBD63QbLGzCRB1qPvoxS-oPj5SWW_XVANygFvcFE0OmdFKg"
      type="text/javascript"></script>
<cfelseif cgi.HTTP_HOST EQ "www.prefiniti.mobi">
	<!--Google Maps API key for prefiniti.mobi-->
    <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAANDvmFaqAegt0QYIzYW9D3BQG9--bzDoENeb2oUAu-TVJT4rODxRlV0_TON-qVKMhrTAgqvlcDngVYA"
      type="text/javascript"></script>            
</cfif>
<cfelse>
	<style type="text/css">
		.LoadTable td {
			border-bottom:1px solid #999999;
			background-color:#C0C0C0;
		}
	</style>
	<script type="text/javascript">
	
	<cfoutput>
	<cfparam name="vali" default="">
	<cfset vali = GetHost.DefaultRunLevel * 1000>
	window.setTimeout("Reload(#GetHost.DefaultRunLevel#);", #vali#);
	</cfoutput>
	
	function Reload(level)
	{
		location.replace("http://www.prefiniti.com/Framework/CoreSystem/Run.cfm?FW_RUNLEVEL=" + escape(level));
	}
	</script>
	<body style="background-color:white;">
	<div style="margin:20px; padding:20px; width:640px; height:auto; font-family:Verdana, Arial, Helvetica, sans-serif; border:1px solid black; background-color:#C0C0C0;">
		<strong><img src="/graphics/pi-16x16.png" align="absmiddle"/> Prefiniti Application Framework 2.0</strong><br />
		<hr />
		<strong>Load Options:</strong>
	
			<table class="LoadTable" width="100%" cellpadding="3" cellspacing="0">
				<tr>
					<td><input type="button" class="normalButton" value="Safe Mode" onClick="Reload(0);"/></td>
					<td>
						<strong>Safe Mode</strong><br /><br />
						<p>Allows only the Desktop Manager and basic Prefiniti 2.0 features to function. Prefiniti Classic applications, the network browser, content management, and most native applications will be disabled.</p>
						<p>Use only when no other mode of Prefiniti will work.</p>
					</td>
				</tr>
				<tr>
					<td><input type="button" class="normalButton" value="Safe Mode with CMS" onClick="Reload(1);"/></td>
					<td>
						<strong>Safe Mode with CMS</strong><br />
						<p>Allows the Desktop Manager, basic Prefiniti 2.0 features, and content management to function. Prefiniti Classic applications, the network browser, and many native applications will be disabled.</p>
					</td>
				</tr>
				<tr>
					<td><input type="button" class="normalButton" value="Native Only Mode" onClick="Reload(2);" /></td>
					<td>
						<strong>Native Only Mode</strong><br />
						<p>Allows all native Prefiniti 2.0 applications to function. This is the preferred mode for users who don't use Prefiniti Classic applications, and is faster than Full Mode.</p>
						<p>Prefiniti Classic applications will be disabled.</p>
					</td>
				</tr>
				<tr>
					<td><input type="button" class="normalButton" value="FW1.5 Compatibility Mode" onClick="Reload(3);" /></td>
					<td>
						<strong>Framework 1.5 Compatibility Mode</strong><br />
						<p>Allows all native Prefiniti 2.0 and Prefiniti Classic applications to function. Use this mode when you wish to use Prefiniti Classic features.</p>
						<p>Nothing is disabled in full mode, but this mode can be memory intensive, especially for mobile browsers.</p>
					</td>
				</tr>
			</table>
			<br />
			<strong>Hosting Platform Information:</strong><br /><br />
			<blockquote>
			<cfoutput>
			<strong>Browser:</strong> #CGI.HTTP_USER_AGENT#<br />
			<strong>Network Node:</strong> #CGI.REMOTE_ADDR#<br /><br />
			#DateFormat(Now(), "mm.dd.yyyy")# #TimeFormat(Now(), "hh:mm:ss")#
			</cfoutput>
			</blockquote>
			
			
	</div>
	</body>
	
	<div style="position:fixed; bottom:5px; left:10px; width:400px; padding:5px; background-color:white; color:black; border:1px solid black;">
				<cfoutput><strong>Automatic Load</strong><br><br>
				<img src="/graphics/boot.gif" align="absmiddle"> Prefiniti will load at run level #GetHost.DefaultRunLevel# in #GetHost.BootTimeout# seconds...
				</cfoutput>
			</div>
</cfif>


