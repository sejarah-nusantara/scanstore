<cfcomponent name="UploadLog" hint="" extends="com.silkunion.model.BaseBusinessNoOrmObjectImpl">
	
	<cfset variables.instance.stringBuffer = createObject('java','java.lang.StringBuffer') />

	
	<cffunction name="write" returnType="void" access="public" output="false" hint="">
		<cfargument name="message" type="string" required="true" hint="" />
		<cfset variables.instance.stringBuffer.append("<br>#dateFormat(now(),'dd-mm-yyy')# #timeformat(now(),'HH:MM')# #arguments.message#")/>
	</cffunction>

	<cffunction name="getLogAsText" returnType="string" access="public" output="false" hint="">
		<cfreturn variables.instance.stringBuffer.toString() />
	</cffunction>
	
</cfcomponent>