<cfinterface>
	<cffunction name="getIdentifierParts" access="public" output="false">
		
	</cffunction>
	
	<cffunction name="setIdentifierParts" access="public" output="false" returntype="void">
		<cfargument name="val" type="any">
		
	</cffunction>
	
	<cffunction name="getPropertyName" access="public" output="false">
		
	</cffunction>
	
	
	<cffunction name="setPropertyName" access="public" output="false">
		<cfargument name="val" type="any" required="true">
		
	</cffunction>
	
	<cffunction name="setClassName" access="public" output="false" returntype="void">
		<cfargument name="val" type="string" required="true">
		
	</cffunction>
	
	<cffunction name="getClassName" access="public" output="false" returntype="any">
		
	</cffunction>
	
	<cffunction name="getKeys" access="public" output="false" returntype="any">
	
	</cffunction>
	
	<cffunction name="getValues" access="public" output="false" returntype="any">
		
	</cffunction>
	
	<cffunction access="public" name="addIdentifierPart" output="false" returntype="void" 
				hint="adds the property/value to the identifier, this method can only be called once for each property. If the identifier changes, the object is completely different the identity can only be constructed not changed.">
		<cfargument name="propertyName" type="string" required="true" hint="The name of the property of the identity, example: id">
		<cfargument name="value" type="any" required="true" hint="The value representation of the property, example: 1234">
		
	</cffunction>
	
	<cffunction access="public"  name="getHashCode" output="false" returntype="any">
		
	</cffunction>
	
	<cffunction name="isEqual" displayname="equals" access="public" output="false" returntype="boolean">
		<cfargument name="other" type="any" required="true">
		
	</cffunction>

	<cffunction name="toText" displayname="toString" access="public" output="false" returntype="string">
		
	</cffunction>


</cfinterface>