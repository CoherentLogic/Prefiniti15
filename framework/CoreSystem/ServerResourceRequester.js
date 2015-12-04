/*
 * ServerResourceRequester.js
 * AJAX core functions
 *
 * John Willis
 * john@prefiniti.com
 *
 * Copyright (C) 2008, AJL Intel-Properties, LLC
 *
 */


/* load statuses */
var LS_PENDING = 0;
var LS_WAITING = 1;
var LS_COMPLETE = 2;
var LS_ERROR = 3;

function KGetAjax()
{
	var xmlHttp;
	
	try {
		xmlHttp = new XMLHttpRequest();
		//writeConsole('Using industry-standard AJAX');
	}
	catch (e) {
		try {
			xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
			//writeConsole('Using MSXML AJAX');
		}
		catch (e) {
			try {
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
				//writeConsole('Using MSXML AJAX');
			}
			catch (e) {
				writeConsole('FATAL:  AJAX not supported');
				return false;
			}
		}
	}
	
	return xmlHttp;
}


function KReqResult() {
	this.Size = null;
	this.RawData = null;
	this.DefaultViewXSLT = null;
	this.ObjectTypeID = null;
	this.InstanceID = null;
	this.Status = LS_PENDING;
}


var AsyncRequests = new Array(1);
var CReqIdx = 0;

function KObjectRequest(ObjectTypeID, InstanceID)
{
	var RequestHeaders = new KRequestHeaders();
	RequestHeaders.Add(new KRequestParam("ObjectTypeID", ObjectTypeID));
	RequestHeaders.Add(new KRequestParam("InstanceID", InstanceID));
	
	var BaseURL = "/Framework/ServerInterface/SIObjectXML.cfm";
	
	var Request = KGetAjax();
	var URL = BaseURL + RequestHeaders.QueryString();
	
	AsyncRequests[CReqIdx] = new KReqResult();
	var result = AsyncRequests[CReqIdx];
	
	ro.onreadystatechange = function ()
	{
		switch (ro.readyState) {
			case 1:				//waiting
				result.Status = LS_WAITING;
				break;
			case 4:				//ready
				result.Status = LS_COMPLETE;
				result.RawData = Request.responseXML;
				result.Size = Request.responseLength;
				result.DefaultViewXSLT = KGetDefaultView(ObjectTypeID);
				result.ObjectTypeID = ObjectTypeID;
				result.InstanceID = InstanceID;
				
				p_session.Framework.PostGlobalMessage(IWC_OBJECTDATAREADY, C_DATATRANSPORT, result);
				break;
		}
	}
	
	ro.open("GET", URL, true);
  	ro.send(null);
	
	CReqIdx++;
}


function KSynchronousRequest(BaseURL, RequestHeaders)
{
	var ro = KGetAjax();
	var URL = BaseURL + RequestHeaders.QueryString(BaseURL);
	
	ro.open("GET", URL, false);                             
    ro.send(null);
    return ro.responseText;	
}

function KSynchronousRequestXML(BaseURL, RequestHeaders)
{
	var ro = KGetAjax();
	var URL = BaseURL + RequestHeaders.QueryString(BaseURL);
	
	ro.open("GET", URL, false);                             
    ro.send(null);
    return ro.responseXML;	
}

function KAsyncRequest(BaseURL, RequestHeaders, OnTransferWaiting, OnTransferCompleted, Legacy)
{
	var ro = KGetAjax();
	var URL = BaseURL + RequestHeaders.QueryString(BaseURL);
	
	
	ro.onreadystatechange = function ()
	{
		switch (ro.readyState) {
			case 1:				//waiting
				OnTransferWaiting();
				break;
			case 4:				//ready
				OnTransferCompleted(ro.responseText);
				try {
					Legacy();
				}
				catch (ex) {}
				break;
		}
	}
	
	ro.open("GET", URL, true);
  	ro.send(null);
}

un = 1;
function GetUnique ()
{
	un++;
	return un;
}

function AjaxLoadPageToDiv(DivID, PageURL, onTransferCompleted)
{
	KSessionMonitor();
	
	
	if(DivID == 'tcTarget') {
		// THIS IS A LEGACY LOAD
		AjaxLoadPageToDivC(DivID, PageURL, onTransferCompleted);
		return;
	}
	
	// THIS IS A NATIVE LOAD
	var RequestHeaders = new KRequestHeaders();
	RequestHeaders.Add(new KRequestParam("CalledByUser", AuthenticationRecord.UserID));
	RequestHeaders.Add(new KRequestParam("Current_Association", AuthenticationRecord.AssociationID));
	RequestHeaders.Add(new KRequestParam("Current_Site_ID", AuthenticationRecord.SiteID));
	RequestHeaders.Add(new KRequestParam("FrameworkRevision", p_session.Framework.Revision));
	RequestHeaders.Add(new KRequestParam("PAFFLAGS", AuthenticationRecord.PAFFLAGS));
	RequestHeaders.Add(new KRequestParam("HP_Browser", HP_Browser));
	RequestHeaders.Add(new KRequestParam("HP_OS", HP_OS));
	RequestHeaders.Add(new KRequestParam("PDMDefaultTheme", AuthenticationRecord.DesktopTheme));
	RequestHeaders.Add(new KRequestParam("LoaderUniqueValue", GetUnique()));
	
	
	var CB_Waiting = function () {
		document.body.style.cursor="wait";
		SetInnerHTML(DivID, '<img src="/graphics/ajax-loader.gif" align="absmiddle" style="padding:5px;">');
	};
	
	var CB_Complete = function (Data) {
		SetInnerHTML(DivID, Data);
		document.body.style.cursor = "default";
	};
	
	KAsyncRequest(PageURL, RequestHeaders, CB_Waiting, CB_Complete, onTransferCompleted);		
}

function KGetUserProfileField(UserID, Field)
{
	var Hdr = new KRequestHeaders();
	Hdr.Add(new KRequestParam("UserID", UserID));
	Hdr.Add(new KRequestParam("Field", Field));
	
	var url = '/Framework/CoreSystem/HTMLResources/KGetUserProfileField.cfm';
	return KSynchronousRequest(url, Hdr);
}

function KGetSetting(UserID, SettingKey) 
{
	var Hdr = new KRequestHeaders();
	Hdr.Add(new KRequestParam("UserID", UserID));
	Hdr.Add(new KRequestParam("SettingKey", SettingKey));
	
	var url = '/Framework/CoreSystem/HTMLResources/KGetSetting.cfm';
	
	var ret = KSynchronousRequest(url, Hdr);
	if (ret == 'WW_NOT_CONFIGURED ') {
		return null;
	}
	else {
		return ret;
	}
}

function KSaveSetting(UserID, SettingKey, SettingValue)
{
	var Hdr = new KRequestHeaders();
	Hdr.Add(new KRequestParam("UserID", UserID));
	Hdr.Add(new KRequestParam("SettingKey", SettingKey));
	Hdr.Add(new KRequestParam("SettingValue", SettingValue));
	
	var url = '/Framework/CoreSystem/HTMLResources/KSaveSetting.cfm';
	
	return KSynchronousRequest(url, Hdr);
}

function KGetWindowSetting(UserID, WindowHandle, SettingKey)
{
	var Hdr = new KRequestHeaders();
	Hdr.Add(new KRequestParam("UserID", UserID));
	Hdr.Add(new KRequestParam("SettingKey", SettingKey));
	Hdr.Add(new KRequestParam("WindowHandle", WindowHandle));
	
	var url = '/Framework/CoreSystem/HTMLResources/KGetWindowSetting.cfm';
	
	return KSynchronousRequest(url, Hdr);
}

function KSaveWindowSetting(UserID, WindowHandle, SettingKey, SettingValue)
{
	var Hdr = new KRequestHeaders();
	Hdr.Add(new KRequestParam("UserID", UserID));
	Hdr.Add(new KRequestParam("SettingKey", SettingKey));
	Hdr.Add(new KRequestParam("WindowHandle", WindowHandle));
	Hdr.Add(new KRequestParam("SettingValue", SettingValue));
	
	var url = '/Framework/CoreSystem/HTMLResources/KSaveWindowSetting.cfm';
	
	return KSynchronousRequest(url, Hdr);
}


function KGetDefaultView(ObjectTypeID) 
{
	var bu = "/Framework/ServerInterface/SIGetDefaultView.cfm";
	var rh = new KRequestHeaders();
	rh.Add(new KRequestParam("ObjectTypeID", ObjectTypeID));
	
	
	
	var retval = KSynchronousRequestXML(bu, rh);
	
	return retval;
}

function KHarvestCompleteRequests()
{
	for (i in AsyncRequests) {
		if (AsyncRequests[i].Status == LS_COMPLETE) {
			AsyncRequests.slice(i, 1);
		}
	}
}

function KRequestParam(VarName, VarValue)
{
	this.VarName = VarName;
	this.VarValue = VarValue;
}

function KRequestHeaders()
{
	this.Headers = new Array(1);
	
}

KRequestHeaders.prototype.Add = function(RequestParam) {
	this.Headers.push(RequestParam);
};

KRequestHeaders.prototype.QueryString = function(BaseString) {
	if (BaseString.indexOf('?') == -1) {
		var leadChar = '?';
	}
	else {
		var leadChar = '&';
	}
	
	var qString = '';
	
	for (i in this.Headers) {
		qString += leadChar + this.Headers[i].VarName + '=' + escape(this.Headers[i].VarValue);
		leadChar = '&';
	}
	
	return qString;
};





function KParseXML (XMLString)
{	
	try {
		xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
		xmlDoc.async="false";
		xmlDoc.loadXML(XMLString);
	}
	catch(e)
	{
		try {
			parser=new DOMParser();
			xmlDoc=parser.parseFromString(XMLString,"text/xml");
		}
		catch(e) {alert(e.message)}
	}
	
	return xmlDoc;
}

function KGetSingleTag (XMLDoc, TagName) 
{
	try {
		return XMLDoc.getElementsByTagName(TagName)[0].childNodes[0].nodeValue;
	}
	catch (ex) {
		return null;
	}
}

function KDestroyBitBucket() 
{
	AjaxGetElementReference('dev-null').innerHTML = '';
}
			
	
function KDynamicLoadSitePicture(DivID, SourceOIID, width, height)
{
	var url;
	url = '/framework/CoreSystem/HTMLResources/DynamicSitePicture.cfm?SourceOIID=' + escape(SourceOIID);
	url += '&width=' + escape(width);
	url += '&height=' + escape(height);
	
	AjaxLoadPageToDiv(DivID, url);
}

String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g,"");
}
String.prototype.ltrim = function() {
	return this.replace(/^\s+/,"");
}
String.prototype.rtrim = function() {
	return this.replace(/\s+$/,"");
}
