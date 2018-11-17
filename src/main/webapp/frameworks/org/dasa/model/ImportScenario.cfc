<cfinterface displayname="ImportScenario" hint="" >

	
	<cffunction name="createScans" returnType="array" access="public" output="false" hint="">
		<cfargument name="archiveID" type="string" required="true" hint="" />
		<cfargument name="languageID" type="string" required="true" hint="" />
		<cfargument name="archiveFileID" type="string" required="true" hint="" />
		<cfargument name="type" type="string" required="true" hint="" />
		<cfargument name="title" type="string" required="true" hint="" />

	</cffunction>
	
</cfinterface>