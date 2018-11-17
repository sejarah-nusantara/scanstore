<cfinterface displayName="IValidatable">
	<cffunction name="validate" access="public" output="false" returntype="void" hint="VO object validates itself">
	 	<cfargument name="recursive" required="false" type="boolean"  default="true"/>
	</cffunction>
	<cffunction name="isObjectValid" access="public" output="false" returntype="boolean" >
	 	
	</cffunction>
	<cffunction name="getValidationMessages" access="public" output="false" returntype="com.silkunion.model.validation.IValidationMessage[]" >
	 	
	</cffunction>
	<cffunction name="setIsObjectValid" access="public" output="false" returntype="void" >
	 	<cfargument name="isObjectValid"  type="boolean"  />
	</cffunction>
	
</cfinterface>