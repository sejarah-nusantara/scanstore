<!---
	Version: $Id: IConnector.cfc 15374 2010-04-15 11:43:57Z micdur $
--->
<cfinterface name="IConnector" hint="Generic interface for connecting to external systems">

	
	<cffunction name="sendData" returnType="any" access="public" output="false" hint="">
		<cfargument name="data" type="com.silkunion.connector.IConnectorData" required="true" hint="generic container for data transport" />

	</cffunction>
	
</cfinterface>