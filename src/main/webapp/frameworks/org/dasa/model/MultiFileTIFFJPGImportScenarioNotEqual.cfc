<cfcomponent name="MultiFileTIFFJPGImportScenario" hint="@see:BaseImportScenario"  
			extends="org.dasa.model.MultiFileTIFFJPGImportScenario"  accessors="true">
	<cfproperty name="name" type="string">
	<cfproperty name="id" type="string">
	<cfproperty name="useTiffForPublication" type="boolean">
	<cfproperty name="useJPGForPublication" type="boolean">
	<cfscript>
		variables.name="Multi file import unequal filenames(TIFF JPG)";
		variables.id="MultiFileTIFFJPGUnEqual";
		variables.useTiffForPublication = false;
		variables.useJPGForPublication = true;
	</cfscript>
	
	
	<cffunction name="createScans" returnType="array" access="public" output="false" hint="this scenario assumes 
				the pair wise ordering of tiff and jpg files tiff will be first in the list 
				please note that the ordering is done by filename: @see:BaseImportScenario @throws : ImportViolationError">
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
				//here we assume that the ordering is pair wise tiff jpg so at index i there is a tiff file and at index i+1 there is a jpg file belonging to the same scan object
				local.tifIndex = 0;
				local.jpgIndex = 1;
				while(local.tifIndex < local.files.size()){
					local.tiffFile 	=  local.files.get(local.tifIndex);
					local.jpgFile 	= local.files.get(local.jpgIndex);
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
					//now increase both indexes with 2 
					local.tifIndex += 2;
					local.jpgIndex += 2;
				
				}
				
				
				return local.pageScans;
			</cfscript>
	</cffunction>
	
	
</cfcomponent>