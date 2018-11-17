<cfcomponent name="SecurityAroundAdvice" extends="coldspring.aop.MethodInterceptor">

	<!--- setters for dependencies --->
	<cffunction name="init" returntype="any" access="public" output="false" hint="Dependency: security service">
		<cfargument name="userSessionController" type="any">
		<cfset variables.userSessionController  = arguments.userSessionController/>
		<cfreturn this/>
	</cffunction>

	<cffunction name="invokeMethod" access="public" returntype="any" output="false">
		<cfargument name="methodInvocation" type="coldspring.aop.MethodInvocation" required="false" />
		<cfscript>
			var local={};
			local.methodname=arguments.methodInvocation.getMethod().getMethodName();
			if(!variables.userSessionController.userIsLoggedIn()){
				throw(message="User is not logged in",type='org.dasa.security.UserAcessViolationError');
			}
			local.allowOk=variables.userSessionController.getCurrentUser().userIsAuthorized(local.methodname);
			if(local.allowOk){
				local.rtn = arguments.methodInvocation.proceed();
				if(isdefined("local.rtn")){
					return local.rtn;
				}
			}
		</cfscript>
	</cffunction>
</cfcomponent>