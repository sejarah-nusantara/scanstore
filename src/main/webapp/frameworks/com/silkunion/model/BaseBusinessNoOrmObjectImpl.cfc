<cfcomponent extends="com.silkunion.model.BaseBusinessObjectImpl">

<!--- override populate --->
	<cffunction name="populate" access="public" returntype="any" output="false" hint="Populates the object with values from the arguments">
			<cfargument name="data" type="any" required="yes" />
			<cfargument name="propList" type="any" required="no" default="#ArrayNew(1)#" />
			<cfscript>
				var item="";
				var fRef="";
				//for now only flat (form)  data is suppported non recursive
				for(item in arguments.data){
					
					if(structKeyExists(data,item) && isSimpleValue(data[item])){
						if(propList.size() && arrayFindNoCase(arguments.propList,item)){
							fRef= this['set' & item];
							fRef(data[item]);
						
						}else if(!propList.size() && structKeyExists(this,'set' & item)){
							
							fRef= this['set' & item];
							fRef(data[item]);
						}
						
					
					}
					
				
				}
				
				
			
			</cfscript>
			
	</cffunction>
</cfcomponent>