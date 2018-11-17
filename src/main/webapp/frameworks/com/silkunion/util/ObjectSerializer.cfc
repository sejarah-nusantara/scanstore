<!---
	Version: $Id: ObjectSerializer.cfc 15232 2010-03-16 15:45:21Z micdur $
--->
<cfcomponent output="false">
	<cfscript>
		variables.instance={};
		
	</cfscript>
	<cffunction name="init"  returntype="com.silkunion.util.ObjectSerializer">
		<cfargument name="filePath" >
		<cfscript>
			variables.instance.filePath=arguments.filePath;
			return this;
		</cfscript>
	
	</cffunction>
	<cffunction  name="serializeObject">
		<cfargument name="obj" type="any">
		<cfscript>
			var local={};
			local.fileOut = CreateObject("java", "java.io.FileOutputStream");
			local.fileOut.init(getFilePath());
			local.objOut=CreateObject("java", "java.io.ObjectOutputStream");
			local.objOut.init(local.fileOut);
			local.objOut.writeObject(obj);
			local.objOut.close();	
		</cfscript>
	</cffunction>
	<cffunction  name="deSerializeObject" returntype="any">
		<cfscript>
			var local={};
			local.fileIn = CreateObject("java", "java.io.FileInputStream");
			local.fileIn.init(getFilePath());
			local.objIn=CreateObject("java", "java.io.ObjectInputStream");
			local.objIn.init(local.fileIn);
			local.newCFCInstance = local.objIn.readObject();
			local.objIn.close();
			return local.newCFCInstance;	
		</cfscript>
	</cffunction>
	<cffunction name="getFilePath" returntype="string">
		<cfreturn 	variables.instance.filePath>
	</cffunction>
</cfcomponent>