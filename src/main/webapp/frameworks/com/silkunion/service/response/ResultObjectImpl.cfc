<!---
	The ResultObject is used in most cases if you want to return a value to the client
	but also some instructions with it.

	There are a couple of default constructions for instance the propertyChangeInstruction
	in order to manipulate an object client side.

	Version:	
--->

<cfcomponent 
			 output="false" implements="IResultObject" extends="com.silkunion.Object" 
			 hint="The ResultObject is used in most cases if you want to return a value to the client
	but also add some instructions with it.

	<p>There are a couple of default constructions for instance the PropertyChangeInstruction
	in order to manipulate an object client side.</p>

	<p>Extend this ResultObject in your project ResultObject. The project ResultObject should hold additional methods for project specific service instructions.
			 	This ResultObject only holds methods to create the basic generic instructions.
			 		<p><strong>Example:</strong>
<pre>
&lt;cfcomponent output='false'
	    



&lt;/cfcomponent&gt;
</pre>

<hr>
<p>IMPORTANT NOTICE
<br>================
<br>Properties are not correctly inherrited inside subclasses, so if you implement
<br>this resultObject inside your project, please copy the cfproperty statement
<br>to the sub-ResultObject. otherwise you will get the exception this.result is undefined</p>
<hr>

">


	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services,
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.

		 IMPORTANT NOTICE
		 ================
		 Properties are not correctly inherrited inside subclasses, so if you implement
		 this resultObject inside your project, please copy the cfproperty statement
		 to the sub-ResultObject. otherwise you will get the exception this.result is undefined
	--->
	<cfproperty name="result" type="any" default="" hint="The actual result requested for.">
	<cfproperty name="instructions" type="array" default="" hint="0 or more instructions for the GUI, these instructions are all typed objects. ">
	<cfproperty name="isValid" type="boolean" default="true" hint="">
	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.result = "";
		variables.validationMessages = [];
		variables.isValid=true;
	</cfscript>

	<cffunction name="init" output="false" >
		<cfreturn this>
	</cffunction>
	<cffunction access="public" name="getIsValid" output="false" returntype="boolean">
		<cfreturn variables.isValid/>
	</cffunction>
	<cffunction access="public" name="setIsValid" output="false" returntype="void">
		<cfargument name="val" type="boolean" required="true">
		<cfset variables.isValid=arguments.val/>
	</cffunction>
	<cffunction access="public" name="getResult" output="false" returntype="any">
		<cfreturn variables.result>
	</cffunction>

	<cffunction access="public" name="setResult" output="false" returntype="void">
		<cfargument name="val" type="any" required="true">
		<cfscript>
			variables.result = arguments.val;
			
		</cfscript>
	</cffunction>

	<cffunction access="public" name="getValidationMessages" output="false" returntype="com.silkunion.validation.IValidationMessage[]" >
		<cfreturn variables.validationMessages/>
	</cffunction>

	<cffunction access="public" name="setValidationMessages" output="false" returntype="void">
		<cfargument name="val" type="com.silkunion.validation.IValidationMessage[]" required="true">
		<cfset variables.validationMessages=arguments.val/>
	</cffunction>


	
</cfcomponent>