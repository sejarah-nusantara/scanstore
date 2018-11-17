<cfscript>
	controller=createObject('component','remote.RemoteScanstoreController');
	service = createObject('component','remote.RemoteScanImportService');
	result = controller.uploadZipFile();
	message = "Upload successfull";
	if(isSimplevalue(result) AND result neq "N/A"){
		form.importDirectory = result;
		service.sendScanImportToRepository(argumentCollection=form);
		message = "Upload and import successful";
	}
</cfscript>
<cfif isSimplevalue(result)>
<cfoutput>
	{
	    "success":true,
	    "message":"#replace(message,"""","\""")#",
	    "data":{
	    	"importDirectory":"#result#",
		}
	}
</cfoutput>
<cfelse>
	<cfoutput>#serializeJson(result)#</cfoutput>
</cfif>