<cfcomponent implements="com.silkunion.control.IValidationController" 
extends="com.silkunion.Object">
	
	<cffunction name="validateData" hint="validate simple form struct" returntype="com.silkunion.model.validation.IValidationMessage[]" >
		<cfargument name="data" type="struct" required="true"/>
		<cfargument name="objectType" required="true" />
		<cfargument name="context" required="false" type="string"  default="*"/>
		<cfscript>
			var errors="";
			var msg=[];
			var identifier=createObject('component','com.silkunion.model.IdentifierImpl');
			var validationResult=getBusinessRuleEngine().validate(objectType=arguments.objectType,theObject=arguments.data,Context=arguments.context);
			var metaData={};
			identifier.setClassName(arguments.objectType);
			
			if(!validationResult.getIsSuccess()){
				errors=validationResult.getFailureMessagesByProperty();
				msg=getMessagefactory().createErrorMessagesForObject(identifier=identifier,metadata=metaData,errors=errors);
					
			}
			
			return msg;
		
		</cfscript>
	</cffunction>
	
	<cffunction name="validateAll" access="public" output="false"  >
		<cfargument name="object" required="true" type="com.silkunion.model.validation.IValidatable" />
		<cfargument name="context" required="false" type="string"  default="*"/>
		<cfargument name="recursive" required="false" type="boolean"  default="true"/>
		<cfargument name="instanceMap" required="false" type="struct"  default="#structnew()#"/>
		<cfscript>
			var properties= getMetadata(object).properties;
			var arr=[];
			var validationResult="";
			var errors={};
			var msg=[];
			//preventing stackoverfow in bidirectional releations
			if(!structKeyExists(arguments.instanceMap,object.objectSerial)){
				validationResult=getBusinessRuleEngine().validate(theObject=arguments.object,Context=arguments.context);
				//preventing stackoverfow in bidirectional releations
				arguments.instanceMap[object.objectSerial]=true;
				
				if(!validationResult.getIsSuccess()){
					
					errors=validationResult.getFailureMessagesByProperty();
					msg=getMessagefactory().createErrorMessagesForObject(identifier=object.getidentifier(),metadata=object.getObjectMetaData(),errors=errors);
					object.getValidationMessages().addAll(msg);
					object.setIsObjectValid(false);
				}
				if(arguments.recursive){
					processProperties(properties,arguments.recursive,arguments.object,arguments.context,arguments.instanceMap);
				}
			
			}
			
		</cfscript>
	</cffunction>
	<cffunction name="validateProperty" access="public" output="false">
		<cfargument name="object" required="true" type="com.silkunion.model.validation.IValidatable" />
		<cfargument name="property" required="true" type="string" />
		<cfargument name="context" required="false" type="string"  default="*"/>
		
		<cfthrow type="com.silkunion.notImplemented" message="the method validateProperty in ValidationVTController is not implemented"/>
		<!---<cfscript>
			var local={};
			local.result=getBusinessRuleEngine().validateProperty(theObject=arguments.object,theProperty=arguments.property);
			if(!local.result.getIsSuccess()){
				local.errors=getMessagefactory().createErrorMessagesForObject(	
																				object.getIdentifier(),
																				object.getObjectMetaData(),
																				local.result.getFailureMessagesByProperty()
																				);
																				
				getResultObject().setInstructions(local.errors);
				getResultObject().setIsValid(false);
				getResultObject().setResult(false);
			}	
		</cfscript>--->
	</cffunction>
	
	<cffunction name="getBusinessRuleEngine" access="public" output="false"  returntype="any">
	
		<cfreturn variables.businessRuleEngine/>
	</cffunction> 
	<cffunction name="setBusinessRuleEngine" access="public" output="false" >
		<cfargument name="businessRuleEngine" type="any" />
		
		<cfset variables.businessRuleEngine = arguments.businessRuleEngine/>
	</cffunction> 
	<cffunction name="getMessagefactory" access="public" output="false"  returntype="com.silkunion.model.validation.IValidationMessageFactory" >
	
		<cfreturn variables.messagefactory/>
	</cffunction> 
	<cffunction name="setMessagefactory" access="public" output="false" >
		<cfargument name="messagefactory" type="com.silkunion.model.validation.IValidationMessageFactory" />
		
		<cfset variables.messagefactory = arguments.messagefactory/>
	</cffunction> 
	<cffunction name="processProperties" access="private" output="false">
	<cfargument name="properties" type="array"/>
	<cfargument name="recursive" type="boolean"/>
	<cfargument name="object" type="any"/>
	<cfargument name="context" type="string"/>
	<cfargument name="instanceMap" type="struct"/>
	<cfscript>
			var i=0;
			var j=0;
			var arr=[];
			var propertyValue="";
			for (i=1; i lte arrayLen(properties); i=i+1) {
				if(structKeyExists(object,'get' & properties[i].NAME)){
				
					propertyValue="";
					object.accessorRef=object['get' & properties[i].NAME];
					propertyValue=object.accessorRef();
					//logtext("isnull #properties[i].NAME# #isnull(propertyValue)#");
					if(!isnull(propertyValue)){
					//logtext("isarray #properties[i].NAME# #isArray(propertyValue)#");
							if(isArray(propertyValue)){
							
								
									
									//only object arrays and com.silkunion.model.IBaseBusinessObject accepted
									for (j=1; j lte arrayLen(propertyValue); j=j+1) {
										
									
										if(isObject(propertyValue[j]) && doesImplement(propertyValue[j],'com.silkunion.model.IBusinessObject')){
											validateAll(propertyValue[j],arguments.context,arguments.recursive,arguments.instanceMap);
										//no mixed arrays alowed
										}else{
											break;
										}
									
									}
							}else if(isObject(object.accessorRef()) && doesImplement(object.accessorRef(),'com.silkunion.model.IBusinessObject')){
								
								validateAll(propertyValue,arguments.context,arguments.recursive,arguments.instanceMap);
							}
							
						}
					}
			
			}
	
	</cfscript>
	</cffunction>
</cfcomponent>