<!---
	Version: $Id: NativeConnectorDataImpl.cfc 15374 2010-04-15 11:43:57Z micdur $
--->
<cfcomponent name="baseconnectordata" hint=""  
			implements="com.silkunion.connector.IConnectorData" 
			extends="com.silkunion.Object">

	<cfscript>
		variables.instance={};
	</cfscript>
	<cffunction name="init" returnType="com.silkunion.connector.BaseConnectorDataImpl" access="public" output="false" hint="">
		<cfargument name="data" type="any" required="true" hint="" />
		
		<cfreturn super.init(arguments) />
	</cffunction>
	<cffunction name="getData" returnType="any" access="public"  output="false" hint="">
		<cfreturn variables.instance.data>
	</cffunction>
	
	<cffunction name="setData" returnType="void" access="public"  output="false" hint="">
		<cfargument name="data" type="any" required="true" hint="" />
		<cfset variables.instance.data=arguments.data/>
	</cffunction>
</cfcomponent>