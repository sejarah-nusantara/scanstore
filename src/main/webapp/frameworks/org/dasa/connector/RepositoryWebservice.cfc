<cfcomponent extends="org.dasa.model.ScanStoreBaseObject">

	<cffunction name="init" access="public" >
		<cfreturn super.init(argumentCollection=arguments)/>
	</cffunction>

	<cffunction name="uploadScan" access="public" >
		<cfargument name="pageScan" type="org.dasa.model.PageScan"/>
		<cfset var local={}/>
		<!---
					@archive_id:	and id of an archive, must be in /lists/archives
					@archiveFile:	identifier of an archive file within the archive (given by archive_id)
					@file:	the image of the scan
					@status:	a status: a value among Status Values (except 0)
					@user:	the name of a user - optional, will be used for logging info
		--->
		<cfhttp multipart="true" url="#application.settings.REPOSITORY_URL#scans" method="POST" result="local.result">
			<cfhttpParam name="archive_id" value="#arguments.pageScan.getArchive_id()#"  type="formField"/>
			<cfhttpParam name="archiveFile" value="#arguments.pageScan.getArchiveFile()#" type="formField"/>
			<cfhttpParam name="status" value="#arguments.pageScan.getStatus()#" type="formField"/>
			<cfhttpParam name="title" value="#arguments.pageScan.getTitle()#" type="formField"/>
			<cfhttpParam name="type" value="#arguments.pageScan.getType()#" type="formField"/>
			<cfhttpParam name="language" value="#arguments.pageScan.getLanguage()#" type="formField"/>
			<cfhttpParam name="user" value="#getUserSessionController().getCurrentUser().getUsername()#" type="formField"/>
			<cfloop array="#arguments.pageScan.getImages()#" index="local.image">
				<cfhttpparam type="File" name="file" file="#local.image.getFileLocation()#">
			</cfloop>
		</cfhttp>
		<cfif NOT findNocase("200",local.result.statuscode) >
			<cfthrow type="repositoryException" message="Error uploading file to repository, #local.result.statuscode# - #application.settings.REPOSITORY_URL#scans" detail="#local.result.toString()#">
		</cfif>
	</cffunction>

	<cffunction name="searchScans" access="public" returntype="string">
		<cfargument name="number" type="string" required="false"/>
		<cfargument name="archiveID" type="string" required="false"/>
		<cfargument name="archiveFileID" type="string" required="false"/>
		<cfargument name="statusID" type="numeric" required="false" />
		<cfargument name="limit" type="numeric" required="false" />
		<cfargument name="start" type="numeric" required="false" default="0"/>
		<!---
		@archive_id:	and id of an archive, must be in /lists/archives
		@institution:	the institution of the scan (cf. /lists/archives)
		@archive:	the archive of the scan (cf. /lists/archives)
		@archiveFile:	as above
		@start:	index of the first element returned (used in pagination)
		@limit:	max # of objects to return
		@contains_text:	a string
		returns:	information about the query, and a paged lists of results--->
		<cfset var resultsearch=""/>
		<cfset var searchurl=application.settings.REPOSITORY_URL&"scans"/>
		<cfif structKeyExists(arguments,'number') AND len(arguments.number)>
			<cfset searchurl=searchurl&"/"&arguments.number/>
		</cfif>
		<cfhttp  url="#searchurl#" method="GET" result="resultSearch">
			<cfif structKeyExists(arguments,'archiveID') AND len(arguments.archiveID)>
				<cfhttpParam name="archive_id" value="#arguments.archiveID#" type="URL"/>
			</cfif>
			<cfhttpParam name="institution" value="#getUserSessionController().getCurrentUser().getInstitutionID()#" type="URL"/>
			<cfif structKeyExists(arguments,'archiveFileID') AND len(arguments.archiveFileID)>
				<cfhttpParam name="archiveFile" value="#arguments.archiveFileID#" type="URL"/>
			</cfif>
			<cfif structKeyExists(arguments,'limit') AND len(arguments.limit)>
				<cfhttpParam name="limit" value="#arguments.limit#" type="URL"/>
			</cfif>
			<cfif structKeyExists(arguments,'start') AND len(arguments.start)>
				<cfhttpParam name="start" value="#arguments.start#" type="URL"/>
			</cfif>
			<cfif structKeyExists(arguments,'statusID') AND len(arguments.statusID)>
				<cfhttpParam name="status" value="#arguments.statusID#" type="URL"/>
			</cfif>
		</cfhttp>
		<cfif structKeyExists(arguments,'number') AND len(arguments.number)>
			<cfif NOT findNocase("200",resultSearch.statuscode) >
				<cfreturn "{""total_results"": 0, ""start"": 0, ""end"": 0, ""results"": []}"/>
			<cfelse>
				<cfreturn "{""total_results"": 1, ""start"": 0, ""end"": 1, ""results"": ["&resultSearch.fileContent.toString()&"]}"/>
			</cfif>
		<cfelse>
			<cfif NOT findNocase("200",resultSearch.statuscode) >
				<cfthrow type="repositoryException" message="Error connecting to repository, #resultSearch.statuscode# - #searchurl#" detail="#resultSearch.toString()#">
			</cfif>
			<cfreturn resultSearch.fileContent.toString()/>
		</cfif>
	</cffunction>

	<cffunction name="getScan" access="public" returntype="string">
		<cfargument name="number" type="numeric">
		<cfset var resultGet=""/>
		<cfhttp  url="#application.settings.REPOSITORY_URL#scans/#arguments.number#" method="GET" result="resultGet"/>
		<cfif NOT findNocase("200",resultGet.statuscode) >
			<cfthrow type="repositoryException" message="Error connecting to repository, #resultGet.statuscode# - #application.settings.REPOSITORY_URL#scans/#arguments.number#" detail="#resultGet.toString()#">
		</cfif>
		<cfreturn resultGet.fileContent.toString()/>
	</cffunction>

	<cffunction name="updateScan" access="public" returntype="string">
		<cfargument name="pageScan" type="any">
		<cfset var local={}/>
		<cfset var resultPUT=""/>
		<cfset local.i = 1/>
		<cfset local.properties = pageScan.getConvertedPropertyStruct()/>
		<cfset local.properties.user = getUserSessionController().getCurrentUser().getUsername() />
		<cfset local.stringList =createObject('java','java.lang.StringBuffer')/>
		<cfloop collection="#local.properties#" item="local.property">
				<cfset local.stringList.append("#local.property#=#URLEncodedFormat(local.properties[local.property])#")/>
				<cfif local.i LT StructCount(local.properties) >
					<cfset local.stringList.append("&")/>
				</cfif>
				<cfset local.i++/>
		</cfloop>
		<cfhttp  url="#application.settings.REPOSITORY_URL#scans/#arguments.pageScan.getNumber()#" method="PUT"  result="resultPUT"  >
			<cfhttpparam type="header" name="Content-Type" value="application/x-www-form-urlencoded" />
			<cfhttpParam  value="#local.stringList.toString()#" type="body" />
		</cfhttp>
		<cfif NOT findNocase("200",resultPUT.statuscode) >
			<cfthrow type="repositoryException" message="Error connecting to repository, #resultPUT.statuscode# - #application.settings.REPOSITORY_URL#scans/#arguments.pageScan.getNumber()#" detail="#resultPUT.toString()#">
		</cfif>
		<cfreturn resultPUT.fileContent.toString()/>
	</cffunction>

	<cffunction name="updateScanImage" access="public" returntype="string">
		<cfargument name="pageScan" type="any">
		<cfset var local={}/>
		<cfset var resultPUT=""/>
		<cfset local.properties=arguments.pageScan.getConvertedPropertyStruct()/>
		<cfhttp  url="#application.settings.REPOSITORY_URL#scans/#arguments.pageScan.getNumber()#" method="POST"  result="resultPUT" multipart="true" >
			<cfif len(arguments.pageScan.getHiresImage())>
				<cfhttpparam type="File" name="file" file="#arguments.pageScan.getHiresImage()#">
				<cfhttpParam name="user" value="#getUserSessionController().getCurrentUser().getUsername()#" type="formField"/>
			</cfif>
		</cfhttp>
		<cfif NOT findNocase("200",resultPUT.statuscode) >
			<cfthrow type="repositoryException" message="Error connecting to repository, #resultPUT.statuscode# - #application.settings.REPOSITORY_URL#scans/#arguments.pageScan.getNumber()#" detail="#resultPUT.toString()#">
		</cfif>
		<cfreturn resultPUT.fileContent.toString()/>
	</cffunction>

	<cffunction name="deleteScan" access="public" returntype="string">
		<cfargument name="number" type="numeric">
		<cfset var resultDelete=""/>
		<cfhttp  url="#application.settings.REPOSITORY_URL#scans/#arguments.number#" method="delete"   result="resultDelete">
			<cfhttpParam name="user" value="#getUserSessionController().getCurrentUser().getUsername()#" type="url"/>
		</cfhttp>
		<cfif NOT findNocase("200",resultDelete.statuscode) >
			<cfthrow type="repositoryException" message="Error connecting to repository, #resultDelete.statuscode# - #application.settings.REPOSITORY_URL#scans/#arguments.number#" detail="#resultDelete.toString()#">
		</cfif>
		<cfreturn resultDelete.fileContent.toString()/>
	</cffunction>

	<cffunction name="moveScan" access="public" returntype="void">
		<cfargument name="number" type="numeric">
		<cfargument name="after" type="numeric" hint=" after:	put this scan after the scan with number :after:">
		<cfhttp  url="#application.settings.REPOSITORY_URL#scans/#arguments.number#/move" method="post"   result="resultMove">
			<cfhttpparam type="formField" name="after" value="#arguments.after#">
			<cfhttpParam name="user" value="#getUserSessionController().getCurrentUser().getUsername()#" type="formField"/>
		</cfhttp>
		<cfif NOT findNocase("200",resultMove.statuscode) >
			<cfthrow type="repositoryException" message="Error connecting to repository, #resultMove.statuscode# - #application.settings.REPOSITORY_URL#scans/#arguments.number#/move" detail="#resultMove.toString()#">
		</cfif>
	</cffunction>

	<cffunction name="getArchivesList" access="public" returntype="string">
		<cfset var resultArchives=""/>
		<cfhttp  url="#application.settings.REPOSITORY_URL#lists/archives" method="get"   result="resultArchives"/>
		<cfif NOT findNocase("200",resultArchives.statuscode) >
			<cfthrow type="repositoryException" message="Error connecting to repository, #resultArchives.statuscode# - #application.settings.REPOSITORY_URL#lists/archives" detail="#resultArchives.toString()#">
		</cfif>
		<cfreturn resultArchives.fileContent.toString()/>
	</cffunction>

	<cffunction name="getFilesList" access="public" returntype="string">
		<cfargument name="archiveId" type="string"/>
		<cfset var resultFiles=""/>
		<cfhttp  url="#application.settings.REPOSITORY_URL#lists/archiveFileId" method="get"   result="resultFiles">
			<cfhttpparam type="url" name="archive_id" value="#arguments.archiveId#"/>
		</cfhttp>
		<cfif NOT findNocase("200",resultFiles.statuscode) >
			<cfthrow type="repositoryException" message="Error connecting to repository, #resultFiles.statuscode# - #application.settings.REPOSITORY_URL#lists/archiveFileId" detail="#resultFiles.toString()#">
		</cfif>
		<cfreturn resultFiles.fileContent.toString()/>
	</cffunction>

	<cffunction name="getFilesForPublishing" access="public" returntype="string">
		<cfargument name="archiveId" type="string"  required="false"/>
		<cfargument name="status" type="numeric" required="false"/>
		<cfargument name="hasScans" type="boolean" required="false"/>
		<cfargument name="start" type="numeric" required="false" default="0"/>
		<cfset var resultFiles=""/>
		<cfhttp  url="#application.settings.REPOSITORY_URL#archivefiles" method="get"   result="resultFiles">
			<cfif structKeyexists(arguments,"archiveId")>
				<cfhttpparam type="url" name="archive_id" value="#arguments.archiveId#"/>
			</cfif>
			<cfif structKeyexists(arguments,"status")>
				<cfhttpparam type="url" name="status" value="#arguments.status#"/>
			</cfif>
			<cfhttpparam type="url" name="has_scans" value="#arguments.hasScans#"/>
			<cfhttpParam name="limit" value="#application.settings.PAGESIZE#" type="URL"/>
			<cfif structKeyExists(arguments,'start') AND len(arguments.start)>
				<cfhttpParam name="start" value="#arguments.start#" type="URL"/>
			</cfif>
		</cfhttp>
		<cfif NOT findNocase("200",resultFiles.statuscode) >
			<cfthrow type="repositoryException" message="Error connecting to repository, #resultFiles.statuscode# - #application.settings.REPOSITORY_URL#archivefiles" detail="#resultFiles.toString()#">
		</cfif>
		<cfreturn resultFiles.fileContent.toString()/>
	</cffunction>

	<cffunction name="addImage">
		<cfargument name="image" type="any"/>
		<cfset var local={}/>
		<cfhttp multipart="true" url="#application.settings.REPOSITORY_URL#scans/#image.getScanId()#/images" method="POST" result="local.result">
			<cfhttpParam name="is_default" value="#image.getUseForPublication()#"  type="formField"/>
			<cfhttpparam type="File" name="file" file="#image.getFileLocation()#">
			<cfhttpParam name="user" value="#getUserSessionController().getCurrentUser().getUsername()#" type="formField"/>
		</cfhttp>
		<cfif NOT findNocase("200",local.result.statuscode) >
			<cfthrow type="repositoryException" message="Error connecting to repository, #local.result.statuscode# - #application.settings.REPOSITORY_URL#scans/#image.getScanId()#/images" detail="#local.result.toString()#">
		</cfif>
		<cfreturn local.result.fileContent.toString()/>
	</cffunction>

	<cffunction name="removeImage">
		<cfargument name="image" type="any"/>
		<cfset var local={}/>
		<cfhttp url="#application.settings.REPOSITORY_URL#scans/#image.getScanId()#/images/#image.getId()#" method="DELETE" result="local.result">
			<cfhttpParam name="user" value="#getUserSessionController().getCurrentUser().getUsername()#" type="url"/>
		</cfhttp>
		<cfif NOT findNocase("200",local.result.statuscode) >
			<cfthrow type="repositoryException" message="Error connecting to repository, #local.result.statuscode# - #application.settings.REPOSITORY_URL#scans/#image.getScanId()#/images/#image.getId()#" detail="#local.result.toString()#">
		</cfif>
		<cfreturn local.result.fileContent.toString()/>
	</cffunction>

	<cffunction name="updateImage">
		<cfargument name="image" type="any"/>
		<cfset var local={}/>
		<cfhttp url="#application.settings.REPOSITORY_URL#scans/#image.getScanId()#/images/#image.getId()#" method="POST"  multipart="true" result="local.result">
			<cfif image.hasFileLocation()>
				<cfhttpparam type="File" name="file" file="#image.getFileLocation()#">
			</cfif>
			<cfhttpParam name="is_default" value="#image.getUseForPublication()#"  type="formField"/>
			<cfhttpParam name="user" value="#getUserSessionController().getCurrentUser().getUsername()#" type="formField"/>
		</cfhttp>
		<cfif NOT findNocase("200",local.result.statuscode) >
			<cfthrow type="repositoryException" message="Error connecting to repository, #local.result.statuscode# - #application.settings.REPOSITORY_URL#scans/#image.getScanId()#/images/#image.getId()#" detail="#local.result.toString()#">
		</cfif>
		<cfreturn local.result.fileContent.toString()/>
	</cffunction>

	<cffunction name="getImages">
		<cfargument name="scanId" type="any"/>
		<cfset var local={}/>
		<cfhttp url="#application.settings.REPOSITORY_URL#scans/#scanId#/images" method="GET"  result="local.result">
		</cfhttp>
		<cfif NOT findNocase("200",local.result.statuscode) >
			<cfthrow type="repositoryException" message="Error connecting to repository #local.result.toString()#">
		</cfif>
		<cfreturn local.result.fileContent.toString()/>
	</cffunction>

	<cffunction name="deleteArchiveFileScans" access="public" returntype="string">
		<cfargument name="archiveFile" type="any"/>
		<cfset var local={}/>
		<cfhttp  url="#application.settings.REPOSITORY_URL#utils/delete_scans" method="post" result="local.result">
			<cfhttpParam name="archive_id" value="#archiveFile.archiveID#"  type="formField"/>
			<cfhttpParam name="archiveFile" value="#archiveFile.number#"  type="formField"/>
			<cfhttpParam name="user" value="#getUserSessionController().getCurrentUser().getUsername()#" type="formField"/>
		</cfhttp>
		<cfif NOT findNocase("200",local.result.statuscode) >
			<cfthrow type="repositoryException" message="Error uploading file to repository, #local.result.statuscode# - #application.settings.REPOSITORY_URL#utils/delete_scans" detail="#local.result.toString()#">
		</cfif>
		<cfreturn local.result.fileContent.toString()/>
	</cffunction>

	<cffunction name="publishArchiveFile">
		<cfargument name="archiveFile" type="any"/>
		<cfset var local={}/>
		<cfhttp url="#application.settings.REPOSITORY_URL#archivefiles/#archiveFile.archiveID#/#archiveFile.number#" method="POST" result="local.result">
			<cfhttpParam name="status" value="#archiveFile.statusID#"  type="formField"/>
			<cfhttpParam name="user" value="#getUserSessionController().getCurrentUser().getUsername()#" type="formField"/>
		</cfhttp>
		<cfif NOT findNocase("200",local.result.statuscode) >
			<cfthrow type="repositoryException" message="Error connecting to repository, #local.result.statuscode# - #application.settings.REPOSITORY_URL#archivefiles/#archiveFile.archiveID#/#archiveFile.number#" detail="#local.result.toString()#">
		</cfif>
		<cfreturn local.result.fileContent.toString()/>
	</cffunction>

	<!--- dependencies --->
	<cffunction name="setUserSessionController" returnType="void" access="public" output="false" hint="">
		<cfargument name="userSessionController" type="any" required="true" hint="" />
		<cfset variables.instance.userSessionController=arguments.userSessionController/>
	</cffunction>

	<cffunction name="getUserSessionController" returnType="any" access="public" output="false" hint="">
		<cfreturn variables.instance.userSessionController/>
	</cffunction>

</cfcomponent>