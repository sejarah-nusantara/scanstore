<cfcomponent implements="com.silkunion.persistence.IDao" output="false">
	<!---
	CONSTRUCTOR
	--->
	<cffunction name="init" access="public" output="false">
		<cfargument name="userRoleDao" type="any" required="true" />
		<cfscript>
			var local = {};
			variables.userdao = {};
			variables.userdao.counter = 0;
			variables.userdao.users = arrayNew(1);
			variables.userdao.userMap = {
				username:{},
				userid:{}
			}
			
			local.user = new();
			local.user.setInstitutionID("ID-ANRI");
			local.user.setFirstname("Mock-Up");
			local.user.setLastname("Administrator");
			local.user.setEmail("noreply@corstfoundation.org");
			local.user.setUsername("admin");
			local.user.setPassword(hash(hash("admin","SHA-256")&":admin","SHA-256"));
			local.user.setRoles([ arguments.userRoleDao.readByProperty('roleName',"SYS_ADMIN") ]);
			save(local.user);

			local.user = new();
			local.user.setInstitutionID("ID-ANRI");
			local.user.setFirstname("Mock-Up");
			local.user.setLastname("User");
			local.user.setEmail("noreply@corstfoundation.org");
			local.user.setUsername("user");
			local.user.setUsername("user");
			local.user.setPassword(hash(hash("user","SHA-256")&":user","SHA-256"));
			local.user.setRoles([ arguments.userRoleDao.readByProperty('roleName',"SYS_USER") ]);
			save(local.user);
		</cfscript>
		<cfreturn this />
	</cffunction>

	<cffunction name="getNewID" access="private" output="false" returntype="Number">
		<cfscript>
			variables.userdao.counter++;
			return variables.userdao.counter;
		</cfscript>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="void">
		<cfargument name="obj" type="com.silkunion.model.IBusinessObject" required="true" />
		<cfargument name="flush" type="boolean" required="false" default="true">
		<cfscript>
			var local = {};
			if(NOT arguments.obj.getIsDeleted()){
				if(arguments.obj.getUserID() eq ""){
					arguments.obj.setUserID(getNewID());
					arrayAppend(variables.userdao.users,arguments.obj);
				} else {
					for(local.idx = 1; local.idx lte arrayLen(variables.userdao.users);local.idx++){
						if(variables.userdao.users[local.idx].getUserID() is arguments.obj.getUserID()){
							variables.userdao.users[local.idx] = arguments.obj;
							break;
						}
					}
				}
				variables.userdao.userMap.userid[arguments.obj.getUserID()] = arguments.obj;
				variables.userdao.userMap.username[arguments.obj.getUserName()] = arguments.obj;
			} else {
				delete(argumentCollection = arguments);
			}
		</cfscript>
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="com.silkunion.model.IBusinessObject">
		<cfargument name="id" type="any" required="true" />
		<cfscript>
			return variables.userdao.userMap.userid[arguments.id];
		</cfscript>
	</cffunction>

	<cffunction name="new" access="public" output="false" returntype="com.silkunion.model.IBusinessObject">
		<cfscript>
			var local = {};
			local.user = createObject('component','org.dasa.model.user.User').init();
			local.user.setSecurityConfig(application.beanFactory.getBean("securityConfig"));
			return local.user;
		</cfscript>
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="void">
		<cfargument name="obj" type="com.silkunion.model.IBusinessObject" required="true" />
		<cfargument name="flush" type="boolean" required="false" default="true">
		<cfscript>
			var local = {};
			for(local.idx = 1; local.idx lte arrayLen(variables.userdao.users);local.idx++){
				if(variables.userdao.users[local.idx].getUserID() is arguments.obj.getUserID()){
					arrayDeleteAt(variables.userdao.users,local.idx);
					break;
				}
			}
			structDelete(variables.userdao.userMap.userid,arguments.obj.getUserID());
			structDelete(variables.userdao.userMap.username,arguments.obj.getUserName());
		</cfscript>
	</cffunction>

	<cffunction name="readByProperty" access="public" output="false" returntype="com.silkunion.model.IBusinessObject">
		<cfargument name="property" type="string" required="true" />
		<cfargument name="value" type="string" required="true" />
		<cfscript>
			return variables.userdao.userMap[arguments.property][arguments.value];
		</cfscript>
	</cffunction>			
	
	<cffunction name="listByPropertyMap" access="public" output="false" returntype="Array">
		<cfargument name="propertyMap" type="struct" required="true" />
		<cfargument name="options" type="struct" required="false" />
		<cfargument name="sortorder" type="string" required="false" />
		<cfscript>
			return variables.userdao.users;
		</cfscript>
	</cffunction>

	<cffunction name="readByPropertyMap" access="public" output="false" returntype="com.silkunion.model.IBusinessObject">
		<cfargument name="propertyMap" type="struct" required="true" />		
		<cfscript>
			var local = {};
			local.user = variables.userdao.userMap.username[arguments.propertyMap.username];
			if(local.user.getPassword() eq arguments.propertyMap.password){
				return local.user;
			} else {
				return;
			}
		</cfscript>
		<cfabort>
	</cffunction>
	
</cfcomponent>


