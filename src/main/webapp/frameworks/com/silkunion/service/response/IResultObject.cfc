<cfinterface>
	<cffunction access="public" name="getIsValid" output="false" returntype="boolean">
		
	</cffunction>
	<cffunction access="public" name="setIsValid" output="false" returntype="void">
		<cfargument name="val" type="boolean" required="true">
		
	</cffunction>
	<cffunction access="public" name="getResult" output="false" returntype="any">
	
	</cffunction>

	<cffunction access="public" name="setResult" output="false" returntype="void">
		<cfargument name="val" type="any" required="true">
		
	</cffunction>

	<cffunction access="public" name="getInstructions" output="false" returntype="com.silkunion.validation.IValidationMessage[]" >
		
	</cffunction>

	<cffunction access="public" name="setInstructions" output="false" returntype="void">
		<cfargument name="val" type="com.silkunion.validation.IValidationMessage[]" required="true">
		
	</cffunction>
</cfinterface>