<cfcomponent extends="com.silkunion.Object">

	<cffunction name="init">
		<cfargument name="repositoryWebservice">
		<cfargument name="userSessionController">
		<cfscript>
			return super.init(argumentCollection=arguments);
		</cfscript>
	</cffunction>
	<cffunction name="getCountryByArchiveId" access="public" returntype="any">
		<cfargument name="archiveId" type="string">
		<cfscript>
			var local = {};
			for(local.i=0 ; local.i < getArchivesList().size() ;local.i++){
				if(getArchivesList().get(local.i).id == archiveId){
					return getArchivesList().get(local.i).country_code;
				}

			}
		</cfscript>
	</cffunction>

	<cffunction name="getInstitutionByArchiveId" access="public" returntype="any">
		<cfargument name="archiveId" type="string">
		<cfscript>
			var local = {};
			for(local.i=0 ; local.i < getArchivesList().size() ;local.i++){
				if(getArchivesList().get(local.i).id == archiveId){
					return getArchivesList().get(local.i).institution;
				}

			}
		</cfscript>
	</cffunction>
	<cffunction name="getArchiveByArchiveId" access="public" returntype="any">
		<cfargument name="archiveId" type="string">
		<cfscript>
			var local = {};
			for(local.i=0 ; local.i < getArchivesList().size() ;local.i++){
				if(getArchivesList().get(local.i).id == archiveId){
					return getArchivesList().get(local.i).archive;
				}

			}
		</cfscript>
	</cffunction>
	<cffunction name="getDistinctArchivesList" access="public" returntype="array">
		<cfscript>
			var local= {};

			local.distictArchives = [];
			local.archives = getArchivesList();
			for(local.i = 0 ; local.i < local.archives.size(); local.i++){
				local.found=false;
				for(local.j = 0 ; local.j < local.distictArchives.size(); local.j++){
					if(local.archives.get(local.i).institution == local.distictArchives.get(local.j).institution){
						local.found=true;
						break;
					}

				}
				if(!local.found){
					local.distictArchives.add(local.archives.get(local.i));
				}
			}
			return local.distictArchives;
		</cfscript>
	</cffunction>
	<cffunction name="getArchivesList" access="public" returntype="any">


		<cfscript>
			lock
				name="ArchiveRefreshLock"
				type="EXCLUSIVE"
				timeout="30"
				{

				if(!structKeyExists(variables.instance,'archivesList') || dateDiff('n',application.cacheTimestamp,now()) > 30){
						application.cacheTimestamp = now();
						variables.instance.archivesList = getArchivesListFromRepository();
					}
				}


				return variables.instance.archivesList;
			</cfscript>

	</cffunction>

	<cffunction name="getStatusList" access="public" returntype="any">
		<cfscript>
			if(!structKeyExists(variables.instance,'statusList')){



				variables.instance.statusList = createStatusList();
			}
			return variables.instance.statusList;
		</cfscript>
	</cffunction>
	<cffunction name="getStatuslabelById" access="public" returntype="any">
		<cfargument name="statusId" />
		<cfscript>
			var local = {};
			for(local.i=0 ; local.i < getStatusList().size() ;local.i++){
				if(getStatusList().get(local.i).id == statusId){
					return getStatusList().get(local.i).name;
				}

			}
		</cfscript>
	</cffunction>
	<cffunction name="createStatusList" access="private" returntype="any">
		<cfscript>
			var local={};
			/* 		http://docs.restrepo.gerbrandy.com/datamodels/index.html#status-values
					0 	Deleted (i.e. only accessible when accessed directly)
					1 	Newly added default
					2 	Public

				*/
			local.stList=[];

			local.stItem={};
			local.stItem['id']=1;
			local.stItem['name']="New";
			local.stItem['description']="default";
			local.stList.add(local.stItem);
			local.stItem={};
			local.stItem['id']=2;
			local.stItem['name']="Public";
			local.stItem['description']="visible on public websites";
			local.stList.add(local.stItem);

			return local.stList;
		</cfscript>

	</cffunction>

	<cffunction name="getArchivesListFromRepository" access="private" returntype="any">
		<cfscript>
			var local={};
			local.archivesJson=getRepositoryWebservice().getArchivesList();
			local.archives = deserializeJson(local.archivesJson);

			return local.archives.results;
		</cfscript>

	</cffunction>
	<cffunction name="getFilesList" access="public" returntype="any">

		<cfscript>
			var local={};
			local.archives = getArchivesList();
			local.fileArray = [];
			for(local.i = 0 ; local.i <  local.archives.size() ; local.i++){
				local.archiveSource =  local.archives.get(local.i);

				if(getUserSessionController().getCurrentUser().getInstitutionID()  ==  local.archiveSource.institution){
					local.filesJson=getRepositoryWebservice().getFilesList(archiveID=local.archiveSource.id);
					local.files = deserializeJson(local.filesJson);
					local.fileArray.addAll(local.files.results);
				}
			}

			return local.fileArray;
		</cfscript>

	</cffunction>
	<cffunction name="getRepositoryWebservice" access="private" returntype="any">
		<cfscript>
			return variables.instance.repositoryWebservice;
		</cfscript>
	</cffunction>

	<cffunction name="getUserSessionController" access="private" returntype="any">
		<cfscript>
			return variables.instance.userSessionController;
		</cfscript>
	</cffunction>
</cfcomponent>