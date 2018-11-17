<cfcomponent extends="org.dasa.model.ScanStoreBaseObject">

	<cffunction name="init">
		<cfargument name="acceptedFilesConfig">
		<cfargument name="userSessionController">
		<cfscript>
			variables.zipMimeTypes = acceptedFilesConfig.zipMimeTypes;
			variables.zipExtentions = acceptedFilesConfig.fileExtentions.ZIP;
			variables.acceptedImageFiles = acceptedFilesConfig.acceptedImageFiles;
			return super.init(argumentCollection=arguments);
		</cfscript>
	</cffunction>

	<cffunction name="searchScans"  returnType="org.dasa.model.SearchResult" access="public" output="false" hint=""  >
		<cfargument name="archiveID" type="string" required="false"/>
		<cfargument name="archiveFileID" type="string" required="false"/>
		<cfargument name="statusID" type="numeric" required="false" />
		<cfargument name="limit" type="numeric" required="false" default="#application.settings.PAGESIZE#"/>
		<cfargument name="start" type="numeric" required="false" default="0"/>
		<cfscript>
			var local={};
			local.searchResult=createObject('component','org.dasa.model.SearchResult');
			local.pageScans=[];
			local.jsonResult=getRepositoryWebservice().searchScans(argumentCollection=arguments);
			local.searchResultJson=deserializeJson(local.jsonResult);
			for(local.i=0; local.i < local.searchResultJson.results.size() ; local.i++){
				local.pageScan=getPageScanFactory().transformPageScanStruct(local.searchResultJson.results.get(local.i));
				local.pageScans.add(local.pageScan);
			}
			local.searchResult.setCollection(local.pageScans);
			local.searchResult.setOffset(arguments.start);
			local.searchResult.setCount(local.searchResultJson.total_results);
			return local.searchResult;
		</cfscript>
	</cffunction>

	<cffunction name="getScan" returnType="org.dasa.model.PageScan" access="public" output="false" hint="">
		<cfargument name="number" type="numeric">
		<cfscript>
			var local={};
			local.jsonResult=getRepositoryWebservice().getScan(argumentCollection=arguments);
			local.getResult=deserializeJson(local.jsonResult);
			local.pageScan=getPageScanFactory().createPageScanFromStruct(local.getResult);
			return local.pageScan;
		</cfscript>
	</cffunction>

	<cffunction name="updateScan" returnType="org.dasa.model.PageScan" access="public" output="false" hint="">
		<cfargument name="pageScan" type="any">
		<cfscript>
			var local={};
			local.jsonResult = getRepositoryWebservice().updateScan(argumentCollection=arguments);

			local.getResult = deserializeJson(local.jsonResult);
			if(structKeyExists(local.getResult,"errors")){
				handleErrors(local.getResult.errors);
			}
			local.pageScan = getPageScanFactory().createPageScanFromStruct(local.getResult);
			local.newSequence = arguments.pageScan.getSequenceNumber();
			local.oldSequence = local.pageScan.getSequenceNumber();
			if(local.newSequence gt 0 && local.newSequence != oldSequence){
				local.parentSequence = local.newSequence;
				if(local.oldSequence > local.newSequence){
					local.parentSequence--;
				}
				getRepositoryWebservice().moveScan(number = arguments.pageScan.getNumber(), after = local.parentSequence);
			}
			return local.pageScan;
		</cfscript>
	</cffunction>

	<cffunction name="updateScans" returnType="org.dasa.model.PageScan[]" access="public" output="false" hint="">
		<cfargument name="pageScans" type="any">
		<cfscript>
			var local={};
			local.result = arrayNew(1);
			for(local.i=1;local.i lte arrayLen(pageScans);local.i++){
				arrayAppend(local.result,updateScan(pagescans[local.i]));
			}
			return local.result;
		</cfscript>
	</cffunction>

	<cffunction name="updateScanImage" returnType="org.dasa.model.PageScan" access="public" output="false" hint="">
		<cfargument name="pageScan" type="any">
		<cfscript>
			var local={};
			local.jsonResult=getRepositoryWebservice().updateScanImage(argumentCollection=arguments);
			local.getResult=deserializeJson(local.jsonResult);
			local.pageScan=getPageScanFactory().createPageScanFromStruct(local.getResult);
			return local.pageScan;
		</cfscript>
	</cffunction>

	<cffunction name="deleteScan" returnType="struct" access="public" output="false" hint="">
		<cfargument name="pageScan" type="any">
		<cfscript>
			var local={};
			getRepositoryWebservice().deleteScan(number=pageScan.getNumber());
			local.data ={};
			local.data.success=true;
			local.data.message="Scan is successfully removed";
			return local.data;
		</cfscript>
	</cffunction>

	<cffunction name="uploadZipFile" returnType="any" access="public" output="false" hint="">
		<cfscript>
			var local={};
			local.requestData = getHTTPRequestData();
			try {
				if(structKeyExists(local.requestData.headers,"X-Form-Action")){
					if(local.requestData.headers["X-Form-Action"] eq "Post"){
						local.uploadSessionPath = getUserSessionController().getUploadPath()&hash("UPLOAD_"&form.filedata_name);
						getFileSystemController().createDirectory(local.uploadSessionPath);
						local.importDir = listFirst(form.filedata_name,".");
						local.importFile = form.filedata_name;
					} else if(local.requestData.headers["X-Form-Action"] eq "File"){
						local.uploadSessionPath = getUserSessionController().getUploadPath()&hash("UPLOAD_"&local.requestData.headers["X-File-Name"]);
						getFileSystemController().createDirectory(local.uploadSessionPath);
						if(!listFindNocase(variables.zipExtentions,listLast(local.requestData.headers["X-File-Name"],"."))){
							throw(message="No valid file zip file format found",type='org.dasa.user.ValidationError',detail="No valid file zip file format found");
						}
						//upload zip file to temp folder
						return getFileSystemController().uploadFileChunk(local.uploadSessionPath);
					} else {
						throw(message="Unknown file upload action",type='org.dasa.user.SystemError',detail="No valid form action in header found");
					}
				} else {
					local.uploadSessionPath = getUserSessionController().getUploadPath()&hash("UPLOAD_"&createUUID());
					getFileSystemController().createDirectory(local.uploadSessionPath);
					//upload zip file to temp folder
					local.fileProperties = getFileSystemController().uploadFile(form.FILEDATA,local.uploadSessionPath);
					if(!listFindNocase(variables.zipExtentions,local.fileProperties.serverFileExt)){
						throw(message="No valid file zip file format found",type='org.dasa.user.ValidationError',detail="No valid file zip file format found");
					}
					local.importDir = local.fileProperties.serverFileName;
					local.importFile = local.fileProperties.serverFile;
				}
				if(structKeyExists(local,"importFile")){
					local.zipExtractPath = getUserSessionController().getUploadPath()&hash("EXTRACT_"&local.importFile);
					getFileSystemController().createDirectory(local.zipExtractPath);
					//extract to temp folder
					getZipUtility().unpackFile(local.uploadSessionPath& "/" &local.importFile,local.zipExtractPath);
					getFileSystemController().deleteDirectory(local.uploadSessionPath);
					local.files = getFileSystemController().list(directory=local.zipExtractPath,filetypes=variables.acceptedImageFiles);
					if(!local.files.recordCount){
						throw(message="No valid file formats found in zip file",type='org.dasa.user.ValidationError',detail="No valid file formats found in zip file");
					}
					local.institutionID = getUserSessionController().getCurrentUser().getInstitutionId();
					local.uploadZipPath = application.settings.UPLOAD_LOCATION & local.institutionID  & "/" & local.importDir;
					if(!directoryExists(local.uploadZipPath)){
						getFileSystemController().moveDirectory(local.zipExtractPath,local.uploadZipPath);
					} else {
						local.folderNumber = 0;
						while(directoryExists(local.uploadZipPath)){
							local.folderNumber++;
							local.uploadZipPath = application.settings.UPLOAD_LOCATION & local.institutionID  & "/" & local.importDir& "_" & local.folderNumber;
						}
						local.importDir = local.importDir & "_" & local.folderNumber;
						getFileSystemController().moveDirectory(local.zipExtractPath,local.uploadZipPath);
					}
					return local.importDir;
				}
			} catch(any e) {
				if(structKeyExists(local,"uploadSessionPath")) getFileSystemController().deleteDirectory(local.uploadSessionPath);
				if(structKeyExists(local,"zipExtractPath")) getFileSystemController().deleteDirectory(local.zipExtractPath);
				rethrow;
			}
		</cfscript>
	</cffunction>

	<cffunction name="importScans" returnType="void" access="public" output="false" hint="">
		<cfargument name="importDirectory" type="any" required="true" hint="the directory object representing the directory on the server the location was made from " />
		<cfargument name="pageScans" type="array" required="true" hint="array of pagescan objects" />
		<cfargument name="metaData" type="struct" required="true" hint="" />
		<cfscript>
			var local={};
			importDirectory.buildImportStartMessage(metaData);
			try{
				for(local.i=0 ; local.i < pageScans.size() ; local.i++){
					try{
						getRepositoryWebservice().uploadScan(pageScans.get(local.i));
						local.images = pageScans.get(local.i).getImages();
						for(local.j = 0 ; local.j < local.images.size() ; local.j++){
							getDirectoryController().removeFile(local.images.get(local.j).getOriginalFileName(),importDirectory.getImportLocation(),true);
							importDirectory.processSuccessfullImport("processed successfully",local.images.get(local.j).getOriginalFileName());
						}
					}catch(any e){
						local.images = pageScans.get(local.i).getImages();
						for(local.j = 0 ; local.j < local.images.size() ; local.j++){
							getDirectoryController().removeFile(local.images.get(local.j).getOriginalFileName(),importDirectory.getImportLocation(),false);
							importDirectory.processUnsuccessfullImport(e.message,local.images.get(local.j).getOriginalFileName());
						}
						rethrow;
					}
				}
				getDirectoryController().removeDirectory(importDirectory.getImportLocation(),false);
			} catch(any e){
				importDirectory.processUnsuccessfullImport(e.message,'');
				getDirectoryController().removeDirectory(importDirectory.getImportLocation(),false);
				rethrow;
			}
		</cfscript>
	</cffunction>

	<cffunction name="moveScan" access="public" returntype="any">
		<cfargument name="pageScan" type="any">
		<cfscript>
			getRepositoryWebservice().moveScan(number = arguments.pageScan.getNumber(), after = (arguments.pageScan.getSequenceNumber()-1));
		</cfscript>
	</cffunction>

	<!--- dependencies --->
	<cffunction name="getDirectoryController" returnType="any" access="public" output="false" hint="">
		<cfreturn variables.instance.directoryController/>
	</cffunction>

	<cffunction name="setDirectoryController" returnType="void" access="public" output="false" hint="">
		<cfargument name="directoryController" type="any" required="true" hint="" />
		<cfset variables.instance.directoryController=arguments.directoryController/>
	</cffunction>

	<cffunction name="getFileSystemController" returnType="any" access="public" output="false" hint="">
		<cfreturn variables.instance.fileSystemController/>
	</cffunction>

	<cffunction name="setFileSystemController" returnType="void" access="public" output="false" hint="">
		<cfargument name="fileSystemController" type="any" required="true" hint="" />
		<cfset variables.instance.fileSystemController=arguments.fileSystemController/>
	</cffunction>

	<cffunction name="getValidationController" returnType="com.silkunion.control.IValidationController" access="public" output="false" hint="">
		<cfreturn variables.instance.validationController/>
	</cffunction>

	<cffunction name="setValidationController" returnType="void" access="public" output="false" hint="">
		<cfargument name="validationController" type="com.silkunion.control.IValidationController" required="true" hint="" />
		<cfset variables.instance.validationController=arguments.validationController/>
	</cffunction>

	<cffunction name="getZipUtility" returnType="any" access="public" output="false" hint="">
		<cfreturn variables.instance.zipUtility/>
	</cffunction>

	<cffunction name="setZipUtility" returnType="void" access="public" output="false" hint="">
		<cfargument name="zipUtility" type="any" required="true" hint="" />
		<cfset variables.instance.zipUtility=arguments.zipUtility/>
	</cffunction>

	<cffunction name="getPageScanFactory" returnType="org.dasa.model.IPageScanFactory" access="public" output="false" hint="">
		<cfreturn variables.instance.pageScanFactory/>
	</cffunction>

	<cffunction name="setPageScanFactory" returnType="void" access="public" output="false" hint="">
		<cfargument name="pageScanFactory" type="org.dasa.model.IPageScanFactory" required="true" hint="" />
		<cfset variables.instance.pageScanFactory=arguments.pageScanfactory/>
	</cffunction>

	<cffunction name="getRepositoryWebservice" returnType="any" access="public" output="false" hint="">
		<cfreturn variables.instance.repositoryWebservice/>
	</cffunction>

	<cffunction name="setRepositoryWebservice" returnType="void" access="public" output="false" hint="">
		<cfargument name="repositoryWebservice" type="any" required="true" hint="" />
		<cfset variables.instance.repositoryWebservice=arguments.repositoryWebservice/>
	</cffunction>

	<cffunction name="getUserSessionController" returnType="any" access="public" output="false" hint="">
		<cfreturn variables.instance.userSessionController/>
	</cffunction>

	<cffunction name="setUserSessionController" returnType="void" access="public" output="false" hint="">
		<cfargument name="userSessionController" type="any" required="true" hint="" />
		<cfset variables.instance.userSessionController=arguments.userSessionController/>
	</cffunction>

	<cffunction name="handleErrors" returnType="void" access="private" output="false" hint="">
		<cfargument name="errorArray" type="array" required="true" hint="" />
		<cfscript>
			var i=0;
			var errors = createObject('java','java.lang.StringBuffer');
			var error = {};
			for(i = 0 ;i < errorArray.size() ; i++){
				error = errorArray.get(i);
				for(item in error){
					errors.append(" #item# :#error[item]#");

				}
			}
		</cfscript>
		<cfthrow type="org.dasa.repository.Exception" message="#errors.toString()#" detail="#errors.toString()#">
	</cffunction>

</cfcomponent>