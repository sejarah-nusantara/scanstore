<cfcomponent name="ValidateAdvisor" extends="coldspring.aop.MethodInterceptor">

	<!--- setters for dependencies --->
	<cffunction name="init" returntype="any" access="public" output="false" >
		<cfargument name="userFactory" type="any">
		<cfscript>
			variables.userFactory = arguments.userFactory;
			return this;
		</cfscript>
	</cffunction>
    
	<cffunction name="invokeMethod" access="public" returntype="any" output="false">
		<cfargument name="methodInvocation" type="coldspring.aop.MethodInvocation" required="false" />
		<cfscript>
			var local={};
			local.args = arguments.methodInvocation.getArguments();
			local.json = toString(getHTTPRequestData().content);
			local.args.user = variables.userFactory.createFromStruct(deserializeJson(local.json));
			local.rtn = arguments.methodInvocation.proceed();
			if(isdefined("local.rtn")){
					return local.rtn;
			}
		</cfscript>
	</cffunction>

</cfcomponent>