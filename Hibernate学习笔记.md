使用`@Entity`注解来声明一个普通的POJO类

使用`@Id`声明该实体的标识符属性，其他映射声明是隐式的

`@Table` 类级别的注解，允许你为你的实体映射定义表，目录，模式名，默认为实体的非全限定名

*逻辑列名由Hibernate的NamingStrategy实现*

默认的JPA命名策略使用**物理列名作为逻辑列名**

使用`@version`注解为一个实体增加**乐观锁**能力，每个类只能使用一个Version属性或字段

下列类型支持version属性

int，Integer，short，Short，long，Long，java.sql.Timestamp

#### 声明基本的属性映射

一个实体非静态和非瞬时属性都认为是持久化的

使用`@Transient`注解来显示声明不持久化

`@Basic` 注解允许你声明一个属性的抓取策略

`Temporal` 只能用在为`Date`或`Calendar`的字段或属性上

`@Enumerated`定义一个持久化属性或字段应该持久为枚举类型的