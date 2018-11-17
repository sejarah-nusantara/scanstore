<cfcomponent name="SecurityAroundAdvice" extends="coldspring.aop.MethodInterceptor">

	<!--- setters for dependencies --->
	<cffunction name="init" returntype="void" access="public" output="false" hint="Dependency: security service">
		<cfargument name="securityService" type="nl.deviant.studiemeter.interfaces.ISecurityService">
		<cfargument name="debugger" type="nl.deviant.studiemeter.utils.Debugger">
		<cfargument name="logger" type="any">
		<cfset variables.securityService=arguments.SecurityService>
		<cfset variables.debugger=arguments.debugger>
		<cfset variables.logger=arguments.logger>
	</cffunction>
    
	<cffunction name="invokeMethod" access="public" returntype="any" output="false">
		<cfargument name="methodInvocation" type="coldspring.aop.MethodInvocation" required="false" />
		<cfscript>
			//var local={};
			local.args = arguments.methodInvocation.getArguments();
			local.methodname=arguments.methodInvocation.getMethod().getMethodName();
			local.objName = getMetadata(arguments.methodInvocation.getTarget()).name;
			local.allowOk=false;
			local.struct={};
			local.userDetails=securityService.checkTicket(local.args.ticket);
			local.argsDup = duplicate(local.args);
			local.allowOk=securityService.checkPermissionByMethod(local.userDetails,local.methodname, local.argsDup);
			local.args.userDetails=local.userDetails;
			if(local.allowOk){
				local.rtn = arguments.methodInvocation.proceed();
				
				if(isdefined("local.rtn")){
					return local.rtn;
				}
			}else{
				local.perpDetails = "Perp info: #chr(13)#"&
			 		"ip: #cgi.REMOTE_ADDR# #chr(13)#" &
			 		"name: #cgi.REMOTE_HOST##chr(13)#"&
			 		"user agent: #cgi.HTTP_USER_AGENT# #chr(13)#";
			 	logger.warn("Remote acces was attempted from "& #cgi.REMOTE_ADDR# & " and denied." & local.perpDetails);
			 	throw(message="#application.ERROR_MESSAGE_INVALID_TICKET#", errorCode="#application.ERROR_NUMBER_INVALID_TICKET#");
			}
		</cfscript>
	</cffunction>
</cfcomponent>