### SpEL spring表达式语言

参考指南

#### 2.1 文本表达式

文本表达式支持字符表达式、日期、数字（正数、实数及十六进制数）、布尔类型及null.其中字符表达式需要用单引号声明，对数字支持负数、指数及小数。默认情况下实数使用Double.parseDouble()进行表达式类型转换
```
String[] lELs = { "'hello SpEL'", "1.028E+7", "0x12EF", "true", "null" };
assertEquals("hello SpEL",
		exp.parseExpression(lELs[0]).getValue(String.class));
assertEquals(new Double(10280000), exp.parseExpression(lELs[1])
		.getValue(Double.class));
assertEquals(new Integer(4847),
		exp.parseExpression(lELs[2]).getValue(Integer.class));
assertTrue(exp.parseExpression(lELs[3]).getValue(Boolean.class));
assertNull(exp.parseExpression(lELs[4]).getValue());
```

#### 2.2 属性、数组、列表、字典(map)及索引

在表达式中访问类属性时直接使用属性名，属性名首字母大小写均可。

访问数组时可以使用[index]进行元素对象范围。

访问列表时，可直接使用类表的方法，通过点操作符
```
// 属性测试。time为SpElUtil类Date型数据，这里调用Date的属性Year
assertEquals(new Integer(2011), exp.parseExpression("time.Year + 1900")
		.getValue(secontext, Integer.class));
// 属性测试。innerClass为SpElUtil类中引入的其他类。
assertEquals(29,
		exp.parseExpression("innerClass.age").getValue(secontext));
// 设置SpElUtil类的numbers属性
spel.setNumbers(Arrays.asList(2, 3, 4, 5, 6, 7, 9));
// 访问对象属性数组通过索引
assertEquals(2, exp.parseExpression("numbers[0]").getValue(secontext));
// 访问map
assertEquals("string1",
		exp.parseExpression("maps[1]")
				.getValue(secontext, String.class));
				
```
#### 2.3 内置列表
列表可以直接表示在表达式中使用{}符号表达。{}本身代表一个空的list
```
// 构造list
List<String> nums = (List<String>) exp.parseExpression(
		"{'a','b','c','d'}").getValue();
assertEquals(Arrays.asList("a", "b", "c", "d"), nums);
// 构造List<List<>>
List listOfLists = (List) exp.parseExpression("{ {1,2},{3,4} }")
		.getValue(secontext);
assertEquals(Arrays.asList(1, 2), listOfLists.get(0));
```

#### 2.4 数组构造
通过熟悉的java语法在表达是语言中定义
```
// 创建没有初始值的数组
int[] a = (int[]) exp.parseExpression("new int[4]").getValue();
assertEquals(4, a.length);
// 创建带有初始值的数组
int[] b = (int[]) exp.parseExpression("new int[4]{1,2,3,4}").getValue();
assertEquals(3, b[2]);
// 创建二维数组
int[][] c = (int[][]) exp.parseExpression("new int[4][5]").getValue();
assertEquals(4, c.length);
assertEquals(5, c[0].length);

```
#### 2.5 方法调用
表达式中的方法调用遵循java语法。
```
assertEquals("abC2def",
		exp.parseExpression("'abcdef'.replace('c','C2')").getValue(
					String.class));
// 自定义类方法测试
assertFalse(exp.parseExpression("innerClass.isGt30ForAge()").getValue(
		secontext, Boolean.class));
spel.getInnerClass().setAge(34);
assertTrue(exp.parseExpression("innerClass.isGt30ForAge()").getValue(
		secontext, Boolean.class));
```

#### 2.6 操作符
##### 2.6.1 关系操作符
支持eq("==")、ne("!=")、le("<=")、lt("<")、gt(">")、ge(">=")、div("/")、mod("%")、not("!")、正则表达式及instanceof操作
```
assertTrue(exp.parseExpression("1 == 1").getValue(Boolean.class));
assertTrue(exp.parseExpression("1 eq 1").getValue(Boolean.class));
assertTrue(exp.parseExpression("1 > -1").getValue(Boolean.class));
assertTrue(exp.parseExpression("1 gt -1").getValue(Boolean.class));
assertTrue(exp.parseExpression("'a' < 'b'").getValue(Boolean.class));
assertTrue(exp.parseExpression("'a' lt 'b'").getValue(Boolean.class));
assertTrue(exp.parseExpression(
		" new Integer(123) instanceof T(Integer) ").getValue(
		Boolean.class));
assertTrue(exp.parseExpression("'5.00' matches '^-?\\d+(\\.\\d{2})?$'")
			.getValue(Boolean.class));
```

##### 2.6.2 逻辑操作符
逻辑操作符支持and,or,not
```
assertTrue(exp.parseExpression("true and true").getValue(Boolean.class));
```
##### 2.6.3 数学运算操作符
加法运算符可以用于数字，字符串和日期。减法可以用在数字和日期。乘法和除法只能用于对数字。其他受支持的数学运算是模数（％）和指数幂（^）。运行顺序按标准运算符优先级执行
```
assertEquals(25.0,
		exp.parseExpression("1 + 2 * 8 div 4 mod 2 + 2 ^ 3 * 3e0")
				.getValue());
```
#### 2.7 赋值操作
通过赋值操作进行属性设置。通常是调用setValue方法，但也可以在调用getValue时设置。
```
Date oldDate = spel.getTime();// 获取当前time属性值
exp.parseExpression("time").setValue(secontext, new Date(113, 2, 25)); // 为time属性重新赋值
Date newDate = spel.getTime();// 获取赋值后的time属性值
assertEquals(2013,
		exp.parseExpression("time.Year + 1900").getValue(secontext));
assertNotSame(oldDate, newDate);
// 或者使用下属方法赋值
assertEquals("abc",
		exp.parseExpression("Name = 'abc'").getValue(secontext));
```
#### 2.8 类型
通过特殊的T操作符可以用来指定一个java.lang.Class的实例。在实例话对象的静态方法将会被调用。
```
Class dateClass = exp.parseExpression("T(java.util.Date)").getValue(Class.class);
assertEquals("java.util.Date", dateClass.getName());
assertTrue(exp
		.parseExpression(
				"T(java.math.RoundingMode).CEILING < T(java.math.RoundingMode).FLOOR")
		.getValue(Boolean.class));	
```
#### 2.9 构造器
构造器通过new操作被调用。在new操作时需要指明类的完全类名(包括包路径)
```
SpelTestInnerClass spt = exp
		.parseExpression(
				"new  leeyee.study.spring3.bean.SpelTestInnerClass('constructTest',23)")
		.getValue(SpelTestInnerClass.class);
```
#### 2.10 变量
变量可以通过 #变量名 在表达式中被引用。变量通过StandardEvaluationContext类的setVariable方法进行设置
```
List<Integer> list = new ArrayList<Integer>();
list.addAll(Arrays.asList(2, 3, 4, 5, 6, 7, 9));
secontext.setVariable("list", list);
List<Integer> vList = (List<Integer>) exp.parseExpression("#list")
		.getValue(secontext);
assertEquals(vList, list);
```
#### 2.10.1 #this变量
变量#this被定义为当前操作对象的引用。
```
List<Integer> nums = (List<Integer>) exp.parseExpression(
		"#list.?[#this >5]").getValue(secontext); // 获取值大于5的元素集合
assertEquals(nums, Arrays.asList(6, 7, 9));
```

#### 2.11 用户自定义函数
你可以扩展SpEL通过注册自定义函数。注册后的函数可以在表达式中通过其名称进行调用。函数的注册是通过StandardEvaluationContext类的registerFunction方法进行声明
```
context.registerFunction("len", SpElUtil.class.getDeclaredMethod("len",
		new Class[] { String.class }));
assertEquals(3, exp.parseExpression("#len('abc')").getValue(context));
```
#### 2.12 三元操作
```
assertTrue(exp.parseExpression(" true ? true :false").getValue(
		Boolean.class));
```
#### 2.13 Elvis操作
Elvis操作是一个短的三元操作符语法，通常在Groovy语言中使用。

Note: Elvis操作在表达式中可以用来生成默认值，当被访问属性为空时。比如@Value
```
@Value("#systemPro['mail.port'] ? : 25}")
// 当mail.port为空时将默认为25
Expression ex = exp.parseExpression("name?:'name is null'");
assertEquals("override", ex.getValue(secontext, String.class));
spel.setName(null);
assertEquals("name is null", ex.getValue(secontext, String.class));
spel.setName("override");
```

#### 2.14 安全导航操作
该操作是为避免空指针异常。他是来自Groovy语言的。典型的当你有一个指向对象的引用，在你访问其方法或属性时，可能需要验证该对象的方法或属性是否为空，为了避免验证，使用安全导航操作将简单的返回null而不是空指针异常。
```
assertEquals("innerClass", exp.parseExpression("innerClass?.name")
		.getValue(secontext, String.class));
spel.setInnerClass(null);
// 使用这种表达式可以避免抛出空指针异常
assertNull(exp.parseExpression("innerClass?.name").getValue(secontext,
		String.class));
```
#### 2.15 集合选择
选择是一个强大的表达式语言属性，可以使用选择表达式过滤源集合，从而生成一个新的符合选择条件的集合

选择的语法为`?[selectionExpression]`。他将过滤集合并且返回一个新的集合（原集合的子集）。选择语句也可用在Map中，过滤keySet及valueSet分别使用key和value关键字。另外：选择语法中，选择符合条件的结果集的第一个元素的语法为` ^[selectionExpression]`，选择最后一个元素的语法为`$[selectionExpression]`
```
spel.setNumbers(Arrays.asList(2, 3, 4, 5, 6, 7, 9));
List<Integer> nums = (List<Integer>) exp.parseExpression(
		"numbers.?[#this >5]").getValue(secontext);
assertEquals(nums, Arrays.asList(6, 7, 9));
// 获取第一个元素
assertEquals(6,
		exp.parseExpression("numbers.^[#this > 5]").getValue(secontext));
        
// 获取最后一个元素
assertEquals(9,
		exp.parseExpression("numbers.$[#this > 5]").getValue(secontext));
Map<Integer, String> maps = (Map<Integer, String>) exp.parseExpression(
		"maps.?[value == 'string3' ]").getValue(secontext);
Map<Integer, String> tmap = new HashMap<Integer, String>();
tmap.put(3, "string3");
assertEquals(maps, tmap);
Map<Integer, String> mapk = (Map<Integer, String>) exp.parseExpression(
		"maps.?[key > 2 and key < 4 ]").getValue(secontext);
assertEquals(mapk, tmap);
```
#### 2.16 集合投影
语法`![projectionExpression]`判断集合中每个元素是否符合语法要求
```
assertEquals(Arrays.asList(5, 6, 7, 8, 9), exp
		.parseExpression("numbers.![#this+3]").getValue(secontext));
```
#### 2.17 模板表达式
表达式模板允许混合文字表达式，一个或多个值计算块。每一个值计算块被声明通过可被自定义的前缀和后缀，一般选择使用#{}作为一个定界符。
```
assertEquals(
		" this is a test 4",
		exp.parseExpression(" this is a test #{ maps.![key].get(3)}",
				new TemplateParserContext()).getValue(secontext,
				String.class));
```


1. 字面值表达式
2. 布尔值和关系操作符
3. 正则表达式
4. 类表达式
5. 访问properties，arrays，lists，maps
6. 方法调用
7. 关系操作符
8. 赋值
9. 调用构造器
10. Bean引用
11. 数组构造器
12. 一致lists
13. 一致maps
14. 三元操作符
15. 变量
16. 用户自定义的函数
17. 集合投影
18. 集合选择
19. 模板表达式

`ExpressionParser` 负责解析表达式字符串的
`Expression` 负责封装已定义的表达式字符串

SpEL支持调用方法，访问属性，调用构造器

SpEL也支持嵌套属性使用标准的点符号，例如pro.prop1.prop2

SpEL表达式可以被用于XML和基于注解的配置元数据 使用`#{expression string}`的形式

安全导航操作: ? 典型的当你有一个指向对象的引用，在你访问其方法或属性时，可能需要验证该对象的方法或属性是否为空，为了避免验证，使用安全导航操作将简单的返回null而不是空指针异常。

通过特殊的T操作符可以用来指定一个java.lang.Class的实例。在实例话对象的静态方法将会被调用。

```
<bean id="numberGuess" class="org.spring.samples.NumberGuess">
    <property name="randomNumber" value="#{ T(java.lang.Math).random() * 100.0 }"/>
</bean>
```

```
<bean id="taxCalculator" class="org.spring.samples.TaxCalculator">
    <property name="defaultLocale" value="#{ systemProperties['user.region'] }"/>
</bean>
```
```
<bean id="numberGuess" class="org.spring.samples.NumberGuess">
    <property name="randomNumber" value="#{ T(java.lang.Math).random() * 100.0 }"/>
</bean>

<bean id="shapeGuess" class="org.spring.samples.ShapeGuess">
    <property name="initialShapeSeed" value="#{ numberGuess.randomNumber }"/>
</bean>
```
基于注解的配置
 `@Value("#{ systemProperties['user.region'] }")` 可以用于字段，方法，方法参数/构造器参数上

#### 语言说明文档
1. 字面值表达式 支持字符串，日期，数值(整型，实际值，十六进制)，布尔值，null


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
