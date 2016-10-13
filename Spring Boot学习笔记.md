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
