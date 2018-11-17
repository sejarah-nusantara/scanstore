<cfcomponent implements="com.silkunion.persistence.IDao" output="false">
	<!---
	CONSTRUCTOR
	--->
	<cffunction name="init" access="public" output="false" returntype="com.silkunion.persistence.HibernateDaoImpl">
		<cfargument name="entityName" type="String" required="true" />
		<cfargument name="beanInjector" type="any" required="false" />
		<cfargument name="setupMethod" type="string" required="false" />
		
		<cfset variables.entityName = arguments.entityName />
		<cfif structKeyExists(arguments,'beanInjector')>
			<cfset variables.beanInjector = arguments.beanInjector />
		</cfif>
		<cfif structKeyExists(arguments,'setupMethod')>
			<cfset variables.setupMethod = arguments.setupMethod />
		</cfif>
		<cfreturn this />
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="void">
		<cfargument name="obj" type="com.silkunion.model.IBusinessObject" required="yes" />
		<cfargument name="flush" type="boolean" required="false" default="true">
		<cfset entitySave( obj ) />
		<cfif arguments.flush>
			<cfset ormFlush() />
		</cfif>
	</cffunction>

	<cffunction name="existsByProperty" access="public" output="false" returntype="boolean">
		<cfargument name="property" type="string" required="yes" />
		<cfargument name="value" type="string" required="yes" />
		<cfscript>
			var id={};
			id[property]=value;
			var obj=entityLoad (variables.entityName,id,true);
			return !isnull(obj);
		</cfscript>
	</cffunction>
	
	<cffunction name="readByProperty" access="public" output="false" returntype="com.silkunion.model.IBusinessObject">
		<cfargument name="property" type="string" required="yes" />
		<cfargument name="value" type="string" required="yes" />
		<cfscript>
			var id={};
			id[property]=value;
			var obj=entityLoad (variables.entityName,id,true);
			if(!isnull(obj)){return configureObject(obj);}
			throw(type="com.silkunion.persistence.RecordNotFound",message="no record found");
		</cfscript>
	</cffunction>
	<cffunction name="readByPropertyMap" access="public" output="false" returntype="com.silkunion.model.IBusinessObject">
		<cfargument name="propertyMap" type="struct" required="true" />		
		<cfscript>
			var obj=entityLoad (variables.entityName,arguments.propertyMap,true);
			if(!isnull(obj)){return configureObject(obj);}
			throw(type="com.silkunion.persistence.RecordNotFound",message="no record found");
		</cfscript>
	</cffunction>
	<cffunction name="listByPropertyMap" access="public" output="false" returntype="Array">
		<cfargument name="propertyMap" type="struct" required="true" />
		<cfargument name="options" type="struct" required="false" />
		<cfargument name="sortorder" type="string" required="false" />
		<!--- sortorder
	

				String used to specify the sortorder of the entities that are returned.If specified, loads and returns an array of entities that satisfy the filtercriteria sorted as specified by the sortorder.
				
				options
					
				
				The following options to customize the output:
				
				    *
				
				      ignorecase: Ignores the case of sort order when set to true. Use only if you specify the sortorder parameter.
				    *
				
				      offset: Specifies the position from which to retrieve the objects.
				    *
				
				      maxResults: Specifies the maximum number of objects to be retrieved.
				    *
				
				      cacheable: Whether the result has to be cached in the secondary cache. Default is false.
				    *
				
				      cachename: Name of the cache in secondary cache.
				    *
				
				      timeout: Specifies the timeout value (in seconds) for the query.

			 --->
		
		<cfscript>
			var obj="";
			if(structKeyExists(arguments,'options') && structKeyExists(arguments,'sortorder') ){
				obj=entityLoad (variables.entityName,arguments.propertyMap,arguments.sortorder,arguments.options);
			}else if(structKeyExists(arguments,'options')){
			
				obj=entityLoad (variables.entityName,arguments.propertyMap,false,arguments.options);
			}else if(structKeyExists(arguments,'sortorder')){
				obj=entityLoad (variables.entityName,arguments.propertyMap,arguments.sortorder);
			}else{
				obj=entityLoad (variables.entityName,arguments.propertyMap,false);
			}
			return obj;
		</cfscript>
		
	</cffunction>		
	<cffunction name="delete" access="public" output="false" returntype="void">
		<cfargument name="obj" type="com.silkunion.model.IBusinessObject" required="yes" />
		<cfargument name="flush" type="boolean" required="false" default="true">
		<cfset entityDelete( obj ) />
		<cfif arguments.flush>
			<cfset ormFlush() />
		</cfif>
	</cffunction>

	<cffunction name="new" access="public" output="false" returntype="com.silkunion.model.IBusinessObject">
		<cfset var obj=entityNew(variables.entityName)/>
		<cfreturn configureObject(entityNew(variables.entityName))>
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="com.silkunion.model.IBusinessObject">
		<cfargument name="id" type="any" required="yes" />
		<cfscript>
			var obj=entityLoadByPK( variables.entityName ,id);
			if(!isnull(obj)){return configureObject(obj);}
			throw(type="com.silkunion.persistence.RecordNotFound",message="no record found");
		</cfscript>
	</cffunction>
	<cffunction name="hasBeanInjector" access="private" output="false" returntype="boolean">
		<cfreturn structKeyExists(variables,'beanInjector')/>
	</cffunction>
	<cffunction name="hasSetupMethod" access="private" output="false" returntype="boolean">
		<cfreturn structKeyExists(variables,'setupMethod')/>
	</cffunction>
	<cffunction name="getBeanInjector" access="private" output="false" returntype="any">
		<cfreturn variables.beanInjector/>
	</cffunction>
	<cffunction name="getSetupMethod" access="private" output="false" returntype="any">
		<cfreturn variables.setupMethod/>
	</cffunction>
	<cffunction name="configureObject" access="private" output="false" returntype="com.silkunion.model.IBusinessObject">
		<cfargument name="obj" type="com.silkunion.model.IBusinessObject" required="yes" />
		<cfif hasBeanInjector()>
			<cfset getBeanInjector().autowire(obj)/>
		</cfif>
		<cfif hasSetupMethod()>
			<cfinvoke component="#obj#" method="#getSetupMethod()#"/>
		</cfif>
		<cfreturn obj/>
	</cffunction>
</cfcomponent>