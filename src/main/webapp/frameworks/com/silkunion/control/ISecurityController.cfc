<cfinterface displayName="ISecurityController">
	<cffunction name="checkPermissionByMethod" access="public" output="false" returntype="boolean">
	 	<cfargument name="userdetails" type="Struct" required="true" />
		<cfargument name="methodName" type="String" required="true" />
		<cfargument name="args" type="Struct" required="true" />
	 	
	</cffunction>
	
</cfinterface>