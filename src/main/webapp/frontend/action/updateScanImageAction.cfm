<cftry>
	<cfscript>
		userSessionController 	= application.beanFactory.getbean('userSessionController');
		stController 			= application.beanFactory.getbean('scanstoreController');
		fileSystemController 	= application.beanFactory.getbean('fileSystemController');
		if(!userSessionController.userIsLoggedIn()){
			throw(message="user is not logged in",type='org.dasa.security.UserAcessViolationError');
		}
		userSessionController.getCurrentUser().userIsAuthorized('updateScan');
		if(isdefined("form.number")){
			if(len(form.fileData)){
				tmpUploadDir = createObject('java','java.util.UUID').randomUUID().toString();
				uploadDir = application.settings.UPLOAD_LOCATION & tmpUploadDir;
				fileProperties = fileSystemController.uploadFile(form.FILEDATA,uploadDir,application.beanFactory.getBean("acceptedFilesConfig").acceptedImageMimetypes);
				form.hiresImage = uploadDir & "/" & fileProperties.SERVERFILE;
			}
			res=stController.getScan(form.number);
			res.populate(form);
			if(len(form.fileData)){
				try{
					stController.updateScanImage(res);
				}catch(any e){
					fileSystemController.deleteDirectory(uploadDir);
					rethrow;
				}
			}else{
				stController.updateScan(res);
			}
			if(isDefined("uploadDir")){
				fileSystemController.deleteDirectory(uploadDir);
			}

		}
		success = true;
		message = "Upload successful";
	</cfscript>
	<cfcatch type="Any">
	<cfscript>
		if(isDefined("uploadDir")){
			fileSystemController.deleteDirectory(uploadDir);
		}
		success = false;
		message = "Server error, "&cfcatch.message&" "&cfcatch.detail;
	</cfscript>
	</cfcatch>
</cftry>
<cfoutput>
	{
	    "success":#success#,
	    "data":{
		    "msg":"#replace(message,"""","\""")#"
		}
	}
</cfoutput>

