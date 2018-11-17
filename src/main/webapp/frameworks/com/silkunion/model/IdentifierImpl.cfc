<!---
	
--->
<cfcomponent output="false" implements="com.silkunion.model.Identifiable">
	<cfproperty name="identifierParts" type="struct" default="">
	<cfproperty name="propertyName" type="string" default="">
	<cfproperty name="className" type="string" hint="The classname of the host object. The host object is the object for which this is its identifier.">
	<cfproperty name="keys" type="array" hint="">
	<cfproperty name="values" type="array" hint="">
	
	<cfscript>
		//Initialize the CFC with the default properties values.
		this.identifierParts = structNew();
		this.propertyName = "";
		this.className = "" ;
		this.keys = arrayNew(1);
		this.values = arrayNew(1);
	</cfscript>
	

	<cffunction name="init" output="false" returntype="IdentifierEmissary">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="getIdentifierParts" access="public" output="false">
		<cfreturn this.identifierParts>
	</cffunction>
	
	<cffunction name="setIdentifierParts" access="public" output="false" returntype="void">
		<cfargument name="val" type="any">
		<cfscript>
			this.identifierParts = arguments.val;
		</cfscript>
	</cffunction>
	
	<cffunction name="getPropertyName" access="public" output="false">
		<cfreturn this.propertyName>
	</cffunction>
	
	<cffunction name="setPropertyName" access="public" output="false">
		<cfargument name="val" type="any" required="true">
		<cfset this.propertyName = arguments.val>
	</cffunction>
	
	<cffunction name="setClassName" access="public" output="false" returntype="void">
		<cfargument name="val" type="string" required="true">
		<cfset this.className = arguments.val>
	</cffunction>
	
	<cffunction name="getClassName" access="public" output="false" returntype="any">
		<cfreturn this.className>
	</cffunction>
	
	<cffunction name="getKeys" access="public" output="false" returntype="any">
		<cfreturn this.keys>
	</cffunction>
	
	<cffunction name="getValues" access="public" output="false" returntype="any">
		<cfreturn this.values>
	</cffunction>
	
	<!---
		Public methods
	--->
	<cffunction access="public" name="addIdentifierPart" output="false" returntype="void" 
				hint="adds the property/value to the identifier, this method can only be called once for each property. If the identifier changes, the object is completely different the identity can only be constructed not changed.">
		<cfargument name="propertyName" type="string" required="true" hint="The name of the property of the identity, example: id">
		<cfargument name="value" type="any" required="true" hint="The value representation of the property, example: 1234">
		
		<cfscript>
			var i = 1;
			
			if (structKeyExists(this.identifierParts,ARGUMENTS.propertyName)) {
				structUpdate(this.identifierParts,ARGUMENTS.propertyName,ARGUMENTS.value);
				
				for (i=1; i lte arrayLen(this.keys);i=i+1) {
					if (this.keys[i] eq ARGUMENTS.propertyName) {
						this.values[i] = ARGUMENTS.value;
					}
				}
				
			} else {
	
				structInsert(this.identifierParts,ARGUMENTS.propertyName,ARGUMENTS.value);
			
				arrayAppend(this.keys,ARGUMENTS.propertyName);
			
				arrayAppend(this.values,ARGUMENTS.value);
			}
		</cfscript>
	</cffunction>
	
	<cffunction access="public"  name="getHashCode" output="false" returntype="any">
		<cfscript>
			var i = 1;
			var hashCode = "";
			var keys = structSort(this.identifierParts,'text','DESC');
			
			while (i lte arrayLen(keys)) {
				hashCode = hashCode & keys[i] & toString(structFind(this.identifierParts,keys[i]));
				
				i=i+1;
			}
			
			return hashCode;
		</cfscript>
	</cffunction>
	
	<cffunction name="isEqual" displayname="equals" access="public" output="false" returntype="boolean">
		<cfargument name="other" type="any" required="true">
		<cfscript>
			var i = 1;
			var keys = structKeyArray(this.identifierParts);
			
			/*
			 * When the provided value is a struct it is not an identifier
			 */
			if (not isStruct(other)) return false; 
			
			/*
			 * When the provided value is a simple value it is not an identifier
			 */
			if (isSimpleValue(ARGUMENTS.other)) return false;
			
			
			/*
			 * When the class names are not equal the identifiers are not equal
			 */
			if (this.className neq other.className) return false;
			
			/*
			 * When the number of identifier parts are nog equal the identifiers are not equal
			 */
			if (structCount(this.identifierParts) neq structCount(other.identifierParts)) return false;
			
			/*
			 * Iterate through the keys of the identifier parts to check if the content is equal
			 */
			for (i=1; i lte arrayLen(keys); i=i+1) {
				/*
				 * Check if the current key exists in the other struct
				 */
				if (not structKeyExists(other.identifierParts, keys[i])) {
					return false;
				}
				
				/*
				 * Check if the value of the current key is equal to the value of the other 
				 */
				if (structFind(this.identifierParts, keys[i]) neq structFind(other.identifierParts, keys[i])) {
					return false;
				}
			}
			
			return true;
		</cfscript>
	</cffunction>

	<cffunction name="toText" displayname="toString" access="public" output="false" returntype="string">
		<cfscript>
			var i = 1;
			var text = '';
			var keys = structKeyArray(this.identifierParts);
			
			for (i=1;i lte arrayLen(keys); i=i+1) {
				value = structFind(this.identifierParts,keys[i]);
				text = text & "[" & keys[i] & " = " & value & "] ";
			}
			
			return text;
		</cfscript>
	</cffunction>

</cfcomponent>