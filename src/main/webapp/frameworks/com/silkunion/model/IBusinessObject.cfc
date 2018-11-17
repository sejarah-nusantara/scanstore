<cfinterface>
	
	<cffunction name="getContext" access="public" output="false" returntype="string" >
    	
	</cffunction>
	<cffunction name="isDirty" access="public" output="false" returntype="boolean" >
    	
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
		

		
	</cffunction>
	
	
	
	<cffunction name="populate" access="public" returntype="any" output="false" hint="Populates the object with values from the arguments">
		<cfargument name="data" type="any" required="yes" />
		<cfargument name="propList" type="any" required="no" />
	</cffunction>
	<cffunction name="setIdentifier" access="public" output="false" returntype="void" >
    	<cfargument name="identifier" type="com.silkunion.model.Identifiable" required="yes" />
    	
    
	</cffunction>
	<cffunction name="getIdentifier" access="public" output="false" returntype="com.silkunion.model.Identifiable" >
    	
    	
    
	</cffunction>
	<cffunction name="setObjectMetaData" access="public" output="false" returntype="void" >
    	<cfargument name="metadata" type="struct" required="yes" />
    	
    
	</cffunction>
	<cffunction name="getObjectMetaData" access="public" output="false" returntype="struct" >
    	
    	
    
	</cffunction>
</cfinterface>