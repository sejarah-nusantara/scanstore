<cfcomponent name="BaseImportDirectory" hint=""  accessors="true" extends="com.silkunion.Object">

	<cfproperty name="id" type="string">
	<cfproperty name="creationDate" type="string">
	<cfproperty name="fileCount" type="numeric">
	<cfproperty name="fileQueue" type="string">
	<cfproperty name="lastImportdate" type="string">
	<cfproperty name="failureCount" type="numeric">
	<cfproperty name="isProcessing" type="boolean">
	<cfproperty name="directoryName" type="string">

	<cfset variables.isProcessing = false />
	<cfset variables.directoryName = "" />
	<cfset variables.directoryPath = "" />
	<cfset variables.importLogReaderWriter = "" />

	<cffunction name="init">
		<cfargument name="directoryName">
		<cfargument name="directoryPath">
		<cfargument name="creationDate">
		<cfargument name="isProcessing">
		<cfscript>
			variables.id = toBase64(arguments.directoryName);
			variables.directoryName = arguments.directoryName;
			variables.directoryPath = arguments.directoryPath;
			variables.creationDate = arguments.creationDate;
			variables.isProcessing = arguments.isProcessing;
			return this;
		</cfscript>
	</cffunction>

	<cffunction name="setup" hint="this creates log filewriter log  for this directory if not it creates a log file via ImportLogReaderWriter">
		<cfscript>
			var args = {};
			args.directoryName =  variables.directoryName;
			args.directoryPath =  variables.directoryPath;
			args.creationDate =  variables.creationDate;
			variables.importLogReaderWriter = getImportDirectoryFactory().create("importLogReaderWriter",args);
		</cfscript>
	</cffunction>

	<cffunction name="getImportLocation" returnType="string" access="public" output="false" hint="">
		<cfreturn variables.directoryPath & variables.directoryName>
	</cffunction>

	<cffunction name="getName" returnType="string" access="public" output="false" hint="">
		<cfreturn variables.directoryName>
	</cffunction>

	<cffunction name="getFileCount" returnType="string" access="public" output="false" hint="">
		<cfreturn variables.importLogReaderWriter.getFileCount()>
	</cffunction>

	<cffunction name="getFileQueue" returnType="string" access="public" output="false" hint="">
		<cfreturn variables.importLogReaderWriter.getFileQueue()>
	</cffunction>

	<cffunction name="getFailureCount" returnType="string" access="public" output="false" hint="">
		<cfreturn variables.importLogReaderWriter.getFailureCount()>
	</cffunction>

	<cffunction name="getLastImportdate" returnType="any" access="public" output="false" hint="">
		<cfreturn variables.importLogReaderWriter.getLastImportDate()>
	</cffunction>

	<cffunction name="getCreationDate" returnType="any" access="public" output="false" hint="">
		<cfreturn variables.importLogReaderWriter.getCreationDate()>
	</cffunction>

	<cffunction name="getImportDirectoryFactory" returnType="any" access="private" output="false" hint="">
		<cfreturn variables.instance.importDirectoryFactory/>
	</cffunction>

	<cffunction name="setImportDirectoryFactory" returnType="void" access="public" output="false" hint="">
		<cfargument name="importDirectoryFactory" type="any" required="true" hint="" />
		<cfset variables.instance.importDirectoryFactory=arguments.importDirectoryFactory/>
	</cffunction>

</cfcomponent>