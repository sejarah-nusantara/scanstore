<cfinterface>
	

		
	
	<cffunction name="getProperty" output="false" access="public" returntype="string">
		
	</cffunction>

	<cffunction name="setProperty" output="false" access="public" returntype="void">
		<cfargument name="val" required="true" type="string" >
		
	</cffunction>
	<cffunction name="getMessage" output="false" access="public" returntype="string">
		
	</cffunction>

	<cffunction name="setMessage" output="false" access="public" returntype="void">
		<cfargument name="val" required="true" type="string">
		
	</cffunction>

	<cffunction name="getMessageType" output="false" access="public" returntype="string">
	
	</cffunction>

	<cffunction name="setMessageType" output="false" access="public" returntype="void">
		<cfargument name="val" required="true" type="string">
		
	</cffunction>
	<cffunction name="getIdentifier" output="false" access="public" returntype="com.silkunion.model.Identifiable">
		
	</cffunction>

	<cffunction name="setIdentifier" output="false" access="public" returntype="void">
		<cfargument name="val" required="true" type="com.silkunion.model.Identifiable">
		
	</cffunction>
	<cffunction name="getObjectMetadata" output="false" access="public" returntype="struct">
		
	</cffunction>

	<cffunction name="setObjectMetadata" output="false" access="public" returntype="void">
		<cfargument name="val" required="true" type="struct">
		
	</cffunction>


</cfinterface>