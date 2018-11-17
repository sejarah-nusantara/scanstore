<cfcomponent extends="com.silkunion.service.BaseService">

	<cffunction name="init">
		<cfargument name="userDAO" type="com.silkunion.persistence.IDao">
		<cfargument name="userRoleDao" type="com.silkunion.persistence.IDao">
		<cfargument name="beanInjector" type="any">
		<cfreturn super.init(argumentcollection=arguments)/>
	</cffunction>

	<cffunction name="getUsers" access="public" returntype="any">
		<cfscript>
			var local = {};
			local.filter = {};
			local.filter.isDeleted=false;
			try {
				local.dataSet = getUserDAO().listByPropertyMap(local.filter);
				local.returnSet = [];
				local.limit = arguments.limit;
				for(local.idx = (arguments.start+1);local.idx lte arrayLen(local.dataSet);local.idx++){
					local.user = {};
					local.user["id"] = local.dataSet[local.idx].getUserid();
					local.user["username"] = local.dataSet[local.idx].getUsername();
					local.user["firstname"] = local.dataSet[local.idx].getFirstname();
					local.user["lastname"] = local.dataSet[local.idx].getLastname();
					local.user["institutionID"] = local.dataSet[local.idx].getInstitutionID();
					local.user["email"] = local.dataSet[local.idx].getEmail();
					local.user["admin"] = local.dataSet[local.idx].userIsSysAdmin();
					local.returnSet[local.idx] = local.user;
					local.limit--;
					if(local.limit is 0) break;
				}
				local.returnData = {
					succeeded: true,
					collection: local.returnSet,
					count: arrayLen(local.dataSet),
					offset: arguments.start
				}
			} catch(any e){
				local.returnData = {
					succeeded: false
				}
			}
			return local.returnData;
		</cfscript>
	</cffunction>

	<cffunction name="getSystemAdministratorsByInstitution" access="public" returntype="any">
		<cfargument name="institution">
		<cfscript>
			var filter={};
			var users = [];
			var sysAdmin = [];
			var i = 0;
			filter.institutionID=institution;
			filter.isDeleted=false;
			users = getUserDAO().listByPropertyMap(filter);
			for(i=0 ; i < users.size() ; i++){
				if(users.get(i).userIsSysAdmin()){
					sysAdmin.add(users.get(i));
				}
			}
			return sysAdmin;
		</cfscript>
	</cffunction>

	<cffunction name="createUser" access="public" returntype="any">
		<cfscript>
			return getBeanInjector().autoWire(getUserDAO().new());
		</cfscript>
	</cffunction>

	<cffunction name="updateUser" access="public" returntype="any">
		<cfargument name="user" type="org.dasa.model.user.User"/>
		<cfscript>
			var local = {};
			local.user = saveUser(arguments.user);
			local.returnUser = {};
			local.returnUser["id"] = local.user.getUserid();
			local.returnUser["username"] = local.user.getUsername();
			local.returnUser["firstname"] = local.user.getFirstname();
			local.returnUser["lastname"] = local.user.getLastname();
			local.returnUser["institutionID"] = local.user.getInstitutionID();
			local.returnUser["email"] = local.user.getEmail();
			local.returnUser["admin"] = local.user.userIsSysAdmin();
			return returnUser;
		</cfscript>
	</cffunction>

	<cffunction name="getUser" access="public" returntype="any">
		<cfargument name="userId" type="numeric"/>
		<cfscript>
			return getUserDAO().read(arguments.userId);

		</cfscript>
	</cffunction>

	<cffunction name="saveUser" access="public" returntype="any">
		<cfargument name="user" type="org.dasa.model.user.User"/>
		<cfscript>
			getUserDAO().save(arguments.user);
			return user;
		</cfscript>
	</cffunction>

	<cffunction name="deleteUser" access="public" returntype="any">
		<cfargument name="user" type="org.dasa.model.user.User"/>
		<cfscript>
			user.setIsDeleted(true);
			return saveUser(user);
		</cfscript>
	</cffunction>

	<cffunction name="addRoleToUser" access="public" returntype="any">
		<cfargument name="userId" type="numeric"/>
		<cfargument name="roleId" type="numeric"/>
		<cfscript>
			var local={};
			local.user = getUser(arguments.userId);
			local.role = getUserRoleDAO().read(arguments.roleId);
			if(!local.user.hasRoles(local.role)){
				local.user.addRoles(local.role);
				saveUser(local.user);
			}
		</cfscript>
	</cffunction>

	<cffunction name="removeRoleFromUser" access="public" returntype="any">
		<cfargument name="userId" type="numeric"/>
		<cfargument name="roleId" type="numeric"/>
		<cfscript>
			var local={};
			local.role = getUserRoleDAO().read(arguments.roleId);
			local.user = getUser(arguments.userId);
			if(local.user.hasRoles(local.role)){
				local.user.removeRoles(local.role);
				saveUser(local.user);
			}
		</cfscript>
	</cffunction>

	<cffunction name="getUserRoles" access="public" returntype="any">
		<cfscript>
			var filter={};
			return getUserRoleDAO().listByPropertyMap(filter);
		</cfscript>
	</cffunction>

	<cffunction name="saveRole" access="public" returntype="any">
		<!--- todo:implement --->
	</cffunction>

	<cffunction name="addRole" access="public" returntype="any">
	<!--- todo:implement --->
	</cffunction>

	<cffunction name="getBeanInjector" access="private" returntype="any">
		<cfreturn variables.instance.beanInjector/>
	</cffunction>

	<cffunction name="getUserDAO" access="private" returntype="com.silkunion.persistence.IDao">
		<cfreturn variables.instance.userDAO/>
	</cffunction>

	<cffunction name="getUserRoleDAO" access="private" returntype="com.silkunion.persistence.IDao">
		<cfreturn variables.instance.userRoleDAO/>
	</cffunction>

</cfcomponent>