<cfcomponent extends="com.silkunion.Object"  
implements="com.silkunion.model.IBusinessObject,com.silkunion.model.validation.IValidatable" >
	<cfproperty  name="validationMessages" type="com.silkunion.model.validation.IValidationMessage[]"/>
	<cfscript>
			
	</cfscript>
	<cffunction name="init" access="Public" returntype="any" output="false" hint="I build a new object.">
		<cfscript>
			configure();
		
		</cfscript>
		<cfreturn this />
	</cffunction>
	<cffunction name="configure" retturntype="void">
	
		<cfscript>
			variables.Metadata = getMetadata(this) ;
			variables.identifier=createObject("component",'com.silkunion.model.IdentifierImpl');
			variables.identifier.setClassName(variables.Metadata.fullname);
			variables.hasDirtyProp=false;
			variables.instanceId="";
			variables.objectmetadata={};
			variables.context="*"; 
			variables.validationMessages=[];
			variables.isObjectValid=true;
			variables.Metadata.cleanseInput=false;
			
		</cfscript>
	
	</cffunction>
	
	<cffunction name="populate" access="public" returntype="any" output="false" hint="Populates the object with values from the arguments">
		<cfargument name="data" type="any" required="yes" />
		<cfargument name="propList" type="any" required="no" default="#ArrayNew(1)#" />
		
		<cfset var properties=variables.Metadata.properties/>
		
		<cfloop array="#properties#" index="local.theProperty">
			<!--- If a propList was passed in, use it to filter --->
			<cfif NOT ArrayLen(arguments.propList) OR ArrayContains(arguments.propList,local.theProperty.name)>
				<!--- Do columns --->
				<cfif NOT StructKeyExists(local.theProperty,"fieldType") OR local.theProperty.fieldType EQ "column">
					<cfif StructKeyExists(arguments.data,local.theProperty.name)>
						<!--- The property has a matching argument --->
						<cfset local.varValue = arguments.data[local.theProperty.name] />
						<!--- For nullable fields that are blank, set them to null --->
						<cfif (NOT StructKeyExists(local.theProperty,"notNull") OR NOT local.theProperty.notNull) AND NOT Len(local.varValue)>
							<cfset _setPropertyNull(local.theProperty.name) />
						<cfelse>
							<!--- Cleanse input? --->
							<cfparam name="local.theProperty.cleanseInput" default="#variables.Metadata.cleanseInput#" />
							<cfif local.theProperty.cleanseInput>
								<cfset local.varValue = _cleanse(local.varValue) />
							</cfif>
							<cfset _setProperty(local.theProperty.name,local.varValue) />
						</cfif>
					</cfif>
				<!--- do many-to-one --->
				<cfelseif local.theProperty.fieldType EQ "many-to-one">
					<cfif StructKeyExists(arguments.data,local.theProperty.fkcolumn)>
						<cfset local.fkValue = arguments.data[local.theProperty.fkcolumn] />
					<cfelseif StructKeyExists(arguments.data,local.theProperty.name)>
						<cfset local.fkValue = arguments.data[local.theProperty.name] />
					</cfif>
					<cfif StructKeyExists(local,"fkValue")>
						<cfset local.varValue = EntityLoadByPK(local.theProperty.name,local.fkValue) />
						<cfif IsNull(local.varValue)>
							<cfif NOT StructKeyExists(local.theProperty,"notNull") OR NOT local.theProperty.notNull>
								<cfset _setPropertyNull(local.theProperty.name) />
							<cfelse>
								<cfthrow detail="Trying to load a null into the #local.theProperty.name#, but it doesn't accept nulls." />
							</cfif>
						<cfelse>
							<cfset _setProperty(local.theProperty.name,local.varValue) />
						</cfif>
					</cfif>
				</cfif>
			</cfif>
		</cfloop>
	</cffunction>
	
	<cffunction name="setInstanceId" access="public" output="false" returntype="void" >
    	<cfargument name="instanceId" type="string" required="yes" />
    	<cfset variables.instanceId=arguments.instanceId/>
    <!--- dummy setter --->
	</cffunction>
	<cffunction name="getInstanceId" access="public" output="false" returntype="string" >
    	
    	<cfreturn variables.instanceId/>
	</cffunction>
	
	<cffunction name="setIdentifier" access="public" output="false" returntype="void" >
    	<cfargument name="identifier" type="com.silkunion.model.Identifiable" required="yes" />
    	 <cfset variables.identifier= arguments.identifier/>
    
	</cffunction>
	
	<cffunction name="setup" returntype="void">
		<cfscript>
			setInstanceId(createObject('java','java.util.UUID').randomUUID().toString());
			getIdentifier().addIdentifierPart("instanceId",getInstanceId());
			
		</cfscript>
	</cffunction>
	<cffunction name="getIdentifier" access="public" output="false" returntype="com.silkunion.model.Identifiable" >
    	
    		<cfreturn  variables.identifier/>
	</cffunction>

	<cffunction name="setIsDirty" access="public" output="false" returntype="void" >
    	<cfargument name="isDirty" type="boolean" required="yes" />
		<cfscript>
			variables.hasDirtyProp=arguments.isDirty;
		</cfscript>
    
	</cffunction>
	<cffunction name="isDirty" access="public" output="false" returntype="boolean" >
    	<cfscript>
    		return variables.hasDirtyProp;
   		 </cfscript>
	</cffunction>
	<cffunction name="setObjectMetaData" access="public" output="false" returntype="void" >
    	<cfargument name="metadata" type="struct" required="yes" />
    	
    	<cfset variables.objectmetadata=arguments.objectmetadata/>
	</cffunction>
	<cffunction name="getObjectMetadata" access="public" output="false" returntype="struct" >
    	
    	<cfreturn variables.objectmetadata/>
    
	</cffunction>
<!--- Generic update function for the business objects --->
	<cffunction access="public" name="updateProperty" returntype="void"
				hint="Update the properties given in the propertyChangeEvent
					<p><strong>returns</strong>
					<ul><li><strong>true</strong>, if everything is succesfull.</li>
					<li><strong>false and/or exception</strong>, on a validation faillure</li>
					
					</ul>
					</p>
					 <p>PropertyChangeEvent:</p>
						   <table>
						    <tr><td><strong>Property</strong></td><td><strong>Value</strong></td></tr>
						    <tr><td><code>id</code></td><td>The identifier of the businessobject.</td></tr>
						    <tr><td><code>kind</code></td><td >The kind of change; UPDATE
						             or DELETE.</td></tr>
						    <tr><td><code>property</code></td><td>The property that changed</td></tr>
							<tr><td><code>oldValue</code></td><td>The original property value.</td></tr>
						    <tr><td><code>newValue</code></td><td>The new property value.</td></tr>
						  </table>">
		<cfargument name="propertyChangeEvent" type="struct" required="true">
		

			<!--- update the property with the new value by calling the setter --->
			<cfscript>
				var setterRef=this["set#propertyChangeEvent.property#"];
				setterRef(propertyChangeEvent.newValue);
				setIsDirty(true);
			</cfscript>

	</cffunction>
	
	
	
	<cffunction name="getContext" access="public" output="false" returntype="string" >
    	<cfreturn variables.context/>
		
	</cffunction>
	<cffunction name="setContext" access="public" output="false" returntype="void" >
   	 <cfargument name="context"/>
		<cfset variables.context=arguments.context/>
	</cffunction>
	<cffunction name="validate" access="public" output="false" returntype="void"  hint="VO object validates itself">
	 	<cfargument name="recursive" required="false" type="boolean"  default="true"/>
	 	<cfscript>
	 		 getValidationController().validateAll(this,getContext(),arguments.recursive);
	 		
		</cfscript>
	</cffunction>
	<cffunction name="validationMessagesToString" access="public" output="false" returntype="string"  hint="VO object validates itself">
	 	<cfargument name="pagebreak" type="string" required="false" default="\n"/>
	 	<cfscript>
	 		var local={};
			local.messages=getValidationMessages();
			local.stringBuffer= createObject('java','java.lang.StringBuffer');
			for(local.i = 0 ; local.i < local.messages.size() ; local.i++ ){
				local.stringBuffer.append(local.messages.get(local.i).getMessage() & arguments.pagebreak);
			}
	 		return local.stringBuffer.toString();
		</cfscript>
	</cffunction>
	<cffunction name="setIsObjectValid" access="public" output="false" returntype="void" >
	 	<cfargument name="isObjectValid"  type="boolean"  />
		<cfset variables.isObjectValid=arguments.isObjectValid/>
	</cffunction>
	<cffunction name="isObjectValid" access="public" output="false" returntype="boolean" >
	 	<cfreturn variables.isObjectValid/>
	</cffunction>
	<cffunction name="getValidationMessages" access="public" output="false" returntype="com.silkunion.model.validation.IValidationMessage[]" >
	 	<cfreturn variables.validationMessages/>
	</cffunction>
	<cffunction name="getValidationController" access="public" output="false" returntype="com.silkunion.control.IValidationController"  hint="VO object validates itself">
	 <cfreturn variables.validationController/>
	</cffunction>
	<cffunction name="setValidationController" access="public" output="false" returntype="void"  hint="VO object validates itself">
	 	<cfargument name="validationController" type="com.silkunion.control.IValidationController"/>
		<cfset variables.validationController=arguments.validationController/>
	</cffunction>
	
	
	
	
	<!--- These private methods are used by the populate() method --->

	<cffunction name="_setProperty" access="private" returntype="void" output="false" hint="I set a dynamically named property">
		<cfargument name="name" type="any" required="yes" />
		<cfargument name="value" type="any" required="false" />
		<cfset var theMethod = this["set" & arguments.name] />
		<cfif IsNull(arguments.value)>
			<cfset theMethod(javacast('NULL', '')) />
		<cfelse>
			<cfset theMethod(arguments.value) />
		</cfif>
	</cffunction>
	
	<cffunction name="_setPropertyNull" access="private" returntype="void" output="false" hint="I set a dynamically named property to null">
		<cfargument name="name" type="any" required="yes" />
		<cfset _setProperty(arguments.name) />
	</cffunction>

	<cffunction name="_cleanse" access="private" returntype="any" output="false" hint="I cleanse input via HTMLEditFormat. My implementation can be changed to support other cleansing methods.">
		<cfargument name="data" type="any" required="yes" />
		<cfreturn HTMLEditFormat(arguments.data) />
	</cffunction>
</cfcomponent>