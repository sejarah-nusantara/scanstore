<cfcomponent output="false" extends="coldspring.beans.factory.FactoryBean">

  <cfset SCOPE_KEY = "__com_mentor_util_bean_scope_factory_cache_key__" />

  <cffunction name="init" access="public" output="false" returntype="BeanScopeCache">
    <cfargument name="targetBeanName" type="string" required="true" />
    <cfargument name="scope" type="string" required="true" />
    <cfargument name="bindToBeanFactory" type="string" default="false"
      hint="Whether to bind instances to this bean factory.  Ignored for singletons." />
    <cfset variables.targetBeanName = targetBeanName />
    <cfset variables.scope = scope />
    <cfset variables.bindToBeanFactory = bindToBeanFactory />
    <cfreturn this />
  </cffunction>

  <cffunction name="setBeanFactory" access="public" output="false" returntype="void">
    <cfargument name="beanFactory" type="coldspring.beans.BeanFactory" required="true" />
    <cfset variables.beanFactory = beanFactory />
    <cfset INSTANCE_ID = createObject("java", "java.lang.System").identityHashCode(beanFactory) />
  </cffunction>

  <cffunction name="isSingleton" access="public" output="false" returntype="boolean">
    <cfreturn scope EQ "singleton" />
  </cffunction>

  <cffunction name="getObject" access="public" output="false" returntype="any">
    <cfset var key = SCOPE_KEY & targetBeanName />
    <cfset var container = "" />
    <cfif bindToBeanFactory>
      <cfset key &= INSTANCE_ID />
    </cfif>
    <cfswitch expression="#scope#">
      <cfcase value="prototype">
        <cfset container = {} />
      </cfcase>
      <cfcase value="request">
        <cfset container = request />
      </cfcase>
      <cfcase value="session">
        <cfset container = session />
      </cfcase>
      <cfcase value="singleton">
        <cfset container = variables />
      </cfcase>
      <cfdefaultcase>
        <cfthrow type="IllegalArgumentException"
          message="The '#scope#' scope is not supported." />
      </cfdefaultcase>
    </cfswitch>
    <cfif NOT structKeyExists(container, key)>
      <cfset container[key] = beanFactory.getBean(targetBeanName) />
    </cfif>
	<cflog text="#key# called"/>
    <cfreturn container[key] />
  </cffunction>

</cfcomponent>