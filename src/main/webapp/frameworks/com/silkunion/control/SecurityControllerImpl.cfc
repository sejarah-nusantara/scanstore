<cfcomponent output="false"  implements="com.silkunion.control.ISecurityController" extends="com.silkunion.Object" >
<cffunction name="init" access="public" output="false" returntype="com.silkunion.control.SecurityControllerImpl" >
		<cfargument name="debugger" type="any" required="true" />
		<cfargument name="methodPermissions" type="struct" required="true" />
		<cfargument name="methodProfiles" type="struct" required="true" />
		<cfscript>
			return super.init(argumentCollection=arguments);
		</cfscript>
	</cffunction>
	
	<cffunction name="checkPermissionByMethod" access="public" output="false" returntype="boolean">
		<cfargument name="userdetails" type="Struct" required="true" />
		<cfargument name="methodName" type="String" required="true" />
		<cfargument name="args" type="Struct" required="true" />
		<cfscript>
			
			//todo: implement method
			return true;
		</cfscript>
	</cffunction>
</cfcomponent>