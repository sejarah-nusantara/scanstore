<cfcomponent  displayname="ArchiveComparator"
			implements="com.silkunion.util.IComparable" >
	<cffunction name="compareValues" returntype="numeric">
		<cfargument name="object" type="any">
		<cfargument name="otherObject" type="any">
		<cfscript>
			if(object.number GT otherObject.number){
				return 1;
			}else if(object.number EQ otherObject.number){
				return 0;
			
			}else{
				return -1;
			}
			
		</cfscript>
		
	</cffunction>
</cfcomponent>
	