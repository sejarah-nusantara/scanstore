<!--- 
LICENSE 
Copyright 2008 Brian Kotek

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at
	
	    http://www.apache.org/licenses/LICENSE-2.0
	
	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.

	Thanks to Jon Messer for the thread safety patch that added the loadedKey logic.

File Name: 

	BeanInjector.cfc
	
Version: 1.1	

Description: 

	This component will autowire any target component with matching beans from ColdSpring. It is useful for injecting beans into
	"transient" or "per-request" components. It also has advantages over using ColdSpring to manage the non-Singleton objects: 
	
	1. ColdSpring goes through several phases of lookup and resolution when beans are created. This adds performance overhead
	when managing non-Singleton beans. This BeanInjector avoids that overhead.
	
	2. Since ColdSpring creates a fully-initialized component before it returns it to you, you have only limited control over
	how that object is constructed (via the ColdSpring XML configuration). Using this BeanInjector allows you to create and call 
	the init() method on your components, allowing you full control over how they are constructed. 
	
	This makes it much easier to create "rich" objects that can handle much more business logic than objects that can't leverage
	ColdSpring. The dependencies are cached by the BeanInjector for performance. After the first instance of object is created, all 
	subsequent objects of that type will have their dependencies injected using cached information. The component is thread-safe.

Usage:

	Usage of the BeanInjector is fairly straightforward. The ColdSpring XML file might look like this:
		
		<bean id="userService" class="components.userService">
			<property name="beanInjector">
				<ref bean="beanInjector" />
			</property>
		</bean>
		
		<bean id="beanInjector" class="components.BeanInjector" />
		
		<bean id="validatorFactory" class="components.ValidatorFactory" />
	
	Next, I would create public setter method(s) for the bean(s) you want to inject into my component, for example I might
	have a User.cfc with the following method:
	
		<cffunction name="setValidatorFactory" access="public" returntype="void" output="false" hint="I set the ValidatorFactory.">
			<cfargument name="validatorFactory" type="any" required="true" hint="ValidatorFactory" />
			<cfset variables.instance.validatorFactory = arguments.validatorFactory />
		</cffunction>
		
	To autowire a new User inside my UserService, I would simply create the User (either directly or with a factory) and then
	call autowire() on the BeanInjector:
	
		<cfset var user = CreateObject('component', 'components.User').init() />
		<cfset variables.beanInjector.autowire(user) />	
	
	That's it. The User object would now be autowired and have the ValidatorFactory injected into it. The end result is that 
	any setters in your target object that have matching bean IDs in ColdSpring will have those beans injected automatically. 
	As an additional example, a bean with an ID of "productService" would be autowired into a component that had a public setter 
	method named setProductService(), and so on.
	
	There is an optional constructor argument called "suffixList" that can be supplied. This is a comma-delimited list
	of propery name suffixes that will be allowed. If you specify a suffixList, the Observer will only inject beans which
	end in one of the suffixes in the list. For example, if you specify a suffixList of "service", setter methods for
	setUserService() and setLoginService() would be called, but setter methods for setValidatorFactory() or setContext()
	would NOT be called. This can be useful in rare situations where your Transfer Object may have database-driven properties
	that conflict with the names of ColdSpring beans. Most people probably won't need to worry about this, but the option
	is here in case the issue arises.
	
	In case you have problems determining whether beans are being properly injected into your Decorators, there is
	an optional init() method argument called "debugMode". By default, this is false. If you set it to true via the ColdSpring
	XML config file, the component will trace successful dependency injections to the debugging output. It will also
	rethrow any errors that occur while trying to inject beans into your Decorators. Obviously, ensure that this is
	remains off in production.
	
	The autowire() method also has two optional arguments that can be used for small performance increases: 
	
	The first optional argument is "targetComponentTypeName". If the calling code already knows the full type name of the target 
	component, you can pass this string into the autowire() method to avoid the need to look up the type name in the component 
	metadata. For example, Transfer ORM Decorators already know their type, so if you are autowiring a Decorator, you can pass in 
	the type name. The performance differnce is small, but every little bit helps so I made this an option. In most cases, the
	type won't be known by the calling code, so this argument won't be used.
	
	The second optional argument is "stopRecursionAt". This is the full type name of a superclass of the target component at which
	you want dependency resolution lookup to stop. For example, Transfer ORM Decorators inherit from the "transfer.com.TransferDecorator"
	class. However, when autowiring Transfer Decorators, you don't want to waste time trying to resolve dependencies at that level,
	because from that parent class upwards, everything is managed by Transfer. There are no custom properties for you to define at
	that level. Looking for properties to autowire in those parent classes would usually not cause any errors, but it is wasted time.
	By specifying a type name to stop the lookup recursion, you can save some processing time and avoid looking at unnecessary 
	parent classes. Unless the target component is part of some greater framework, such as Transfer, using this optional argument
	will usually be unnecessary.
	
--->

<cfcomponent name="BeanInjector" extends="com.silkunion.util.beanutil.BeanInjector">
	
	<cffunction name="init" access="public" returntype="any" hint="Constructor." output="false">
		
		<cfset super.init("", application.settings.DEBUG ) />
		<cfreturn this />

	</cffunction>
	
</cfcomponent>