<cfcomponent output="false" extends="com.silkunion.service.BaseService" hint="responsible for removing and adding images">

	<cffunction name="init">
		<cfargument name="acceptedFilesConfig">
		<cfscript>
			variables.zipMimeTypes = acceptedFilesConfig.zipMimeTypes;
			variables.acceptedImageFiles = acceptedFilesConfig.acceptedImageMimetypes;
			return super.init(argumentCollection=arguments);
		</cfscript>
	</cffunction>

	<cffunction name="getImages">
		<cfargument name="scanId">
		<cfscript>
			var local = {};
			local.images = [];
			local.imageArray = deserializeJson(getRepositoryWebservice().getImages(scanId)).results;
			for(local.i =1 ;local.i <= arrayLen(local.imageArray) ; local.i++){
				local.images.add(getScanImageFactory().createFromStruct(local.imageArray[local.i]));
			}
			return  local.images;
		</cfscript>
	</cffunction>

	<cffunction name="removeImage">
		<cfargument name="image">
		<cfscript>
			var local ={};
			local.result = {};
			getRepositoryWebservice().removeImage(image);
			local.result['success']=true;
			return  local.result;
		</cfscript>
	</cffunction>

	<cffunction name="addImage">
		<cfargument name="scanId">
		<cfargument name="useForPublication" default="false">
		<cfargument name="fileData">
		<cfscript>
			var local = {};
			local.data= {};
			try{
				local.uploadSessionDir=createObject('java','java.util.UUID').randomUUID().toString();
				getFileSystemController().createDirectory(application.settings.UPLOAD_LOCATION);
				local.uploadDir = application.settings.UPLOAD_LOCATION & local.uploadSessionDir & "/";
				getFileSystemController().createDirectory(local.uploadDir);
				try{
					local.fileProperties = getFileSystemController().uploadFile(fileData,local.uploadDir,variables.acceptedImageFiles);
				}catch(any e){
					throw(message=e.message,type='org.dasa.user.ValidationError',detail=e.message);
				}
				local.fileStruct= form;
				local.fileStruct.fileLocation = local.uploadDir & local.fileProperties.SERVERFILE;
				local.fileStruct.originalFileName = local.fileProperties.SERVERFILE;
				local.image = getScanImageFactory().createFromStruct(local.fileStruct);

				local.imageJson = getRepositoryWebservice().addImage(local.image);
				local.imageResult = deserializeJson(local.imageJson);
				local.images = local.imageResult.results;
				for(local.i=1 ; local.i<=arrayLen(local.images) ; local.i++){
					if(structKeyExists(local.images[local.i],"url")){
						local.images[local.i].fileUrl = local.images[local.i].fileUrl = local.images[local.i].url;
					} else {
						local.images[local.i].fileUrl = application.settings.REPOSITORY_URL & "scans/" & local.images[local.i].scan_number & "/images/"  & local.images[local.i].id & "/file";
					}
					local.newImage = getScanImageFactory().createFromStruct(local.images[local.i]);
				}
				getFileSystemController().deleteDirectory(local.uploadDir);
				local.data['success'] = true;
				local.data['message'] = "Upload successfull";
				return local.data;
			}catch(any e){
				getFileSystemController().deleteDirectory(local.uploadDir);
				rethrow;
			}
		</cfscript>
	</cffunction>

	<cffunction name="replaceImage">
		<cfargument name="scanId">
		<cfargument name="Id">
		<cfargument name="userforPublication">
		<cfargument name="fileData" required="false" >
		<cfscript>
			var local = {};
			local.data = {};

			local.fileStruct= arguments;
			if(structKeyExists(form,"fileData") && len(form.fileData) ){
				local.uploadSessionDir=createObject('java','java.util.UUID').randomUUID().toString();
				getFileSystemController().createDirectory(application.settings.UPLOAD_LOCATION);
				local.uploadDir = application.settings.UPLOAD_LOCATION & local.uploadSessionDir & "/";
				getFileSystemController().createDirectory(local.uploadDir);
				local.fileProperties = getFileSystemController().uploadFile(fileData,local.uploadDir,variables.acceptedImageFiles);
				local.fileStruct.fileLocation = local.uploadDir & "/" & local.fileProperties.SERVERFILE;
				local.fileStruct.originalFileName = local.fileProperties.SERVERFILE;
			}

			local.image = getScanImageFactory().createFromStruct(local.fileStruct);
			local.imageJson = getRepositoryWebservice().updateImage(local.image);
			local.imageStruct = deserializeJson(local.imageJson).image;
			if(structKeyExists(local,"uploadDir")){
				getFileSystemController().deleteDirectory(local.uploadDir);
			}

			local.data['success'] = true;
			local.data['message'] = "Upload successfull";
			return local.data;
		</cfscript>
	</cffunction>

	<cffunction name="updateImage">
		<cfargument name="image">
		<cfscript>
			var local = {};
			local.args = {};
			local.args.scanId = image.getScanId();
			local.args.id = image.getId();
			local.args.useForPublication = image.getuseForPublication();
			return replaceImage(argumentCollection= local.args);
		</cfscript>
	</cffunction>

	<!--- dependencies --->

	<cffunction name="getScanImageFactory" returnType="any" access="private" output="false" hint="">
		<cfreturn variables.instance.ScanImageFactory/>
	</cffunction>

	<cffunction name="setScanImageFactory" returnType="void" access="public" output="false" hint="">
		<cfargument name="ScanImageFactory" type="any" required="true" hint="" />
		<cfset variables.instance.ScanImageFactory=arguments.ScanImageFactory/>
	</cffunction>
	<cffunction name="getFileSystemController" returnType="any" access="private" output="false" hint="">

		<cfreturn variables.instance.fileSystemController/>
	</cffunction>

	<cffunction name="setFileSystemController" returnType="void" access="public" output="false" hint="">
		<cfargument name="fileSystemController" type="any" required="true" hint="" />
		<cfset variables.instance.fileSystemController=arguments.fileSystemController/>
	</cffunction>
	<cffunction name="getRepositoryWebservice" returnType="any" access="private" output="false" hint="">

		<cfreturn variables.instance.repositoryWebservice/>
	</cffunction>

	<cffunction name="setRepositoryWebservice" returnType="void" access="public" output="false" hint="">
		<cfargument name="repositoryWebservice" type="any" required="true" hint="" />
		<cfset variables.instance.repositoryWebservice=arguments.repositoryWebservice/>
	</cffunction>
</cfcomponent>