<cfinclude template="/pm/pm_udf.cfm">

<style>
	.WizardHeader {
		font-family:"Times New Roman", Times, serif;
		font-size:36px;
		letter-spacing:-1px;
		font-weight:lighter;
		margin-bottom:8px;
	}
	
	.WizardParagraph {
		margin-left:20px;
		font-family:Verdana, Geneva, sans-serif;
		font-size:12px;
	}
</style>

<div style="width:500px; height:260px; border-top:1px solid black;">
    <div style="padding-left:20px;">
        <div id="PM_Create_0" style="display:block;">
        	<h1 class="WizardHeader">Welcome.</h1>
            <cfoutput>
            <p class="WizardParagraph">You have chosen to create a new <strong>#pmGetProjectTypeName(URL.ProjectType)#</strong> project. This wizard will guide you through the steps necessary to get your project going. Watch this area for instructions as you complete each step.</p>
            </cfoutput>
            
            <p class="WizardParagraph">Let's begin by choosing a <strong>Project Name</strong> for this project in the text box below. When you have done this, click the <strong>Next</strong> button with your mouse.</p><br />
        
        	<label><strong>Project Name:</strong> <input type="text" name="PM_ProjectName" id="PM_ProjectName" /></label>
        	<br />
        	
        </div>
        
        <div id="PM_Create_1" style="display:none;"> 
        
        </div>
        
        <div id="PM_Create_2" style="display:none;">
        
        </div>
        
        <div id="PM_Create_3" style="display:none;">
        
        </div>
    </div>
</div>

<cfmodule template="/controls/Wizardizer.cfm" base_name="PM_Create" step_count="4" width="500px">