<cfcomponent name="ValidateAdvisor" extends="coldspring.aop.MethodInterceptor">

	<!--- setters for dependencies --->
	<cffunction name="init" returntype="void" access="public" output="false" >
		
	</cffunction>
    
	<cffunction name="invokeMethod" access="public" returntype="any" output="false">
		<cfargument name="methodInvocation" type="coldspring.aop.MethodInvocation" required="false" />
		<cfscript>
			var local={};
			local.args = arguments.methodInvocation.getArguments();
			local.data = deserializeJson(toString(getHTTPRequestData().content));

			local.args.username = local.data.username;
			local.args.password = local.data.password;
			
			local.rtn = arguments.methodInvocation.proceed();
			if(isdefined("local.rtn")){
					return local.rtn;
			}
		</cfscript>
	</cffunction>

</cfcomponent>