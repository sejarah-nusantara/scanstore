<cfcomponent extends="com.silkunion.Object">

	<cffunction name="getUploadLog"  returntype="org.dasa.model.UploadLog">
		<cfscript>
			if(!structKeyexists(request,'uploadLog')){
				request.uploadLog=createObject('component','org.dasa.model.UploadLog');
				return request.uploadLog;
			} else {
				return request.uploadLog;
			}
		</cfscript>
	</cffunction>

</cfcomponent>