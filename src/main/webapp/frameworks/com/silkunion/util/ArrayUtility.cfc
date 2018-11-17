<cfcomponent output="false" extends="com.silkunion.Object">
	<!--- IMPLEMENTENTATION OF BUBBLE SORT ALGORITHM --->
<cffunction name="sort" access="public" returntype="array">
	<cfargument name="targetArray">
	<cfargument name="comparator" type="com.silkunion.util.IComparable">
	<cfscript>
		
		var i=1;
		var j=1;
		var swapped=false;
		var elem="";
		//NO SORT
		if(arrayLen(arguments.targetArray)==1){
			
			return arguments.targetArray;
		}
		for(i=arrayLen(arguments.targetArray) ; i >=1; i=i-1){
			for(j=1 ;j<i;j++){
					
				if(comparator.compareValues(arguments.targetArray[j],arguments.targetArray[j+1]) == 1){
					elem=arguments.targetArray[j];
					arguments.targetArray[j]=arguments.targetArray[j+1];
					arguments.targetArray[j+1]=elem;
					swapped=true;
				}
				
			}
			
		}
		return arguments.targetArray;
	</cfscript>
</cffunction>
<cffunction name="sum" access="public" returntype="numeric">
	<cfargument name="targetArray">
	<cfargument name="propertyName" type="string">
	<cfscript>
		var accessorRef="";
		var i=1;
		var obj="";
		var total=0;
		var value=0;
		for(i=1; i <= arrayLen(targetArray);i++){
			//try accessor
			obj=targetArray[i];
			if(structkeyExists(obj,'get' & propertyName)){
				obj.accessorRef=obj['get' & propertyName];
				value=obj.accessorRef();
				structDelete(obj,accessorRef);
				if(isNumeric(value)){
					total+=value;
				}else{
					throwException(message="property #propertyName# from #obj.getMetaData().name# is not numeric",
					   type="APPLICATION",
					   detail="ERROR");	
				
				}
				
				
			//try direct access
			}else if(structkeyExists(obj,propertyName)){
				value=obj[propertyName];
				if(isNumeric(value)){
					total+=value;
				}else{
					throwException(message="property #propertyName# from #obj.getMetaData().name# is not numeric",
					   type="APPLICATION",
					   detail="ERROR");	
				
				}
			
			}else{
				throwException(message="property #propertyName# from #obj.getMetaData().name# does not exist",
					   type="APPLICATION",
					   detail="ERROR");	
			
			}
			
			
		}
			
			
		return total;
	</cfscript>
</cffunction>
</cfcomponent>