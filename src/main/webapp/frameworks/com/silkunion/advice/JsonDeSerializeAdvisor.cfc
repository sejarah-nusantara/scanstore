<cfcomponent name="ValidateAdvisor" extends="coldspring.aop.MethodInterceptor">

	<!--- setters for dependencies --->
	<cffunction name="init" returntype="void" access="public" output="false" >
		
	</cffunction>
    
	<cffunction name="invokeMethod" access="public" returntype="any" output="false">
		<cfargument name="methodInvocation" type="coldspring.aop.MethodInvocation" required="false" />
		<cfscript>
			var local={};
			local.args = arguments.methodInvocation.getArguments();
			
			for(local.item IN local.args){
				local.args[local.item]=deserializeJson(local.args[local.item]);
			}
			local.rtn = arguments.methodInvocation.proceed();
			
			
		</cfscript>
	</cffunction>

	
</cfcomponent>