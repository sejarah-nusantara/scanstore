<cfcomponent name="ValidateAdvisor" extends="coldspring.aop.MethodInterceptor">

	<!--- setters for dependencies --->
	<cffunction name="init" returntype="any" access="public" output="false" >
		<cfreturn this>
	</cffunction>
    
	<cffunction name="invokeMethod" access="public" returntype="any" output="false">
		<cfargument name="methodInvocation" type="coldspring.aop.MethodInvocation" required="false" />
		<cfscript>
			var local={};
			local.args = arguments.methodInvocation.getArguments();
			local.json = toString(getHTTPRequestData().content);

			local.args.image = getScanImageFactory().createFromStruct(deserializeJson(local.json));
			local.rtn = arguments.methodInvocation.proceed();
			if(isdefined("local.rtn")){
					return local.rtn;
			}
		</cfscript>
	</cffunction>
	<cffunction name="getScanImageFactory" returnType="any" access="public" output="false" hint="">
		
		<cfreturn variables.instance.scanImageFactory/>
	</cffunction>
	
	<cffunction name="setScanImageFactory" returnType="void" access="public" output="false" hint="">
		<cfargument name="scanImageFactory" type="any" required="true" hint="" />
		<cfset variables.instance.scanImageFactory=arguments.scanImageFactory/>
	</cffunction>

</cfcomponent>