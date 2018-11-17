<cfcomponent extends="com.silkunion.Object" implements="org.dasa.model.IPageScanFactory" >
	<cffunction name="init">
		<cfreturn this/>
	</cffunction>">

	<cffunction name="createPageScanFromStruct" access="public" output="false" returntype="org.dasa.model.PageScan">
		<cfargument name="data" type="struct" required="false" />
		<cfscript>
			var local={};

			local.data = transformPageScanStruct(structCopy(arguments.data));

			local.pageScan = createObject('component','org.dasa.model.PageScan');

			getBeanInjector().autowire(targetComponent=local.pageScan);
			local.pageScan.populate(local.data);

			if(structKeyexists(arguments.data,'images') &&  isArray(arguments.data.images)){
				for(local.i = 1 ; local.i <= arrayLen(arguments.data.images) ; local.i++){
					local.image = arguments.data.images[local.i];
					local.image.scanID = arguments.data.number;
					local.image.fileUrl = application.settings.REPOSITORY_URL & "scans/" & arguments.data.number & "/images/" & arguments.data.images[local.i].id;
					local.pageScan.addImage(getScanImageFactory().createFromStruct(local.image));
				}
			}

			return local.pageScan;
		</cfscript>
	</cffunction>

	<cffunction name="transformPageScanStruct" access="public" output="false" returntype="Struct">
		<cfargument name="data" type="struct" required="false" />
		<cfscript>
			var local={};
			local.datesTOConvert ="date,translationENDate,translationIDDate,transcriptionDate";
			for(local.i= 1 ; local.i<= listLen(local.datesTOConvert) ; local.i++ ){
				local.item = listGetAt(local.datesTOConvert,local.i);
				if(structKeyexists(arguments.data,local.item)  &&  len(arguments.data[local.item])){
					arguments.data[local.item] = convertISOToDate(arguments.data[local.item]);
				}
			}
			if(structKeyExists(arguments.data,"archivefile")){
				arguments.data.archiveFileID = arguments.data.archivefile;
				structDelete(arguments.data,"archivefile");
			}
			if(structKeyExists(arguments.data,"language")){
				arguments.data.languageID = arguments.data.language;
				structDelete(arguments.data,"language");
			}
			if(structKeyExists(arguments.data,"institution")){
				arguments.data.institutionID = arguments.data.institution;
				structDelete(arguments.data,"institution");
			}
			if(structKeyExists(arguments.data,"archive_id")){
				arguments.data.archiveID = arguments.data.archive_id;
				structDelete(arguments.data,"archive_id");
			}
			if(structKeyExists(arguments.data,"image_url")){
				arguments.data.imageUrl = arguments.data.image_url;
				structDelete(arguments.data,"image_url");
			}
			if(structKeyExists(arguments.data,"status")){
				arguments.data.statusID = arguments.data.status;
				structDelete(arguments.data,"status");
			}
			if(structKeyExists(arguments.data,"images")){
				structDelete(arguments.data,"images");
			}

			return arguments.data;
		</cfscript>
	</cffunction>

	<!--- dependencies --->

	<cffunction name="setScanImageFactory" access="public" returntype="void" output="false">
		<cfargument name="ScanImageFactory" type="any" required="true">
		<cfset variables.ScanImageFactory = arguments.ScanImageFactory >
	</cffunction>

	<cffunction name="getScanImageFactory" access="private" returntype="any" output="false">
		<cfreturn variables.ScanImageFactory />
	</cffunction>

	<cffunction name="setBeanInjector" access="public" returntype="void" output="false">
		<cfargument name="BeanInjector" type="any" required="true">
		<cfset variables.BeanInjector = arguments.BeanInjector >
	</cffunction>

	<cffunction name="getBeanInjector" access="private" returntype="any" output="false">
		<cfreturn variables.BeanInjector />
	</cffunction>

	<cffunction name="convertISOToDate">
		<cfargument name="dateString" type="string"/>
		<cfscript>
			var local={};
			local.expr   = refindNocase("^\d{4}-\d{2}-\d{2}",arguments.dateString,0,true);
			try{
				local.substr = mid(arguments.dateString,local.expr.pos[1],local.expr.len[1]);
			}catch(any e){
				return "";
			}
			return local.substr;
		</cfscript>
	</cffunction>

</cfcomponent>



