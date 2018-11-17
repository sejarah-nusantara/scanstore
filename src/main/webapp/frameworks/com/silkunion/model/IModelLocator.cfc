<cfinterface>
	<cffunction name="getModel">
		<cfargument name="identifier" type="com.silkunion.model.Identifiable"/>
		<cfargument name="metaData" type="struct"/>
	</cffunction>
	<cffunction name="unRegisterModel" returntype="void">
		<cfargument name="identifier" type="com.silkunion.model.Identifiable"/>
		
	</cffunction>
	<cffunction name="registerModel" returntype="void">
		<cfargument name="item" type="any"/>
		
	
	</cffunction>
	<cffunction name="clean" returntype="void">
		
	
	</cffunction>
</cfinterface>