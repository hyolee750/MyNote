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
