<cfcomponent extends="coldspring.aop.MethodInterceptor">

	 <cffunction name="invokeMethod" access="public" returntype="any" output="false">
		<cfargument name="methodInvocation" type="coldspring.aop.MethodInvocation" required="false" />
		<cfscript>
			var local={};
			try{
				return arguments.methodInvocation.proceed();
			} catch(any e){
				local.result = {};
				//todo:add filter expressions via di
				if(!refindNocase("org.dasa|com.silkunion",e.type)){
					//todo: log dump or mail error via notify observer observable add observers via di
					logText(e.message);
					notifyHandlers(e);
					local.result['success']=false;
					local.result['message']="A system error occurred while processing your request. Please contact technical support";
					local.result['type']="org.dasa.system.Error";
				} else {
					local.result['success']=false;
					local.result['message']=e.message;
					local.result['type']=e.type;
				}
				return local.result;
			}
		</cfscript>
	</cffunction>

	<cffunction name="setHandlers">
		<cfargument name="handlers" type="com.silkunion.IObserver[]">
		<cfset variables.handlers= arguments.handlers>
	</cffunction>

	<cffunction name="notifyHandlers">
		<cfargument name="object"/>
		<cfset var handler="">
		<cfloop array="#variables.handlers#" index="handler">
			<cfset handler.update(object)>
		</cfloop>
	</cffunction>

	<cffunction name="logText" access="private" output="false"  returntype="void">
		<cfargument name="message" type="string"/>
		<cflog text="#message#"/>
	</cffunction>

</cfcomponent>