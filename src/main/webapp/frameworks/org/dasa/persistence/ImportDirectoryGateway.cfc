<cfcomponent output="false" extends="com.silkunion.Object">

	<cffunction name="init">
		<cfargument name="importDirectoryFactory" type="com.silkunion.util.IFactory">
		<cfargument name="fileSystemController" type="any">
		<cfargument name="directoryController" type="any">
		<cfargument name="userSessionController" type="any">
		<cfscript>
			return super.init(argumentCollection=arguments) ;
		</cfscript>
	</cffunction>

	<cffunction name="getPendingImports" returntype="struct">
		<cfargument name="start" type="numeric" required="false" default="0"/>
		<cfargument name="limit" type="numeric" required="false" default="#application.settings.PAGESIZE#"/>
		<cfscript>
			var local={};
			local.folderData={};
			local.folderData.importDirs = [];
			local.folderData.totalCount = 0;
			local.pageSize = limit;
			local.end = start + local.pageSize;
			local.startPos = start + 1;
			local.user = variables.instance.userSessionController.getCurrentuser();
			local.importLocation =  application.settings.UPLOAD_LOCATION & local.user.getInstitutionID();
			local.importFolders = variables.instance.fileSystemController.list(directory=local.importLocation,recurse=false,excludeHidden=true,sort='DATELASTMODIFIED desc');
			local.folderData.totalCount = local.importFolders.recordCount;
			if(local.end > local.importFolders.recordcount){
				local.end = local.importFolders.recordcount;
			}
			for(local.i = local.startPos ;local.i <= local.end; local.i++){
				local.info = variables.instance.fileSystemController.info(local.importLocation&"/"&local.importFolders.name[local.i]);
				if(local.info.TYPE == "directory"){
					local.args={};
					local.args.directoryName 	= 	local.info.NAME;
					local.args.directoryPath  	= 	local.importLocation & "/";
					local.args.creationDate  	= 	dateFormat(local.info.lastmodified,"YYYY-MM-DD") & " " & timeformat(local.info.lastmodified,"HH:MM:SS");
					local.args.isProcessing		=	variables.instance.directoryController.directoryIsLocked(local.args.directoryPath & local.args.directoryName);
					local.folderData.importDirs.add(
						variables.instance.importDirectoryFactory.create("baseImportDirectory",local.args)
					);
				}
			}
			return local.folderData;
		</cfscript>
	</cffunction>

	<cffunction name="getImportByName" returntype="org.dasa.model.ImportDirectory">
		<cfargument name="directoryName" type="String">
		<cfscript>
			var local={};
			local.user = variables.instance.userSessionController.getCurrentuser();
			local.importLocation =  application.settings.UPLOAD_LOCATION & local.user.getInstitutionID();
			local.info = variables.instance.fileSystemController.info(local.importLocation&"/"&directoryName);
			if(local.info.TYPE == "directory"){
				local.args={};
				local.args.directoryName 	= 	local.info.NAME;
				local.args.directoryPath  	= 	local.importLocation & "/";
				local.args.creationDate  	= 	dateFormat(local.info.lastmodified,"YYYY-MM-DD") & " " & timeformat(local.info.lastmodified,"HH:MM:SS");
				local.args.isProcessing		=	variables.instance.directoryController.directoryIsLocked(local.args.directoryPath & local.args.directoryName);
				local.importDirectory = variables.instance.importDirectoryFactory.create("importDirectory",local.args);
			}
			return local.importDirectory;
		</cfscript>
	</cffunction>

	<cffunction name="getImportById" returntype="org.dasa.model.ImportDirectory">
		<cfargument name="id" type="String">
		<cfscript>
			return getImportByName(toString(toBinary(id)));
		</cfscript>
	</cffunction>

</cfcomponent>