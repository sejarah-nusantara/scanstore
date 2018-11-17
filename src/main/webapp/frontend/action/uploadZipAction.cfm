<cfscript>
	controller = createObject('component','remote.RemoteScanstoreController');
	result = controller.uploadZipFile();
</cfscript>
<!---
if an error occured the erroadvisor returns an message struct
					local.result['success']=false;
					local.result['message']="A system error occurred while processing your request. Please contact technical support";
					local.result['type']="org.dasa.system.Error";
 --->
<cfif isSimplevalue(result)>
	<cfoutput>
		{
		    "success":true,
		    "message":"Upload successful",
		    "data":{
		    	"importDirectory":"#result#",
			}
		}
	</cfoutput>
<cfelse>
	<cfoutput>#serializeJson(result)#</cfoutput>
</cfif>