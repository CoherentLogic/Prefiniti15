<cfquery name="UQ" datasource="webwarecl">
	UPDATE shopping_cart_items SET quantity=#url.quantity# WHERE id=#URL.item_id#
</cfquery>
<strong style="color:red">Item updated</strong>