<!---
	This class is the placeholder for convert methods for translating object trees.
	In this class object trees will be converted to diferent types. See function comment
	for further explanation.

	Note:
	This class contains state variables, therefore it cannot be used within the application
	scope and should be created each time it is used.

	Version: $Id: ObjectTreeConvertor.cfc 15639 2010-06-21 11:26:53Z marwor $
--->
<cfcomponent extends="com.silkunion.Object" output="false"
			hint="This class is the placeholder for convert methods for translating object trees. In this class object trees will be converted to diferent types. See function comment for further explanation. Note: This class contains state variables, therefore it cannot be used within the application scope and should be created each time it is used. Version: $Id: ObjectTreeConvertor.cfc 15639 2010-06-21 11:26:53Z marwor $">
	<cfscript>
		/*
		 * Collection of objects that are already translated
		 * This collection will prevent endless loops when circular references
		 * are active.
		 */
		variables.translatedObjects = arrayNew(1);
	</cfscript>

	<cffunction access="public" name="reset" returntype="void" output="false">
		<cfset variables.translatedObjects = arrayNew(1)>
	</cffunction>

	<!---
		This method converts an object tree to a struct with coldfusion own types.
		Components will be converted to structs with simple values.

		This method will keep track of the translated objects and checks if it is used already
		When it is used already an empty struct is returned. Otherwise an endless loop will be
		created in case of a bi-directional/circular relationship
	--->
	<cffunction access="public" name="translateObjectTreeToStruct" returntype="struct" output="false"
				hint="This method converts an object tree to a struct with coldfusion own types. Components will be converted to structs with simple values. This method will keep track of the translated objects and checks if it is used already. When it is used already an empty struct is returned. Otherwise an endless loop will be created in case of a bi-directional/circular relationship">
		<cfargument name="object" type="any" required="true">

		<cfscript>
			var i = 1;
			var value = "";
			var tValue = "";
			var propertyName = "";
			var properties = "";
			var structKeys = "";
			var retVal = structNew();
			var metaData = getMetaData(ARGUMENTS.object);

			/*
			 * Only translate the object when it is not already translated (bi-directionally).
			 */
			if (isInstanceOf(ARGUMENTS.object, "com.silkunion.Object")) {
				if (!isObjectTranslated(ARGUMENTS.object)) {
					/*
					 * Register the object in the translated object collection
					 */
					arrayAppend(variables.translatedObjects, ARGUMENTS.object.objectSerial);

					/*
					 * Store the origional type of the object in the type variable
					 */
					structInsert(retVal, "___type___", metaData.name);

					/*
					 * Iterate through all properties so struct keys can be added for them
					 */
					if (isDefined("metaData.properties") && isArray(metaData.properties)) {
						properties = metaData.properties;
						for (i=1; i <= arrayLen(properties); i++) {
							propertyName = properties[i].name;

							/*
							 * Validate whether the property is defined in the object and
							 * Retrieve the value of the current property and select the
							 * appropriate translation action.
							 */
							if (!structKeyExists(ARGUMENTS.object,"get#propertyName#")) {
								ARGUMENTS.object.funcRef = ARGUMENTS.object['get#propertyName#'];
								value = ARGUMENTS.object.funcRef();
							} else {
								value = ARGUMENTS.object[propertyName];
							}

							/*
							 * Translate the current value and add it to the structure
							 */
							if (isDefined("value")) {
								tValue = translateValue(value);
								if(!isNull(tValue)){
									structInsert(retVal, propertyName, tValue);
								}
							}
						}
					}
				}
			} else if (isStruct(ARGUMENTS.object)) {
				/*
				 * Copy the struct
				 * Iterate through the struct keys of the current struct so new struct keys can be added for them
				 */
				structKeys = structkeyarray(ARGUMENTS.object);
				for (i=1; i <= arrayLen(structKeys); i++) {
					value = structFind(ARGUMENTS.object, structKeys[i]);
					/*
					 * Translate the current value and add it to the structure
					 */
					tValue = translateValue(value);
					if(!isNull(tValue)){
						structInsert(retVal, structKeys[i], tValue);
					}

				}
			}
			return retVal;
		</cfscript>
	</cffunction>

	<!---
		This method will translate the provided value to a coldfusion own type.
	--->
	<cffunction access="public" name="translateValue" returntype="any" output="false"
				hint="This method will translate the provided value to a coldfusion own type.">
		<cfargument name="origionalValue" type="any" required="true">

		<cfscript>
			var i = 1;
			var newValue = "";

			if (isSimpleValue(ARGUMENTS.origionalValue)) {
				return ARGUMENTS.origionalValue;
			} else if (isQuery(ARGUMENTS.origionalValue)) {
				return copyQuery(ARGUMENTS.origionalValue);
			} else if (isStruct(ARGUMENTS.origionalValue)) {
				return translateObjectTreeToStruct(ARGUMENTS.origionalValue);
			} else if (isArray(ARGUMENTS.origionalValue)) {
				newValue = arrayNew(1);
				for (i=1; i <= arrayLen(ARGUMENTS.origionalValue); i++) {
					arrayAppend(newValue, translateValue(ARGUMENTS.origionalValue[i]));
				}
				return newValue;
			}
		</cfscript>
	</cffunction>

	<!---
		This method will copy a query result to a new query
	--->
	<cffunction access="private" name="copyQuery" returntype="query" output="false"
				hint="This method will copy a query result to a new query">
		<cfargument name="origionalQuery" type="query" required="true">

		<cfset var newQuery = "">

		<!---
			The query of query copies the origional query while quering,
			therefore just a simple query of query is enough
		--->
		<cfquery name="newQuery" dbtype="query">
			SELECT * FROM ARGUMENTS.origionalQuery
		</cfquery>

		<cfreturn newQuery>
	</cffunction>

	<!---
		This method will determine whether or not an object is already active in the
		translated objects collection and therefore has been converted already as a result of a
		bi-directional or circular reference.
	--->
	<cffunction access="private" name="isObjectTranslated" returntype="boolean" output="false"
				hint="This method will determine whether or not an object is already active in the translated objects collection and therefore has been converted already as a result of a bi-directional or circular reference.">
		<cfargument name="originalValue" type="com.silkunion.Object"  required="true">

		<cfscript>
			var i = 1;

			/*
				Identifier objects are allways returned and translated, the identifier should not
				implement bi-directional relationships.
			*/


			for (i=1; i <= arrayLen(variables.translatedObjects); i++) {
				if (variables.translatedObjects[i] == ARGUMENTS.originalValue.objectSerial) {
					return true;
				}
			}

			return false;
		</cfscript>
	</cffunction>
</cfcomponent>