<!--
	URL:
	
	CartID
-->

<!---<cfquery name="VendorsInCart" datasource="webwarecl">
	SELECT 		DISTINCT catalog_item.site_id,
				cart_item.item_id
	FROM		product_catalog catalog_item
	INNER JOIN	shopping_cart_items cart_item
	ON			cart_item.item_id = catalog_item.id
	WHERE		cart_item.cart_id = #Attributes.CartID#
</cfquery>--->

<cfquery name="CartSummary" datasource="webwarecl">
	SELECT 		cart_item.item_id,
				cart_item.quantity,
				catalog_item.ProductName,
				catalog_item.UnitPrice,
				catalog_item.site_id
	FROM		shopping_cart_items cart_item
	INNER JOIN	product_catalog catalog_item
	ON			cart_item.item_id = catalog_item.id
	WHERE		cart_item.cart_id = #Attributes.CartID#
	ORDER BY	site_id, ProductName
	ASC
</cfquery>

<cfquery name="VendorsInCart" dbtype="query">
	SELECT DISTINCT site_id FROM CartSummary
</cfquery>


<div class="PFrame">
<span class="PFrameHeader">Order Summary</span>
<cfoutput query="VendorsInCart">
	<cfmodule template="/framework/components/vendorCart.cfm" CartID="#Attributes.CartID#" VendorID="#site_id#">	
</cfoutput>


</div>