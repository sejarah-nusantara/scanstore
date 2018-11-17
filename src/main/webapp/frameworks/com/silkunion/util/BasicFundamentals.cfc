<!--- 
	
	Basic fundamentals
	
	This class contains basic fundamentals which could be useful inside the CFC project, but are not implemented inside the current ColdFusion version.

	version: $Id: BasicFundamentals.cfc 15639 2010-06-21 11:26:53Z marwor $
	Author: Hans Regeer
	
---> 
<cfcomponent 	extends="ditp.Object"
				displayname="Basic Fundamental Methods" 
				hint="This class contains basic fundamentals which could be useful inside the CFC project, but are not implemented inside the current ColdFusion version.">
	
	<!--- 
		Currently this component contains the following (helper) methods
		
		* throwException() - Throws a basic exception
		* typeOf() - returns the type of a given variable
	--->
	
	<cffunction name="mail" access="public" returntype="void" 
				hint="Sends an email with the variabele given as a cfdump">
		<cfargument name="var" required="true" type="any">
		<cfargument name="title" required="false" type="String" default="">
		
		<cftry>
			<cfmail to="#APPLICATION.exceptions.mailExceptions.address#" from="#APPLICATION.exceptions.mailExceptions.from#" type="html" subject="#ARGUMENTS.title#">
				<cfdump var="#ARGUMENTS.var#">
			</cfmail>
			
			<cfcatch>
				<cfset writeDumpToFile(ARGUMENTS.var, ARGUMENTS.title)>
			</cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="writeDumpToFile" access="public" returntype="void" 
				hint="Writes a file to a location on the file system which is specified in the application scope">
		<cfargument name="var" required="true" type="any">
		<cfargument name="title" required="false" type="String" default="">
		
		<!---
			Create a variabele with the error message dumped to HTML
		--->
		<cfsavecontent variable = "errorMessage">
			<cfdump var="#ARGUMENTS.var#">
		</cfsavecontent>
		
		<cfif not directoryExists(APPLICATION.writeDumpLocation)>
			<cfdirectory action="create" directory="#APPLICATION.writeDumpLocation#">
		</cfif>
		
		<cfset ARGUMENTS.title = replace(ARGUMENTS.title, "\", "&##92;", "all")>
		<cfset ARGUMENTS.title = replace(ARGUMENTS.title, ":", "&##58;", "all")>
		
		<cffile action="write" file="#APPLICATION.writeDumpLocation##ARGUMENTS.title#mail#timeFormat(now(), 'HH-mm-ss-l')#_#randRange(1, 10000000)#.htm" 
				output="#errorMessage#">
	</cffunction>
	
	<cffunction name="typeOf" access="public" returntype="string" 
				hint="<p>Returns the type of the variable.</p>
<p><strong>Parameters</strong>:<br />
object - The data to inspect. (Required)  </p>
<p><strong>Returns:</strong>  <br />
  Returns a string of the current type. </p>
<strong>Example:</strong>
<pre>&lt;cfscript&gt;
	variable = Tobinary(ToBase64(&quot;foo&quot;);
	utils = createObject(&quot;component&quot;, &quot;ditp.utils.BasicFundamentals&quot;);
	type = utils.typeOf(variable) //this could look very weird for a JAVA developer.
&lt;/cfscript&gt;</pre>">
		<cfargument name="object" required="yes" type="any">
		<cfscript>
		   if(isArray(object)) return "array";
		   if(isStruct(object)) return "object";
		   if(isQuery(object)) return "query";
		   if(isSimpleValue(object) and isWddx(object)) return "wddx";
		   if(isBinary(object)) return "binary";
		   if(isCustomFunction(object)) return "custom function";
		   if(isDate(object)) return "date";
		   if(isNumeric(object)) return "numeric";
		   if(isBoolean(object)) return "boolean";
		   if( listFindNoCase( structKeyList( GetFunctionList() ), "isXMLDoc" ) AND	isXMLDoc(object)) return "xml";
		   if(isSimpleValue(object)) return "string";
		   return "unknown";  
		</cfscript>
	</cffunction>
		
	<cffunction name="sessionClear" access="public" returntype="void"
				hint="Allows you to 'structclear' an entire session without worrying about deleting ColdFusion's built in variables.<p><strong>Example:</strong></p><p>... populated session<br>&lt;cfset utils.sessionClear() /&gt;</br>... cleaned session</p>">
		<cfscript>
			var dont_clear = "sessionid,cfid,cftoken,jsessionid,urltoken";
			var key = "";
			for(key in session) {
				if(not listFindNoCase(dont_clear, key)) structDelete(session,key);
			}
		</cfscript>
	</cffunction>

	<cffunction name="getJavaMetadata" returntype="struct" output="false"
				hint="This returns a data structure that contains all the fields and methods for a given Java object and all of the classes from which it inherits. It is similar in nature to the CFMX function getMetadata(). It is very useful for inspecting objects for which you haven't any documented API... like all of CFMX!
					<p><strong>Example</strong></p><p>struct = StructNew()<br>&lt;cfdump var=##utils.getJavaMetadata(struct)##/&gt;</p>">
		<cfargument name="Object" type="any" required="true"/>
		<cfargument name="AccessLimit" type="string" required="false" default="public">
		<cfargument name="isMetadata" type="boolean" required="false" default="false"/>
		<!---  --->
		<cfset var NULL = Chr(0)>
		<cfset var Modifier = CreateObject("java", "java.lang.reflect.Modifier")>
		<cfset var class = NULL>
		<cfset var i = 0>
		<cfset var j = 0>
		<cfset var methods = NULL>
		<cfset var fields = NULL>
		<cfset var extends = NULL>
		<cfset var Current = StructNew()>
		<cfset var Data = StructNew()>
		<cfset var Limits = StructNew()>
		<cfset var LimitName = Arguments.AccessLimit>
		<cfset var ret = StructNew()>
		
		<cfif NOT Arguments.isMetadata>
			<cfset class = Arguments.Object.getClass()>
		<cfelse>
			<cfset class = Arguments.Object>
		</cfif>
		<cfif class.isArray()>
			<cfset class = class.getComponentType()>
		</cfif>	
		<cfset methods = class.getDeclaredMethods()>
		<cfset fields = class.getDeclaredFields()>
		
		<!-------------------------------------------------------------------------------->
		
		<cfset Limits["public"] = "public">
		<cfset Limits["protected"] = "public,protected">
		<cfset Limits["private"] = "public,protected,private">
		
		<!-------------------------------------------------------------------------------->
		
		<cfset Current["Method"] = NULL>
		<cfset Current["Params"] = NULL>
		<cfset Current["Param"] = StructNew()>
		<cfset Current["Param"]["Type"] = NULL>
		<cfset Current["Param"]["Name"] = NULL>
		<cfset Current["Return"] = StructNew()>
		<cfset Current["Return"]["Type"] = NULL>
		<cfset Current["Return"]["Name"] = NULL>
		<cfset Current["Exceptions"] = NULL>
		<cfset Current["Modifiers"] = NULL>
		<cfset Current["Field"] = StructNew()>
		<cfset Current["Field"]["Value"] = NULL>
		<cfset Current["Field"]["Class"] = NULL>
		<cfset Current["Field"]["Type"] = NULL>
		<cfset Current["Field"]["TypeName"] = NULL>
		
		<!-------------------------------------------------------------------------------->
		
		<cfset Current["Data"] = StructNew()>
		<cfset Current["Data"]["Methods"] = NULL>
		<cfset Current["Data"]["Method"] = NULL>
		<cfset Current["Data"]["Params"] = NULL>
		<cfset Current["Data"]["Param"] = NULL>
		<cfset Current["Data"]["Exceptions"] = NULL>
		<cfset Current["Data"]["Fields"] = NULL>
		<cfset Current["Data"]["Field"] = NULL>
				
		<!-------------------------------------------------------------------------------->
	
		<cfset ret["Class"] = class.getName()>
		<cfset ret["Name"] = class.getName()>
		<cfset ret["Package"] = class.getPackage().getName()>
		<cfset ret["Type"] = "java">
	
		<!-------------------------------------------------------------------------------->
		
		<cfif ArrayLen(Methods)>
			<cfset Current.Data.Methods = ArrayNew(1)>
			
			<cfloop index="i" from="1" to="#ArrayLen(Methods)#">
				<cfset Current.Data.Method = StructNew()>
				
				<cfset Current.Method = methods[i]>
				<cfset Current.Params = Current.Method.getParameterTypes()>
				
				<!---  --->
				
				<cfset Current.Modifiers = Current.Method.getModifiers()>
				<cfif Modifier.isPublic(Current.Modifiers)>
					<cfset Current.Data.Method["Access"] = "public">
				<cfelseif Modifier.isPrivate(Current.Modifiers)>
					<cfset Current.Data.Method["Access"] = "private">
				<cfelse>
					<cfset Current.Data.Method["Access"] = "protected">
				</cfif>
				
				<!---  --->
				
				<cfif ListFindNoCase(Limits[LimitName], Current.Data.Method.Access, ",")>
				
					<cfset Current.Data.Method["Declaration"] = Current.Method.toString()>
					<cfset Current.Data.Method["Name"] = Current.Method.getName()>
					
					<!---  --->
					
					<cfset Current.Return.Type = Current.Method.getReturnType()>
					<cfset Current.Return.Name = NULL>
					<cfloop condition="TRUE">
						<cfif Current.Return.Type.isArray()>
							<cfset Current.Return.Name = Current.Return.Name & "[]">
							<cfset Current.Return.Type = Current.Return.Type.getComponentType()>
						<cfelse>
							<cfset Current.Return.Name = Current.Return.Type.getName() & Current.Return.Name>
							<cfbreak/>
						</cfif>
					</cfloop>
						
					<cfset Current.Data.Method["ReturnType"] = Current.Return.Name>
		
					<!---  --->
					
					<cfset Current.Data.Method["Modifiers"] = ListToArray(Modifier.toString(Current.Modifiers), " ")>
					
					<!---  --->
					
					<cfif ArrayLen(Current.Params)>
						<cfset Current.Data.Params = ArrayNew(1)>
						
						<cfloop index="j" from="1" to="#ArrayLen(Current.Params)#">
							<cfset Current.Param.Type = Current.Params[j]>
							<cfset Current.Param.Name = NULL>
							
							<cfloop condition="TRUE">
								<cfif Current.Param.Type.isArray()>
									<cfset Current.Param.Name = Current.Param.Name & "[]">
									<cfset Current.Param.Type = Current.Param.Type.getComponentType()>
								<cfelse>
									<cfset Current.Param.Name = Current.Param.Type.getName() & Current.Param.Name>
									<cfbreak/>
								</cfif>
							</cfloop>
							
							<cfset ArrayAppend(Current.Data.Params, Current.Param.Name)>
						</cfloop>
						
						<cfset Current.Data.Method["Parameters"] = Current.Data.Params>
					</cfif>					
					
					<!---  --->
		
					<cfset Current.Exceptions = Current.Method.getExceptionTypes()>
					<cfif ArrayLen(Current.Exceptions)>
						<cfset Current.Data.Exceptions = ArrayNew(1)>
						<cfloop index="j" from="1" to="#ArrayLen(Current.Exceptions)#">
							<cfset ArrayAppend(Current.Data.Exceptions, Current.Exceptions[j].getName())>
						</cfloop>
						<cfset Current.Data.Method["Throws"] = Current.Data.Exceptions>						
					</cfif>
					
					<!---  --->
					<cfset ArrayAppend(Current.Data.Methods, Current.Data.Method)>
				</cfif>
			</cfloop>
			
			<cfif ArrayLen(Current.Data.Methods)>
				<cfset ret["Methods"] = Current.Data.Methods>
			</cfif>
		</cfif>
				
		<!-------------------------------------------------------------------------------->
				
		<cfif ArrayLen(Fields)>
			<cfset Current.Data.Fields = ArrayNew(1)>
			
			<cfloop index="i" from="1" to="#ArrayLen(Fields)#">
				<cfset Current.Data.Field = StructNew()>
			
				<cfset Current.Field.Value = fields[i]>
				<cfset Current.Field.Class = fields[i].getType()>
				
				<!---  --->
				
				<cfset Current.Modifiers = Current.Field.Value.getModifiers()>
				<cfif Modifier.isPublic(Current.Modifiers)>
					<cfset Current.Data.Field["Access"] = "public">
				<cfelseif Modifier.isPrivate(Current.Modifiers)>
					<cfset Current.Data.Field["Access"] = "private">
				<cfelse>
					<cfset Current.Data.Field["Access"] = "protected">
				</cfif>			
				
				<cfif ListFindNoCase(Limits[LimitName], Current.Data.Field.Access, ",")>
				
					<!---  --->
					<cfset Current.Data.Field["Declaration"] = Current.Field.Value.toString()>
					<cfset Current.Data.Field["Name"] = Current.Field.Value.getName()>
					<!---  --->
					
					<cfset Current.Field.Type = Current.Field.Class>
					<cfset Current.Field.TypeName = NULL>
					
					<cfloop condition="TRUE">
						<cfif Current.Field.Type.isArray()>
							<cfset Current.Field.TypeName = Current.Field.TypeName & "[]">
							<cfset Current.Field.Type = Current.Field.Type.getComponentType()>
						<cfelse>
							<cfset Current.Field.TypeName = Current.Field.Type.getName() & Current.Field.TypeName>
							<cfbreak/>
						</cfif>
					</cfloop>
					<cfset Current.Data.Field["Type"] = Current.Field.TypeName>
		
					<!---  --->
					<cfset Current.Data.Field["Modifiers"] = ListToArray(Modifier.toString(Current.Modifiers), " ")>
					<!---  --->
					
					<cfset ArrayAppend(Current.Data.Fields, Current.Data.Field)>
					
				</cfif>
			</cfloop>
			
			<cfif ArrayLen(Current.Data.Fields)>
				<cfset ret["Fields"] = Current.Data.Fields>
			</cfif>
		</cfif>
				
		<!-------------------------------------------------------------------------------->
				
		<cfif Compare(class.getName(), "java.lang.Object")>
			<cfset ret["Extends"] = getJavaMetadata(class.getSuperClass(), Arguments.AccessLimit, true)>
		</cfif>
			
	<!-------------------------------------------------------------------------------->
	
	<cfreturn ret/>
</cffunction>
	
	<cffunction name="queryToTableDump" access="public" returntype="string" output="false"
				hint="This method takes a query as an argument and dumps out the contents of the query in a table, columns in TH tags and data in TD tags, for the simple purpose of examining the data in a page. Handy for testing purposes">
	<cfargument name="queryData" type="query" required="true" />
		<cfset var theQuery = arguments.queryData>
		<cfset var columns = theQuery.columnList>
		<cfset var theResults = "">
		<cfset var c = "">
		<cfset var i = "">
		<cfsavecontent variable="theResults">
			<cfoutput>
				<table border="1" cellpadding="0" cellspacing="0">
				<tr>
				<cfloop list="#columns#" index="c">
					<th>#c#</th>
				</cfloop>
				</tr>
				<cfloop from="1" to="#theQuery.recordCount#" index="i">
					<tr><cfloop list="#columns#" index="c">
						<td><cfif len(theQuery[c][i])>#theQuery[c][i]#<cfelse>&nbsp;</cfif></td></cfloop>
					</tr>
				</cfloop>
				</table>
			</cfoutput>
		</cfsavecontent>
		<cfreturn theResults />
		
	</cffunction>
	
	<cffunction name="arrayContains" access="public" returntype="boolean" output="false"
				hint="Returns the index of the first item in an array that contains a specified substring.">
		<cfargument name="arrayToSearch" type="array" required="true">
		<cfargument name="valueToFind" type="string" required="true">
		
		<cfscript>
			var arrayList = "";

			arrayList = ArrayToList(arrayToSearch);
			return ListContains(arrayList,valueToFind);	
		</cfscript>
	</cffunction>
	
	<cffunction name="doesArrayContain" access="public" returntype="boolean" output="false">
		<cfargument name="arrayToSearch" type="array" required="true">
		<cfargument name="valueToFind" type="string" required="true">
		
		<cfscript>
			var i = 1;
			for (i = 1; i <= arrayLen(arrayToSearch); i++) {
				if (arrayToSearch[i] == valueToFind) {
					return true;
				}
			}
			
			return false;
		</cfscript>
	</cffunction>
	
	<cffunction name="deleteFromArray" access="public" returntype="array" output="false">
		<cfargument name="arrayToSearch" type="array" required="true">
		<cfargument name="valueToFind" type="string" required="true">
		
		<cfscript>
			var i = 1;
			var arr = [];
			for (i = 1; i <= arrayLen(arrayToSearch); i++) {
				if (ucase(arrayToSearch[i]) != uCase(valueToFind)) {
					arrayAppend(arr, arrayToSearch[i]);
				}
			}
			
			return arr;
		</cfscript>
	</cffunction>
	
	<cffunction name="queryToArrayOfStructures" access="public" returntype="array" output="false"
				hint="Converts a query object into an array of structures.">
		<cfargument name="theQuery" type="query" required="true">
		<cfscript>
			var theArray = arraynew(1);
			var cols = ListtoArray(theQuery.columnlist);
			var row = 1;
			var thisRow = "";
			var col = 1;
			for(row = 1; row LTE theQuery.recordcount; row = row + 1){
				thisRow = structnew();
				for(col = 1; col LTE arraylen(cols); col = col + 1){
					thisRow[cols[col]] = theQuery[cols[col]][row];
				}
				arrayAppend(theArray,duplicate(thisRow));
			}
			return theArray;
		</cfscript>
	</cffunction> 
	
	<cffunction name="queryColumnToArray" access="public" returntype="array" output="false"
				hint="Converts a column of a query into an array.">
		<cfargument name="theQuery" type="query" required="true">
		<cfargument name="columnName" type="String" required="true">
		<cfscript>
			var theArray = arraynew(1);
			var i = 1;
			for(i = 1; i <= ARGUMENTS.theQuery.recordcount; i++){
				arrayAppend(theArray, evaluate("theQuery.#ARGUMENTS.columnName#[i]"));
			}
			return theArray;
		</cfscript>
	</cffunction> 
	
	<!--- populate an object with a query resultset (tupel only) --->
	<cffunction name="populateObjectWithTupel" access="public" output="false" returntype="any" 
				description="This is an automated populate routine"
				hint="This is an automated populate routine, wich could be used for simple object population. it needs a name of the object and the query wich holds the data to populate<br><br><strong>Important!</strong> Currently only queries with 1 record can be populated and only if the query columnnames are the same as the object attributes">
		<cfargument name="object" required="yes">
		<cfargument name="query" required="yes">
		
		<cfscript>
			var i=1;
			var obj = "";
			var column = "";
			var columnValue = "";
		</cfscript>
		
		<cftry>
	
			<!--- instanciate the object --->
			<cfset obj = createObject("component", "#ARGUMENTS.object#")>
			
			<!--- execute the populate script, which loops through the whole columnlist of the query--->
			<cfscript>
				for (i=1;i lte ListLen(query.columnList); i=i+1) {
			
					//get the columnname of the selected listItem
					column = ListGetAt(query.columnList, i);
					columnValue = evaluate('ARGUMENTS.query' & '.' & column);
					
					//null values don't need to be set to the object instance
					if (columnValue neq '') {
						//set the value using the setters of the given object
						evaluate('obj.set'&column&'("'& columnValue &'")');
					}
				}
				
			</cfscript>
		
			<cfcatch>
				<cfthrow message="#CFCATCH.Message#">
			</cfcatch>
		
		</cftry>
		
		<cfreturn obj>
	</cffunction>

	<!--- popuplate an array of objects with a query --->
	<cffunction access="public" name="createArrayOfObjectsOfQuery" returntype="array" 
				hint="popuplate an array of objects with a query">
		<cfargument name="Qobjects" type="query" required="true">
		<cfargument name="objectType" type="string" required="true">
		
		<cfscript>
			var i=1;
			/*
				Create array for objects which needs to be returned.
			*/
			var objects = arrayNew(1);
			/*
				Create an array of structures from the query
			*/
			var objectsStructs = queryToArrayOfStructures(Qobjects);

			/*
				create an object for every record in the database and fill it. 
				After filling it, put it in the array which needs to be returned
			*/
			for (i=1; i lte ArrayLen(objectsStructs); i=i+1) {
				/*
					Populate a new object with the data from the struct
				*/
				object = createObject('component',ARGUMENTS.objectType);
				object.populate(objectsStructs[i]);
				
				arrayAppend(objects, object);
			}
			return objects;
		</cfscript>
	</cffunction>
	
	<!--- Changes the column name of the given query. --->
	<cffunction access="public" name="QueryChangeColumnName" output="false" returntype="query"
		hint="Changes the column name of the given query.">
		<cfargument name="Query" type="query" required="true" />
 		<cfargument name="ColumnName" type="string" required="true" />
 		<cfargument name="NewColumnName" type="string" required="true" />
 
		<cfscript>
			/*
				Get the list of column names. We have to get this from the query itself as 
				the "ColdFusion" query 	may have had an updated column list.
			*/
			LOCAL.Columns = ARGUMENTS.Query.GetColumnNames();
			 
			/*
				Convert to a list so we can find the column name. This version of the array does 
				not have indexOf type functionality we can use.
			*/
			LOCAL.ColumnList = ArrayToList(LOCAL.Columns);
			 
			
			// Get the index of the column name.
			LOCAL.ColumnIndex = ListFindNoCase(LOCAL.ColumnList,ARGUMENTS.ColumnName);
			 
			
			// Make sure we have found a column.
			if (LOCAL.ColumnIndex){
				/*
					Update the column name. We have to create our own array based on the list since we
				 	cannot directly update the array passed back from the query object.
				*/
				LOCAL.Columns = ListToArray(LOCAL.ColumnList);
				LOCAL.Columns[ LOCAL.ColumnIndex ] = ARGUMENTS.NewColumnName;
				
				// Set the column names.
				ARGUMENTS.Query.SetColumnNames(LOCAL.Columns);
			}
			return( ARGUMENTS.Query );
		</cfscript>
	</cffunction>
	
	<!--- Determines is a given value is a natural number --->
	<cffunction access="public" name="isNaturalNumber" returntype="boolean"
				hint="Method that determines if a given value is a natural number">
		<cfargument name="value" type="numeric" required="true">
		
		<cfscript>
			/*
				The int() method of ColdFusion is similair to the floor() method of JAVA
				it takes a float and returns it's corresponding int by rounding down.
				
				The basic idea behind this method is to compare the given value with it's 
				rounded down counterpart. If the two are exactly the same than the given value
				was already a rounded down number and therefore natural.
				
				5.00001 = not naturalNumber
				5.00000 = naturalNumber
			*/
			if(arguments.value eq int(arguments.value)) {
				return true;
			}
			
			return false;
		</cfscript>
	</cffunction>
	
	<!--- Rounds any given value to a certain precision --->
	<cffunction access="public" name="decimalFormatter" output="false" returntype="numeric"
				hint="Rounds any given value to a certain precision">
		<cfargument name="value" type="numeric" required="true">
		<cfargument name="precision" type="numeric" required="true">
		<cfscript>
			return APPLICATION.MathUtils.scale(
						ARGUMENTS.value,
						ARGUMENTS.precision,
						"ROUND_HALF_EVEN");
		</cfscript>
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

</cfcomponent>