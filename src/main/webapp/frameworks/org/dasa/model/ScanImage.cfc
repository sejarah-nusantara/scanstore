<cfcomponent name="ScanFile" hint="" accessors="true" extends="com.silkunion.model.BaseBusinessNoOrmObjectImpl" >
	<cfproperty name="id" type="string">
	<cfproperty name="originalFileName" type="string">
	<cfproperty name="useForPublication" type="string">
	<cfproperty name="fileUrl" type="string">
	<cfproperty name="fileLocation" type="string" hint="the location on the scanstore server for uploading to the repository">
	<cfproperty name="scanID" type="string">
	<cfset variables.id = "" />

	<cfset variables.originalFileName = null />
	<cfset variables.useForPublication = false />
	<cfset variables.fileUrl = null />
	<cfset variables.fileLocation = null />
	<cfset variables.scanID = null />
	<!--- adapter methods for repository  data--->
	<cffunction name="setIs_default">

		<cfargument name="val">
		<cfset variables.useForPublication = val>
	</cffunction>
	<cffunction name="setScan_number">

		<cfargument name="val">
		<cfset variables.scanId = val>
	</cffunction>

	<cffunction name="setImage_url">

		<cfargument name="val">
		<cfset variables.fileUrl = val>
	</cffunction>

	<cffunction name="setFilename">

		<cfargument name="val">
		<cfset variables.originalFileName = listLast(val,"/")>
	</cffunction>

	<!--- adapter methods for repository  data--->
	<cffunction name="hasFileLocation" returntype="boolean">
		<cfreturn len(fileLocation) GT 0>
	</cffunction>

</cfcomponent>