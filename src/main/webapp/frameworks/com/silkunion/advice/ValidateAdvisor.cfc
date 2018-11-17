<cfcomponent name="ValidateAdvisor" extends="coldspring.aop.MethodInterceptor">

	<!--- setters for dependencies --->
	<cffunction name="init" returntype="void" access="public" output="false" >
		
	</cffunction>
    
	<cffunction name="invokeMethod" access="public" returntype="any" output="false">
		<cfargument name="methodInvocation" type="coldspring.aop.MethodInvocation" required="false" />
		<cfscript>
			//var local={};
			local.args = arguments.methodInvocation.getArguments();
			local.methodname=arguments.methodInvocation.getMethod().getMethodName();
			local.objName = getMetadata(arguments.methodInvocation.getTarget()).name;
			
			for(local.item IN local.args){
				 if(isObject(local.args[local.item])){
				 	//warning all objects must implement the Ivalidatable interface
				 	local.errors=local.args[local.item].validate();
				 }
			
			}
		
			if(not Arraylen(local.errors)){
				local.rtn = arguments.methodInvocation.proceed();
				
				if(isdefined("local.rtn")){
					return local.rtn;
				}
			}else{
				
			 	throw(message="#errorToString(local.errors)#", errorCode="0");
			}
		</cfscript>
	</cffunction>

	<cffunction name="errorToString" access="private" returntype="string" output="false">
		<cfargument name="errors" type="array">
		<cfscript>
			//var local={};
			local.sb = createObject("java","java.lang.StringBuffer");
			for(local.i=0;local.i LTE arrayLen(errors);local.i++){
				for(local.item IN errors[local.i]){
					local.errorString="#local.item#: #errors[local.i][local.item]#";
					local.sb.append(javaCast('string',local.errorString));
				}
			
			}
			
			return local.sb.toString();
		</cfscript>
	
	</cffunction>
</cfcomponent>