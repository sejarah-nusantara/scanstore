<cfcomponent displayname="DirectoryController" output="false"
			hint="Manages files and  directories ensures that
				only one thread can access the directory and files being processed." extends="com.silkunion.Object">

	<!--- ==========================================================================
	PROPERTIES
	=========================================================================== --->

	<cfscript>
		variables.fileSystemController = '';
		logText("Directory manager created: #now()#");
	</cfscript>

	<!--- ==========================================================================
	CONSTRUCTOR
	=========================================================================== --->

	<cffunction name="init" access="public" returntype="com.silkunion.control.SingleThreadDirectoryController" output="false" hint="Constructor">
		<cfargument name="fileSystemController" type="com.silkunion.control.IFilesystemController" required="true" hint="The utitlity object to use for interacting with the filesystem">
		<cfargument name="acceptedFilesConfig" type="struct" hint="config for restricting the type of files that can be accessed">
		<cfscript>
			setFileSystemController(fileSystemController);
			setAcceptedFilesConfig(acceptedFilesConfig);
			return this;
		</cfscript>
	</cffunction>

	<!--- ==========================================================================
	Public METHODS
	=========================================================================== --->

	<cffunction name="listFilesAvailableForProcessing" access="public" returntype="array" output="false" hint="Returns a list of files ready to be processed. Please note that the files returned are marked as locked for processing until they have been archived by this directory manager and will thus not appear in any subsequent calls to listFilesAvailableForProcessing()">
		<cfargument name="inputDir">
		<cfscript>
			var filesAvailableForProcessing = [];
			var i 							= 0;
			var fileName					= '';
			var filesInInputDir				="";
			var filesBeingProcessed	="";
		</cfscript>
		<!--- We use a named lock to prevent simultaneous access of the 'directoriesBeingProcessed' registry by multiple thread.
		By using the lock we can be confident that a file is never processed twice. --->
		<cflock name="com.silkunion.DirectoryController.filesBeingProcessed" type="exclusive" timeout="10" throwontimeout="true">
			<cfscript>
				/*
				* We loop over all files in the input directory.
				* For all files that are not marked as locked for processing (by previous calls to this method),
				* we add the file name to the resultset returned by this method AND
				* we add the file name to the registry of files being locked for processing to ensure it will not be processed more than once.
				*
				**/
				filesInInputDir = getFilesInInputDir(inputDir);
				filesBeingProcessed	= checkAndCreateInputDirInregistry(inputDir);
				/*
				* 	if there are no files in the directory
					release the directory from the registry and stop
				*/

				if(filesInInputDir.recordcount == 0){
					removeDirectory(inputDir,false);
					return filesAvailableForProcessing;
				}

				for (i = 1; i<= filesInInputDir.RecordCount; i++) {
					fileName = filesInInputDir['name'][i];
					if (NOT StructKeyExists(filesBeingProcessed, fileName)) {
						filesBeingProcessed[fileName] = Now();
						ArrayAppend(filesAvailableForProcessing, fileName);
					}
				}
			</cfscript>
		</cflock>
		<cfscript>
			return filesAvailableForProcessing;
		</cfscript>
	</cffunction>

	<cffunction name="getFile" access="public" returntype="string" output="false" hint="Returns the contents of a file with given name from the input directory.">
		<cfargument name="fileName" type="string" required="true" hint="The name of the file to get contents from.">
		<cfargument name="inputDir">
		<cfscript>
			var fileSystemController	= getFileSystemController();
			var filesBeingProcessed		= {};
			/*
			* For the sake of defensive programming, we check if the requested file has been locked for processing before returning the file contents.
			**/
			verifyFileAccess(fileName,inputDir, 'read');
			return fileSystemController.readFile(inputDir & '/' & fileName);
		</cfscript>
	</cffunction>

	<cffunction name="removeFile" access="public" returntype="void" output="false" hint="Unlocks and removes a file after it has been processed. If the processedSuccessful flag is true the file is removed form the file system if the flag is false it't only removed from the set">
		<cfargument name="fileName" type="string" required="true" hint="The name of the file to archive.">
		<cfargument name="inputDir" type="string" required="true" hint="The name of the directory to process.">
		<cfargument name="processedSuccessful" type="boolean" required="true" hint="True if the file was processed successfully; false if the file was processed unsuccessfully.">
		<cfscript>
			var fileSystemController	= 	getFileSystemController();
			var filesBeingProcessed		=	checkAndCreateInputDirInregistry(inputDir);
			/*
			* For the sake of defensive programming, we check if the requested file has been locked for processing before archiving it.
			**/
			verifyFileAccess(fileName,inputDir, 'delete');
		</cfscript>
		<cflock name="com.silkunion.DirectoryController.filesBeingProcessed" type="exclusive" timeout="10" throwontimeout="true">
			<cfscript>
				if(processedSuccessful){
					fileSystemController.deleteFile(inputDir & '/' & fileName);
				}
				StructDelete(filesBeingProcessed, fileName);
			</cfscript>
		</cflock>
	</cffunction>

	<cffunction name="removeDirectory" access="public" returntype="void" output="false" hint="unlocks a directory after it has been processed. If the processedSuccessful flag is true the directory is removed from the file system if the flag is false it't only removed from the set">
		<cfargument name="inputDir" type="string" required="true" hint="The name of the directory to process.">
		<cfargument name="processedSuccessful" type="boolean" required="true" hint="True if the directory was processed successfully; false if the directory was processed unsuccessfully.">
		<cfscript>
			var fileSystemController	= getFileSystemController();
			/*
			* For the sake of defensive programming, we check if the requested directory has been locked for processing before archiving it.
			**/
			verifyDirectoryAccess(inputDir, 'delete');
		</cfscript>
		<cflock name="com.silkunion.DirectoryController.filesBeingProcessed" type="exclusive" timeout="10" throwontimeout="true">
			<cfscript>
				if(processedSuccessful){
					fileSystemController.deleteDirectory(inputDir );
				}
				StructDelete(getDirectoriesBeingProcessed(), inputDir);
			</cfscript>
		</cflock>
	</cffunction>

	<cffunction name="directoryIsLocked" access="public" returntype="boolean" output="false" hint="check to see if a directory is loccked for processing">
		<cfargument name="inputDir" type="string" required="true" hint="The name of the directory to process.">
		<cflock name="com.silkunion.DirectoryController.filesBeingProcessed" type="exclusive" timeout="10" throwontimeout="true">
			<cfscript>
				return structkeyExists(getDirectoriesBeingProcessed(),inputDir);
			</cfscript>
		</cflock>
	</cffunction>

	<!--- ==========================================================================
	PRIVATE METHODS
	=========================================================================== --->

	<cffunction name="checkAndCreateInputDirInregistry" returntype="struct" acess="private">
		<cfargument name="inputDir" type="string" required="true" hint="The name of the directory to process.">
		<cfscript>
			var directories= getDirectoriesBeingProcessed();
				if(!structkeyExists(directories,inputDir)){
					directories[inputDir]={};
				}
				return directories[inputDir];
		</cfscript>
	</cffunction>
	<cffunction name="verifyDirectoryAccess" access="private" returntype="void" output="false" hint="Verifies if the specified action is allowed for given file. Throws an IllegalAccessException if the action is not allowed.">
		<cfargument name="inputDir" 		type="string" required="true" hint="The name of the directory to verify access for.">
		<cfargument name="attemptedAction" 	type="string" required="true" hint="The type of access action to attempt on the file.">
		<cfscript>
			/*
			* For a file to be legally accessed, it MUST have been locked for processing.
			* This happens when a file is retrieved in the resultset of the listFilesAvailableForProcessing() method.
			*/
		</cfscript>
		<cflock name="com.silkunion.DirectoryController.filesBeingProcessed" type="exclusive" timeout="10" throwontimeout="true">
			<cfscript>

				if (NOT StructKeyExists(getDirectoriesBeingProcessed(), inputDir)) {
					throwIllegalAccessException(inputDir, attemptedAction);
				}
			</cfscript>
		</cflock>
	</cffunction>

	<cffunction name="verifyFileAccess" access="private" returntype="void" output="false" hint="Verifies if the specified action is allowed for given file. Throws an IllegalFileAccessException if the action is not allowed.">
		<cfargument name="fileName" 		type="string" required="true" hint="The name of the file to verify access for.">
		<cfargument name="inputDir" 		type="string" required="true" hint="The name of the directory to verify access for.">
		<cfargument name="attemptedAction" 	type="string" required="true" hint="The type of access action to attempt on the file.">
		<cfscript>
			var filesBeingProcessed = {};
			/*
			* For a file to be legally accessed, it MUST have been locked for processing.
			* This happens when a file is retrieved in the resultset of the listFilesAvailableForProcessing() method.
			*/
		</cfscript>
		<cflock name="com.silkunion.DirectoryController.filesBeingProcessed" type="exclusive" timeout="10" throwontimeout="true">
			<cfscript>
				filesBeingProcessed = checkAndCreateInputDirInregistry(inputDir);
				if (NOT StructKeyExists(filesBeingProcessed, fileName)) {
					throwIllegalAccessException(fileName, attemptedAction);
				}
			</cfscript>
		</cflock>
	</cffunction>

	<cffunction name="throwIllegalAccessException" access="private" returntype="void" output="false" hint="Throws an IllegalFileAccessException">
		<cfargument name="object" type="string" required="true" hint="The name of the file or directory for which illegal access was attempted.">
		<cfargument name="attemptedAction" type="string" required="true" hint="The type of access action that was attempted on the file or directory.">
		<cfthrow
			type="IllegalFileAccess"
			message="You have attempted to perform the action '#attemptedAction#' on '#object#', which is not locked for processing"
			detail="You must use the listFilesAvailableForProcessing() method to retrieve a list of files that may be processed.
					When a file is retrieved by that method, is is marked as locked for processing, so that it will not appear
					in the resultset of subsequent calls to listAvailableFilesForProcessing, thus ensuring that a file is never processed twice."
			>
	</cffunction>

	<cffunction name="getFilesInInputDir" access="private" returntype="query" output="false" hint="Returns a recordset of files, currenty present in the input directory.">
		<cfargument name="inputDir">
		<cfscript>
			var acceptedFilesConfig= getAcceptedFilesConfig();
			var fileSystemController	= getFileSystemController();
			return fileSystemController.list(
				directory=inputDir,
				filetypes=acceptedFilesConfig.acceptedImageFiles,
				recurse=false,
				excludeHidden=true,
				sort="NAME asc"
			);
		</cfscript>
	</cffunction>

	<!--- ==========================================================================
	GETTERS AND SETTERS
	=========================================================================== --->

	<cffunction name="getDirectoriesBeingProcessed" access="private" returntype="struct" output="false" hint="Returns a registry of directories that are currently marked as locked for processing">
		<cfscript>
			return application.directoriesBeingProcessed;
		</cfscript>
	</cffunction>

	<cffunction name="getfileSystemController" access="private" returntype="com.silkunion.control.IFilesystemController" output="false" hint="Returns The utitlity object to use for interacting with the filesystem">
		<cfscript>
			return variables.fileSystemController;
		</cfscript>
	</cffunction>

	<cffunction name="setfileSystemController" access="private" returntype="void" output="false" hint="Sets The utitlity object to use for interacting with the filesystem">
		<cfargument name="fileSystemController" type="com.silkunion.control.IFilesystemController" required="true" hint="The utitlity object to use for interacting with the filesystem">
		<cfscript>
			variables.fileSystemController = fileSystemController;
		</cfscript>
	</cffunction>

	<cffunction name="getAcceptedFilesConfig" returnType="struct" access="private" output="false" hint="">
		<cfreturn variables.instance.acceptedFilesConfig/>
	</cffunction>

	<cffunction name="setAcceptedFilesConfig" returnType="void" access="private" output="false" hint="">
		<cfargument name="acceptedFilesConfig" type="struct" required="true" hint="" />
		<cfset variables.instance.acceptedFilesConfig=arguments.acceptedFilesConfig/>
	</cffunction>

</cfcomponent>