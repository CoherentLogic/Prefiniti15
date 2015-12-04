<cfquery name="ackorder" datasource="webwarecl">
	UPDATE orders SET stage=1 WHERE id=#URL.OrderID#
</cfquery>
<br />
<br />
<br />
Order acknowledged.