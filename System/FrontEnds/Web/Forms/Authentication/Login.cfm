
<html>
<head>
	<title>Prefiniti - The Next Generation</title>
	<link rel="stylesheet" href="/System/Prefiniti.css">
</head>
    
<body>

<cfif IsDefined("form.Submit")>
	
   <!--- result
    
   <!--- <cftry>
    <cfparam name="tmpUser" default="">
    <cfset tmpUser = createObject("component","System.User").Open(form.username)>
    
    <cfif tmpUser.Authenticate(form.password)>
    	Authentication successful.
	<cfelse>
    	Authentication failed.
	</cfif>                
    
    <cfcatch>
    	<cfoutput>
        #cfcatch.Message#<br>
        #cfcatch.Detail#</cfoutput>
	</cfcatch>
    </cftry>   --->     
    here
    --->
    <cfscript>
		
		try {
		 	tmpUser = createObject("component", "System.User");
			tmpUser.Open(form.username);
			
			if(tmpUser.Authenticate(form.password)) {
				
				tmpUser.OpenSession(CGI.REMOTE_ADDR, CGI.REMOTE_HOST, CGI.HTTP_USER_AGENT);
				
				session.User = tmpUser;
			
			}
			else {
				WriteOutput("Authentication failed.");
			}
		}
		catch (Any e) {
			WriteOutput("Error in authentication routine: " & e.message);
		}
			
		
		
	</cfscript>
    
    <cflocation url="/System/default.cfm?AppID=4A612BEA-19B9-CB32-B72D38D2B5BEF3D3&View=Home" addtoken="no">
<cfelse>

<div style="width:550px; height:500px; background-color:#666; margin-left:auto; margin-right:auto; margin-top:80px" align="center" >
   
	<img src="/System/Resources/Graphics/prefiniti-logo-white.png" style="margin-top:80px;">
    <p style="color:white; margin-bottom:60px;">Version 1.6</p>
<cflayout type="tab" tabheight="175" style="width:450px; margin-left:auto; margin-right:auto; background-color:##CCC;" align="center" tabposition="bottom">
  <cflayoutarea title="Existing Account" style="padding:20px; background-color:white;">
    <cfform name="Login" format="xml" skin="basiccss" width="400" preservedata="Yes" action="/System/FrontEnds/#session.UserInterface#/Forms/Authentication/Login.cfm" method="post">
        <cfformgroup type="fieldset" label="Please enter your username and password">
            <cfformgroup type="vertical">
                <cfinput type="text" size="20" name="username" label="Username" required="yes">
                <cfinput type="password" name="password" label="Password" required="yes">        
                <cfinput type="submit" name="submit" label="Submit" value="Submit" align="right" style="float:right;">
            </cfformgroup>
         </cfformgroup>
    </cfform>  
  </cflayoutarea>
  <cflayoutarea title="New Account">tab 2 content</cflayoutarea>
   
 </cflayout>
 <br>
 <p style="color:white; font-size:8px;">Copyright &copy; 2010 AJL Intel-Properties, LLC</p>
 
 </div>


</cfif>
</body>
</html>