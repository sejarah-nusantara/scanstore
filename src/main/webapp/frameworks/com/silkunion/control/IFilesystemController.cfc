<!---
	Version: $Id: IFilesystemController.cfc 15230 2010-03-16 15:44:13Z micdur $
--->
<cfinterface  hint="Interface for filesystem controller" >

	
	<cffunction name="fileCheck" access="public" output="false" returntype="boolean">
	 	<cfargument name="ext" type="String" required="true" />
	 	<cfargument name="acceptedfiles" type="String" required="true" />
	 	
	 </cffunction>
	<cffunction name="uploadFile" access="public" output="false" returntype="struct">
		<cfargument name="filedata" type="string" required="true" />
		<cfargument name="destinationpath" type="string" required="true" />
		<cfargument name="accept" type="string" required="false"  hint="list of mimetypes" />
	</cffunction>
	<cffunction name="uploadFileChunk" access="public" output="false" returntype="array">
		<cfargument name="destinationpath" type="string" required="true" />
	</cffunction>
	<cffunction name="deleteFile" access="public" output="false" returntype="boolean">
	 	<cfargument name="destinationfile" type="string" required="true" />
	 	
	 </cffunction>
	
	
	<cffunction name="createFile" returnType="void" access="public" output="false" hint="">
		<cfargument name="fileName" type="string" required="true" hint="" />
		<cfargument name="filePath" type="string" required="true" hint="" />
		<cfargument name="fileContent" type="any" required="true" hint="" />
		
	</cffunction>
	
	
	<cffunction name="readFile" returnType="any" access="public" output="false" hint="">
		<cfargument name="file" type="string" required="true" hint="" />
		
	</cffunction>
	<cffunction name="readFileAsBinary" returnType="any" access="public" output="false" hint="">
		<cfargument name="file" type="string" required="true" hint="" />
		
	</cffunction>

	 <cffunction name="moveFile" access="public" output="false" returntype="Boolean">
	 	<cfargument name="sourcepath" type="string" required="true" />
	 	<cfargument name="destinationpath" type="string" required="true" />
	 	
	 </cffunction>
	<cffunction name="copyFile" returnType="void" access="public" output="false" hint="">
		<cfargument name="target" type="string" required="true" hint="" />
		<cfargument name="destination" type="string" required="true" hint="" />
		<cfargument name="fileName" type="string" required="true" hint="" />
		
	</cffunction>
	<cffunction name="createDirectory" returnType="void" access="public" output="false" hint="">
		<cfargument name="directory" type="string" required="true" hint="" />
		
	</cffunction>
	
	
	
	 <cffunction name="moveDirectory" access="public" output="false" returntype="boolean">
	 	<cfargument name="sourcepath" type="string" required="true" />
	 	<cfargument name="destinationpath" type="string" required="true" />
	 	
	 	
	 	
	 </cffunction>
	 <cffunction name="renameDirectory" access="public" output="false" returntype="boolean">
	 	<cfargument name="oldfolder" type="string" required="true" />
	 	<cfargument name="newfolder" type="string" required="true" />
	 	
	 </cffunction>
	 <cffunction name="list" returntype="Query" >
		 <cfargument name="directory" type="string">
		 <cfargument name="filetypes" type="string" required="false" hint="list of fileExtentions">
		<cfargument name="recurse" type="boolean" required="false" hint="recurse true false" default="true">
		 <cfargument name="excludeHidden" type="boolean" required="false" hint="excludehiddeen true false" default="false">
		<cfargument name="sort" type="string" required="false" default="DATELASTMODIFIED desc">
	</cffunction>
	 
	
	
	
	
	<cffunction name="deleteDirectory" returnType="boolean" access="public" output="false" hint="">
		<cfargument name="directory" type="string" required="true" hint="" />
		
	</cffunction>
	
</cfinterface>