<cfcomponent>

<cfscript>
	function localeWeek(inputDateObj,languageCode,countryCode) {
	var loc 	=  	createObject("java","java.util.Locale").init(languageCode,countryCode);
	var calObj 	= 	createObject("java","java.util.Calendar");
	var c = calObj.getInstance(loc);
	c.setTimeInMillis(inputDateObj.getTime());
	return c.get(c.WEEK_OF_YEAR);
	}
</cfscript>
<cffunction name="getClientLocalTime" returntype="date">
	<cfargument name="clientUtcOffsetInMinutes"/>
	<cfargument name="serverDate"  type="date" />
	
	<cfscript>
		var local={};
		local.serverUtcTime	=	dateConvert('local2Utc',serverDate);
		return dateAdd('n',-clientUtcOffsetInMinutes,local.serverUtcTime);
	
	</cfscript>
	
</cffunction>

</cfcomponent>