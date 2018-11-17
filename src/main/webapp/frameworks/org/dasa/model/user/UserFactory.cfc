<cfcomponent extends="com.silkunion.Object">

	<cffunction name="init">
		<cfreturn this/>
	</cffunction>">

	<cffunction name="createFromStruct" access="public" output="false" returntype="org.dasa.model.user.User">
		<cfargument name="data" type="struct" required="false" />
		<cfscript>
			var local = {};
			if(not arguments.data.id is 0){
				local.user = getUserDao().read(arguments.data.id);
			} else {
				local.user = getUserDao().new();
			}
			local.user.setUsername(arguments.data.username);
			local.user.setFirstname(arguments.data.firstname);
			local.user.setLastname(arguments.data.lastname);
			if(len(arguments.data.password) gt 0){
				local.user.setPassword(
					hash(UCase(arguments.data.password)&":"&arguments.data.username,"SHA-256")
				);
			}
			local.user.setEmail(arguments.data.email);
			local.user.setInstitutionID(arguments.data.institutionID);
			if(arguments.data.admin){
				local.user.setRoles([
					getUserRoleDao().readByProperty('roleName',"SYS_ADMIN")
				]);
			} else {
				local.user.setRoles([
					getUserRoleDao().readByProperty('roleName',"SYS_USER")
				]);
			}
			return local.user;
		</cfscript>
	</cffunction>

	<cffunction name="setUserDao" access="public" returntype="void" output="false">
		<cfargument name="userDao" type="any" required="true">
		<cfset variables.userDao = arguments.userDao >
	</cffunction>

	<cffunction name="getUserDao" access="private" returntype="any" output="false">
		<cfreturn variables.userDao />
	</cffunction>

	<cffunction name="setUserRoleDao" access="public" returntype="void" output="false">
		<cfargument name="userRoleDao" type="any" required="true">
		<cfset variables.userRoleDao = arguments.userRoleDao >
	</cffunction>

	<cffunction name="getUserRoleDao" access="private" returntype="any" output="false">
		<cfreturn variables.userRoleDao />
	</cffunction>

</cfcomponent>