<cfcomponent persistent="true" table="scanstore_roles"  serializable="true" extends="com.silkunion.model.BaseBusinessObjectImpl" output="false">

	<cfproperty name="roleid" column="roleid" type="numeric" ormtype="int" fieldtype="id" generator="identity" />
	<cfproperty name="roleName" column="role_name" type="string" ormtype="string" />
	<cfproperty name="roleDescription" column="role_description" type="string" ormtype="string" />

</cfcomponent>
