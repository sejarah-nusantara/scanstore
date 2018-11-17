<!---
	Version: $Id: IConfig.cfc  2010-03-16 15:45:21Z micdur $
--->
<cfinterface name="IConfig" hint="" >

	
	<cffunction name="getItem" returnType="any" access="public" output="false" hint="">
		<cfargument name="name" type="string" required="true" hint="" />

	</cffunction>
	
	<cffunction name="getConfig" returnType="struct" output="false" access="public" hint="">

	</cffunction>
	
	<cffunction name="setConfig" returnType="void" access="public"   output="false" hint="">
		<cfargument name="value" type="struct" required="true" hint="" />

	</cffunction>
	
	<cffunction name="setItem" returnType="void" access="public"  output="false" hint="">
		<cfargument name="name" type="string" required="true" hint="" />
		<cfargument name="value" type="any" required="true" hint="" />

	</cffunction>
	
</cfinterface>