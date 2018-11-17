<cfcomponent name="ImportDirectory" hint=""  accessors="true" extends="org.dasa.model.BaseImportDirectory">

	<cfproperty name="id" type="string">
	<cfproperty name="creationDate" type="string">
	<cfproperty name="fileCount" type="numeric">
	<cfproperty name="fileQueue" type="string">
	<cfproperty name="lastImportdate" type="string">
	<cfproperty name="failureCount" type="numeric">
	<cfproperty name="isProcessing" type="boolean">
	<cfproperty name="logInfo" type="string">
	<cfproperty name="directoryName" type="string">

	<cffunction name="getLogInfo" returnType="string" access="public" output="false" hint="">
		<cfreturn variables.importLogReaderWriter.getLogInfo()>
	</cffunction>

	<cffunction name="processSuccessfullImport" returnType="void" access="public" output="false" hint="">
		<cfargument name="message" type="string" required="true" hint="" />
		<cfargument name="fileName" type="string" required="true" hint="" />
		<cfscript>
			variables.importLogReaderWriter.appendMessage(buildLogMessage(message,fileName));
			variables.importLogReaderWriter.updateFileCount();
			variables.importLogReaderWriter.saveAsXML();
		</cfscript>
	</cffunction>

	<cffunction name="processUnsuccessfullImport" returnType="void" access="public" output="false" hint="">
		<cfargument name="message" type="string" required="true" hint="" />
		<cfargument name="fileName" type="string" required="true" hint="" />
		<cfscript>
			variables.importLogReaderWriter.appendMessage(buildLogMessage(message,fileName));
			variables.importLogReaderWriter.updateFailureCount();
			variables.importLogReaderWriter.saveAsXML();
		</cfscript>
	</cffunction>

	<cffunction name="setLastImportDate" access="public" returntype="void">
		<cfargument name="lastImportdate">
		<cfscript>
			variables.importLogReaderWriter.setLastImportDate(lastImportdate);
			variables.importLogReaderWriter.saveAsXML();
		</cfscript>
	</cffunction>

	<cffunction name="setUserSessionController" returnType="void" access="public" output="false" hint="">
		<cfargument name="userSessionController" type="any" required="true" hint="" />
		<cfset variables.instance.userSessionController=arguments.userSessionController/>
	</cffunction>

	<cffunction name="buildLogMessage" returntype="string">
		<cfargument name="message" type="string" required="true" hint="" />
		<cfargument name="fileName" type="string" required="true" hint="" />
		<cfscript>
			return dateformat(now(),"yyyy-MM-DD") & " " & timeformat(now(),"HH:MM:SS") & " " & fileName & " " & message;
		</cfscript>
	</cffunction>

	<cffunction name="buildImportStartMessage">
		<cfargument name="metaData" type="struct">
		<cfscript>
			variables.importLogReaderWriter.buildImportStartMessage(variables.directoryName,variables.instance.userSessionController.getCurrentUser().getUserName(),metaData);
		</cfscript>
	</cffunction>

</cfcomponent>