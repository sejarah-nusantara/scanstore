<!---
	
--->
<cfcomponent name="ConfigImpl" hint="I hold a struct configuration injected via the init function"  implements="com.silkunion.util.IConfig">
	<cfset variables.instance = {} />
	<cfset variables.instance.config = {} />
	<cffunction name="init" returnType="com.silkunion.util.ConfigImpl" access="public" output="false" hint="">
		<cfargument name="config" type="struct" required="true" hint="" />
		<cfscript>
			variables.instance.config=duplicate(arguments.config);
			return this;
		</cfscript> 
	</cffunction>
	
	<cffunction name="setItem" returnType="void" access="public" output="false" hint="">
		<cfargument name="name" type="string" required="true" hint="" />
		<cfargument name="value" type="any" required="true" hint="" />
		<cfset variables.instance.config[name]=value>
	</cffunction>
	
	<cffunction name="getItem" returnType="any" access="public" output="false" hint="">
		<cfargument name="name" type="string" required="true" hint="" />
		<cfreturn variables.instance.config[name] />
	</cffunction>
	
	<cffunction name="setConfig" returnType="void" access="public" output="false" hint="">
		<cfargument name="value" type="struct" required="true" hint="" />
		<cfset variables.instance.config = arguments.value />
	</cffunction>
	
	<cffunction name="getConfig" returnType="struct" access="public" output="false" hint="">
		<cfreturn duplicate(variables.instance.config) />
	</cffunction>
	
	
</cfcomponent>