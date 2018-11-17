<cfcomponent name="TransactionAdvisor" extends="coldspring.aop.MethodInterceptor">

	<!--- setters for dependencies --->
	<cffunction name="init" returntype="void" access="public" output="false" hint="Transaction">
		<cfargument name="logger" type="any">
		<cfargument name="transaction" type="transfer.com.sql.transaction.Transaction" required="true" />
		<cfset variables.logger=arguments.logger>
		<cfset variables.transaction=arguments.transaction>
	</cffunction>
    
	<cffunction name="invokeMethod" access="public" returntype="any" output="false">
		<cfargument name="methodInvocation" type="coldspring.aop.MethodInvocation" required="false" />
		<cfscript>
			//var local={};
			local.args = arguments.methodInvocation.getArguments();
			local.methodname=arguments.methodInvocation.getMethod().getMethodName();
			local.objName = getMetadata(arguments.methodInvocation.getTarget()).name;
			local.struct={};
		</cfscript>
				
				<cfscript>
					
					//logger.warn(local.methodname & " ticket:  " & local.args.ticket);
					return variables.transaction.execute(arguments.methodInvocation.getTarget(),local.methodname,local.args);
				</cfscript>
			
	</cffunction>
</cfcomponent>