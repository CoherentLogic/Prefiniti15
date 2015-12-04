<cfinclude template="/authentication/authentication_udf.cfm">

<!---
<cfoutput>
	#wwWriteConfig(URL.user_id, "PDM:WALLPAPER", URL.p_url)#
</cfoutput>
--->



<cfparam name="PicturePath" default="">
<cfparam name="TempImageName" default="">
<cfparam name="TempImageURL" default="">

<cfset PicturePath=wwReadConfig(URL.calledByUser, "PDM:WALLPAPER")>
<cfset TempImageName="#PicturePath#wp.jpg">

<cfif PicturePath NEQ "" AND PicturePath NEQ "WW_NOT_CONFIGURED">
	<cfimage source="#PicturePath#" name="dtWP">
	<cfset ImageSetAntialiasing(dtWP,"on")>
	<cfset ImageScaleToFit(dtWP,#URL.Width#,#URL.Height#, "NEAREST")>

	<cfset TempImageURL="url(#TempImageName#)">
    
	<cfimage source="#dtWP#" action="write" destination="#TempImageName#" overwrite="true">
    
    <cfoutput>
		<div id="pageScriptContent" style="display:none;">
        	var wRef;
            wRef = AjaxGetElementReference("PDesktopWindow");
            
            wRef.style.backgroundImage = '#Replace(TempImageURL, "D:/Inetpub/Prefiniti15/UserContent", "http://www.prefiniti.com/UserContent")#';
            wRef.style.zIndex = ROOT_ZINDEX;
            
            
        </div>
    </cfoutput>
</cfif>	