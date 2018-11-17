<cfcomponent output="false" implements="com.silkunion.IObserver">

	<cffunction name="init">
		<cfargument name="userSessionController">
		<cfargument name="userService">
		<cfargument name="fileSystemController" type="com.silkunion.control.IFilesystemController">
		<cfscript>
			variables.userSessionController = arguments.userSessionController;
			variables.userService = arguments.userService;
			variables.fileSystemController = arguments.fileSystemController;
		</cfscript>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="void">
		<cfargument name="object" type="any">
		<cfargument name="data" type="any" required="false">
		<cfscript >
			var local = {};
			local.email_addresses = "";
			try {
				local.user = variables.userSessionController.getCurrentUser();
				local.sys_admins = userService.getSystemAdministratorsByInstitution(local.user.getInstitutionID());
			} catch(any e){
				local.sys_admins = [];
			}
			local.cgi = cgi;
			local.form = form;
			if(structKeyExists(arguments,"data")){
				local.data = arguments.data;
			}
			for(local.i=0 ; local.i < sys_admins.size() ; local.i++){
				if(len(sys_admins.get(local.i).getEmail())){
					local.email_addresses = listAppend(local.email_addresses,sys_admins.get(local.i).getEmail(),";");
				}
			}
			if(arguments.object.type EQ "repositoryException"){
				local.subject = "There is a problem while trying to connect to the repository: #application.settings.REPOSITORY_URL#";
			} else {
				local.subject = "A system error occurred in the scanstore";
			}
		</cfscript>
		<cfset local.no_email_server = false />
		<cfif len(local.email_addresses)>
			<cftry>
				<cfmail to="#local.email_addresses#"  from="error@scanstore.corstfoundation.org" subject="#local.subject#" type="html">
					<cfdump var="#local#">
					<cfdump var="#arguments.object#">
				</cfmail>
			<cfcatch type="any">
				<cfset local.no_email_server = true />
			</cfcatch>
			</cftry>
		</cfif>
	 	<cfif application.settings.DEBUG OR local.no_email_server>
			<cftry>
				<cfsavecontent  variable="local.errormessage">
					<cfdump var="#local#">
					<cfdump var="#arguments.object#">
				</cfsavecontent>
				<cfset local.uploadLogPath = application.settings.UPLOAD_LOCATION&"LOG/" />
				<cfset variables.fileSystemController.createDirectory(local.uploadLogPath) />
				<cffile action="write" file="#local.uploadLogPath#error_#dateFormat(now(),'YYYYMMDD')##timeFormat(now(),'HHMMSS')#.html" output="#local.errormessage#">
				<cfcatch type="any">
				</cfcatch>
			</cftry>
			<cfif application.settings.DEBUG>
				<cfthrow object="#arguments.object#">
			</cfif>
		</cfif>
	</cffunction>

</cfcomponent>