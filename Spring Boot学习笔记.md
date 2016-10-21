### Spring Boot 精要

1. 自动配置：针对很多Spring应用常见的应用功能，能自动提供相关配置。
2. 起步依赖：告诉Spring Boot需要什么功能，它就能引入需要的库。
3. 命令行界面：可选特性，无需传统项目构建。
4. Actuator：让你能够深入运行中的Spring Boot应用程序，一探究竟。

#### Actuator
提供在运行时检视应用程序内部情况的能力，包括以下细节：

1. Spring应用程序上下文里配置的Bean
2. Spring Boot的自动配置做的决策
3. 应用程序取到的环境变量，系统属性，配置属性和命令行参数
4. 应用程序里线程的当前状态
5. 应用程序最近处理过的HTTP请求的追踪情况
6. 各种和内存用量，垃圾回收，web请求以及数据源用量相关的指标

## 开发第一个应用程序

### 运行Spring boot

#### 查看初始化的Spring Boot项目

##### 启动引导Spring
`ReadingListApplication`在Spring Boot应用程序中有两个作用：配置和启动引导。

`@SpringBootApplication`开启了Spring组件扫描和Spring Boot的自动配置功能，它是将三个有用的注解组合到了一起。

`@Configuration`：标明该类使用Spring基于Java的配置

`@ComponentScan`：启用组件扫描

`@EnableAutoConfiguration`开启了Spring boot自动配置的魔力，让你不再写成篇的配置。

##### 测试Spring Boot应用程序
`@SpringApplicationConfiguration`通过Spring Boot加载Spring的上下文

##### 配置应用程序属性
通过**application.properties**文件可以帮你细粒度的调整Spring Boot的自动配置

#### 使用起步依赖
1. 指定基于功能的依赖
2. 覆盖起步依赖引入的传递依赖

#### 使用自动配置
1. 专注于应用程序的功能

#### Spring的条件化配置
条件化配置允许配置存在于应用程序中，但在满足某些特定条件之前都忽略这个配置，实现`Condition`接口，覆盖它的`matches()`方法，就可以很容易的编写自己的条件。

```
package readinglist;
import org.springframework.context.annotation.Condition;
import org.springframework.context.annotation.ConditionContext;
import org.springframework.core.type.AnnotatedTypeMetadata;

public class JdbcTemplateCondition implements Condition {
  @Override
  public boolean matches(ConditionContext context,
                AnnotatedTypeMetadata metadata) {
    try {
    context.getClassLoader().loadClass(
    "org.springframework.jdbc.core.JdbcTemplate");
    return true;
    } catch (Exception e) {
    return false;
    }
  }
}


```

当你用Java来声明Bean的时候,可以使用这个自定义条件类:
```
@Conditional(JdbcTemplateCondition.class)
public MyService myService() {
  ...
}
```
在这个例子当中，只有当JdbcTemplateCondition类的条件成立时才会创建`MyService`这个Bean

#### Spring Boot提供的条件化注解

`@ConditionOnBean` 配置了某个特定的Bean

`@ConditionOnMissingBean` 没有配置特定的Bean

`@ConditionOnClass` Classpath里有指定的类

自动配置会做出以下配置决策：
1. 因为Classpath里有H2，所以会创建一个嵌入式的H2数据库的Bean
2. 因为Classpath里有Hibernate的实体管理器，所以自动配置与Hibernate相关的Bean
3. 因为Classpath里有Spring Data JPA，所以它会自动配置为根据仓库的接口创建仓库实现
4. 因为Classpath里有Thymeleaf，所以Thymeleaf会配置为Spring MVC的视图，包括一个模板解析器，模板引擎，及视图解析器
5. 因为Classpath里有Spring MVC，所以会配置Spring的DispatcherServlet，并启用Spring MVC
6. 因为这是一个Spring MVC Web应用程序，所以会注册一个资源处理器，把相对于Classpath根目录的/static目录里的静态资源提供出来
7. 因为Classpath里有Tomcat，所以会启动一个嵌入式的Tomcat容器，监听8080端口

### 自定义配置

#### 自动配置微调

1. 禁用模板缓存 spring.thymeleaf.cache设置为false
2. 配置嵌入式服务器 server
3. 配置日志 logging
4. 配置数据源 spring.datasource
5. 使用Profile进行配置
6. 定制应用程序错误页面

Spring Boot默认提供这个whitelabel错误页

Spring Boot自动配置的默认错误处理器会查找名为error的视图，如果找不到就用默认的白标错误视图。

最简单的方法就是创建一个自定义视图，让解析出的视图名为error

取决于错误视图解析时的视图解析器
1. 实现了Spring的VIew接口的Bean，其ID为error
2. 如果配置了Thymeleaf,则有名为error.html的模板
3. 如果配置了FreeMarker，则有名为error.ftl的模板
4. 如果配置了Velocity，则有名为error.vm的模板
5. 如果是用JSP视图，则有名为error.jsp的模板

默认情况下，Spring Boot会为错误视图提供以下错误属性：
1. timestamp 错误发生的时间
2. status HTTP状态码
3. error 错误原因
4. exception 异常的类名
5. message 异常消息
6. errors BindingResult异常里的各种错误
7. trace 异常跟踪信息
8. path 异常发生时请求的URL路径

覆盖自动配置很简单，就是显示的编写那些没有Spring Boot时你要做的Spring配置

### 测试

#### 自动配置
Spring Boot不会自动生成代码

首先Spring Boot会导入缺失的依赖，接下来，它检查到你需要一个Spring Boot Web Starter因为你使用了SpringMVC的注解。最后它会增加必要的注解来触发其他的自动配置

#### 禁用一个具体的配置
使用`@EnableAutoConfiguration(exclude=[ActiveMQAutoConfiguration.class])`来禁用具体的配置

`SpringApplication`类
从Java main方法中启动和加载spring应用

默认情况下，将会执行以下步骤来启动应用：
1. 创建合适的`ApplicationContext`实例，取决于你的Classpath
2. 注册`CommandLinePropertySource`，来解析命令行参数到Spring属性
3. 刷新应用上下文，加载所有的单例Bean
4. 触发任意`CommandLineRunner`Bean

默认情况下，直接使用`run()`启动应用

为了更高级的配置，创建`SpringApplication`实例，在运行之前自定义配置

##### 自定义banner
使用`SpringApplication`的`setBanner()`方法

默认情况下，Spring Boot会在Classpath路径下寻找banner.txt文件

你可以通过设置banner.location=classpath:/META-INF/banner.txt来修改banner的位置

你也可以删除banner
`spring.main.banner-mode=off`

`SpringApplicationBuilder` 一个流式的API来构建`SpringApplication`,这是另外一种方式配置Spring Boot应用

主要作用：
1. 使用`child()`方法加载其他额外配置
2. 使用`sources()`方法加载应用引导类
3. 使用`web()`方法设置是否启动web
4. 使用`logStartupInfo()`设置是否启用启动信息
5. 使用`banner()`方法设置自定义banner
6. 使用`bannerMode()` 设置Banner显示模式
7. 使用`properties()`方法设置属性
8. 使用`profile()` 方法激活配置
9. 使用`listener()`方法设置应用事件监听器
10. 使用`run()`方法启动Spring Boot应用

##### 应用参数
`ApplicationArguments` 接口
提供访问被用来运行`SpringApplication`的参数

`getSourceArgs` 获取原始未处理的参数

`getOptionsNames` 获取所有参数的名称

`containsOption` 判断是否包含某个名称的参数

`getNonOptionArgs` 获取所有非选项参数的集合

##### `ApplicationRunner`和`CommandLineRunner`
允许应用启动之前执行代码

#### 应用配置
Spring Boot有不同的选项可以保存应用配置：
1. 使用application.properties
2. 使用application.yml
3. 使用环境变量
4. 使用命令行参数

应用配置属性顺序：由高到低
1. 命令行参数
2. SPRING_APPLICATION_JSON
3. JDNI
4. System.getProperties()
5. OS环境变量
6. 随机值属性源
7. 包外的application-{profile}.jar
8. 包内的application-{profile}.jar
9. 包外的application.properties文件
10. 包内的application.properties文件
11. `@PropertySource`
12. SpringApplication.setDefaultProperties

#### Spring Boot CLI

##### run命令
语法：`spring run [options] <files> [--] [args]`
1. `--autoconfigure[boolean]`
2. `--classpath,-cp`
3. `--no-guess-dependencies`
4. `--no-guess-imports`
5. `-q,--quiet`
6. `-v,--verbose`
7. `--watch`

例子：`spring run -v WebApp.java`

##### test命令
语法：`spring test [options] <files> [--] [args]`

例子：`spring test test.groovy`

##### grab命令
该命令将会下载所有的Spring脚本和Java依赖到本地maven仓库

语法：`spring grab [options] <files> [--] [args]`

##### jar命令
创建一个自我包含的可执行jar包

语法：`spring jar [options] <jar-name> <files>`

##### war命令
语法：`spring war [options] <war-name> <files>`

##### install命令
语法：`spring install [options] <coordinates>`

##### uninstall命令
语法：`spring uninstall [options] <coordinates>`

##### init命令
语法：`spring init [options] [location]`

参数：
1. `-a, --artifactId`
2. `-b, --boot-version`
3. `--build`
4. `-d, --dependencies`
5. `--description`
6. `-f, --force`
7. `--format`
8. `-g, --groupId`
9. `-j, --java-version`
10. `-l, --language`
11. `-n, --name`
12. `-p, --packaging`
13. `--package-name`
14. `-t, --type`
15. `--target`
16. `-v, --version`
17. `-x, --extract`

##### shell命令
语法：`spring shell`
##### help命令
语法：`spring help`

```
@EnableJms JMS技术
@EnableCaching 缓存抽象
@EnableRabbit rabbitMQ
@EnableBatchProcessing Spring批处理
@EnableWebSecurity Spring安全
@EnableRedisHttpSession Spring session
@EnableJpaRepositories Spring data
@EnableIntegration Spring集成
```

### 测试
重点在于web的测试，有空了解一下spring的test框架

### Mybatis-Spring-Boot-Starter介绍

基于Spring Boot框架构建mybatis应用

使用该模块你可以完成：
1. 构建独立的应用
2. 减少冗余到0
3. 更少的XML配置

#### 安装
如果你使用maven，只需要在pom.xml中添加以下依赖
```
<dependency>
    <groupId>org.mybatis.spring.boot</groupId>
    <artifactId>mybatis-spring-boot-starter</artifactId>
    <version>1.1.1</version>
</dependency>
```

#### 快速搭建
用Spring使用Mybatis至少需要一个`SqlSessionFactory`和至少一个mapper接口

mybatis-spring-boot-starter将会：
1. 自动探测一个已存在的`DataSource`
2. 将会以`DataSource`作为输入参数创建和注册`SqlSessionFactory`实例
3. 将会创建和注册一个`SqlSessionTemplate`实例
4. 自动扫描你的mappers，链接它们到`SqlSessionTemplate`，并把它们注册到Spring的上下文以便可以被注入到你的Bean中

#### 高级扫描
默认情况下，mybatis-spring-boot-starter将会扫描标记有`@Mapper`注解的类

你可以自定义一个注解或标记来实现扫描，如果这样的话，你必须使用`@MapperScan`注解

如果在spring上下文中存在多个`MapperFactoryBean`，mybatis-spring-boot-starter不会开启扫描处理

#### 使用sqlSession
一个`SqlSessionTemplate`的实例被创建和添加到spring的上下文
这样你可以注入到你自己的Bean中

```
@Component
public class CityDao {

	@Autowired
	private SqlSession sqlSession;

	public City selectCityById(long id) {
		return this.sqlSession.selectOne("selectCityById", id);
	}
}
```

#### 配置
配置参数存储在`application.properties`文件中

MyBatis使用前缀`mybatis`来设置它的属性

可用的属性：
1. `config-location` MyBatis XML 配置文件
2. `mapper-locations` mapper XML配置文件
3. `type-aliases-package` 包的别名
4. `type-handlers-package` 处理器的别名
5. `executor-type` 执行器类型，SIMPLE，REUSE，BATCH
6. `configuration` 一个MyBatis `Configuration` 配置Bean

**注意：** 所有的属性都是可选的，也就是说默认情况下都可以不用配置

#### 使用方法
1. 在application.properties文件中配置数据源，指定数据库，用户名，密码，驱动类
2. 在mapper接口上添加`@Mapper`注解
3. 在`resources`目录中创建与mapper接口一致的目录，保存mapper.xml文件

# Spring Boot 说明文档学习

希望可以通过这次文档的学习，加深对spring和spring boot的理解，同时也希望自己可以掌握使用spring boot开发的细节，以及解决可能出现问题
加油，486

Spring Boot可以更容易的创建基于spring的独立的，产品级别的应用

系统需求
1. Java7 和Spring 4.3.3版本以上
2. Tomcat 8以上

安装Spring Boot

### `@RestController`和`@RequestMapping` 注解的学习

`@RestController` 铅版注解，它提供了暗示让人们读这个代码，对spring来说，该类扮演了一个具体的角色
去看一下api文档怎么说的吧

一个便捷的注解本身上使用了注解`@RequestMapping`和`@ResponseBody`
该注解携带的类型被看做controller对待，支持MVC默认的是RequestMappingHandlerMapping和RequestMappingHandlerAdapter，但是不支持DefaultAnnotationHandlerMapping和AnnotationMethodHandlerAdapter因为它们已经过时了

`RequestMapping` 映射web请求到具体的处理器和处理器方法

使用该注解的方法可以接收的方法参数：

`javax.servlet.ServletRequest`，

`javax.servlet.http.HttpServletRequest`，

`javax.servlet.http.HttpSession`，

`org.springframework.web.context.request.WebRequest`，

`org.springframework.web.context.request.NativeWebRequest`，

`java.util.Locale`，

`java.io.InputStream`，

`java.io.Reader`，

`java.io.OutputStream`，

`java.io.Writer`，

`java.util.Map`

Spring中常用的注解

`@EnableAutoConfiguration` 启用自动配置注解，该注解告诉spring boot 去猜你想要怎么配置spring

改变java的版本 设置java.version属性
```
<properties>
    <java.version>1.8</java.version>
</properties>
```

使用Spring Boot Maven 插件
```
<plugin>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-maven-plugin</artifactId>
  </plugin>
```

导入额外的配置类使用`@Import` 注解

导入xml配置 使用`@ImportResource` 注解

启用自动配置`@EnableAutoConfiguration`和 `@SpringBootApplication`添加到你的自定义的标有`@Configuration`注解的类

禁用具体的自动配置`@EnableAutoConfiguration(exclude={DataSourceAutoConfiguration.class})`
使用exclude进行排除

Spring Beans和依赖注入

使用`@Component, @Service, @Repository, @Controller`的注解会自动Spring的Beans被注册

`@SpringBootApplication` 注解 等价于三个注解`@Configuration, @EnableAutoConfiguration and @ComponentScan`

hot swaping 热插拔

`spring-boot-devtools` 模块支持该功能

默认属性
  ```
    properties.put("spring.thymeleaf.cache", "false");
		properties.put("spring.freemarker.cache", "false");
		properties.put("spring.groovy.template.cache", "false");
		properties.put("spring.velocity.cache", "false");
		properties.put("spring.mustache.cache", "false");
		properties.put("server.session.persistent", "true");
		properties.put("spring.h2.console.enabled", "true");
		properties.put("spring.resources.cache-period", "0");
		properties.put("spring.template.provider.cache", "false");
		properties.put("spring.mvc.log-resolved-exception", "true");
  ```

自动重启 当类路径下的文件发生改变时应用会自动重启，注意静态资源和视图模板的改变不需要重启，idea使用`Ctrl+F9`，会自动重启

排除资源

默认情况下/META-INF/maven, /META-INF/resources ,/resources ,/static ,/public or /templates中的资源不会触发重启

通过`spring.devtools.restart.exclude=static/**,public/**` 排除自己想要排除的资源

使用`spring.devtools.restart.additional-paths`监控不在类路径下的文件

禁用重启

`spring.devtools.restart.enabled` = false

使用触发文件

spring.devtools.restart.trigger-file = file

`SpringApplication` 提供了一种便捷的方式启动spring应用

自定义banner

自定义SpringApplication

使用流式构造者API
`SpringApplicationBuilder`

应用事件和监听器

应用事件的发送顺序
1. `ApplicationStartedEvent` 在运行开始，在除了任何监听器和初始化器的注册之外的任何处理之前
2. `ApplicationEnvironmentPreparedEvent` 在上下文里使用环境时，但是在上下文创建之前
3. `ApplicationPreparedEvent`
4. `ApplicationReadyEvent`
5. `ApplicationFailedEvent`

web环境

`SpringApplication` 会根据你的行为试图创建正确类型的`ApplicationContext`

默认情况下`AnnotationConfigApplicationContext` 和`AnnotationConfigEmbeddedWebApplicationContext` 会被使用，取决于你开发的是web应用还是其他应用

访问应用参数

如果你需要访问被传递到`SpringApplication.run(…​)` 方法的应用的参数，你可以注入一个`org.springframework.boot.ApplicationArguments` Bean，这个接口提供访问原始`String[]` 参数和可解析的`option` 和`non-option`参数

使用`ApplicationRunner`和`CommandLineRunner`接口

需要在`SpringApplication`启动的时候运行一些具体的代码，你可以实现这两个接口

CommandLineRunner 访问应用参数作为简单的字符串数组

ApplicationRunner 使用ApplicationArguments访问应用参数

应用退出

每一个SpringApplication将会注册一个关闭回调，以确保ApplicationContext可以优雅的关闭

配置随机值

`RandomValuePropertySource` 有用的提供注入随机的值
```
my.secret=${random.value}
my.number=${random.int}
my.bignumber=${random.long}
my.uuid=${random.uuid}
my.number.less.than.ten=${random.int(10)}
my.number.in.range=${random.int[1024,65536]}
```
访问命令行属性

默认情况下，`SpringApplication`将会转换任何命令行参数到一个属性，然后将它添加到spring的`Environment`对象中

如果你不想命令行属性被添加到`Environment`，你可以使用`SpringApplication.setAddCommandLineProperties(false)` 禁用该功能

具体配置文件的属性

`Environment`有一个默认的配置属性`default`，如果没有激活任何配置文件的话，会使用该默认属性

属性中的占位符

	app.name=MyApp
	app.description=${app.name} is a Spring Boot application

类型安全的配置属性

	@ConfigurationProperties(prefix="connection")

放松绑定

spring Boot使用一些放松的规则绑定`Environment`属性到`	@ConfigurationProperties`，如果你不需要精确匹配环境的属性名和bean的属性名，常用的示例就是包括虚线分割的环境属性
如：`context-path = contextPath`，`PORT=port`

	Property		Note
	person.firstName 	  		Standard camel case syntax.
	person.first-name     		Dashed notation, recommended for use in .properties and .yml files.
	person.first_name 			Underscore notation, alternative format for use in .properties and .yml files.
	PERSON_FIRST_NAME            Upper case format. Recommended when using a system environment variables.
	

属性转换

spring将会试图转换额外的应用属性到它绑定的bean的正确的类型，如果你需要自定义类型转换，你可以提供一个`ConversionService`或者自定义属性编辑器`CustomEditorConfigurer`或者自定义转换器`Converters`

`@ConfigurationProperties`校验

使用默认的jsr-303来校验额外的配置，你可以简单的添加`javax.validation` 约束注解到你的`@ConfigurationProperties`类

为了校验嵌套属性的值，你必须使用`@Valid`注解相关联的字段，来触发它的校验

@Profile

提供了在不同环境中使用不同配置文件的功能，比如在开发环境中的数据库连接的是测试库，到生产环境中数据库连接线上的库

使用`spring.profiles.active`属性启动配置属性

日志

日志格式

	日期和时间 — 毫秒精度，更容易排序
	日志级别 — ERROR, WARN, INFO, DEBUG 或 TRACE.
	进程 ID.
	 '---' 分隔符区别实际日志消息
	线程名 — 以[]包裹
	日志名 — 通常是全限定类名
	日志消息
	
控制台输出

使用`spring.output.ansi.enabled` 启动颜色代码输出

文件输出

使用`logging.file `或`logging.path`属性来配置日志文件的输出

日志级别

	logging.level.root=WARN
	logging.level.org.springframework.web=DEBUG
	logging.level.org.hibernate=ERROR
	
自定义日志配置

Spring MVC自动配置 

1. 包含`ContentNegotiatingViewResolver`和`BeanNameViewResolver`Beans
2. 支持服务静态资源
3. 自动注册转换器`Converter`，通用转换器`GenericConverter`，格式化`Formatter`
4. 支持`HttpMessageConverters`
5. 自动注册`MessageCodesResolver`
6. 静态`index.html`支持
7. 自定义`Favicon` 支持
8. 自动使用`ConfigurableWebBindingInitializer`

如果你想添加额外的mvc配置，比如拦截器，格式化器，视图控制器，你可以添加自己的`@Configuration`的`WebMvcConfigurerAdapter`类型的类，但是不使用`@EnableWebMvc` 

对象可以被自动的转换成JSON或者XML，默认编码为UTF-8

自定义JSON序列化和反序列化(这个功能可是非常的重要)

`@JsonComponent` 该注解可以更容易的注册Spring Bean

使用方法
	1. 创建自己自定义的`JsonSerializer`和`JsonDeserializer`实现类
	2. 在实现类上直接使用`@JsonComponent`即可自动注册序列化和反序列
	
所有在`ApplicationContext`的`@JsonComponent` Beans都会自动被Jackson注册

上面这个方法太傻逼了，最简单的方法在`application.properties`属性文件中添加以下属性：
`spring.jackson.date-format=yyyy-MM-dd`即可自动实现JSON的日期和字符串的转换

spring boot的作用是减少不必要的配置，减少编码，将主要的核心放在业务代码上




