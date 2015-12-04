<cfquery name="AddProduct" datasource="webwarecl">
	INSERT INTO product_catalog
		(ProductName,
		ProductDescription,
		ItemNumber,
		UnitPrice,
		QuantityOnHand,
		ProductWeight,
		site_id)
	VALUES
		('#URL.ProductName#',
		'#URL.ProductDescription#',
		'#URL.ItemNumber#',
		#URL.UnitPrice#,
		#URL.QuantityOnHand#,
		#URL.ProductWeight#,
		#URL.site_id#)
</cfquery>		
<strong>Product added to catalog.</strong>