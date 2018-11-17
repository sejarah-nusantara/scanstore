<cfcomponent name="BaseImportScenario"
			extends="com.silkunion.model.BaseBusinessNoOrmObjectImpl"
				hint="This class is responsible for creating an array of scan objects"
			implements="org.dasa.model.ImportScenario" accessors="true">
	<cfscript>
		variables.name = null;
		variables.id = null;
		variables.importLocation = null;
	</cfscript>

	<cffunction name="init">
		<cfargument name="importLocation" hint="full path to the selected pending import folder selected">
		<cfscript>
			variables.importLocation = arguments.importLocation;
			return this;
		</cfscript>
	</cffunction>

	<cffunction name="createScans" returnType="array" access="public" output="false" hint="absctract method:
				 import scenario this method creates an array of pageScan Objects
				 	the exact implementation is delegated to subclasses">

		<cfargument name="archiveID" type="string" required="true" hint="archive metadata metadata passed to each scan object in the import" />
		<cfargument name="languageID" type="string" required="true" hint="language metadata metadata passed to each scan object in the import" />
		<cfargument name="archiveFileID" type="string" required="true" hint="archive file metadata passed to each scan object in the import" />
		<cfargument name="type" type="string" required="true" hint="type metadata passed to each scan object in the import" />
		<cfargument name="title" type="string" required="true" hint="title metadata passed to each scan object in the import" />
			<cfthrow type="abstractmethod" message="method is abstract and must be overrridden">
	</cffunction>

	<cffunction name="getFilesFromImportLocation" returnType="array" access="private" output="false" hint="@throws:DirectoryViolationError,FileViolationError">
		<cfscript>
			var files =[];
			//prevent 2 threads using the same directory
			if(getDirectoryController().directoryIsLocked(variables.importLocation)){
				throw(message="Directory is locked for processing by another user",type='org.dasa.security.DirectoryViolationError',detail="directory is locked for processing by another user");
			}
			files = getDirectoryController().listFilesAvailableForProcessing(variables.importLocation);
			if(files.size() == 0){
				throw(message="No valid file formats found in import directory or import directory has already been imported",type='org.dasa.user.ValidationError',detail="No valid file formats found in import directory or import directory has already been imported");
			}
			return files;
		</cfscript>
	</cffunction>

	<cffunction name="collectFilesWithextention"  acces="private" hint="Collects files with the same extentions
																			@param :a list of extentions @param: the list of files">

		<cfargument name="extentions" type="string">
		<cfargument name="filesToSearch" type="array">
		<cfscript>
			var local={};
			local.files=[];

				for(local.i=0 ; local.i < filesToSearch.size() ; local.i++){
					local.ext = listLast(filesToSearch.get(local.i),".");
					if(listFind(extentions,local.ext)){
						local.files.add(filesToSearch.get(local.i));
					}
				}
			return local.files;
		</cfscript>
	</cffunction>

	<cffunction name="getDirectoryController" returnType="any" access="private" output="false" hint="">
		<cfreturn variables.instance.directoryController/>
	</cffunction>

	<cffunction name="setDirectoryController" returnType="void" access="public" output="false" hint="">
		<cfargument name="directoryController" type="any" required="true" hint="" />
		<cfset variables.instance.directoryController=arguments.directoryController/>
	</cffunction>

	<cffunction name="getPageScanFactory" returnType="org.dasa.model.IPageScanFactory" access="private" output="false" hint="">
		<cfreturn variables.instance.pageScanFactory/>
	</cffunction>

	<cffunction name="setPageScanFactory" returnType="void" access="public" output="false" hint="">
		<cfargument name="pageScanFactory" type="org.dasa.model.IPageScanFactory" required="true" hint="" />
		<cfset variables.instance.pageScanFactory=arguments.pageScanfactory/>
	</cffunction>

	<cffunction name="getAcceptedFilesConfig" returnType="struct" access="private" output="false" hint="">
		<cfreturn variables.instance.acceptedFilesConfig/>
	</cffunction>

	<cffunction name="setAcceptedFilesConfig" returnType="void" access="public" output="false" hint="">
		<cfargument name="acceptedFilesConfig" type="struct" required="true" hint="" />
		<cfset variables.instance.acceptedFilesConfig=arguments.acceptedFilesConfig />
	</cffunction>

</cfcomponent>
