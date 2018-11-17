<cfcomponent output="false"  implements="com.silkunion.model.validation.IValidationMessage"  extends="com.silkunion.Object" >
	
	<cfproperty name="message" type="string" default="">
	<cfproperty name="messageType" type="string" default="">
	<cfproperty name="property" type="string" default="">
	<cfproperty name="identifier" type="com.silkunion.model.Identifiable" />
	<cfproperty name="objectMetadata" type="struct" />
		
	
	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.message = "";
		variables.messageType = "";
		variables.identifier = createObject('component','com.silkunion.model.IdentifierImpl');
		variables.objectmetadata 	= {};
		variables.property	= "";
		
		this.MESSAGE_TYPE_INFO="infoMessage";
		this.MESSAGE_TYPE_WARNING="warningMessage";
		this.MESSAGE_TYPE_ERROR="errorMessage"; 
	</cfscript>

	<cffunction name="init" output="false" returntype="com.silkunion.model.validation.ValidationMessageImpl" >
		<cfreturn this>
	</cffunction>
	<cffunction name="getProperty" output="false" access="public"  returntype="string">
		<cfreturn variables.property>
	</cffunction>

	<cffunction name="setProperty" output="false" access="public" returntype="void">
		<cfargument name="val" required="true" type="string">
		<cfset variables.property = arguments.val>
	</cffunction>
	<cffunction name="getMessage" output="false" access="public" returntype="string">
		<cfreturn variables.message>
	</cffunction>

	<cffunction name="setMessage" output="false" access="public" returntype="void">
		<cfargument name="val" required="true" type="string">
		<cfset variables.message = arguments.val>
	</cffunction>

	<cffunction name="getMessageType" output="false" access="public" returntype="string">
		<cfreturn variables.messageType>
	</cffunction>

	<cffunction name="setMessageType" output="false" access="public" returntype="void">
		<cfargument name="val" required="true" type="string">
		<cfset variables.messageType = arguments.val>
	</cffunction>
	<cffunction name="getIdentifier" output="false" access="public" returntype="com.silkunion.model.Identifiable">
		<cfreturn variables.identifier>
	</cffunction>

	<cffunction name="setIdentifier" output="false" access="public" returntype="void">
		<cfargument name="val" required="true" type="com.silkunion.model.Identifiable" >
		<cfset variables.identifier = arguments.val>
	</cffunction>
	<cffunction name="getObjectMetadata" output="false" access="public" returntype="struct">
		<cfreturn variables.objectmetadata>
	</cffunction>

	<cffunction name="setObjectMetadata" output="false" access="public" returntype="void">
		<cfargument name="val" required="true" type="struct">
		<cfset variables.objectmetadata = arguments.val>
	</cffunction>

</cfcomponent>