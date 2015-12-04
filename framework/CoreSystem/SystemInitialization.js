function InitializePrefiniti() 
{
	//hideSplash();
	
	var wcDiv = document.createElement('div');
	wcDiv.setAttribute('id', 'window_container');
	wcDiv.style.position = "absolute";
	wcDiv.style.top = "0px";
	wcDiv.style.left = "0px";
	wcDiv.style.width = "0px";
	wcDiv.style.height = "0px";
	
	document.body.appendChild(wcDiv);
	
	
	
	try {
		writeConsole("Prefiniti Application Framework 2.0");
		writeConsole("&nbsp;Copyright &copy; 2008, AJL Intel-Properties LLC");
		writeConsole("");
		writeConsole("Initializing framework...");
	}
	catch (ex) {}
	
	if(AuthenticationRecord.PAFFLAGS & F_CM) {
		document.oncontextmenu = function () { return false };
	}
	
	document.onresize = handleAppResize ();
	
	
	if (!p_session) {
		P_SMALLICON = new PDimensions(16, 16);
		P_LARGEICON = new PDimensions(32, 32);
		p_session = new PSession(new PrefinitiFramework());
		//document.body.onunload = p_session.UnloadCheck();
		
		handleAppResize();
		CreateDesktop();
		
		if(AuthenticationRecord.PAFFLAGS & F_TB) {
			LoadDesktopManager();
		}
		
		LoadTools();
	
		soundManager.createMovie('/sm2/soundmanager2.swf');
		
		
		soundManager.play('SND_SIGNON');
		

		
		var pt;
		pt = new PTask ('Notification Listener', PAutoUpdater('/framework/components/sitestats_15.cfm', 'SiteStatsDiv'), 10, true, glob_userid);
		PAddTask(pt);
		
		pt = new PTask ('Garbage Collection', KHarvestCompleteRequests, 30, true, 0);
		PAddTask(pt);
		
		pt = new PTask ('Automatic Window Refresh', p_session.Framework.DoAutoRefresh, 10, true, glob_userid);
		PAddTask(pt);
		
		pt = new PTask ('System Clock', PAutoUpdater('/clock/clock.cfm', 'SystemClock'), 5, true, 0);
		PAddTask(pt);
		
		if (AuthenticationRecord.PAFFLAGS & F_GPS) {
			pt = new PTask ('GPS Status Listener', FWCheckGPS, 5, true, glob_userid);
			PAddTask(pt);
		}
				
		pt = new PTask ('Null Request Cleanup', KDestroyBitBucket, 8, true, 0);
		PAddTask(pt);
		
		pt = new PTask ('Session Monitor', KSessionMonitor, 5, true, 0);
		PAddTask(pt);
		
		if (AuthenticationRecord.PAFFLAGS & F_GPS) {
			pt = new PTask ('GPS Updater', PAutoUpdater('/framework/components/gps_module.cfm', 'SystemGPS'), 5, true, glob_userid);
			PAddTask(pt);
		}
		
		
		KConsistencyCheck();
		
		try { writeConsole("Framework initialization successful."); } catch(ex) {}
		
		p_session.CenterDock();
		
		if (AuthenticationRecord.PAFFLAGS & F_NB) {
			P15Browser();
		}
		
		
		if(AuthenticationRecord.AutoCatalog.toString() != '') {
			try {
				ViewCatalog(AuthenticationRecord.AutoCatalog);
			}
			catch (ex) {}
		}
		
		var country;
		var region;
		var state;
		var community;
		
		country = KGetSetting(AuthenticationRecord.UserID, "CI_COUNTRY");
		state = KGetSetting(AuthenticationRecord.UserID, "CI_STATE");
		region = KGetSetting(AuthenticationRecord.UserID, "CI_REGION");
		community = KGetSetting(AuthenticationRecord.UserID, "CI_COMMUNITY");
		
		if (!country | !state | !region | !community) {
			ChooseRegion();
		}
		
		var hostRegistered = null;
		
		var rh = new KRequestHeaders();
		rh.Add(new KRequestParam("HP_PrefinitiHostKey", HP_PrefinitiHostKey));
		
		var hkurl = '/Framework/CoreSystem/HTMLResources/HostRegistered.cfm';
		
		hostRegistered = parseInt(KSynchronousRequest(hkurl, rh));
		
		if(hostRegistered < 1) {
			RegisterHost();
		}
		
		PEnableTaskQueue();
		
		return true;
	}
	else {
		writeConsole("Framework initialization could not be completed.");
		return false;
	}
}

function LoadDesktopManager() 
{
	var DMDiv = document.createElement('div');
	DMDiv.setAttribute('id', 'DMContainer');
	DMDiv.style.position = "absolute";
	DMDiv.style.bottom = "0px";
	DMDiv.style.left = "0px";
	DMDiv.style.width = "100%";
	DMDiv.style.height = "0px";
	
	AjaxGetElementReference('PDesktopWindow').appendChild(DMDiv);
	
	var OnRequestCallback = function () {
		p_session.CenterDock();
	};
	
	AjaxLoadPageToDiv('DMContainer', '/Framework/CoreSystem/DesktopTools/DesktopManager.cfm', OnRequestCallback);
	
	
}

function LoadTools()
{
	
		var DMDiv = document.createElement('div');
		DMDiv.setAttribute('id', 'Tools');
		DMDiv.style.position = "absolute";
		DMDiv.style.bottom = "0px";
		DMDiv.style.left = "0px";
		DMDiv.style.width = "100%";
		try {
			DMDiv.style.height = "80px;";
		}
		catch (ex) {
			DMDiv.style.height = 80+'px';
		}
		
		AjaxGetElementReference('PDesktopWindow').appendChild(DMDiv);
		
		var OnRequestCallback = function () {
			//alert(GetInnerHTML('Tools'));
		};
		
		
		AjaxLoadPageToDiv('Tools', '/Framework/CoreSystem/DesktopTools/Notifications.cfm', OnRequestCallback);
	
}

function CreateDesktop()
{
	var dtRect = new PRect(0, 0, p_session.ScreenWidth, p_session.ScreenHeight);
	var dtIcon = new PIcon('/graphics/show_desktop.png', P_SMALLICON);
	var dtWindowHandle = "PDesktopWindow";
	var dtWindow = new PWindow(dtWindowHandle, 
							   "Prefiniti Desktop", 
							   dtRect, 
							   dtIcon, 
							   WS_ROOT, 
							   DesktopMessageHandler);
	
	ROOT_REF = p_session.Framework.CreateWindow(dtWindow);
	p_session.Framework.PostLocalMessage('PDesktopWindow', 
										 IWC_SCREENRESIZED, 
										 C_WINDOWMANAGER, 
										 new PDimensions(p_session.ScreenWidth, p_session.ScreenHeight));
	
	p_session.Framework.PostLocalMessage('PDesktopWindow', 
										 IWC_POPULATEFOLDER, 
										 C_WINDOWMANAGER,
										 null);	
}	

function DesktopMessageHandler(handle, msg_id, sender_component, message_object)
{
	//alert(handle);
	switch (msg_id) {
		case IWC_POPULATEFOLDER:
			if (GlobPAFFLAGS & F_FM) {
				PPopulateFolder('DesktopFolder', 0, 'VT_ICON');
			}
			break;
		case IWC_SCREENRESIZED:	
			
			
			var wRef;
			wRef = AjaxGetElementReference("PDesktopWindow");
			wRef.style.width = message_object.width + "px";
			wRef.style.height = message_object.height + "px";
			
			/*var clockRef = AjaxGetElementReference('SystemClock');
			if (clockRef) {
				clockRef.style.zIndex = p_session.Framework.FindWindow('PDesktopWindow').style.zIndex + 10;
			}*/
			
			// load the resized desktop wallpaper.
			// lots of undue cleverness in here, but it felt right at the time...
			var url;
			url = '/framework/components/get_desktop_background.cfm?Width=' + escape(message_object.width);
			url += '&Height=' + escape(message_object.height);
			
			
			AjaxLoadPageToDiv('dev-null', url);
			
			var targetDiv = AjaxGetElementReference('PDesktopWindow');
			var newDiv = document.createElement('div');
			newDiv.setAttribute('id', 'ResNotifier');
			
			targetDiv.appendChild(newDiv);
			
			var onCompleteCallback = function () {
				SetInnerHTML('screenRes', message_object.width + "x" + message_object.height);
				
				window.setTimeout('HideResChanged();', 3000);
				
			};
			
			AjaxLoadPageToDiv('ResNotifier', '/framework/components/resolution_changed.cfm', onCompleteCallback);
			break;
		case IWC_REQUESTMINIMIZE:
			break;
		default:
			p_session.Framework.DefaultMessageHandler(handle, msg_id, sender_component, message_object);
			break;
	}
}


function KConsistencyCheck()
{
	var KCCwin =  new PWindow('KConsistencyCheck', 
							   "Scanning Objects", 
							   new PAutoRect(320, 200), 
							   new PIcon("/graphics/cog.png", P_SMALLICON),  
							   WS_DIALOG, 
							   null,
							   new PColor(255, 255, 255));
							   
	var wRef = p_session.Framework.CreateWindow(KCCwin);
	
	var LoadCallback = function () {
		p_session.Framework.PostGlobalMessage(IWC_POPULATEFOLDER, C_WINDOWMANAGER, null);
		window.setTimeout("p_session.Framework.DeleteWindow('KConsistencyCheck');", 20000);
	};
	
	wRef.LoadClientArea('/framework/components/ConsistencyCheck.cfm?UserID=' + glob_userid + '&Fix', LoadCallback);
}


function RegisterHost()
{
	/* Window code generated by Prefiniti Development System 1.0.3 */
	var RH_handle = 'RegisterHost';
	
	var wRef = p_session.Framework.FindWindow(RH_handle);
	if (!wRef) {	
		var RH_title  = 'Register Computer';
		var RH_icon   = new PIcon('/graphics/computer_add.png', P_SMALLICON);
		var RH_rect   = new PAutoRect(450, 400);
		var RH_style  = WS_ALLOWCLOSE | WS_ALLOWMINIMIZE | WS_SHOWAPPMENU | WS_ENABLEPDM;
		var RH_MessageHandler  = null;
		var RH_BackgroundColor = new PColor(255, 255, 255);
	
		var RH_window = new PWindow(RH_handle, RH_title, RH_rect, RH_icon, RH_style, RH_MessageHandler, RH_BackgroundColor);
	
		wRef = p_session.Framework.CreateWindow(RH_window);
			
	}

	RH_ClientAreaURL = '/Framework/CoreSystem/HTMLResources/RegisterHost.cfm';
	RH_ClientAreaURL += '?HP_PrefinitiHostKey=' + escape(HP_PrefinitiHostKey);
	
	wRef.LoadClientArea(RH_ClientAreaURL);
}