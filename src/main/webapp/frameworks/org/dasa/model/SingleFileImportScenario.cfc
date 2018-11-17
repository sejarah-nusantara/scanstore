<cfcomponent name="SingleFileImportScenario" hint="@see:BaseImportScenario"  
			extends="org.dasa.model.BaseImportScenario" accessors="true">
	<cfproperty name="name" type="string">
	<cfproperty name="id" type="string">
	
	<cfscript>
		variables.name="Single file import";
		variables.id="SingleFile";
		
	</cfscript>
	<cffunction name="checkFilesForConsistency"  acces="private" hint="Checks the files list 
														Condition: the image files in the import folder must all have the same file extention
														@throws : ImportViolationError">
		<cfargument name="files"  type="array">
																	
		<cfscript>
			
			
			if(!hasEqualFileExtentions(files)){
				throw(message="The image files in the import folder must all have the same file extention"
						,type='org.dasa.user.ValidationError'
						,detail="The image files in the import folder must all have the same file extention");
			}
			
			
		
			
		</cfscript>
	
	</cffunction>
	<cffunction name="createScans" returnType="array" access="public" output="false" hint="@see:BaseImportScenario @throws:DirectoryViolationError,FileViolationError ">
		<cfargument name="archiveID" type="string" required="true" hint="" />
		<cfargument name="languageID" type="string" required="true" hint="" />
		<cfargument name="archiveFileID" type="string" required="true" hint="" />
		<cfargument name="type" type="string" required="true" hint="" />
		<cfargument name="title" type="string" required="true" hint="" />
			<cfscript>
			var local = {};
			local.pageScans = [];
			local.files = getFilesFromImportLocation();
			checkFilesForConsistency(local.files);
			//generic metadata
			local.pagescanData=arguments;
			local.pagescanData.number=0;
			//loop over unpackedfiles
			for(local.i=0 ; local.i < local.files.size() ; local.i++){
				
				local.pagescanData.images = [];
				local.file = {};
				local.file.ID=1;
				local.file.fileLocation = variables.importLocation & "/" & local.files.get(local.i);
				local.file.originalFileName = local.files.get(local.i);
				local.pagescanData.images.add(local.file);
				local.pageScan=getPageScanFactory().createPageScanFromStruct(local.pagescanData);
				local.pageScans.add(local.pageScan);
			}
				return local.pageScans;
			</cfscript>
	</cffunction>
	<cffunction name="hasEqualFileExtentions">
	<cfargument name="files">
		<cfscript>
			var local ={};
			local.acceptedFilesConfig = getAcceptedFilesConfig();
			local.TIFFExtentions 	= 	local.acceptedFilesConfig.fileExtentions.TIF;
			local.JPGExtentions 	= 	local.acceptedFilesConfig.fileExtentions.JPG;
			local.tiffFiles = collectFilesWithextention(local.TIFFExtentions,files);
			local.jpgFiles 	= collectFilesWithextention(local.JPGExtentions,files);
			if(local.tiffFiles.size() > 0 && files.size() != local.tiffFiles.size()){
				return false;
			}
			if(local.jpgFiles.size() > 0 && files.size() != local.jpgFiles.size()){
				return false;
			}
			return true;
		</cfscript>
	</cffunction>
	
	
	
</cfcomponent>