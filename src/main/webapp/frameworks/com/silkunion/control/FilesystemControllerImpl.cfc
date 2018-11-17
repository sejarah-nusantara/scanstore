<cfcomponent name="FilesystemControllerImpl"   implements="com.silkunion.control.IFilesystemController" extends="com.silkunion.Object" hint="" >
	<cfset variables.instance.separator="/">

	<cffunction name="init">
		<cfargument name="separator" required="false" default="/">
		<cfargument name="excludedfolders" required="false" default="">
		<cfscript>
			variables.instance.separator=arguments.separator;
			variables.instance.excludedfolders=arguments.excludedfolders;
		</cfscript>
	</cffunction>

	<cffunction name="fileCheck" access="public" output="false" returntype="boolean">
		<cfargument name="ext" type="String" required="true" />
		<cfargument name="acceptedfiles" type="String" required="true" />
		<cfscript>
			return listFindNoCase(acceptedfiles,ext);
		</cfscript>
	</cffunction>

	<cffunction name="uploadFile" access="public" output="false" returntype="struct">
	 	<cfargument name="filedata" type="string" required="true" />
	 	<cfargument name="destinationpath" type="string" required="true" />
	 	<cfargument name="accept" type="string" required="false"  />
	 	<cfset var local=structnew()>
	 	<cfscript>
			createDirectory(arguments.destinationpath);
		</cfscript>
		<cfif structkeyExists(arguments,'accept')>
			<cffile action="upload"
				filefield="form.filedata"
				destination="#arguments.destinationpath#"
				nameconflict="makeunique" accept="#arguments.accept#"/>
		<cfelse>
			<cffile action="upload"
				filefield="form.filedata"
				destination="#arguments.destinationpath#"
				nameconflict="makeunique" />
		</cfif>
		<cfset local.file=File/>
		<cfreturn local.file>
	</cffunction>

	<cffunction name="uploadFileChunk" access="public" output="false" returntype="array">
	 	<cfargument name="destinationpath" type="string" required="true" />
	 	<cfset var local=structnew()>
	 	<cfscript>
			createDirectory(arguments.destinationpath);
			local.requestData = getHTTPRequestData();
			local.fileName = arguments.destinationpath&"/"&hash(local.requestData.headers["X-File-Name"]);
			try {
				// Open file index
				local.index = createObject( 'java', 'java.util.Properties' ).init();
				local.fis = createObject( 'java', 'java.io.FileInputStream').init(local.fileName&".index");
				local.index.load( local.fis );
				local.fis.close();
				// Save part data
				if(structKeyExists(local.requestData.headers,"X-File-Part")){
					// Save file part data
					local.fos = createObject("java", "java.io.FileOutputStream").init(local.fileName&".part."&local.requestData.headers["X-File-Part"]);
					local.fos.write(local.requestData.content);
					local.receivedSize = local.fos.getChannel().size();
					local.missingParts = listToArray(local.index.getProperty('file_parts_missing'));
					local.fos.close();
					if(local.requestData.headers["X-File-Part"] is local.index.getProperty('file_parts')){
						local.expectedSize = local.index.getProperty('file_size')-((local.index.getProperty('file_parts')-1)*local.index.getProperty('file_part_size'));
					} else {
						local.expectedSize = local.index.getProperty('file_part_size');
					}
					if(local.receivedSize is local.expectedSize){
						// Update missing part index
						arrayDeleteAt(local.missingParts, arrayFind(local.missingParts,local.requestData.headers["X-File-Part"]));
						local.index.setProperty('file_parts_missing',arrayToList(local.missingParts));
					}
					// Reconstruct file if all parts are received
					if(arrayLen(local.missingParts) is 0){
						local.fos = createObject("java", "java.io.FileOutputStream").init(local.fileName&".rebuild", true);
						local.reflectArray = createObject("java", "java.lang.reflect.Array");
						local.byteClass = createObject("java", "java.lang.Byte").type;
						for(local.idx=1;local.idx lte local.index.getProperty('file_parts');local.idx++){
							local.file = createObject("java", "java.io.File").init(local.fileName&".part."&local.idx)
							local.buffer = local.reflectArray.newInstance(local.byteClass,local.file.length());
							local.fis = createObject("java", "java.io.FileInputStream").init(local.file);
							local.fis.read(local.buffer);
							local.fis.close();
							local.fos.write(local.buffer);
							local.file.delete();
						}
						local.rebuildedSize = local.fos.getChannel().size();
						local.fos.close();
						if(local.rebuildedSize is local.index.getProperty('file_size')){
							moveFile(local.fileName&".rebuild",arguments.destinationpath&"/"&local.requestData.headers["X-File-Name"]);
						} else {
							throw(type='com.silkunion.control.UploadError',message='rebuilding file has failed');
						}
					}
				}
			} catch(any local.e){
				if(local.e.type eq "java.io.FileNotFoundException"){
					// Create file index
					local.index = createObject( 'java', 'java.util.Properties' ).init();
					try {
						local.index.setProperty('file_parts',local.requestData.headers["X-File-Parts"]);
						local.index.setProperty('file_part_size',local.requestData.headers["X-File-Part-Size"]);
						local.index.setProperty('file_size',local.requestData.headers["X-File-Size"]);
						local.missingParts = '';
						for(local.idx=1;local.idx lte local.requestData.headers["X-File-Parts"];local.idx++){
							local.missingParts = listAppend(local.missingParts,local.idx);
						}
						local.index.setProperty('file_parts_missing',local.missingParts);
					} catch(any local.e){
						throw(type='com.silkunion.control.UploadError',message='missing file metadata');
					}
				} else {
					rethrow;
				}
			}
			// Store file index
			local.fos = createObject( 'java', 'java.io.FileOutputStream').init(local.fileName&".index");
			local.index.store( local.fos, local.requestData.headers["X-File-Name"]&" index" );
			local.fos.close();
			// Return array of missing parts
			return listToArray(local.index.getProperty('file_parts_missing'));
		</cfscript>
	</cffunction>

	<cffunction name="info" access="public" output="false" returntype="struct">
	 	<cfargument name="destination" type="string" required="true" />
 		<cfreturn getFileInfo(destination) />
	 </cffunction>

	<cffunction name="deleteFile" access="public" output="false" returntype="boolean">
	 	<cfargument name="destinationfile" type="string" required="true" />
	 	<cftry>
	 		<cffile action="delete" file="#destinationfile#"/>
	 		<cfreturn true>
	 		<cfcatch type="any">
		 		<cfreturn false>
			</cfcatch>
	 	</cftry>
	 </cffunction>

	<cffunction name="createFile" returnType="void" access="public" output="false" hint="">
		<cfargument name="fileName" type="string" required="true" hint="" />
		<cfargument name="filePath" type="string" required="true" hint="" />
		<cfargument name="fileContent" type="any" required="true" hint="" />
		<cfscript>
			createDirectory(filePath);
		</cfscript>
		<cffile action="write" addnewline="false"
				output="#arguments.fileContent#"
				file="#arguments.filePath##variables.instance.separator##arguments.fileName#" charset="utf-8">
	</cffunction>

	<cffunction name="readFile" returnType="any" access="public" output="false" hint="">
		<cfargument name="file" type="string" required="true" hint="" />
		<cfset var local={}>
		<cffile action="read" file="#file#" variable="local.file">
		<cfreturn local.file>
	</cffunction>

	<cffunction name="readFileAsBinary" returnType="any" access="public" output="false" hint="">
		<cfargument name="file" type="string" required="true" hint="" />
		<cfset var local={}>
		<cffile action="readbinary"  file="#file#" variable="local.file">
		<cfreturn local.file>
	</cffunction>

	 <cffunction name="moveFile" access="public" output="false" returntype="Boolean">
	 	<cfargument name="sourcepath" type="string" required="true" />
	 	<cfargument name="destinationpath" type="string" required="true" />
	 	<cfset var local=structnew()>
	 	<cfscript>
		 	try {
		 		local.file = createObject("java", "java.io.File").init(arguments.sourcepath);
				local.file.renameTo(createObject("java", "java.io.File").init(arguments.destinationpath));
			} catch(any e) {
				return false;
		 	}
		 	return true;
	 	</cfscript>
	 </cffunction>

	<cffunction name="copyFile" returnType="void" access="public" output="false" hint="">
		<cfargument name="target" type="string" required="true" hint="" />
		<cfargument name="destination" type="string" required="true" hint="" />
		<cfargument name="fileName" type="string" required="true" hint="" />
		<cfset createDirectory(arguments.destination)>
		<cffile action="copy"
				destination="#arguments.destination##arguments.filename#"
					source="#arguments.target#" >
	</cffunction>

	<cffunction name="createDirectory" returnType="void" access="public" output="false" hint="">
		<cfargument name="directory" type="string" required="true" hint="" />
		<cfif NOT directoryExists(arguments.directory)>
			<cfdirectory action="create" directory="#arguments.directory#"/>
		</cfif>
	</cffunction>

	 <cffunction name="moveDirectory" access="public" output="false" returntype="boolean">
	 	<cfargument name="sourcepath" type="string" required="true" />
	 	<cfargument name="destinationpath" type="string" required="true" />
	 	<cfscript>
		 	return moveFile(arguments.sourcepath,arguments.destinationpath);
	 	</cfscript>
	 </cffunction>

	 <cffunction name="renameDirectory" access="public" output="false" returntype="boolean">
	 	<cfargument name="oldfolder" type="string" required="true" />
	 	<cfargument name="newfolder" type="string" required="true" />
	 	<cfset var local=structnew()>
	 	<cfset local.success=false/>
	 	<cfif Not directoryexists(newfolder) >
	 		<cfdirectory directory="#oldfolder#" action="rename" newdirectory="#newfolder#">
	 		<cfset local.success=true>
	 	<cfelseif NOT comparenocase(oldfolder,newfolder)>
	 		<cfset local.success=true>
	 	</cfif>
	 	<cfreturn local.success>
	 </cffunction>

	 <cffunction name="list" returntype="Query" >
		<cfargument name="directory" type="string">
		<cfargument name="filetypes" type="string" required="false" hint="list of fileExtentions">
		<cfargument name="recurse" type="boolean" required="false" hint="recurse true false" default="false">
		<cfargument name="excludeHidden" type="boolean" required="false" hint="exclude hidden true false" default="true">
		<cfargument name="sort" type="string" required="false" hint="sort on NAME,DATELASTMODIFIED,DATECREATED ASC or DESC">
		<cfset var local=structnew()>
		<!--- hier loopen en de lijst filteren --->
		<cfscript>
			local.excludedColumns=variables.instance.excludedfolders;
			if(structKeyExists(arguments,"sort") and arguments.sort neq "NAME"){
				local.filteredQuery = querynew("NAME,DATELASTMODIFIED,DATECREATED");
				local.Paths = createObject("java", "java.nio.file.Paths");
				local.Files = createObject("java", "java.nio.file.Files");
			} else {
				local.filteredQuery = querynew("NAME");
			}
			local.dirList = createObject("java", "java.io.File").init(directory).list();
			for(local.i=1;local.i LTE arrayLen(local.dirList);local.i=local.i+1){
				if(NOT listfindNocase(local.excludedColumns,local.dirList[local.i])){
					if(structkeyExists(arguments,'filetypes')){
						local.fileName = listLast(local.dirList[local.i],'/');
						local.fileExtention = listLast(local.filename,'.');
						if(listFindNoCase(arguments.filetypes,local.fileExtention)){
							if(left(local.dirList[local.i], 1) neq "." OR !excludeHidden){
								queryAddrow(local.filteredQuery);
								querySetCell(local.filteredQuery,"NAME",local.dirList[local.i]);
								if(structKeyExists(arguments,"sort") and arguments.sort neq "NAME"){
									local.attributes = local.Files.readAttributes(
										local.Paths.get(directory,[local.dirList[local.i]]),
										"creationTime,lastModifiedTime",
										[]
									)
									querySetCell(local.filteredQuery,"DATELASTMODIFIED",local.attributes.creationTime.toMillis());
									querySetCell(local.filteredQuery,"DATECREATED",local.attributes.lastModifiedTime.toMillis());
								}
							}
						}
					} else if(left(local.dirList[local.i], 1) neq "." OR !excludeHidden){
						queryAddrow(local.filteredQuery);
						querySetCell(local.filteredQuery,"NAME",local.dirList[local.i]);
						if(structKeyExists(arguments,"sort") and arguments.sort neq "NAME"){
							local.attributes = local.Files.readAttributes(
								local.Paths.get(directory,[local.dirList[local.i]]),
								"creationTime,lastModifiedTime",
								[]
							)
							querySetCell(local.filteredQuery,"DATECREATED",local.attributes["creationTime"].toMillis());
							querySetCell(local.filteredQuery,"DATELASTMODIFIED",local.attributes["lastModifiedTime"].toMillis());
						}
					}
				}
				if(recurse){
					local.file = createObject("java", "java.io.File").init(directory&"/"&local.dirList[local.i]);
					if(local.file.isDirectory()){
						local.subDirList = local.file.list();
						for(local.j=1;local.j LTE arrayLen(local.subDirList);local.j=local.j+1){
							local.subDirList[local.j] = directory&"/"&local.subDirList[local.j];
						}
						local.dirList.addAll(local.subDirList);
					}
				}
			}
		</cfscript>
		<cfif structKeyExists(arguments,"sort")>
			<cfquery dbtype="query" name="local.filteredQuery">
				SELECT NAME from local.filteredQuery
				ORDER BY #sort#
			</cfquery>
		</cfif>
		<cfreturn local.filteredQuery>
	</cffunction>

	<cffunction name="deleteDirectory" returnType="boolean" access="public" output="false" hint="">
		<cfargument name="directory" type="string" required="true" hint="" />
		<cfif directoryExists(directory)>
			<cfdirectory action="delete" recurse="true" directory="#arguments.directory#">
			<cfreturn true>
		</cfif>
		<cfreturn false>
	</cffunction>

</cfcomponent>