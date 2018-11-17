<!---
	Version: $Id: IConnectorData.cfc 15297 2010-04-08 12:47:13Z marwor $
--->
<cfinterface name="IConnectorData" hint="Generic container for data transport" >

	
	<cffunction name="getData" returnType="any" access="public"  output="false" hint="">

	</cffunction>
	
	<cffunction name="setData" returnType="void" access="public"  output="false" hint="">
		<cfargument name="data" type="any" required="true" hint="" />

	</cffunction>
	
</cfinterface>