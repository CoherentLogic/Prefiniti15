<cfquery name="GCI" datasource="webwarecl">
	SELECT * FROM product_catalog WHERE site_id=#url.current_site_id#
</cfquery>

<table width="100%">
<cfoutput query="GCI">
	<tr>
	<td align="left">#ProductName#</td>
	<td align="right"><cfmodule template="/framework/components/AssocCheck.cfm" 
								SourceOTID="5" 
								SourceOIID="#attributes.SiteFileID#"
								DestOTID="17"
								DestOIID="#id#"></td>
	</tr>								
</cfoutput>	
</table>