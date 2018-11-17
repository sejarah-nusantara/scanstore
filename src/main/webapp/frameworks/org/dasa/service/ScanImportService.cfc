<cfcomponent extends="com.silkunion.service.BaseService" hint="Responsible for importing scans into the repository">

	<cffunction name="init">
		<cfargument name="scenarioFactory" type="com.silkunion.util.IFactory">
		<cfargument name="scanStoreController" type="any">
		<cfargument name="directoryController" type="any">
		<cfargument name="importDirectoryGateway" type="any">
		<cfargument name="fileSystemController" type="any">
		<cfscript>
			return super.init(argumentCollection=arguments) ;
		</cfscript>
	</cffunction>

	<cffunction name="getPendingImports" returntype="any">
		<cfargument name="start" type="numeric" required="false" default="0"/>
		<cfscript>
			local.searchResult = createObject('component','org.dasa.model.SearchResult');
			local.folderData =  variables.instance.importDirectoryGateway.getPendingImports(start);
			local.folders = local.folderData.importDirs;
			local.searchResult.setCollection(local.folders);
			local.searchResult.setOffset(arguments.start);
			local.searchResult.setCount(local.folderData.totalCount);
			return local.searchResult;
		</cfscript>
	</cffunction>

	<cffunction name="getImportDirectory" returnType="struct" >
		<cfargument name="id" type="string" required="true" />
		<cfscript>
			try{
				local.result={};
				local.result['success']=true;
				local.result['item']= variables.instance.importDirectoryGateway.getImportById(id);;
			} catch(any e){
				local.result={};
				local.result['success']=false;
			}
			return local.result
		</cfscript>
	</cffunction>

	<cffunction name="getImportScenarios" returntype="any">
		<cfscript>
			var local={};
			local.scenarios =[];
			local.singleScenario = createObject("component","org.dasa.model.SingleFileImportScenario");
			local.multiScenario = createObject("component","org.dasa.model.MultiFileTIFFJPGImportScenario");
			local.multiScenario2 = createObject("component","org.dasa.model.MultiFileTIFFJPGImportScenarioNotEqual");
			local.scenarios.add(local.singleScenario);
			local.scenarios.add(local.multiScenario);
			local.scenarios.add(local.multiScenario2);
			return local.scenarios;
		</cfscript>
	</cffunction>

	<cffunction name="sendScanImportToRepository" returntype="any" hint="this method creates a scanimport object and sends the scan import to the repository">
		<cfargument name="importDirectory" type="any" required="true" hint="" />
		<cfargument name="archiveID" type="string" required="true" hint="" />
		<cfargument name="languageID" type="string" required="true" hint="" />
		<cfargument name="archiveFileID" type="string" required="true" hint="the archiveFileID metadata for the import" />
		<cfargument name="type" type="string" required="true" hint="he type metadata for the import" />
		<cfargument name="title" type="string" required="true" hint="the title metadata for the import" />
		<cfargument name="scenarioID" type="string" required="true" hint="the id of the selected scenario" />
		<cfscript>
			var local={};
			try{
				local.rtn ={};
				local.rtn['success']=true;
				//in this process there is validation
				local.initArgs = {};
				local.initArgs.importLocation = importDirectory.getImportLocation();
				local.scenario = variables.instance.scenarioFactory.create(scenarioID,local.initArgs);
				local.scans = local.scenario.createScans(
					archiveID,
					languageID,
					archiveFileID,
					type,
					title,
					scenarioID
				);
				thread	action="run"
						name="importThread"
						dir=importDirectory
						scans = local.scans
						metaData= arguments
				{
					setting requestTimeout="3600";
					try{
						dir.setLastImportDate(now());
						initArgs = {};
						variables.instance.scanStoreController.importScans(dir,scans,metaData);
					} catch(any e){
						variables.instance.directoryController.removeDirectory(dir.getImportLocation(),false);
						rethrow;
					}
				}
			} catch(any e){
				try{
					importDirectory.processUnsuccessfullImport(e.message,'');
					variables.instance.directoryController.removeDirectory(importDirectory.getImportLocation(),false);
				} catch(IllegalFileAccess e){
					//ignore
				}
				rethrow;
			}
			return local.rtn;
		</cfscript>
	</cffunction>

	<cffunction name="deleteImportDirectory" returnType="struct" access="public" output="false" hint="">
		<cfargument name="importDirectory" type="any" />
		<cfscript>
			var data ={};
			if(!variables.instance.directoryController.directoryIsLocked(importDirectory.getImportLocation())){
				variables.instance.fileSystemController.deleteDirectory(importDirectory.getImportLocation());
			} else {
				throw (	type="org.dasa.user.IllegalDirectoryAccess" ,
					message="You have attempted to remove '#importDirectory.getImportLocation()#' , which is locked for processing"
				);
			}
			data.success = true;
			data.message= "directory sucessfully removed";
			return data;
		</cfscript>
	</cffunction>

</cfcomponent>
