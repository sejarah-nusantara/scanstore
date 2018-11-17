<cfcomponent persistent="true" table="scanstore_users"  serializable="true" accessors="true" extends="com.silkunion.model.BaseBusinessObjectImpl" output="false" implements="com.silkunion.security.IAuthenticatable">

	<cfproperty name="userId" column="user_id" type="numeric" ormtype="int" fieldtype="id"  generator="identity" />
	<cfproperty name="username" column="user_name" type="string" ormtype="string" />
	<cfproperty name="password" column="user_password" type="string" ormtype="string" />
	<cfproperty name="firstname" column="user_firstname" type="string" ormtype="string" />
	<cfproperty name="lastname" column="user_lastname" type="string" ormtype="string" />
	<cfproperty name="institutionID" type="string" column="user_institution"  ormtype="string" />
	<cfproperty name="email" type="string" column="user_email"  ormtype="string" />
	<cfproperty name="isDeleted" type="boolean" column="user_deleted" ormtype="boolean" default="false" notnull="true" insert="false" />

	<!--- please note lazy must be false if user in sessionscope --->
	<cfproperty name="roles" type="array" fieldtype="many-to-many" cfc="UserRole" linktable="scanstore_user_roles" fkcolumn="user_id" inversejoincolumn="role_id" lazy="false" cascade="save-update"/>

	<cffunction name="userIsSysAdmin">
		<cfscript>
			var local = {};
			local.roles		=	getRoles();
			for(local.i=0; local.i < local.roles.size() ; local.i++){
				if(local.roles.get(local.i).getRoleName() EQ "SYS_ADMIN"){
					return true;
				}
			}
			return false;
		</cfscript>
	</cffunction>

	<cffunction name="userIsAuthorized" returntype="boolean" >
		<cfargument name="operation" type="string" />
		<cfscript>
			var local={};
			local.roles		=	getRoles();
			local.config	=	getSecurityConfig();
			local.securityRoles = local.config['roleNames'];
			for(local.i=0; local.i < local.roles.size() ; local.i++){
				local.roleName	=	local.roles.get(local.i).getRoleName();
				for(local.item in local.securityRoles){
					if(item == local.roleName){
						local.methods=local.securityRoles[local.item];
						for(local.j=0 ; local.j < local.methods.size(); local.j++){
							local.method = local.methods.get(local.j);
							if(local.method == "*"  || refindNocase(local.method,arguments.operation)){
								return true;
							}
						}
					}
				}
			}
			throw(message="User is not authorized to access #operation#",type='org.dasa.security.UserAcessViolationError');
		</cfscript>
	</cffunction>

	<cffunction name="checkDuplicateUserPassword" returntype="boolean" >
		<cfscript>
			var local={};
			local.map.userName=getuserName();
			local.map.password=getpassword();
			local.map.isDeleted=false;
			try {
				local.checkuser = getUserDAO().readByPropertyMap(local.map);
				} catch (any e) {
					return true;

				}
			return false;
		</cfscript>
	</cffunction>

	<cffunction name="setUserdao" returntype="void" >
		<cfargument name="userDao" type="any" />
		<cfset variables.userDao=arguments.userDao/>
	</cffunction>

	<cffunction name="getUserdao" returntype="any" >
		<cfreturn variables.userDao/>
	</cffunction>

	<!--- dependencies injected via orm.eventhandler beand injector --->
	<cffunction name="setSecurityConfig" returntype="void" >
		<cfargument name="securityConfig" type="struct" />
		<cfset variables.securityConfig=arguments.securityConfig/>
	</cffunction>

	<cffunction name="getSecurityConfig" returntype="struct" >
		<cfreturn variables.securityConfig/>
	</cffunction>

</cfcomponent>
