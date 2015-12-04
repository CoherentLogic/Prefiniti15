<cfhttp url="http://vista.coherent-logic.com/cgi-bin/fileman.cgi?dd=200&ien=65" result="test">

<cfset thevar=DeserializeJSON(test.filecontent)>
<cfoutput>
#StructFind(thevar, "NAME")#
</cfoutput>
<cfdump var="#thevar#">