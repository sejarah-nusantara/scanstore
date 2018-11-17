<cfcomponent extends="com.silkunion.service.BaseService">



	<cffunction name="init">
		<cfargument name="userSessionController">
		<cfargument name="archivesGateway">
		<cfargument name="repositoryWebservice">
		<cfargument name="arrayUtility">
		<cfscript>

			return super.init(argumentCollection=arguments) ;
		</cfscript>
	</cffunction>
	<cffunction name="getIntitutions"  returntype="org.dasa.model.SearchResult">

		<cfscript>
				var local = {};
				local.searchResult = createObject('component','org.dasa.model.SearchResult');
				local.archives=[];
				local.archivesList = getArchivesGateway().getDistinctArchivesList();

				for(local.i = 0 ; local.i <  local.archivesList.size() ; local.i++){
					local.archiveSource =  local.archivesList.get(local.i);
					local.archiveTarget	=	{};
					local.archiveTarget['name']	= local.archiveSource.institution;
					local.archiveTarget['id'] 	=  local.archiveSource.institution;
					local.archiveTarget['description'] 	=  local.archiveSource.archive_description;
					local.archives.add(local.archiveTarget);

				}
				local.searchResult.setCollection(local.archives);
				local.searchResult.setCount(local.archives.size());
			return local.searchResult;
		</cfscript>
	</cffunction>
	<cffunction name="getArchives"  returntype="org.dasa.model.SearchResult">
		<!--- hier alleen tonen voor gebruiker --->
		<cfscript>
			var local = {};
			local.archives = [];
			local.archivesList = getArchivesGateway().getArchivesList();
			local.searchResult = createObject('component','org.dasa.model.SearchResult');
			for(local.i = 0 ; local.i <  local.archivesList.size() ; local.i++){
				local.archiveSource =  local.archivesList.get(local.i);
				if(getUserSessionController().getCurrentUser().getInstitutionID()  ==  local.archiveSource.institution){
					local.archiveTarget	= {};
					local.archiveTarget['name'] = local.archiveSource.archive;
					local.archiveTarget['id'] = local.archiveSource.id;
					local.archiveTarget['description'] = local.archiveSource.archive_description;
					local.archiveTarget['institutionID'] = local.archiveSource.institution;
					local.archives.add(local.archiveTarget);
				}
			}
			local.archives = getArrayUtility().sort(local.archives,createObject("component","org.dasa.model.ArchiveComparator"));
			local.searchResult.setCollection(local.archives);
			local.searchResult.setCount(local.archives.size());
			return local.searchResult;
		</cfscript>

	</cffunction>


	<cffunction name="getFiles"  returntype="org.dasa.model.SearchResult">
		<cfargument name="archiveId"  default="1" required="false">
		<cfscript>
			var local = {};
			local.files	=	[];
			local.searchResult = createObject('component','org.dasa.model.SearchResult');
			local.filesList = getArchivesGateway().getFilesList(argumentCollection=arguments);
			for(local.i = 0 ; local.i < local.filesList.size() ; local.i++){

				local.file	=	{};
				local.file['id']			= local.filesList.get(local.i).id;
				local.file['archiveID'] 	= local.filesList.get(local.i).archive_id;
				local.file['number']		= local.filesList.get(local.i).id;
				local.file['description']	= local.filesList.get(local.i).id;
				local.file['public']		= false;
				local.files.add(local.file);
				}
				local.comparator = createObject("component","org.dasa.model.ArchiveFileComparator");
				local.searchResult.setCollection(getArrayUtility().sort(local.files,local.comparator));
				local.searchResult.setCount(local.files.size());
			return local.searchResult;
		</cfscript>
	</cffunction>
	<cffunction name="getStatuses"  returntype="org.dasa.model.SearchResult">

		<cfscript>
			var local = {};
			local.statusCodes={};
			local.searchResult = createObject('component','org.dasa.model.SearchResult');
			local.searchResult.setCollection(getArchivesGateway().getStatusList());
			local.searchResult.setCount(getArchivesGateway().getStatusList().size());

			return local.searchResult;
		</cfscript>
	</cffunction>
	<cffunction name="getLanguages"  returntype="org.dasa.model.SearchResult">

		<cfscript>
			var local = {};
			local.languages = [];

			local.searchResult = createObject('component','org.dasa.model.SearchResult');
				local.language = {};
				local.language['id']			= 'nl';
				local.language['name']			= 'Dutch';
				local.language['description']	= 'Dutch';
				local.languages.add(local.language);
				local.language = {};
				local.language['id']			= 'en';
				local.language['name']			= 'English';
				local.language['description']	= 'English';
				local.languages.add(local.language);
				local.language = {};
				local.language['id']			= 'id';
				local.language['name']			= 'Indonesian';
				local.language['description']	= 'Indonesian';
				local.languages.add(local.language);
				local.language = {};
				local.language['id']			= 'pt';
				local.language['name']			= 'Portuguese';
				local.language['description']	= 'Portuguese';
				local.languages.add(local.language);
				local.language = {};
				local.language['id']			= 'es';
				local.language['name']			= 'Spanish';
				local.language['description']	= 'Spanish';
				local.languages.add(local.language);




			local.searchResult.setCollection(local.languages);
			local.searchResult.setCount(local.languages.size());

			return local.searchResult;
		</cfscript>
	</cffunction>
	<cffunction name="getFilesListForPublishing"  returntype="org.dasa.model.SearchResult">
		<cfargument name="archiveID" required="false">
		<cfargument name="statusID" type="boolean" required="false"/>
		<cfargument name="hasScans" type="boolean" required="false" default="true"/>
		<cfargument name="start" type="numeric" required="false" default="0"/>
		<cfscript>
			var local = {};
			local.files	=	[];
			local.searchResult = createObject('component','org.dasa.model.SearchResult');
			local.jsonResult=variables.instance.repositoryWebservice.getFilesForPublishing(argumentCollection=arguments);
			local.searchResultJson=deserializeJson(local.jsonResult);
			for(local.i=0; local.i < local.searchResultJson.results.size() ; local.i++){
				local.file	=	{};
				local.elem1 =  local.searchResultJson.results.get(local.i).archiveFile;
				local.elem2 =  local.searchResultJson.results.get(local.i).archive_id;
				local.file['id']			= hash(local.elem1 & "_" & local.elem2);
				local.file['archiveID'] 	= local.searchResultJson.results.get(local.i).archive_id;
				local.file['number']			= local.searchResultJson.results.get(local.i).archiveFile;
				local.file['scanCount']			= local.searchResultJson.results.get(local.i).number_of_scans;
				local.file['description']	= local.searchResultJson.results.get(local.i).archiveFile;
				local.file['statusID']		= local.searchResultJson.results.get(local.i).status;
				local.files.add(local.file);

			}
			local.files = getArrayUtility().sort(local.files,createObject("component","org.dasa.model.ArchiveFileComparator"));
			local.searchResult.setCollection(local.files);
			local.searchResult.setOffset(arguments.start);
			local.searchResult.setCount(local.searchResultJson.total_results);
			return local.searchResult;


		</cfscript>
	</cffunction>

	<cffunction name="updateArchiveFile"  returntype="any">
		<cfargument name="archiveFile">

		<cfscript>
			var result = {};
			variables.instance.repositoryWebservice.publishArchiveFile(archiveFile);
			result['success']=true;
			result['message']="published succesfully";
			return result;
		</cfscript>
	</cffunction>

	<cffunction name="deleteArchiveFile"  returntype="any">
		<cfargument name="archiveFile">

		<cfscript>
			var result = {};
			variables.instance.repositoryWebservice.deleteArchiveFileScans(archiveFile);
			result['success']=true;
			result['message']="deleted succesfully";
			return result;
		</cfscript>
	</cffunction>

	<cffunction name="getArchivesGateway" access="private" returntype="any">
		<cfscript>
			return variables.instance.archivesGateway;
		</cfscript>
	</cffunction>
	<cffunction name="getArrayUtility" access="private" returntype="any">
		<cfscript>
			return variables.instance.arrayUtility;
		</cfscript>
	</cffunction>


	<cffunction name="getUserSessionController" access="private" returntype="any">
		<cfscript>
			return variables.instance.userSessionController;
		</cfscript>
	</cffunction>

</cfcomponent>