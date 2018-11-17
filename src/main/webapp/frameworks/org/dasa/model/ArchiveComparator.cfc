<cfcomponent  displayname="ArchiveComparator"
			implements="com.silkunion.util.IComparable" >
	<cffunction name="compareValues" returntype="numeric">
		<cfargument name="object" type="any">
		<cfargument name="otherObject" type="any">
		<cfscript>
		
			return compareNocase(object.name,otherObject.name);
		</cfscript>
		
	</cffunction>
</cfcomponent>
	