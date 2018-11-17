<cfcomponent name="Datasource Settings Bean" output="no" hint="Simple bean to store datasource settings">

	<cffunction name="init" output="false" access="public" hint="Constructor" returntype="com.silkunion.sql.Datasource">
		<cfargument name="settings" type="struct" required="false" default="#structnew()#" hint="initial settings"/>
		
		<cfparam name="arguments.settings.type" type="string" default="rdbms">
		<cfparam name="arguments.settings.xmlstoragepath" type="string" default="">
		<cfparam name="arguments.settings.dsn" type="string" default="">
		<cfparam name="arguments.settings.vendor" type="string" default="mySql">
			
		<cfset variables.settings = arguments.settings/>
		<cfreturn this/>
	</cffunction>

	<cffunction name="getType" access="public" output="false" returntype="string" hint="I retrieve the type of this datasource (xml, rdbms)">
		<cfreturn variables.settings.type/>
	</cffunction>

	<cffunction name="setType" access="public" output="false" returntype="void"  hint="I set the type of this datasource (xml, rdbms)">
		<cfargument name="type" type="string" required="true"/>
		<cfif not listFind("xml,rdbms",arguments.type)>
			<cfthrow message="'#arguments.type#' is not a valid datasource type. (Valid types are: xml,rdbms)"/>
		</cfif>
		<cfset variables.settings.type = arguments.type/>
	</cffunction>
	<cffunction name="setUser" access="public" output="false" returntype="void"  hint="">
		<cfargument name="user" type="string" required="true"/>
	
		<cfset variables.settings.user = arguments.user/>
	</cffunction>
	<cffunction name="getUser" access="public" output="false" returntype="string" hint="I retrieve the type of this datasource (xml, rdbms)">
		<cfreturn variables.settings.User/>
	</cffunction>
	<cffunction name="setpw" access="public" output="false" returntype="void"  hint="">
		<cfargument name="pw" type="string" required="true"/>
	
		<cfset variables.settings.pw = arguments.pw/>
	</cffunction>
	<cffunction name="getpw" access="public" output="false" returntype="string" hint="">
		<cfreturn variables.settings.pw/>
	</cffunction>
	
	<cffunction name="getDsn" access="public" output="false" returntype="string" hint="I retrieve the Dsn from this instance's data">
		<cfreturn variables.settings.dsn/>
	</cffunction>

	<cffunction name="setDsn" access="public" output="false" returntype="void"  hint="I set the Dsn in this instance's data">
		<cfargument name="dsn" type="string" required="true"/>
		<cfset variables.settings.dsn = arguments.dsn/>
	</cffunction>

	<cffunction name="getVendor" access="public" output="false" returntype="string" hint="I retrieve the vendor from this instance's data">
		<cfreturn variables.settings.vendor/>
	</cffunction>

	<cffunction name="setVendor" access="public" output="false" returntype="void"  hint="I set the vendor in this instance's data">
		<cfargument name="vendor" type="string" required="true"/>
		<cfset variables.settings.vendor = arguments.vendor/>
	</cffunction>
	
	<cffunction name="getXmlStoragePath" access="public" output="false" returntype="string" hint="I retrieve the xmlstoragepath from this instance's data (only applicable when type: xml)">
		<cfreturn variables.settings.xmlstoragepath/>
	</cffunction>

	<cffunction name="setXmlStoragePath" access="public" output="false" returntype="void"  hint="I set the xmlstoragepath in this instance's data (only applicable when type: xml)">
		<cfargument name="xmlStoragePath" type="string" required="true"/>
		<cfset variables.settings.xmlstoragepath = arguments.xmlstoragepath/>
	</cffunction>
</cfcomponent>