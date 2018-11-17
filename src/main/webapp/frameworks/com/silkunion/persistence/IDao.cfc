<cfinterface displayName="Dao">
				
	<cffunction name="save" access="public" output="false" returntype="void">
		<cfargument name="obj" type="com.silkunion.model.IBusinessObject" required="true" />
		<cfargument name="flush" type="boolean" required="false" default="true">
		
	</cffunction>


	<cffunction name="read" access="public" output="false" returntype="com.silkunion.model.IBusinessObject">
		<cfargument name="id" type="any" required="true" />
		
	</cffunction>
	
	<cffunction name="new" access="public" output="false" returntype="com.silkunion.model.IBusinessObject">
	
		
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="void">
		<cfargument name="obj" type="com.silkunion.model.IBusinessObject" required="true" />
		<cfargument name="flush" type="boolean" required="false" default="true">
	
	</cffunction>		
	<cffunction name="readByProperty" access="public" output="false" returntype="com.silkunion.model.IBusinessObject">
		<cfargument name="property" type="string" required="true" />
		<cfargument name="value" type="string" required="true" />
		
	</cffunction>			
	<cffunction name="readByPropertyMap" access="public" output="false" returntype="com.silkunion.model.IBusinessObject">
		<cfargument name="propertyMap" type="struct" required="true" />
				
	</cffunction>
	
	<cffunction name="listByPropertyMap" access="public" output="false" returntype="Array">
		<cfargument name="propertyMap" type="struct" required="true" />
		<cfargument name="options" type="struct" required="false" />
		<cfargument name="sortorder" type="string" required="false" />
	</cffunction>			
</cfinterface>