<cfcomponent extends="com.silkunion.Object" accessors="false">
	<cfproperty name="collection" type="array" />
	<cfproperty name="count" displayname="" hint="" type="numeric" />
	<cfproperty name="succeeded" type="boolean" />
	<cfproperty name="offset" type="numeric" />
	<cfscript>
		variables.collection=[];
		variables.count=0;
		variables.succeeded=true;
		variables.offset=0;
	</cfscript>
	
	<cffunction name="getCollection" access="public" output="false" returntype="array">
		<cfreturn variables.collection>
		
	</cffunction>

	<cffunction name="setCollection" access="public" output="false" returntype="void">
		<cfargument name="argCollection" type="array">
		<cfset variables.collection=arguments.argCollection/>
		
	</cffunction>

	<cffunction name="getCount" access="public" output="false" returntype="numeric">
		<cfreturn variables.count>
		
	</cffunction>

	<cffunction name="setCount" access="public" output="false" returntype="void">
		<cfargument name="argCount" type="numeric">
		<cfset variables.count=arguments.argCount/>
		
	</cffunction>

	<cffunction name="getSucceeded" access="public" output="false" returntype="boolean">
		<cfreturn variables.succeeded>
		
	</cffunction>

	<cffunction name="setSucceeded" access="public" output="false" returntype="void">
		<cfargument name="argSucceeded" type="boolean">
		<cfset variables.succeeded=arguments.argSucceeded/>
		
	</cffunction>

	<cffunction name="getOffset" access="public" output="false" returntype="numeric">
		<cfreturn variables.offset>
		
	</cffunction>

	<cffunction name="setOffset" access="public" output="false" returntype="void">
		<cfargument name="argOffset" type="numeric">
		<cfset variables.offset=arguments.argOffset/>
		
	</cffunction>

</cfcomponent>