<cfinterface>
	<cffunction name="validateData" hint="validate simple form struct" returntype="com.silkunion.model.validation.IValidationMessage[]" >
		<cfargument name="data" type="struct" required="true"/>
		<cfargument name="objectType" required="true" />
		<cfargument name="context" required="false" type="string"  default="*"/>
	
	</cffunction>
	<cffunction name="validateAll" access="public" output="false">
		<cfargument name="object" required="true" type="com.silkunion.model.validation.IValidatable" />
		<cfargument name="context" required="false" type="string"  default="*"/>
		<cfargument name="recursive" required="false" type="boolean"  default="true"/>
		<cfargument name="instanceMap" required="false" type="struct"  />
	</cffunction>
	<cffunction name="validateProperty" access="public" output="false">
		<cfargument name="object" required="true" type="com.silkunion.model.validation.IValidatable" />
		<cfargument name="property" required="true" type="string" />
		<cfargument name="context" required="false" type="string"  default="*"/>
	</cffunction>
</cfinterface>