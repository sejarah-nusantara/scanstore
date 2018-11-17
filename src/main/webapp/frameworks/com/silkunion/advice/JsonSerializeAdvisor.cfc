<cfcomponent name="ValidateAdvisor" extends="coldspring.aop.MethodInterceptor">

	<!--- setters for dependencies --->
	<cffunction name="init" returntype="any" access="public" output="false" >
		<cfargument name="objectConvertor" type="any"/>
		<cfscript>
			variables.objectConvertor =arguments.objectConvertor;
			return this;
		</cfscript>
	</cffunction>

	<cffunction name="invokeMethod" access="public" returntype="any" output="false">
		<cfargument name="methodInvocation" type="coldspring.aop.MethodInvocation" required="false" />
		<cfscript>
			var local={};
			local.rtn = arguments.methodInvocation.proceed();
			if(isdefined("local.rtn")){
				if(isArray(local.rtn)){
					//local.start= getTickCount();
					local.retArr = [];
					for (local.i=1; local.i <= arrayLen(local.rtn); local.i++) {
						local.retArr.add(getObjectConvertor().translateObjectTreeToStruct(local.rtn[local.i]));
					}
					//local.end= getTickCount();
					//logText("user:#getUserSessionController().getCurrentUser().getUsername()# location:#cgi.remote_addr# process:json conversion #arguments.methodInvocation.getMethod().getMethodName()# time:#local.end-local.start#","performance");
					return local.retArr;
				}
				//local.start= getTickCount();
				local.result = getObjectConvertor().translateObjectTreeToStruct(local.rtn);
				//local.end= getTickCount();
				//logText("user:#getUserSessionController().getCurrentUser().getUsername()# location:#cgi.remote_addr# process:json conversion #arguments.methodInvocation.getMethod().getMethodName()# time:#local.end-local.start#","performance");
				return local.result;
			}
		</cfscript>
	</cffunction>

	<cffunction name="getObjectConvertor" returntype="any" access="private" output="false" >
		<cfscript>
			return variables.objectConvertor;
		</cfscript>
	</cffunction>

	<cffunction name="getUserSessionController" returnType="any" access="public" output="false" hint="">
		<cfreturn variables.instance.userSessionController/>
	</cffunction>

	<cffunction name="setUserSessionController" returnType="void" access="public" output="false" hint="">
		<cfargument name="userSessionController" type="any" required="true" hint="" />
		<cfset variables.instance.userSessionController=arguments.userSessionController/>
	</cffunction>

	<cffunction name="logText" access="public" output="false"  returntype="void">
		<cfargument name="message" type="string"/>
		<cfargument name="logFile" type="string" required="false">
		<cfif isdefined("arguments.logFile")>
			<cflog text="#message#" file="#logFile#"/>
		<cfelse>
			<cflog text="#message#" />
		</cfif>
	</cffunction>

</cfcomponent>