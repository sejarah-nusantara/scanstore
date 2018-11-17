<cfcomponent extends="com.silkunion.Object">
	
	<cffunction name="getValidationController" access="public" output="false"  returntype="com.silkunion.control.IValidationController">
	
		<cfreturn variables.validationController/>
	</cffunction> 
	<cffunction name="setValidationController" access="public" output="false" >
		<cfargument name="validationController" type="com.silkunion.control.IValidationController"  />
		
		<cfset variables.validationController = arguments.validationController/>
	</cffunction> 
	
</cfcomponent>