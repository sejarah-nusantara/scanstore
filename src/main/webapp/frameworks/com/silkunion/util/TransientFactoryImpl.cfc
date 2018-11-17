<cfcomponent displayname="TransientFactory" output="false" hint="I create Transient objects." extends="com.silkunion.Object" implements="com.silkunion.util.IFactory">
<!--- 
<cfset initArgs = StructNew()>
<cfset initArgs.myprop = "myvalue">
<cfset result = TransientFactory.create("Result",initArgs)>
<beans>
<bean id="beanInjector" class="model.BeanInjector" singleton="true" />

<bean id="TransientFactory" class="model.TransientFactory" singleton="true">
<constructor-arg name="classes">
<map>
<entry key="ServiceResult">
<value>model.util.ServiceResult</value>
</entry>
<entry key="Timer">
<value>model.util.Timer</value>
</entry>
</map>
</constructor-arg>
<constructor-arg name="afterCreateMethod">
<value>setup</value>
</constructor-arg>
<property name="beanInjector">
<ref bean="beanInjector" />
</property>
</bean>
</beans> --->
<!--- public --->

<cffunction name="init" access="public" output="false" returntype="any" hint="returns a configured transient factory">
<cfargument name="classes" type="struct" required="false" default="#StructNew()#">
<cfargument name="afterCreateMethod" type="string" required="false" default="">
<cfset variables.classes = arguments.classes>
<cfset variables.afterCreateMethod = arguments.afterCreateMethod>
<cfreturn this />
</cffunction>

<cffunction name="create" access="public" output="false" returntype="any" hint="returns a configured, autowired transient">
<cfargument name="transientName" type="string" required="true">
<cfargument name="initArgs" type="struct" required="false" default="#structNew()#">
<cfset var obj = createObject("component",getTransientClassPath(arguments.transientName))>
<cfif StructKeyExists(obj,"init")>
<cfinvoke component="#obj#" method="init" argumentcollection="#initArgs#" />
</cfif>
<cfset getBeanInjector().autowire(targetComponent=obj, targetComponentTypeName=arguments.transientName) />
<cfif StructKeyExists(obj,variables.afterCreateMethod)>
<cfinvoke component="#obj#" method="#variables.afterCreateMethod#" />
</cfif>
<cfreturn obj>
</cffunction>

<cffunction name="getClasses" access="public" output="false" returntype="struct" hint="returns map of classes that can be created.">
<cfreturn variables.classes>
</cffunction>

<cffunction name="onMissingMethod" access="public" output="false" returntype="any" hint="provides virtual api [new{transientName}] for any registered transient.">
<cfargument name="MissingMethodName" type="string" required="true" />
<cfargument name="MissingMethodArguments" type="struct" required="true" />
<cfif (len(arguments.MissingMethodName) gt 3) and (Left(arguments.MissingMethodName,3) is "new")>
<cfreturn create(Right(arguments.MissingMethodName,Len(arguments.MissingMethodName)-3),arguments.MissingMethodArguments)>
</cfif>
</cffunction>

<!--- private --->

<cffunction name="getTransientClassPath" access="private" output="false" returntype="string" hint="returns the transient class path.">
<cfargument name="transientName" type="string" required="true">
<cfreturn variables.classes[arguments.transientName]>
</cffunction>

<!--- dependencies --->

<cffunction name="setBeanInjector" access="public" returntype="void" output="false">
<cfargument name="BeanInjector" type="any" required="true">
<cfset variables.BeanInjector = arguments.BeanInjector >
</cffunction>

<cffunction name="getBeanInjector" access="public" returntype="any" output="false">
<cfreturn variables.BeanInjector />
</cffunction>

</cfcomponent>