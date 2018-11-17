<cfcomponent implements="com.silkunion.persistence.IDao" output="false">
	<!---
	CONSTRUCTOR
	--->
	<cffunction name="init" access="public" output="false">
		<cfscript>
			variables.roles = arrayNew(1);

			variables.roleMap = structNew();

			local.role = new();
			local.role.setRoleID("1");
			local.role.setRoleName("SYS_ADMIN");
			local.role.setRoleDescription("System administrator");
			arrayAppend(variables.roles,local.role);
			variables.roleMap[local.role.getRoleName()] = local.role;

			local.role = new();
			local.role.setRoleID("2");
			local.role.setRoleName("SYS_USER");
			local.role.setRoleDescription("System user");
			arrayAppend(variables.roles,local.role);
			variables.roleMap[local.role.getRoleName()] = local.role;
		</cfscript>
		<cfreturn this />
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="void">
		<cfargument name="obj" type="com.silkunion.model.IBusinessObject" required="true" />
		<cfargument name="flush" type="boolean" required="false" default="true">

	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="com.silkunion.model.IBusinessObject">
		<cfargument name="id" type="any" required="true" />
		<cfscript>
			return variables.roles[1];
		</cfscript>
	</cffunction>

	<cffunction name="new" access="public" output="false" returntype="com.silkunion.model.IBusinessObject">
		<cfscript>
			return createObject('component','org.dasa.mock.model.UserRole').init();
		</cfscript>
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="void">
		<cfargument name="obj" type="com.silkunion.model.IBusinessObject" required="true" />
		<cfargument name="flush" type="boolean" required="false" default="true">

	</cffunction>

	<cffunction name="readByProperty" access="public" output="false" returntype="com.silkunion.model.IBusinessObject">
		<cfargument name="property" type="string" required="true" />
		<cfargument name="value" type="string" required="true" />
		<cfscript>
			return variables.roleMap[arguments.value];
		</cfscript>
	</cffunction>

	<cffunction name="listByPropertyMap" access="public" output="false" returntype="Array">
		<cfargument name="propertyMap" type="struct" required="true" />
		<cfargument name="options" type="struct" required="false" />
		<cfargument name="sortorder" type="string" required="false" />
		<cfscript>
			return variables.roles;
		</cfscript>
	</cffunction>

	<cffunction name="readByPropertyMap" access="public" output="false" returntype="com.silkunion.model.IBusinessObject">
		<cfargument name="propertyMap" type="struct" required="true" />
		<cfscript>
			return variables.roleMap[arguments.propertyMap.roleName];
		</cfscript>
	</cffunction>

</cfcomponent>


