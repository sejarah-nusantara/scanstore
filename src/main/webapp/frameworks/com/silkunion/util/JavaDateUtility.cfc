<cfcomponent output="false" extends="com.silkunion.Object" >
	<cffunction name="init">
		<cfargument name="dateConverter">
		<cfset super.init(argumentCollection=arguments)>
		<cfreturn this/>
	</cffunction>
	<cffunction name="parse"  returnType="date">
		<cfargument name="dateString">
		<cfscript>
			var local={};
			local.parseposition = createObject('java','java.text.ParsePosition').init(0);
			return getDateConverter().parse(dateString,local.parseposition);
		</cfscript>
	</cffunction>
	<cffunction name="isValidDate">
		<cfargument name="dateString">
			<cfscript>
				try{
					
					local.parseposition = createObject('java','java.text.ParsePosition').init(0);
					getDateConverter().parse(dateString,local.parseposition);
				}catch(any e){
					return false;
				}
				return true;
			</cfscript>
			
			
	</cffunction>
	<cffunction name="getDateConverter"  returnType="any">
		<cfscript>
			return variables.instance.dateConverter;

		</cfscript>
		
	</cffunction>

</cfcomponent>