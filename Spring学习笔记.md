### 核心类介绍

##### `DefaultListableBeanFactory`
该类是整个bean加载的核心部分，是spring注册及加载bean的默认实现

各个类的作用：
1. `AliasRegistry`：定义对alias的简单的增删改查操作
2. `SimpleAliasRegistry`：主要使用map作为alias的缓存，并对接口`AliasRegistry`进行实现
3. `SingletonBeanRegistry`： 定义对单例的注册和获取
4. `BeanFactory`：定义获取bean和bean的各种属性
5. `DefaultSingletonBeanRegistry`：对接口`SingletonBeanRegistry`各函数的实现
6. `HierarchicalBeanFacotry`：继承`BeanFactory`，增加了对`parentFactory`的支持
7. `BeanDefinitionRegistry`：定义对`BeanDefinition`的各种增删改查操作
8. `FactoryBeanRegistrySupport`：在`DefaultSingletonBeanRegistry`基础上增加了对FactoryBean的特殊处理功能
9. `ConfigurableBeanFactory`：提供配置Factory的各种方法
10. `ListableBeanFactory`：根据各种条件获取bean的配置清单
11. `AbstractBeanFactory`：综合`FactoryBeanRegistrySupport`和`ConfigurableBeanFactory`的功能
12. `AutowireCapableBeanFactory`：提供创建Bean，自动注入，初始化以及应用bean的后处理器
13. `AbstractAutowireCapableBeanFactory`：综合`AbstractBeanFactory`并对接口`AutowireCapableBeanFactory`进行实现
14. `ConfigurableListableBeanFactory`：`BeanFactory`配置清单，指定忽略类型及接口等
15. `DefaultListableBeanFactory`：综合上面所有功能，主要是对Bean注册后的处理

#### `org.springframework.beans.factory.BeanFactory` 接口
访问Spring bean容器的根接口，这是bean容器最基础的客户端视图

该接口的实现类包含多个Bean的定义，每一个bean都有一个唯一的字符串名称，取决于bean定义，该工厂将会返回一个包含对象的独立实例(原型模式)或者一个共享的单例(单例模式)，该接口是应用组件的核心注册表，也是应用组件的核心配置，建议使用set方法或构造器的依赖注入而不是轮询。

和`ListableBeanFactory`的方法相反，`HierarchicalBeanFactory`接口将会检查父工厂接口，如果bean没有在该接口的实例中找到，它会立即调用父工厂，该接口中的bean会自动覆盖父接口中同名的bean

初始化方法和执行顺序：
1. `BeanNameAware`的`setBeanName`方法
2. `BeanClassLoaderAware`的`setBeanClassLoader`方法
3. `BeanFactoryAware`的`setBeanFactory`方法
4. `EnvironmentAware`的`setEnvironment`方法
5. `EmbeddedValueResolverAware`的`setEmbeddedValueResolver`方法
6. `ResourceLoaderAware`的`setResourceLoader`方法
7. `ApplicationEventPublisherAware`的`setApplicationEventPublisher`方法
8. `MessageSourceAware`的`setMessageSource`方法
9. `ApplicationContextAware`的`setApplicationContext`方法
10. `ServletContextAware`的`setServletContext`方法
11. `BeanPostProcessors`的`postProcessBeforeInitialization`方法
12. `InitializingBean`的`afterPropertiesSet`方法
13. 自定义初始化方法
14. `BeanPostProcessors`的`postProcessAfterInitialization`方法

关闭BeanFactory的生命周期方法：
1. `DestructionAwareBeanPostProcessors`的`postProcessBeforeDestruction`方法
2. `DisposableBean`的`destroy`方法
3. 自定义销毁方法

#### BeanFactory的方法
1. `Object getBean(String name)` 根据名称获取bean对象
2. `<T> T getBean(Class<T> requiredType)` 根据class获取bean对象
3. `boolean containsBean(String name)` 判断是否包含该名称的bean对象
4. `boolean isSingleton(String name)` 判断该bean是否是单例的
5. `boolean isPrototype(String name)` 判断该bean是否是原型的
6. `boolean isTypeMatch(String name, Class<?> typeToMatch)` 判断出该bean是否是类型匹配的
7. `Class<?> getType(String name)` 获取bean的Class
8. `String[] getAliases(String name)` 获取该bean的别名

#### `XmlBeanDefinitionReader`类
涉及到的类：
1. `ResourceLoader`：定义资源加载器，主要应用于根据给定的资源文件地址返回对应的Resource
2. `BeanDefinitionReader`：主要定义资源文件读取并转换为BeanDefinition的各个功能
3. `EnvironmentCapable`：定义获取Environment的方法
4. `DocumentLoader`：定义从资源文件加载到转换为Document的功能
5. `AbstractBeanDefinitionReader`：对`EnvironmentCapable`和`BeanDefinitionReader`的实现
6. `BeanDefinitionDocumentReader`：定义读取Document并注册BeanDefinition功能
7. `BeanDefinitionParserDelegate`：定义解析Element的各种方法

读取XML配置文件的流程：
1. 通过继承自`AbstractBeanDefinitionReader`中的方法，来使用`ResourceLoader`将资源文件路径转换为对应的Resource文件
2. 通过`DocumentLoader`对Resource进行转换，将Resource文件转换为Document文件
3. 通过实现接口`BeanDefinitionDocumentReader`的`DefaultBeanDefinitionDocumentReader`类对Document进行解析，并使用`BeanDefinitionParserDelegate`对Element进行解析



### 依赖注入
Spring的依赖注入容器的核心是`BeanFactory`接口，该接口的主要任务就是管理组件，包括组件的依赖和它们的生命周期。

Bean配置以实现了`BeanDefinition`接口的实例类表示，存储了自身的信息和它的依赖。

`BeanFactory`的实现类也实现了`BeanDefinitionReader`接口，你可以使用` PropertiesBeanDefinitionReader`或`XmlBeanDefinitionReader`从配置文件中读取`BeanDefinition`数据。


### 使用注入参数
```
<bean id="injectSimple" class="com.apress.prospring4.ch03.InjectSimple">
        <property name="name" value="John"/>
        <property name="age" value="20"/>
        <property name="height" value="1.75"/>
        <property name="programmer" value="false"/>
        <property name="ageInSeconds" value="1000000"/>
</bean>
```
注入集合

```
<map>
  <entry key="someValue">
    <value>Hello World!</value>
  </entry>
  <entry key="someBean">
    <ref local="oracle"/>
  </entry>
</map>
```
```
<props>
  <prop key="firstName">Chris</prop>
  <prop key="secondName">Schaefer</prop>
</props>
```
```
<set>
  <value>Hello World!</value>
  <ref local="oracle"/>
</set>
```

```
<list>)
  <value>Hello World!</value>
  <ref local="oracle"/>
</list>
```
```
<util:map id="map" map-class="java.util.HashMap">
  <entry key="someValue">
    <value>Hello World!</value>
  </entry>
  <entry key="someBean">
    <ref bean="oracle"/>
  </entry>
</util:map>)
```

```
<util:properties id="props">
  <prop key="firstName">Chris</prop>
  <prop key="secondName">Schaefer</prop>
</util:properties>
 ```
 ```
<util:set id="set">
  <value>Hello World!</value>
  <ref bean="oracle"/>
</util:set>
 ```
 ```
<util:list id="list">
  <value>Hello World!</value>
  <ref bean="oracle"/>
</util:list>
```

#### 使你的Bean **Spring Aware**

使用`BeanNameAware`接口

获取实现该接口的类的名称，该接口只有一个方法`setBeanNme(String)`，Spring调用该方法当它配置完你的Bean之后，在任何生命周期回调函数被调用之前。

使用`ApplicationContextAware`接口


### spring的io学习

`org.springframework.core.io.InputStreamSource`接口

一个`InputStream`源的对象的简单接口，只有一个方法`getInputStream` 获取一个`InputStream`对象

`org.springframework.core.io.Resource`
该接口继承了`InputStreamSource`接口

一个资源描述者抽象于潜在资源的实际类型的接口，像文件资源或者类路径资源
方法：
1. `boolean exists()` 判断资源是否存在
2. `boolean isReadable()` 判断资源是否可读
3. `boolean isOpen()` 判断是否可以打开
4. `URL getURL()` 获取URL
5. `URI getURI()` 获取URI
6. `File getFile()` 获取文件
7. `long contentLength()` 获取内容长度
8. `long lastModified()` 获取上次修改时间
9. `Resource createRelative(String relativePath)` 创建相对路径资源
10. `String getFilename()` 获取文件资源
11. `String getDescription()` 获取描述

`org.springframework.core.io.ContextResource` 接口
继承`Resource`接口

从一个封闭的context加载资源的扩展接口，例如从`javax.servlet.ServletContext` 或者`javax.portlet.PortletContext`但是也从普通的类路径或者相对的文件系统路径

`String getPathWithinContext()` 获取上下文中的路径

`org.springframework.core.io.WritableResource` 接口

扩展接口，一个资源支持写操作，提供了一个`getOutputStream`方法 获取输出流访问器

1. `boolean isWritable()` 判断该资源是否是可写的
2. `OutputStream getOutputStream()`获取输出流

**`org.springframework.core.io.AbstractResource`**
抽象类，特别重要再仔细看看，原来是个垃圾，很多方法都没有实现

那实现了那些方法呢？
1. `public boolean exists()`，如果文件能打开，就表示存在，如果出现异常了，那就不存在
2. `public long contentLength()`获取文件的内容长度，就是一个字节一个字节的读，然后统计所有的字节

反正这个类只是一个抽象类，也没有什么作用，只是定义了一个模板而已

`FileSystemResource`底层使用`java.io.File`实现的

`PathResource` 底层使用java7的NIO实现的，这个比上面的那个高级

`InputStreamResource` 底层使用`java.io.InputStream`实现

`ByteArrayResource` 底层使用字节数组实现

`DescriptiveResource` 更是垃圾，一点用处都没有

`VfsResource` JBOSS VFS实现

还是直接看`ClassPathResource` 这个类吧，应该是最常用的加载资源的类

总体上还是了解了Spring加载文件的方式
1. 使用`FileSystemResource`。底层使用`java.io.File`
2. 使用`PathResource`，底层使用`java.io.nio.Files`
3. 使用`ClassPathResource` 使用类加载器进行文件的加载

这几个方法都没有什么特点，目的就是加载文件

