<cfinterface>

	<cffunction name="getCurrentUser" access="public" output="false" returntype="any">

	</cffunction>
	<cffunction name="setProperty" access="public" output="false" returntype="void">
		<cfargument name="property" type="string" required="true"/>
		<cfargument name="value" type="any" required="true"/>
	</cffunction>
</cfinterface>