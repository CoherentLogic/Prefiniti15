<cfinclude template="/pm/pm_udf.cfm">


<tr>
<td>
	<input type="checkbox" id="PM_SearchKeyword_#attributes.keyword_name#">
</td>    
<td>
<cfif attributes.allow_condition EQ true>
	<select id="PM_SearchCondition_#attributes.keyword_name#">
    	<option value="AND" selected="selected">And</option>
        <option value="OR">Or</option>
    </select>
<cfelse>
	<select id="PM_SearchCondition_#attributes.keyword_name#" disabled="disabled">
    	<option value="AND" selected="selected">Where</option>
    </select>

</cfif>
</td>
<td>    
<cfoutput>#attributes.keyword_name#</cfoutput>
</td>
<td>
<select id="PM_SearchType_#attributes.keyword_name#">
	<option value="Equals" selected="selected">is equal to</option>
    <option value="Contains">contains</option>
</select>
</td>
<td>
<input type="text" id="PM_SearchText_#attributes.keyword_name#" />
</td>
</tr>

 

