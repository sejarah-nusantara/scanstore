<cfcomponent extends="com.silkunion.Object">
	<cffunction name="init">
		
		<cfreturn this/>
	</cffunction>">

	<cffunction name="createFromStruct" access="public" output="false" returntype="org.dasa.model.ScanImage">
		<cfargument name="data" type="struct" required="false" />
		<cfscript>
			var local = {};
			local.image=createObject('component','org.dasa.model.ScanImage');
			local.image.populate(arguments.data);
			getBeanInjector().autowire(targetComponent=local.image);
			
			return local.image;
		</cfscript>
	</cffunction>
	<cffunction name="setBeanInjector" access="public" returntype="void" output="false">
		<cfargument name="beanInjector" type="any" required="true">
		<cfset variables.beanInjector = arguments.beanInjector >
	</cffunction>
	
	<cffunction name="getBeanInjector" access="private" returntype="any" output="false">
		<cfreturn variables.beanInjector />
	</cffunction>
	
</cfcomponent>