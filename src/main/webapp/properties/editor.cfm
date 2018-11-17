<cfoutput>
<cfif structCount(form) gt 0>
	<cfloop collection="#application.settings#" item="setting">
		<cfswitch expression="#setting#">
			<cfcase value="debug">
				<cfset application.settings[setting] = structKeyExists(form,setting) />
			</cfcase>
			<cfdefaultcase>
				<cfif structKeyExists(form,setting)>
					<cfset application.settings[setting] = form[setting] />
				</cfif>
			</cfdefaultcase>
		</cfswitch>
	</cfloop>
	<cfscript>
		datasource = {};
		if(len(form.datasource_type) gt 0) datasource.type = form.datasource_type;
		if(len(form.datasource_user) gt 0) datasource.user = form.datasource_user;
		if(len(form.datasource_password) gt 0) datasource.password = form.datasource_password;
		if(len(form.datasource_host) gt 0) datasource.host = form.datasource_host;
		if(len(form.datasource_port) gt 0) datasource.port = form.datasource_port;
		if(len(form.datasource_database) gt 0) datasource.database = form.datasource_database;
		application.cfc.setDatasourceProperties(datasource);
		application.cfc.storeSettings();
	</cfscript>
	<h3>application.properties <i>updated</i></h3>
<cfelse>
	<h3>application.properties</h3>
</cfif>
<form method="post">
<p>
	<ul>
	<cfloop collection="#application.settings#" item="setting">
		<li><i>#setting#</i> :
		<cfif listFind("version,database_valid",setting) is 0>
			<cfswitch expression="#setting#">
				<cfcase value="database_connect">
					<b>#application.settings[setting]#</b>
					<cfset drivers = application.cfc.getDatasourceDrivers() />
					<cfset datasource = application.cfc.getDatasourceProperties() />
					<ul>
					<li><i>Database type</i> : <select name="datasource_type">
					<cfloop array="#drivers#" index="driver">
						<option value="#driver#" <cfif datasource.type eq driver>selected="selected"</cfif>>#driver#</option>
					</cfloop>
						<option value="none" <cfif datasource.type eq "none">selected="selected"</cfif>>None</option>
					</select></li>
					<li><i>Database name</i> : <input type="text" name="datasource_database" value="#datasource.database#" /></li>
					<li><i>Database user</i> : <input type="text" name="datasource_user" value="#datasource.user#" /></li>
					<li><i>Database password</i> : <input type="password" name="datasource_password" /></li>
					<li><i>Database host</i> : <input type="text" name="datasource_host" value="#datasource.host#" /></li>
					<li><i>Database port</i> : <input type="text" name="datasource_port" value="#datasource.port#" /></li>
					</ul></li>
				</cfcase>
				<cfcase value="debug">
					<input type="checkbox" name="#setting#" <cfif application.settings[setting]>checked="checked"</cfif> />
				</cfcase>
				<cfdefaultcase>
					<input type="text" name="#setting#" value="#application.settings[setting]#" />
				</cfdefaultcase>
			</cfswitch>
		<cfelse>
		<b>#application.settings[setting]#</b>
		</cfif>
		</li>
	</cfloop>
	</ul>
	<input type="submit" name="type" value="Save">
</form>
</cfoutput>