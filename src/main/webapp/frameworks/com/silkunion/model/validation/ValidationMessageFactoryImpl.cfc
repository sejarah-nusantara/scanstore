<cfcomponent output="false" extends="com.silkunion.Object" implements="com.silkunion.model.validation.IValidationMessageFactory" >
	<cffunction name="createErrorMessagesForObject" returntype="com.silkunion.model.validation.IValidationMessage[]"  >
		<cfargument name="identifier"/>
		<cfargument name="metadata" required="false" default="#structNew()#"/>
		<cfargument name="errors" type="struct"/>
		<cfscript>
			local.messages=[];
			logText("msg factory called " );
		for(local.error in arguments.errors){
				local.errorArray=arguments.errors[local.error];
					//logText("setting message property " & local.error);
				for(local.i =1; local.i <= arrayLen(local.errorArray);local.i++){
					local.message=createObject('component','com.silkunion.model.validation.ValidationMessageImpl');
					local.message.setMessageType(local.message.MESSAGE_TYPE_ERROR);
					local.message.setMessage(local.errorArray[local.i]);
					local.message.setIdentifier(arguments.identifier);
					local.message.setObjectMetadata(arguments.metadata);
					//logText("setting message property in message object " & local.error);
					local.message.setProperty(local.error);
					arrayAppend(local.messages,local.message);
				}
			}
			return local.messages;
		</cfscript>
	
	
	</cffunction>


</cfcomponent>