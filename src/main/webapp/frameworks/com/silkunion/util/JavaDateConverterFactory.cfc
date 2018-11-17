<cfcomponent output="false" extends="com.silkunion.Object" >
	<cffunction name="init">
		<cfset super.init(argumentCollection=arguments)>
		<cfreturn this/>
	</cffunction>
	
	<cffunction name="getObject" access="public">
		<cfargument name="mask"		type="string"	required="true">
		<cfargument name="language"	type="string"	required="true">
		<cfargument name="country"	type="string"	required="true">
		<cfargument name="lenient"	type="boolean"	default="true" hint="Set to false to make date string validation strict.">		
		<cfscript>
			var locale 			= createObject('java','java.util.Locale').init(language,country);
			var dateFormatObj	= createObject('java','java.text.SimpleDateFormat').init(mask,locale);
			dateFormatObj.setLenient(lenient);
			
			return dateFormatObj;
		</cfscript>
		
	</cffunction>
	
</cfcomponent>