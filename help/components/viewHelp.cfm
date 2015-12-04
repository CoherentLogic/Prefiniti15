<link href="../../css/gecko.css" rel="stylesheet" type="text/css">

<cfoutput>
<table width="100%" border="0" cellspacing="0">
	
	
	<cfif #url.image# NEQ "">
		<tr>
			<td colspan="2" align="center">
				<img src="/help/help_images/#url.image#">
			</td>
		</tr>
	</cfif>
	<tr>
		<td colspan="2" align="left" style="border:1px solid silver;">
			<!--- <cfif #url.image# NEQ ""><a href="javascript:showDiv('moreHelp');">More Help</a></cfif> --->
			<div id="moreHelp">
				<cfinclude template="/help/help_text/#url.text#">
			</div>
		</td>
	</tr>
	
</table>
</cfoutput>
