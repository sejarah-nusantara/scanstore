﻿<cfcomponent output="false">
	<cfscript>
		this.name="scanstore-"&replace(cgi.server_name,".","-","ALL");
		this.clientmanagement="Yes" ;

		this.sessionmanagement="Yes" ;
		this.setclientcookies="Yes" ;
		this.sessiontimeout="#createTimeSpan(0, 0, 30, 0)#";
		this.applicationtimeout="#createTimeSpan(0, 2, 0, 0)#";
		this.loginstorage="session";
		this.triggerDataMember=true;
		this.rootPath = getDirectoryFromPath(getCurrentTemplatePath());

		this.mappings["/coldspring"] = this.rootPath&"frameworks/coldspring/";
		this.mappings["/config"] = this.rootPath&"frameworks/config/";
		this.mappings["/remote"] = this.rootPath&"frontend/remote/";
		this.mappings["/org/dasa"] = this.rootPath&"frameworks/org/dasa/";
		this.mappings["/com"] = this.rootPath&"frameworks/com/";
		this.mappings["/net"] = this.rootPath&"frameworks/net/";
		this.mappings["/ValidateThis"] = this.rootPath&"frameworks/ValidateThis/";

		this.ormEnabled = datasourceExists();
		this.datasource = "scanstore";
		this.ormSettings = { cfcLocation=[ "/org/dasa/model/user/"], dialect="MySQLwithInnoDB", flushAtRequestEnd='false', eventHandling=true, eventhandler='org.dasa.orm.OrmEventHandlerImpl' };

		this.cryptKey = "Q+NCiyQmUN4XFeLmzdxJBQ==";
	</cfscript>

	<cffunction name="onApplicationStart" returnType="boolean" output="false">
		<cfscript>
			application.directoriesBeingProcessed = {};
			initSettings();
			var ormEnabled = datasourceExists();
			if(structKeyExists(application,"coldspring.beanfactory.root"))
				structDelete(application,"coldspring.beanfactory.root");
			/* Load the ColdSpring Dynamic XML Bean Factory, which will replace any dynamic values in the XML with matching properties specified.*/
			application.beanFactory = createObject('component','com.silkunion.util.beanutil.DynamicXMLBeanFactory').init();
			// Make this instance available in the application scope
			if(NOT structKeyExists(application,"cfc")) application.cfc = this;
		</cfscript>
		<cfapplication action="update" ormEnabled="#ormEnabled#">
		<cfscript>
			if(ormEnabled){
				application.beanFactory.loadBeansFromXmlFile("/config/coldSpringOrm.xml", true);
			} else {
				application.beanFactory.loadBeansFromXmlFile("/config/coldSpringMem.xml", true);
			}
		</cfscript>
		<cfreturn true>
	</cffunction>

	<cffunction name="onRequestStart" returnType="boolean" output="true">
		<cfargument name="targetPage" type="string" required="true" />
		<cfif structKeyExists(url,"reinit")>
			<cfscript>
				onApplicationStart();
			</cfscript>
		</cfif>
		<cfreturn true>
	</cffunction>

	<cffunction name="onSessionEnd" returnType="boolean" output="true">
		<cfargument name="sessionScope" />
		<cfargument name="applicationScope" />
		<cfscript>
			arguments.applicationScope.beanFactory.getBean("userSessionController").logoutUser();
		</cfscript>
		<cfreturn true>
	</cffunction>

	<cffunction name="storeSettings">
		<cfscript>
			var local = {};
			local.remoteConfig = (structKeyExists(application.settings,"CONFIG_LOCATION") AND len(application.settings.CONFIG_LOCATION) gt 0);
			local.localProperties = createObject( 'java', 'java.util.Properties' ).init();
			local.fileStream = getPageContext().getConfig().getClassLoader().getResourceAsStream( 'application.properties' );
			local.localProperties.load( local.fileStream );
			local.fileStream.close();
			if(local.remoteConfig){
				try {
					local.remoteProperties = createObject( 'java', 'java.util.Properties' ).init();
					local.fileStream = createObject( 'java', 'java.io.FileInputStream').init( application.settings.CONFIG_LOCATION&replace(cgi.server_name,".","-","ALL")&'.properties' );
					local.remoteProperties.load( local.fileStream );
					local.fileStream.close();
				} catch(any e){
					try {
						local.remoteProperties = createObject( 'java', 'java.util.Properties' ).init();
						local.fileStream = createObject( 'java', 'java.io.FileInputStream').init( application.settings.CONFIG_LOCATION&'application.properties' );
						local.remoteProperties.load( local.fileStream );
						local.fileStream.close();
					} catch(any e){
						local.remoteProperties = createObject( 'java', 'java.util.Properties' ).init();
					}
				}
			}
			var saveRemote = true;
			var saveLocal = false;
			for(local.property in application.settings){
				if(local.property neq "database_valid"){
					if(local.remoteConfig AND NOT listFind("config_location,version",local.property)){
						local.remoteProperties.setProperty(local.property,application.settings[local.property]);
					} else if(application.settings[local.property] neq local.localProperties.getProperty(local.property)){
						local.localProperties.setProperty(local.property,application.settings[local.property]);
						saveRemote = false;
						saveLocal = true;
					}
				}
			}
			if(saveLocal){
				local.fileStream = createObject( 'java', 'java.io.FileOutputStream').init( this.rootPath&'/WEB-INF/classes/application.properties' );
				local.localProperties.store( local.fileStream, "Scanstore settings" );
				local.fileStream.close();
			}
			if(local.remoteConfig AND saveRemote){
				local.fileStream = createObject( 'java', 'java.io.FileOutputStream').init( application.settings.CONFIG_LOCATION&replace(cgi.server_name,".","-","ALL")&'.properties' );
				local.remoteProperties.store( local.fileStream, "Scanstore settings" );
				local.fileStream.close();
			}
			onApplicationStart();
		</cfscript>
	</cffunction>

	<cffunction name="initSettings">
		<cfscript>
			application.forceConfig = false;
			application.settings = {};
			var local = {};
			local.properties = createObject( 'java', 'java.util.Properties' ).init();
			local.fileStream = getPageContext().getConfig().getClassLoader().getResourceAsStream( 'application.properties' );
			local.properties.load( local.fileStream );
			local.fileStream.close();
			for(local.property in local.properties.propertyNames()){
				application.settings[local.property] = local.properties.getProperty(local.property);
			}
			if(structKeyExists(application.settings,"CONFIG_LOCATION") AND len(application.settings.CONFIG_LOCATION) gt 0){
				try {
					local.properties = createObject( 'java', 'java.util.Properties' ).init();
					local.fileStream = createObject( 'java', 'java.io.FileInputStream').init( application.settings.CONFIG_LOCATION&'application.properties' );
					local.properties.load( local.fileStream );
					local.fileStream.close();
					for(local.property in local.properties.propertyNames()){
						application.settings[local.property] = local.properties.getProperty(local.property);
					}
				} catch(any e){}
				try {
					local.properties = createObject( 'java', 'java.util.Properties' ).init();
					local.fileStream = createObject( 'java', 'java.io.FileInputStream').init( application.settings.CONFIG_LOCATION&replace(cgi.server_name,".","-","ALL")&'.properties' );
					local.properties.load( local.fileStream );
					local.fileStream.close();
					for(local.property in local.properties.propertyNames()){
						application.settings[local.property] = local.properties.getProperty(local.property);
					}
				} catch(any e){}
			}
			for(local.property in application.settings){
				if(len(application.settings[local.property]) is 0){
					application.forceConfig = true;
					break;
				}
			}
			application.settings["database_valid"] = true;
		</cfscript>
		<cfif application.settings.database_connect neq "none">
			<cftry>
				<cfset local.datasource = getDatasourceProperties() />
				<cfset local.driver = createObject("component","lucee-server.admin.dbdriver."&local.datasource.type) />
				<cfadmin action="updateDatasource"
					type="server"
					password="##%6dy6##%$fffgsd758"
					classname="#local.driver.getClass()#"
					dsn="#local.driver.getDSN()#"
					name="scanstore"
					newname="scanstore"
					host="#local.datasource.host#"
					port="#local.datasource.port#"
					database="#local.datasource.database#"
					dbusername="#local.datasource.user#"
					dbpassword="#local.datasource.password#"
					allowed_select="true"
					allowed_insert="true"
					allowed_update="true"
					allowed_delete="true"
					allowed_alter="true"
					allowed_drop="true"
					allowed_create="true"
					custom="characterEncoding=UTF-8&amp;useUnicode=true&amp;allowMultiQueries=true" />
				<cfcatch>
					<cfscript>
						application.settings["database_valid"] = false;
						application.forceConfig = true;
					</cfscript>
				</cfcatch>
			</cftry>
		<cfelseif datasourceExists()>
			<cfadmin action="removeDatasource" type="server" password="##%6dy6##%$fffgsd758" name="scanstore" />
		</cfif>
	</cffunction>

	<cffunction name="getDatasourceDrivers">
		<cfscript>
			local.drivers = [];
			arrayAppend(local.drivers,"DB2");
			arrayAppend(local.drivers,"Firebird");
			arrayAppend(local.drivers,"H2");
			arrayAppend(local.drivers,"H2Server");
			arrayAppend(local.drivers,"HSQLDB");
			arrayAppend(local.drivers,"MSSQL");
			arrayAppend(local.drivers,"MSSQL2");
			arrayAppend(local.drivers,"MySQL");
			arrayAppend(local.drivers,"ODBC");
			arrayAppend(local.drivers,"Oracle");
			arrayAppend(local.drivers,"Other");
			arrayAppend(local.drivers,"PostgreSql");
			arrayAppend(local.drivers,"Sybase");
			return local.drivers;
		</cfscript>
	</cffunction>

	<cffunction name="datasourceExists">
		<cftry>
			<cfset var datasource = "" />
			<cfadmin action="getDatasource" type="server" password="##%6dy6##%$fffgsd758" name="scanstore" returnVariable="datasource" />
			<cfreturn true />
			<cfcatch type="any">
				<cfreturn false />
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="getDatasourceProperties">
		<cfscript>
			var local = {};
			local.connect = application.settings.database_connect;
			local.properties = {
				type: "none",
				user: "",
				password:"",
				host: "",
				port: "",
				database: ""
			};
			if(listLen(local.connect,"|") is 2){
				local.properties.type = listFirst(local.connect,"|");
				local.connect = listLast(local.connect,"|");
				if(listLen(local.connect,"@") is 2){
					local.credentials = listFirst(local.connect,"@");
					if(listLen(local.credentials,":") is 2){
						local.properties.user = listFirst(local.credentials,":");
						local.properties.password = decrypt(listLast(local.credentials,":"),this.cryptKey,"AES","HEX");
					}
					local.location = listLast(local.connect,"@");
					if(listLen(local.location,"/") is 2){
						local.properties.database = listLast(local.location,"/");
						local.location = listFirst(local.location,"/");
						if(listLen(local.location,":") is 2){
							local.properties.host = listFirst(local.location,":");
							local.properties.port = listLast(local.location,":");
						}
					}
				}
			}
			return local.properties;
		</cfscript>
	</cffunction>

	<cffunction name="setDatasourceProperties">
		<cfargument name="properties" type="struct" required="true" />
		<cfscript>
			var local = {};
			if(arguments.properties.type neq "none"){
				local.properties = getDatasourceProperties();
				for(local.property in arguments.properties){
					local.properties[local.property] = arguments.properties[local.property];
				}
				local.connect = local.properties.type&"|";
				local.connect &= local.properties.user&":"&encrypt(local.properties.password,this.cryptKey,"AES","HEX")&"@";
				local.connect &= local.properties.host&":"&local.properties.port&"/";
				local.connect &= local.properties.database;
				application.settings.database_connect = local.connect;
			} else {
				application.settings.database_connect = "none";
			}
		</cfscript>
	</cffunction>

</cfcomponent>