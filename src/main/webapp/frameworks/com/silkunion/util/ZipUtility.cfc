<cfcomponent name="ZipUtility" hint="" >

	
	<cffunction name="unpackFile" returnType="string" access="public" output="false" hint="">
		<cfargument name="sourcePath" type="string" required="true" hint="" />
		<cfargument name="destinationPath" type="string" required="true" hint="" />
		<cfzip action="unzip"  file="#arguments.sourcePath#" destination="#arguments.destinationPath#"  />
		
		
		<!---<cfthrow type="ZipUtility.unimplementedMethod" message="Method unpackFile() in component ZipUtility not implemented yet." />--->
	</cffunction>
	
	<cffunction name="createZipFile" returnType="void" access="public" output="false" hint="">
		<cfargument name="sourcePath" type="string" required="true" hint="" />
		<cfargument name="destinationPath" type="string" required="true" hint="" />
		
		<cfzip action="zip" source="#arguments.sourcePath#"
					file="#arguments.destinationPath#"/>
		<!---<cfthrow type="ZipUtility.unimplementedMethod" message="Method createZipFile() in component ZipUtility not implemented yet." />--->
	</cffunction>
	
</cfcomponent>