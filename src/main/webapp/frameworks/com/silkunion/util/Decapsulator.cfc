<cfcomponent name="Decapsulator" output="false" displayname="Decapsulator" hint="Dumps the data of a complete data structures including encapsulated object data.">

	<!---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=
		Name:
			Object Decapsulator
		Author:
			M. van Workum
		Version:
			v1.0(jun 2008)
		Summary:
			Dumps the data of a complete data structures including encapsulated object data located in
			the predefined scope. Drop any kind of coldfusion datatype in the dump method and it will return
			all content in a string with HTML code.
		Methods:
			init(scope:String,objectscope:Boolean,objectmeta:Boolean,methodmeta:Boolean,runtime:Boolean,autoexpand:Boolean)
				Contructor method.
			setScope(needs showObjectScope to be true)
				Set scope to be decapsulated within objects.
			showObjectScope(swtch:Boolean)
				Turns object scope dump on or off.
			showObjectMeta(swtch:Boolean)
				Turns object metadata on or off.
			showMethodMeta(swtch:Boolean)
				Turns method (function) metadata on or off.
			showRuntime(swtch:Boolean)
				Turns dump timing on or off.
			setAutoExpand(swtch:Boolean)
				Turns html auto expand on or off.
			dump(object:Any)
				Dumps coldfusion datatypes and decapsulates objects.

	=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=--->

	<cfscript>
		variables.instance = structNew();
		variables.instance.running = structNew();
	</cfscript>

	<cffunction name="init" access="public" returntype="Decapsulator" hint="Contructor method" output="false">
		<cfargument name="scope" type="string" required="false" default="" />
		<cfargument name="objectscope" type="boolean" required="false" default="true" />
		<cfargument name="objectmeta" type="boolean" required="false" default="false" />
		<cfargument name="methodmeta" type="boolean" required="false" default="false" />
		<cfargument name="runtime" type="boolean" required="false" default="false" />
		<cfargument name="autoexpand" type="boolean" required="false" default="false" />
		<cfscript>
			setScope(arguments.scope);
			showObjectScope(arguments.objectscope);
			showObjectMeta(arguments.objectmeta);
			showMethodMeta(arguments.methodmeta);
			showRuntime(arguments.runtime);
			setAutoExpand(arguments.autoexpand);
		</cfscript>
		<cfreturn this />
	</cffunction>

	<cffunction name="setScope" access="public" output="false" displayname="setScope" hint="Set scope to be decapsulated within objects">
		<cfargument name="scope" type="string" required="true" />
		<cfset variables.instance.scope = arguments.scope />
	</cffunction>

	<cffunction name="showObjectScope" access="public" output="false" displayname="showObjectScope" hint="Turns object scope dump on or off">
		<cfargument name="swtch" type="boolean" required="true" />
		<cfset variables.instance.objectScope = arguments.swtch />
	</cffunction>

	<cffunction name="showObjectMeta" access="public" output="false" displayname="showObjectMeta" hint="Turns object metadata on or off">
		<cfargument name="swtch" type="boolean" required="true" />
		<cfset variables.instance.objectMeta = arguments.swtch />
	</cffunction>

	<cffunction name="showMethodMeta" access="public" output="false" displayname="showMethodMeta" hint="Turns method (function) metadata on or off">
		<cfargument name="swtch" type="boolean" required="true" />
		<cfset variables.instance.methodMeta = arguments.swtch />
	</cffunction>

	<cffunction name="showRuntime" access="public" output="false" displayname="showRuntime" hint="Turns dump timing on or off">
		<cfargument name="swtch" type="boolean" required="true" />
		<cfset variables.instance.runtime = arguments.swtch />
	</cffunction>

	<cffunction name="setAutoExpand" access="public" output="false" displayname="autoExpand" hint="Turns html auto expand on or off">
		<cfargument name="swtch" type="boolean" required="true" />
		<cfset variables.instance.autoExpand = arguments.swtch />
	</cffunction>

	<cffunction name="dump" returntype="string" access="public" output="false" displayname="dump" hint="Dumps coldfusion datatypes and decapsulates objects">
		<cfargument name="object" type="any" required="true" />
		<cfscript>
			//var local = structNew();
			local.runID = "DECAP_"&rereplace(createUUID(),"[^A-Z0-9]","","ALL");
			variables.instance.running[local.runID] = arrayNew(1);
			local.decapOut = typeSwitch(arguments.object,local.runID);
			for(local.idx=1;local.idx lte arrayLen(variables.instance.running[local.runID]);local.idx=local.idx+1){
				structDelete(variables.instance.running[local.runID][local.idx],local.runID);
			}
			structDelete(variables.instance.running,local.runID);
		</cfscript>
		<cfsavecontent variable="local.decapsulateResult">
			<cfoutput><style type="text/css"></cfoutput>
				<cfoutput>table.#local.runID# {background-color:##DDDDDD;border:1px solid ##BBBBBB;}</cfoutput>
				<cfoutput>table.#local.runID# tr.i {display:table-row;}</cfoutput>
				<cfoutput>table.#local.runID# tr.n {display:none;}</cfoutput>
				<cfoutput>table.#local.runID# td {font-family:Verdana;font-size:9px;white-space:nowrap;}</cfoutput>
				<cfoutput>table.#local.runID# td.i {font-style:italic;color:##555555;padding-left:6px;padding-right:6px;}</cfoutput>
				<cfoutput>table.#local.runID# td.b {font-weight:bold;padding-left:7px;padding-right:7px;}</cfoutput>
				<cfoutput>table.#local.runID# td.h {width:5%;padding-left:5px;padding-right:5px;}</cfoutput>
				<cfoutput>table.#local.runID# td.p {cursor:pointer;}</cfoutput>
				<cfoutput>table.#local.runID# table {width:100%;}</cfoutput>
				<cfoutput>table.#local.runID# table.o {background-color:##FFBBBB;border:1px solid ##FF4444;}</cfoutput>
				<cfoutput>table.#local.runID# td.o {background-color:##FFDDDD;}</cfoutput>
				<cfoutput>table.#local.runID# table.a {background-color:##BBFFBB;border:1px solid ##44FF44;}</cfoutput>
				<cfoutput>table.#local.runID# td.a {background-color:##DDFFDD;}</cfoutput>
				<cfoutput>table.#local.runID# table.s {background-color:##BBBBFF;border:1px solid ##4444FF;}</cfoutput>
				<cfoutput>table.#local.runID# td.s {background-color:##DDDDFF;}</cfoutput>
				<cfoutput>table.#local.runID# table.q {background-color:##FFBBFF;border:1px solid ##FF44FF;}</cfoutput>
				<cfoutput>table.#local.runID# td.q {background-color:##FFDDFF;}</cfoutput>
				<cfoutput>table.#local.runID# table.m {background-color:##FFDDBB;border:1px solid ##FFAA44;}</cfoutput>
				<cfoutput>table.#local.runID# td.m {background-color:##FFEEDD;}</cfoutput>
				<cfoutput>table.#local.runID# table.v {background-color:##FFFFFF;border:1px solid ##AAAAAA;}</cfoutput>
				<cfoutput>table.#local.runID# table.r {background-color:##EEEEEE;border:1px solid ##BBBBBB;border-bottom:none;}</cfoutput>
			<cfoutput></style></cfoutput>
			<cfoutput><script type="text/javascript"></cfoutput>
				<cfoutput>var #local.runID# = { toggle:function(id){</cfoutput>
						<cfoutput>var e = document.getElementById(id);</cfoutput>
						<cfoutput>e.className = e.className=='i'?'n':'i';</cfoutput>
				<cfoutput>}	}</cfoutput>
			<cfoutput></script></cfoutput>
			<cfoutput><table class="#local.runID#" cellspacing=""1""><tr><td>#local.decapOut#</td></tr></table></cfoutput>
		</cfsavecontent>
		<cfscript>
			return local.decapsulateResult;
		</cfscript>
	</cffunction>

	<cffunction name="injectionMethod" returntype="any" access="private" output="false" displayname="injectionMethod">
		<cfargument name="scope" type="string" required="true" />
		<cfscript>
			if(len(trim(arguments.scope)) is 0){
				return variables;
			} else if(structKeyExists(variables,arguments.scope)){
				return evaluate("variables."&arguments.scope);
			} else {
				return "UNDEFINED SCOPE";
			}
		</cfscript>
	</cffunction>

	<cffunction name="typeSwitch" returntype="string" access="private" output="false" displayname="typeSwitch">
		<cfargument name="object" type="any" required="true" />
		<cfargument name="runID" type="string" required="true" />
		<cfscript>
			//var local = structNew();
			local.decapOut = arrayNew(1);
			if(variables.instance.runtime) local.runtime = getTickCount();
			try{
				if(isObject(arguments.object)){
					arrayAppend(local.decapOut,dumpObject(arguments.object,arguments.runID));
				} else if(isArray(arguments.object)){
					arrayAppend(local.decapOut,dumpArray(arguments.object,arguments.runID));
				} else if(isStruct(arguments.object)){
					arrayAppend(local.decapOut,dumpStruct(arguments.object,arguments.runID));
				} else if(isQuery(arguments.object)){
					arrayAppend(local.decapOut,dumpQuery(arguments.object,arguments.runID));
				} else if(isCustomFunction(arguments.object)){
					arrayAppend(local.decapOut,dumpMethod(arguments.object,arguments.runID));
				} else if(isSimpleValue(arguments.object)){
					if(len(trim(arguments.object))){
						arrayAppend(local.decapOut,"<table class=""v"" cellspacing=""1""><tr><td>"&htmlEditFormat(arguments.object)&"</td></tr></table>");
					} else {
						arrayAppend(local.decapOut,"<table class=""v"" cellspacing=""1""><tr><td class=""i"">EMPTY STRING</td></tr></table>");
					}
				} else {
					arrayAppend(local.decapOut,"<table class=""v"" cellspacing=""1""><tr><td class=""i"">UNKNOWN TYPE</td></tr></table>");
				}
			} catch(Any err){
				arrayAppend(local.decapOut,"<table class=""v"" cellspacing=""1""><tr><td class=""i"">ERR: "&err.message&"</td></tr></table>");
			}
			if(variables.instance.runtime) arrayPrepend(local.decapOut,"<table class=""r"" cellspacing=""1""><tr><td class=""i"">RUNTIME: "&getTickCount()-local.runtime&"ms</td></tr></table>");
			return arrayToList(local.decapOut,"");
		</cfscript>
	</cffunction>

	<cffunction name="typeCntr" returntype="string" access="private" output="false" displayname="typeCntr">
		<cfargument name="descriptor" type="string" required="true" />
		<cfargument name="class" type="string" required="true" />
		<cfargument name="content" type="string" required="true" />
		<cfargument name="runID" type="string" required="true" />
		<cfscript>
			//var local = structNew();
			local.dspID = rereplace(createUUID(),"[^A-Z0-9]","","ALL");
			local.decapOut = arrayNew(1);
			arrayAppend(local.decapOut,"<table class="""&arguments.class&"""><tr onClick="""&arguments.runID&".toggle('"&local.dspID&"');"">");
			arrayAppend(local.decapOut,"<td class=""p b"">"&arguments.descriptor&"</td></tr>");
			if(variables.instance.autoExpand){
				arrayAppend(local.decapOut,"<tr id="""&local.dspID&""" class=""i"">");
			} else {
				arrayAppend(local.decapOut,"<tr id="""&local.dspID&""" class=""n"">");
			}
			arrayAppend(local.decapOut,"<td><table class="""&arguments.class&""" cellspacing=""1"">"&arguments.content&"</table></td></tr></table>");
			return arrayToList(local.decapOut,"");
		</cfscript>
	</cffunction>

	<cffunction name="dumpObject" returntype="string" access="private" output="false" displayname="dumpObject">
		<cfargument name="object" type="any" required="true" />
		<cfargument name="runID" type="string" required="true" />
		<cfscript>
			//var local = structNew();
			local.decapOut = arrayNew(1);
			local.objectMeta = getMetaData(arguments.object);
			if(isStruct(local.objectMeta)){
				if(variables.instance.objectMeta OR variables.instance.objectScope){
					if(variables.instance.objectMeta){
						arrayAppend(local.decapOut,"<tr><td class=""o h"">METADATA</td><td class=""o"">"&typeSwitch(local.objectMeta,arguments.runID)&"</td></tr>");
					}
					if(variables.instance.objectScope){
						local.scopeName = "variables";
						if(len(variables.instance.scope)){
							local.scopeName = local.scopeName&"."&variables.instance.scope;
						}
						arrayAppend(local.decapOut,"<tr><td class=""o h"">"&ucase(local.scopeName)&"</td>");
						if(NOT structKeyExists(arguments.object,arguments.runID)){
							structInsert(arguments.object,arguments.runID,injectionMethod);
							local.decapsulateData = evaluate("arguments.object."&arguments.runID&"(variables.instance.scope)");
							arrayAppend(variables.instance.running[arguments.runID],arguments.object);
							arrayAppend(local.decapOut,"<td class=""o"">"&typeSwitch(local.decapsulateData,arguments.runID)&"</td>");
						} else {
							arrayAppend(local.decapOut,"<td class=""o i"">SCOPE ALLREADY DECAPSULATED</td>");
						}
						arrayAppend(local.decapOut,"</tr>");
					}
			  	return typeCntr("object: "&local.objectMeta.name,"o",arrayToList(local.decapOut,""),arguments.runID);
				} else {
					return "<table class=""o"" cellspacing=""1""><tr><td class=""o"">object: "&local.objectMeta.name&"</td></tr></table>";
				}
			} else {
				return "<table class=""o"" cellspacing=""1""><tr><td class=""o i"">object: UNKNOWN</td></tr></table>";
			}
		</cfscript>
	</cffunction>

	<cffunction name="dumpArray" returntype="string" access="private" output="false" displayname="dumpArray">
		<cfargument name="object" type="array" required="true" />
		<cfargument name="runID" type="string" required="true" />
		<cfscript>
			//var local = structNew();
			local.decapOut = arrayNew(1);
			if(arrayLen(arguments.object)){
				for(local.idx=1;local.idx lte arrayLen(arguments.object);local.idx=local.idx+1){
					arrayAppend(local.decapOut,"<tr><td class=""a h"">"&local.idx&"</td><td class=""a"">");
					arrayAppend(local.decapOut,typeSwitch(arguments.object[local.idx],arguments.runID)&"</td></tr>");
				}
			} else {
				arrayAppend(local.decapOut,"<tr><td class=""a i"">EMPTY ARRAY</td></tr>");
			}
	  	return typeCntr("array("&arrayLen(arguments.object)&")","a",arrayToList(local.decapOut,""),arguments.runID);
		</cfscript>
	</cffunction>

	<cffunction name="dumpStruct" returntype="string" access="private" output="false" displayname="dumpStruct">
		<cfargument name="object" type="struct" required="true" />
		<cfargument name="runID" type="string" required="true" />
		<cfscript>
			//var local = structNew();
			local.decapOut = arrayNew(1);
			if(NOT structIsEmpty(arguments.object)){
				local.keys = structKeyArray(arguments.object);
				arraySort(local.keys,"TEXT");
				for(local.idx=1;local.idx lte arrayLen(local.keys);local.idx=local.idx+1){
					arrayAppend(local.decapOut,"<tr><td class=""s h"">"&local.keys[local.idx]&"</td><td class=""s"">");
					arrayAppend(local.decapOut,typeSwitch(arguments.object[local.keys[local.idx]],arguments.runID)&"</td></tr>");
				}
			} else {
				arrayAppend(local.decapOut,"<tr><td class=""s i"">EMPTY STRUCT</td></tr>");
			}
	  	return typeCntr("struct","s",arrayToList(local.decapOut,""),arguments.runID);
		</cfscript>
	</cffunction>

	<cffunction name="dumpQuery" returntype="string" access="private" output="false" displayname="dumpQuery">
		<cfargument name="object" type="query" required="true" />
		<cfargument name="runID" type="string" required="true" />
		<cfscript>
			//var local = structNew();
			local.decapOut = arrayNew(1);
			local.columns = listToArray(arguments.object.columnlist);
			arrayAppend(local.decapOut,"<tr>");
			for(local.idx=1;local.idx lte arrayLen(local.columns);local.idx=local.idx+1){
				arrayAppend(local.decapOut,"<td class=""q h b"">"&local.columns[local.idx]&"</td>");
			}
			arrayAppend(local.decapOut,"</tr>");
			if(arguments.object.recordcount){
				for(local.aIdx=1;local.aIdx lte arguments.object.recordcount;local.aIdx=local.aIdx+1){
					arrayAppend(local.decapOut,"<tr>");
					for(local.bIdx=1;local.bIdx lte arrayLen(local.columns);local.bIdx=local.bIdx+1){
						arrayAppend(local.decapOut,"<td class=""q"">"&typeSwitch(arguments.object[local.columns[local.bIdx]][local.aIdx],arguments.runID)&"</td>");
					}
					arrayAppend(local.decapOut,"</tr>");
				}
			} else {
				arrayAppend(local.decapOut,"<tr><td class=""q i"" colspan="&arrayLen(local.columns)&">EMPTY QUERY</td></tr>");
			}
		  return typeCntr("query("&arguments.object.recordcount&")","q",arrayToList(local.decapOut,""),arguments.runID);
		</cfscript>
	</cffunction>

	<cffunction name="dumpMethod" returntype="string" access="private" output="false" displayname="dumpMethod">
		<cfargument name="object" type="any" required="true" />
		<cfargument name="runID" type="string" required="true" />
		<cfscript>
			//var local = structNew();
			local.decapOut = arrayNew(1);
			local.methodMeta = getMetaData(arguments.object);
			if(variables.instance.methodMeta){
				local.keys = structKeyArray(local.methodMeta);
				arraySort(local.keys,"TEXT");
				for(local.idx=1;local.idx lte arrayLen(local.keys);local.idx=local.idx+1){
					local.subOut = typeSwitch(local.methodMeta[local.keys[local.idx]],arguments.runID);
					if(len(trim(local.subOut))){
						arrayAppend(local.decapOut,"<tr><td class=""m h"">"&local.keys[local.idx]&"</td><td class=""m"">"&local.subOut&"</td></tr>");
					}
				}
		  	return typeCntr("method","m",arrayToList(local.decapOut,""),arguments.runID);
			} else {
				return "<table class=""m"" cellspacing=""1""><tr><td class=""m"">method: "&local.methodMeta.name&"</td></tr></table>";
			}
		</cfscript>
	</cffunction>

</cfcomponent>