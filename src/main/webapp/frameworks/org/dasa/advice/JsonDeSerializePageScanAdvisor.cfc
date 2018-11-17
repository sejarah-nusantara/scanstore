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
			local.set = deserializeJson(local.json);
			if(isArray(local.set)){
				local.args.pageScans = [];
				for(local.i=1;local.i lte arrayLen(local.set);local.i++){
					arrayAppend(local.args.pageScans,getPageScanFactory().createPageScanFromStruct(local.set[local.i]));
				}
			} else {
				local.args.pageScan = getPageScanFactory().createPageScanFromStruct(local.set);
			}
			local.rtn = arguments.methodInvocation.proceed();
			if(isdefined("local.rtn")){
				return local.rtn;
			}
		</cfscript>
	</cffunction>

	<cffunction name="getPageScanFactory" returnType="org.dasa.model.IPageScanFactory" access="public" output="false" hint="">
		<cfreturn variables.instance.pageScanFactory/>
	</cffunction>

	<cffunction name="setPageScanFactory" returnType="void" access="public" output="false" hint="">
		<cfargument name="pageScanFactory" type="org.dasa.model.IPageScanFactory" required="true" hint="" />
		<cfset variables.instance.pageScanFactory=arguments.pageScanfactory/>
	</cffunction>

</cfcomponent>