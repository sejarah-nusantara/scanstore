<cfcomponent name="ValidateAdvisor" extends="coldspring.aop.MethodInterceptor" hint="for some reason a ext js remote puts all data in the getHTTPRequestData().content this advisor recontructs the arguments from the content and builds a importdirectory via the import directory factory to inject the requirend dependencies">

	<!--- setters for dependencies --->
	<cffunction name="init">
		<cfargument name="importDirectoryGateway" type="any">
		<cfargument name="importDirectoryFactory" type="any">
		<cfargument name="userSessionController" type="any">
		<cfargument name="fileSystemController" type="com.silkunion.control.IFilesystemController">
		<cfargument name="mode" type="string" hint="gateway or factory" default="gateway" required="false">
		<cfscript>
			variables.importDirectoryGateway = arguments.importDirectoryGateway;
			variables.importDirectoryFactory = arguments.importDirectoryFactory;
			variables.userSessionController = arguments.userSessionController;
			variables.fileSystemController = arguments.fileSystemController;
			variables.mode = arguments.mode;
			return this;
		</cfscript>
	</cffunction>
    
	<cffunction name="invokeMethod" access="public" returntype="any" output="false">
		<cfargument name="methodInvocation" type="coldspring.aop.MethodInvocation" required="false" />
		<cfscript>
			var local={};
			local.args = arguments.methodInvocation.getArguments();
			if(variables.mode EQ "gateway"){
				local.args.importDirectory = variables.importDirectoryGateway.getImportByName(local.args.importDirectory);
			} else if(variables.mode EQ "factory"){
				local.data = deserializeJson(toString(getHTTPRequestData().content));
				local.user = variables.userSessionController.getCurrentuser();
				local.data.directoryPath = application.settings.UPLOAD_LOCATION & local.user.getInstitutionID() & "/";
				variables.fileSystemController.createDirectory(local.data.directoryPath);
				local.args.IMPORTDIRECTORY = variables.importDirectoryFactory.create("importDirectory",local.data);
			}
			
			local.rtn = arguments.methodInvocation.proceed();
			if(isdefined("local.rtn")){
					return local.rtn;
			}
		</cfscript>
	</cffunction>

</cfcomponent>