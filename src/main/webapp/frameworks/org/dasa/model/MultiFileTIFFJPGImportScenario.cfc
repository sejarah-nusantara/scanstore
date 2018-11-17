<cfcomponent name="MultiFileTIFFJPGImportScenario" hint="@see:BaseImportScenario"  
			extends="org.dasa.model.BaseImportScenario"  accessors="true">
	<cfproperty name="name" type="string">
	<cfproperty name="id" type="string">
	<cfproperty name="useTiffForPublication" type="boolean">
	<cfproperty name="useJPGForPublication" type="boolean">
	<cfscript>
		variables.name="Multi file import (TIFF JPG)";
		variables.id="MultiFileTIFFJPG";
		variables.useTiffForPublication = false;
		variables.useJPGForPublication = true;
	</cfscript>
	
	
	<cffunction name="createScans" returnType="array" access="public" output="false" hint="@see:BaseImportScenario @throws : ImportViolationError">
		<cfargument name="archiveID" type="string" required="true" hint="" />
		<cfargument name="languageID" type="string" required="true" hint="" />
		<cfargument name="archiveFileID" type="string" required="true" hint="" />
		<cfargument name="type" type="string" required="true" hint="" />
		<cfargument name="title" type="string" required="true" hint="" />
			<cfscript>
				var local = {};
				local.pageScans = [];
				local.acceptedFilesConfig = getAcceptedFilesConfig();
				local.files = getFilesFromImportLocation();
				local.tiffFiles = [];
				local.jpgFiles = [];
				local.TIFFExtentions 	= 	local.acceptedFilesConfig.fileExtentions.TIF;
				local.JPGExtentions 	= 	local.acceptedFilesConfig.fileExtentions.JPG;
				checkFilesForConsistency(local.files);
				//generic metadata
				local.pagescanData=arguments;
				local.pagescanData.number=0;
				//collect all tiffs
				local.tiffFiles = collectFilesWithextention(local.TIFFExtentions,local.files);
				//collect all jpgs
				local.jpgFiles 	= collectFilesWithextention(local.JPGExtentions,local.files);
				//loop over the tiff array
				for(local.i= 0 ; local.i < local.tiffFiles.size() ; local.i++){
					local.tiffFileName = listFirst(local.tiffFiles.get(local.i),".");
					local.tiffFile = local.tiffFiles.get(local.i);
					//find corresponding jpg file with the same name
					for(local.j=0 ; local.j < local.jpgFiles.size() ; local.j++){
						local.jpgFileName = listFirst(local.jpgFiles.get(local.j),".");
						if(local.tiffFileName EQ local.jpgFileName){
							local.jpgFile = local.jpgFiles.get(local.j);
							break;
						}
					}
					//if no jpg file is found throw exception
					if(!structkeyExists(local,"jpgFile")){
						throw(message="No jpg file with name : #local.tiffFileName# can be found"
						,type='org.dasa.security.ImportViolationError'
						,detail="No jpg file with name : #local.tiffFileName# can be found");
					
					}
					//now construct pagescan object
					local.pagescanData.images = [];
					local.jpgImage = {};
					local.jpgImage.ID=1;
					local.jpgImage.fileLocation = variables.importLocation & "/" & local.jpgFile;
					local.jpgImage.originalFileName =local.jpgFile;
					local.pagescanData.images.add(local.jpgImage);
					local.tiffImage = {};
					local.tiffImage.ID=2;
					local.tiffImage.fileLocation = variables.importLocation & "/" & local.tiffFile;
					local.tiffImage.originalFileName = local.tiffFile;
					local.pagescanData.images.add(local.tiffImage);
					local.pageScan=getPageScanFactory().createPageScanFromStruct(local.pagescanData);
					local.pageScans.add(local.pageScan);
					
				}
				
				return local.pageScans;
			</cfscript>
	</cffunction>
	
	<cffunction name="checkFilesForConsistency"  acces="private" hint="Checks the files list 
														Condition: there must be an equal number of jpg files and tiff files 
														Condition : there must be Tiff files	
														Condition: there must be jpg files
														@throws : ImportViolationError">
		<cfargument name="files"  type="array">
																	
		<cfscript>
			var local ={};
			local.acceptedFilesConfig = getAcceptedFilesConfig();
			local.TIFFExtentions 	= 	local.acceptedFilesConfig.fileExtentions.TIF;
			local.JPGExtentions 	= 	local.acceptedFilesConfig.fileExtentions.JPG;
			if(!hasFilesOfExtention(local.JPGExtentions,files)){
				throw(message="No JPG files present in import folder"
						,type='org.dasa.user.ValidationError'
						,detail="No JPG files present in import folder");
			}
			if(!hasFilesOfExtention(local.TIFFExtentions ,files)){
				throw(message="No TIFF files present in import folder"
						,type='org.dasa.user.ValidationError'
						,detail="No TIFF files present in import folder");
			}
			if(!hasEqualTIFFANDJPG(local.JPGExtentions , local.TIFFExtentions ,files)){
				throw(message="The amount of TIFF images is not equal to the amount of JPG images in the import Directory"
						,type="org.dasa.user.ValidationError"
						,detail="The amount of TIFF images is not equal to the amount of JPG images in the import Directory");
			
			
			}
			
		
			
		</cfscript>
	
	</cffunction>
	
	<cffunction name="hasFilesOfExtention"  acces="private" returntype="boolean">
		<cfargument name="extentionList"  type="String">
		<cfargument name="files"  type="array">															
		<cfscript>
			var local = {};
			for(local.i=0 ; local.i < files.size() ; local.i++){
				local.ext = listLast(files.get(local.i),".");
				if(listFindNocase(extentionList,local.ext)){
					return true;
				}
			}
			return false;
			
			//	org.dasa.security.ImportViolationError
			
		</cfscript>
	
	</cffunction>
	<cffunction name="hasEqualTIFFANDJPG"  acces="private" returntype="boolean">
		<cfargument name="JPGExtentionList"  type="String">
		<cfargument name="TIFFExtentionList"  type="String">
		<cfargument name="files"  type="array">															
		<cfscript>
			var local = {};
			local.nrJPG = 0; 
			local.nrTIFF = 0; 
			for(local.i=0 ; local.i < files.size() ; local.i++){
				local.ext = listLast(files.get(local.i),".");
				if(listFindNoCase(JPGExtentionList,local.ext)){
					local.nrJPG++;
				}
				if(listFindNoCase(TIFFExtentionList,local.ext)){
					local.nrTIFF++;
				}
			}
			return local.nrTIFF  == local.nrJPG;
		</cfscript>
	
	</cffunction>
</cfcomponent>