<cfcomponent hint="controls user session" output="false" extends="com.silkunion.Object">
	<cffunction name="init">
		<cfargument name="userDAO" type="com.silkunion.persistence.IDao">
		<cfreturn super.init(argumentcollection=arguments)/>
	</cffunction>

	<cffunction name="getUploadPath" access="public" returntype="String">
		<cfreturn session.upload_location />
	</cffunction>

	<cffunction name="getSessionID" access="public" returntype="String">
		<cfreturn session.sessionid />
	</cffunction>

	<cffunction name="userIsLoggedIn" access="public" returntype="boolean">
		<cfreturn structKeyExists(session,'user')/>
	</cffunction>

	<cffunction name="getCurrentUser" access="public" returntype="org.dasa.model.user.User">
		<cfreturn session.user />
	</cffunction>

	<cffunction name="getLoggedInUser" access="public" returntype="Struct">
		<cfset var local={}/>
		<cfscript>
			try{
				local.user = {};
				local.user["firstname"] = session.user.getFirstname();
				local.user["lastname"] = session.user.getLastname();
				local.user["institutionID"] = session.user.getInstitutionID();
				local.user["admin"] = session.user.userIsSysAdmin();
				local.result={};
				local.result['success']=true;
				local.result['item']= local.user;
			} catch(any e){
				local.result={};
				local.result['success']=false;
			}
		</cfscript>
		<cfreturn local.result />
	</cffunction>

	<cffunction name="loginUser" access="public" returntype="Struct">
		<cfargument name="username" type="string"/>
		<cfargument name="password" type="string"/>
		<cfset var local={}/>
		<cfset local.result={}/>
		<cftry>
			<cfset local.propertyMap = {
				username = arguments.username,
				password = hash(UCase(arguments.password)&":"&arguments.username,"SHA-256")
			} />
			<cfset logoutUser()/>
			<cflock scope="session" type="exclusive" timeout="10" throwontimeout="true" >
				<cfscript>
					session.user = getUserDAO().readByPropertyMap(local.propertyMap)
					local.user = {};
					local.user["username"] = session.user.getUsername();
					local.user["firstname"] = session.user.getFirstname();
					local.user["lastname"] = session.user.getLastname();
					local.user["institutionID"] = session.user.getInstitutionID();
					local.user["admin"] = session.user.userIsSysAdmin();
					session.upload_location = application.settings.UPLOAD_LOCATION&"TEMP/"&hash(session.user.getUsername()&"_"&session.sessionid)&"/";
					getFileSystemController().createDirectory(session.upload_location);
				</cfscript>
			</cflock>
			<cfset local.result['success']=true/>
			<cfset local.result['item']= local.user />
			<cfcatch>
				<cfset local.result['success']=false />
			</cfcatch>
		</cftry>
		<cfreturn local.result />
	</cffunction>

	<cffunction name="logoutUser" access="public" returntype="any">
		<cflock timeout="10" throwontimeout="No" type="exclusive" scope="SESSION">
			<cfscript>
				if(structKeyExists(session,"user")) structDelete(session,"user");
				if(structKeyExists(session,"upload_location")) getFileSystemController().deleteDirectory(session.upload_location);
			</cfscript>
		</cflock>
	</cffunction>

	<cffunction name="getUserDAO"  returntype="com.silkunion.persistence.IDao">
		<cfreturn variables.instance.userDAO/>
	</cffunction>

	<!--- dependencies --->
	<cffunction name="getFileSystemController" returnType="any" access="public" output="false" hint="">
		<cfreturn variables.instance.fileSystemController/>
	</cffunction>

	<cffunction name="setFileSystemController" returnType="void" access="public" output="false" hint="">
		<cfargument name="fileSystemController" type="any" required="true" hint="" />
		<cfset variables.instance.fileSystemController=arguments.fileSystemController/>
	</cffunction>

</cfcomponent>