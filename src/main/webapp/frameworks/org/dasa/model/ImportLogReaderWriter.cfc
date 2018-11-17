<cfcomponent name="ImportLogReaderWriter" hint="" accessors="true" extends="com.silkunion.Object">

	<cfproperty name="fileCount" type="numeric">
	<cfproperty name="creationDate" type="date">
	<cfproperty name="failureCount" type="numeric">
	<cfproperty name="lastImportDate" type="date">
	<cfproperty name="fileQueue" type="date">

	<cfset variables.directoryPath = null />
	<cfset variables.directoryName = null />
	<cfset variables.creationDate = null />
	<cfset variables.lastImportDate = null />
	<cfset variables.fileCount = 0 />
	<cfset variables.fileQueue  = 0 />
	<cfset variables.failureCount = 0 />
	<cfset variables.messages = []/>
	<cfset variables.logFileName = null />
	<cfset variables.stringBuffer = createObject('java','java.lang.StringBuffer') />

	<cffunction name="init">
		<cfargument name="directoryName">
		<cfargument name="directoryPath">
		<cfargument name="creationDate">
		<cfscript>
			variables.directoryName = arguments.directoryName;
			variables.directoryPath = arguments.directoryPath;
			variables.creationDate = arguments.creationDate;
			variables.logFilePath = arguments.directoryPath & arguments.directoryName & "/";
			variables.logFileName = arguments.directoryName & ".xml";
			return this;
		</cfscript>
	</cffunction>

	<cffunction name="setup" hint="this method checks if there is a log file  if not it creates a log file">
		<cfscript>
			if(!hasLogFile()){
				calculateFileCount();
				saveAsXML();
			}else{
				readAsXML();
			}
		</cfscript>
	</cffunction>

	<cffunction name="appendMessage" returnType="void" access="package" output="false" hint="decreases the filecount with one">
		<cfargument name="message" type="string" required="true" hint="" />
		<cfscript>
			variables.messages.add(message);
		</cfscript>
	</cffunction>

	<cffunction name="hasLogFile" returnType="boolean" access="package" output="false" hint="checks if a log file is generated for this directory">
		<cfscript>
			return fileExists(variables.logFilePath &  variables.logFileName);
		</cfscript>
	</cffunction>

	<cffunction name="updateFileCount" returnType="void" access="package" output="false" hint="decreases the filecount with one">
		<cfscript>
			variables.fileQueue--;
		</cfscript>
	</cffunction>

	<cffunction name="updateFailureCount" returnType="void" access="package" output="false" hint="">
		<cfscript>
			variables.failureCount++;
		</cfscript>
	</cffunction>

	<cffunction name="buildImportStartMessage" returnType="void" access="package" output="false" hint="">
		<cfargument name="directoryName">
		<cfargument name="user">
		<cfargument name="metaData" type="struct">
		<cfscript>
			appendMessage(dateformat(now(),"yyyy-MM-DD") & " " & timeformat(now(),"HH:MM:SS") & " "	& arguments.user & " started import " & arguments.directoryName);
			appendMessage("remaining files: "  & variables.fileQueue);
			appendMessage("import metadata:");
			appendMessage(" - archive: " & getArchivesGateway().getArchiveByArchiveId(arguments.metaData.archiveID));
			appendMessage(" - language: " & arguments.metaData.languageID);
			appendMessage(" - archive File: " & arguments.metaData.archiveFileID);
			appendMessage(" - type: " & arguments.metaData.type);
			appendMessage(" - title: " & arguments.metaData.title);
			saveAsXML();
		</cfscript>
	</cffunction>

	<cffunction name="setLastImportDate" returnType="void" access="package" output="false" hint="">
		<cfargument name="importDate" type="date" required="true" hint="" />
		<cfset  variables.lastImportDate = arguments.importDate>
	</cffunction>

	<cffunction name="saveAsXML" returnType="void" access="package" output="false" hint="">
		<cfset var local={}>
			<cfoutput>
				<cfxml variable="local.xml">
					<importlog>
					    <creationdate>#dateformat(variables.creationDate,'yyyy-MM-dd')# #timeformat(variables.creationDate,'HH:MM:SS')#</creationdate>
					    <cfif isDate(variables.lastImportDate)>
					    <lastimportdate>#dateformat(variables.lastImportDate,'yyyy-MM-dd')# #timeformat(variables.lastImportDate,'HH:MM:SS')#</lastimportdate>
					    <cfelse>
					    	<lastimportdate></lastimportdate>
					    </cfif>
					    <filecount>#variables.fileCount#</filecount>
					    <filequeue>#variables.fileQueue#</filequeue>
					    <failurecount>#variables.failureCount#</failurecount>
					    <messages>
					   	<cfloop array="#variables.messages#" index="local.message">
					        <message><![CDATA[#local.message#]]></message>
					       </cfloop>

					    </messages>
					</importlog>
				</cfxml>
			</cfoutput>
			<cfset getFileSystemController().createFile(variables.logFileName,variables.logFilePath,local.xml)/>
	</cffunction>

	<cffunction name="readAsXML" returnType="void" access="private" output="false" hint="">
		<cfscript>
			var xmlString = getFileSystemController().readFile(variables.logFilePath & variables.logFileName);
			var xmlmsg	="";
			var i=0;
			var xmlObject = xmlParse(xmlString);
			//if(getDateUtilityIsoDate().isValidDate(xmlObject.xmlRoot.creationdate.xmlText)){
				variables.creationDate = xmlObject.xmlRoot.creationdate.xmlText;
			//}
			//if(getDateUtilityIsoDate().isValidDate(xmlObject.xmlRoot.lastimportdate.xmlText)){
				variables.lastImportDate = xmlObject.xmlRoot.lastimportdate.xmlText;
			//}
			variables.fileCount = xmlObject.xmlRoot.fileCount.xmlText;
			variables.failureCount = xmlObject.xmlRoot.failureCount.xmlText;
			variables.fileQueue = xmlObject.xmlRoot.fileQueue.xmlText;
			xmlmsg = xmlSearch(xmlObject.xmlRoot,"messages/message");
			for(i=1 ; i <= arrayLen(xmlmsg); i++){
				variables.messages.add(xmlmsg[i].XmlCData);
			}
		</cfscript>
	</cffunction>

	<cffunction name="calculateFileCount" returnType="void" access="private" output="false" hint="">
		<cfscript>
			variables.fileCount = getFileSystemController().list(
				variables.directoryPath & variables.directoryName,
				getAcceptedFilesConfig().acceptedImageFiles
			).recordcount;
			variables.fileQueue = variables.fileCount;
		</cfscript>
	</cffunction>

	<cffunction name="getLogInfo" returnType="string" access="package" output="false" hint="">
		<cfscript>
			var i =0;
			variables.stringBuffer.append("creation date: #dateformat(variables.creationdate,'yyyy-MM-DD')# #timeformat(variables.creationDate,'HH:MM:SS')#<br>" );
			if(isdate(variables.lastImportDate)){
				variables.stringBuffer.append("importdate: #dateformat(variables.lastImportDate,'yyyy-MM-DD')# #timeformat(variables.lastImportDate,'HH:MM:SS')#<br>" );
			}
			variables.stringBuffer.append("file count: #variables.fileCount# <br>" );
			variables.stringBuffer.append("file queue: #variables.fileQueue# <br>" );
			variables.stringBuffer.append("failure count: #variables.failureCount# <br>" );
			variables.stringBuffer.append("messages: <br>" );
			for(i=0 ; i < variables.messages.size(); i++){
				variables.stringBuffer.append("#variables.messages.get(i)# <br>" );
			}
			return variables.stringBuffer.toString();
		</cfscript>
	</cffunction>

	<!--- dependencies--->
	<cffunction name="getArchivesGateway" access="public">
		<cfscript>
			return variables.instance.archivesGateway;
		</cfscript>
	</cffunction>

	<cffunction name="setArchivesGateway" access="public">
		<cfargument name="archivesGateway" type="any"/>
		<cfscript>
			variables.instance.archivesGateway = arguments.archivesGateway;
		</cfscript>
	</cffunction>

	<cffunction name="getfileSystemController" access="private" returntype="com.silkunion.control.IFilesystemController" output="false" hint="Returns The utitlity object to use for interacting with the filesystem">
		<cfscript>
			return variables.fileSystemController;
		</cfscript>
	</cffunction>

	<cffunction name="setfileSystemController" access="public" returntype="void" output="false" hint="Sets The utitlity object to use for interacting with the filesystem">
		<cfargument name="fileSystemController" type="com.silkunion.control.IFilesystemController" required="true" hint="The utitlity object to use for interacting with the filesystem">
		<cfscript>
			variables.fileSystemController = fileSystemController;
		</cfscript>
	</cffunction>

	<cffunction name="getAcceptedFilesConfig" returnType="struct" access="private" output="false" hint="">
		<cfreturn variables.instance.acceptedFilesConfig/>
	</cffunction>

	<cffunction name="setAcceptedFilesConfig" returnType="void" access="public" output="false" hint="">
		<cfargument name="acceptedFilesConfig" type="struct" required="true" hint="" />
		<cfset variables.instance.acceptedFilesConfig = arguments.acceptedFilesConfig/>
	</cffunction>

	<cffunction name="getDateUtilityIsoDate" returnType="any" access="private" output="false" hint="">
		<cfreturn variables.instance.dateUtilityIsoDate/>
	</cffunction>

	<cffunction name="setDateUtilityIsoDate" returnType="void" access="public" output="false" hint="">
		<cfargument name="dateUtilityIsoDate" type="any" required="true" hint="" />
		<cfset variables.instance.dateUtilityIsoDate = arguments.dateUtilityIsoDate/>
	</cffunction>

</cfcomponent>