<cfinclude template="/pm/pm_udf.cfm">

<cfquery name="gp" datasource="webwarecl">
	SELECT * FROM projects WHERE id=#attributes.project_id#
</cfquery>

<cfparam name="assoc_id" default="">

<cfquery name="getAssocID" datasource="sites">
	SELECT * FROM site_associations
    WHERE	user_id=#gp.clientID#
    AND		assoc_type=0
    AND 	site_id=#gp.site_id#
</cfquery>

<cfif getAssocID.RecordCount EQ 0>
	<cfset assoc_id=16>
<cfelse>
	<cfset assoc_id=#getAssocID.id#>
</cfif>    

<blockquote>
<cfoutput query="gp">
	<strong>PROJECT NUMBER:</strong> #clsJobNumber#<br />    
    <strong>PROJECT NAME:</strong> #description#<br />
    <strong>RECIPIENT:</strong> #clientID#<br />
    <strong>CREATOR:</strong> #clientID#<br />
    <strong>DUE DATE:</strong> #duedate#<br />
    <strong>SITE ID:</strong> #site_id#<br />
    <strong>PROJECT TYPE:</strong> 1<br>
    <strong>CLIENT ID -&gt; ASSOCIATION ID MAPPING:</strong> #gp.clientID# -&gt; #getAssocID.id#<br>
</cfoutput> 

<cfparam name="p_uuid" default="">
<cfset p_uuid = CreateUUID()>

 

<cfquery name="doImport" datasource="webwarecl">
	INSERT INTO pm_master_projects
    	(project_number,
        project_name,
        project_recipient,
        project_creator,
        due_date,
        site_id,
        project_type,
        om_uuid)
	VALUES
    	('#gp.clsJobNumber#',
        '#gp.description#',
        #assoc_id#,
        #assoc_id#,
        #CreateODBCDate(DateFormat(gp.duedate, "mm/dd/yyyy"))#,
      	1,
        1,
        '#p_uuid#')
</cfquery>

<cfquery name="getProjectID" datasource="webwarecl">
	SELECT id FROM pm_master_projects WHERE om_uuid='#p_uuid#'
</cfquery>


<cfoutput> 
	<strong>INSTALLING SEARCHABLE KEYWORDS...<br /></strong>
</cfoutput>        

<cfparam name="slb" default="">
<cfparam name="str" default="">
<cfparam name="addr" default="">
<cfparam name="cjn" default="">

<cfscript>
	// write subdiv, lot, block
	slb = gp.subdivision & "," & gp.lot & "," & gp.block;
	WriteOutput(pmWriteProjectKeyword(getProjectID.id,  1, slb));
	
	//write sec, twn, rng
	str = gp.section & "," & gp.township & "," & gp.range;
	WriteOutput(pmWriteProjectKeyword(getProjectID.id,  2, str));
	
	//write address
	addr = gp.address;
	WriteOutput(pmWriteProjectKeyword(getProjectID.id,  3, addr));
	
	//write clsJobNumber
	cjn = gp.clsJobNumber;
	WriteOutput(pmWriteProjectKeyword(getProjectID.id,  4, cjn));
</cfscript>
</blockquote>