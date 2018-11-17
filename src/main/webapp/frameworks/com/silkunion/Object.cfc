<cfcomponent>

	<cfscript>
		this.objectSerial = createObject('java','java.util.UUID').randomUUID().toString();
	</cfscript>

	<cffunction name="init" returntype="com.silkunion.Object">
			<cfscript>
			variables.instance=arguments;

			return this;
		</cfscript>
	</cffunction>

	<cffunction name="getResultObject" access="public" output="false"  returntype="any">
		<cfif not structkeyExists(request,'resultObject')>
				<cfset request.resultObject=createObject('component','com.silkunion.service.response.ResultObject')>
		</cfif>
		<cfreturn request.resultObject/>
	</cffunction>

	<cffunction name="doesExtend" access="public" returntype="Boolean" output="false">
	 	<cfargument name="object" type="any" required="true"/>
	  	<cfargument name="requiredType" type="string" required="true" />
	  	<cfscript>
			var metadata = getMetaData(object);

			if (metadata.name eq requiredType) {
				return true;
			}

			while(structKeyExists(metadata, "extends")) {
				metadata = metadata.extends;
				if (metadata.name eq requiredType) {
					return true;
				}
			}

			return false;
		</cfscript>
	</cffunction>

	<cffunction name="doesImplement" access="public" output="false"  returntype="boolean">
		<cfargument name="object"  type="WEB-INF.cftags.component"/>
		<cfargument name="interfaceName"  type="string"/>
		<cfscript>
				var md=getMetaData(arguments.object);
				var impl="";
				var ext="";
				var extends="";
				if(structKeyExists(md,'IMPLEMENTS')){
					for(impl in md.implements){
							//logText(impl);
							if(arguments.interfaceName == impl){
								return true;
							}
						}
				}
				/* lookup the extends hierarchy to see if super classes implements interface*/
				while(structKeyExists(md,'extends')){
					if(structKeyExists(md,'IMPLEMENTS')){
						for(impl in md.implements){
							//logText(impl);
							if(arguments.interfaceName == impl){
								return true;
							}
						}
					}
					md = md.extends;
				}
				return false;
		</cfscript>
	</cffunction>

	<cffunction name="dumpVar" access="public" output="false"  returntype="void">
		<cfargument name="var" type="any"/>
		<cfdump var="#var#">
		<cfabort>
	</cffunction>

	<cffunction name="logText" access="public" output="false"  returntype="void">
		<cfargument name="message" type="string"/>
		<cfargument name="logFile" type="string" required="false">
		<cfif isdefined("arguments.logFile")>
			<cflog text="#message#" file="#logFile#"/>
			<cfelse>
			<cflog text="#message#" />
		</cfif>
	</cffunction>

</cfcomponent>