# Java 与设计模式

[TOC]

### 开闭原则

一个软件实体应对扩展开放，对修改关闭

1. 通过扩展已有的软件系统，可以通过新的行为，以满足对软件的新需求
2. 已有的软件模块，特别是最重要的抽象层模块不能再修改

解决问题的关键在于抽象化

里氏替换原则：任何基类可以出现的地方，子类一定可以出现

实现开闭原则的关键步骤是抽象化，里氏替换原则是对实现抽象化的具体步骤的规范

依赖倒转原则：要依赖于抽象，不要依赖于实现

聚合复用原则：要尽量使用合成/聚合，而不是继承关系达到复用的目的

迪米特法则：一个软件实体应该与尽可能少的其他实体发生相互作用

接口隔离原则：应当为客户端提供尽可能小的单独的接口，而不要提供大的总接口

策略模式就是从对可变性的封装原则出发，达到开闭原则的一个范例

**将条件转移语句改写成为多态性**是一条广为流传的代码重构做法

### 寻找可变性的线索

java语言是类型安全的，通过以下三种方式完成该功能

1. 编译期的类型检查
2. 自动的存储管理
3. 数组的边界检查

### 接口

一个方法的特征仅包括方法的名字，参数的数目和种类，而不包括方法的返回类型，参量的名字以及所抛出的异常

在java编译器检查方法的重载时，会根据这些条件判断两个方法是否重载了

但是在java编译器检查方法覆盖时，则会进一步检查两个方法的返回类型和所抛出的异常是否相同

1. java接口本身没有任何实现
2. 一个java接口的方法只能是抽象的和公开的，接口不能有构造函数
3. 接口仅仅描述方法的特征，而不给出方法的实现

### 抽象类

抽象类仅提供一个类型的部分实现，抽象类可以有实例变量，以及构造函数。抽象类可以同时有抽象方法具体方法

一个抽象类不会有实例

只要有可能，不要从具体类继承

在一个以继承关系形成的等级结构里面，树叶节点均应当为具体类，而树枝节点均应当是抽象类

抽象类应当拥有尽可能多的共同代码

抽象类应当拥有尽可能少的数据

### 里氏替换原则

面向对象设计的重要原则就是创建抽象化，并且从抽象化导出具体化

从抽象化到具体化的导出要使用继承关系和里氏替换原则

里氏替换原则的严格表达：

> 如果对每一个类型为T1的对象o1，都有类型为T2的对象o2，使得以T1定义的所有程序P在所有的对象o1都代换成o2时，程序P的行为没有变化，那么T2就是T1的子类型

里氏替换原则是继承复用的基石

里氏替换原则讲的是基类和子类的关系，只有当这种关系存在时，里氏替换关系才存在，反之则不存在

一般而言，如果两个具体类A和B有继承关系，那么一个最简单的方案应当是建立一个抽象类C，然后让类A和B成为抽象类C的子类

### 依赖倒转原则

要依赖于抽象，不要依赖于具体

在面向对象的系统里，两个类之间可以发生三种不同的耦合关系：

1. 零耦合关系：如果两个类没有耦合关系，就称为零耦合关系
2. 具体耦合关系，具体性耦合关系发生在两个具体的类之间，经由一个类对另外一个具体类的直接引用造成
3. 抽象耦合关系，发生在一个具体类和一个抽象类之间，使两个类之间发生最大的灵活性

抽象不应当依赖于细节，细节应当依赖于抽象

要针对接口编程，不要针对实现编程

变量被声明时的类型叫做变量的静态类型，也叫明显类型，变量所引用的对象的真实类型叫做变量的实际类型

以抽象方式耦合是依赖倒转原则的关键，里氏替换原则是依赖倒转原则的基础

### 接口隔离原则

一个类对另外一个类的依赖性应当建立在最小的接口上

### 合成/聚合复用原则

要尽量使用合成/聚合，尽量不要使用继承

合成/聚合的好处：

1. 新对象存取成分对象的唯一方法是通过成分对象的接口
2. 这种复用是黑箱复用，因为成分对象的内部细节是新对象所看不见的
3. 这种复用支持包装
4. 这种复用所需依赖较少
5. 每一个新的类可以将焦点集中到一个任务上
6. 这种复用可以在运行时间内动态进行，新对象可以动态的引用与成分对象类型相同的对象

### 迪米特法则

迪米特法则主要用意是控制信息的过载，要注意以下几点:

1. 在类的划分上，应当创建有弱耦合的类
2. 在类的结构设计上，每一个类都应当尽可能的降低成员的访问权限
3. 在类的设计上，只要有可能，一个类应当设计成不变类
4. 在对其他类的引用上，一个对象对其对象引用应当降到最低

在需要一个变量的时候才声明它，可以有效的限制局部变量的有效范围

## 创建模式

创建模式是对类的实例化过程的抽象化

创建模式分为类的创建模式和对象的创建模式两种：

1. 类的创建模式使用继承，把类的创建延迟到子类、
2. 对象的创建模式是把对象的创建过程动态的委派给另一个对象，从而动态的决定客户端将得到哪些具体类的实例

创建模式主要包括以下几种：

1. 简单工厂模式
2. 工厂方法模式
3. 抽象工厂模式
4. 单例模式
5. 多例模式
6. 建造模式
7. 原始模型模式

### 简单工厂模式

简单工厂是类的创建模式，也叫做静态工厂方法模式，由一个工厂对象决定创建出哪一种产品类的实例

工厂模式的几种形态：

1. 简单工厂模式 也叫静态工厂方法模式
2. 工厂方法模式 叫多态性工厂模式或虚拟构造子模式
3. 抽象工厂模式 又称工具箱模式

#### 简单工厂模式的结构

三个角色

1. 工厂类Creator角色：担任这个角色的是工厂方法模式的核心，含有与应用紧密相关的商业逻辑，工厂类在客户端的直接调用下创建产品对象，它往往由一个具体的java类实现
2. 抽象产品角色：担任这个角色的类是由工厂方法模式所创建的对象的父类，或他们共同拥有的接口，可以用一个java接口或者java抽象类实现
3. 具体产品角色：工厂方法模式创建的任何对象都是这个角色的实例，具体产品角色由一个具体java类实现

工厂角色与抽象产品角色合并

工厂角色可以由抽象产品角色扮演，典型的应用就是`java.text.DateFormat`类，一个抽象产品类同时是子类的工厂

简单工厂模式的优缺点：

---

《Java与模式》这本书还是不错的，大概有1000多页，详细的介绍了设计模式的原则和26种设计模式，且对每种设计模式的用法，优缺点提供了详细的说明，是一本值得多次阅读的好书

也希望自己可以多读几遍这样的书，理解和熟练运用设计模式的思想 完成开发的任务，提供自己的设计思想和编码能力，写出更加优美和简洁的代码

2016年11月30日 星期三 

2016年快要过去了，还有一个月的时间，留给我的时间不多了，希望明年3月份跳槽的时候，可以有自信提出12k或者15k的工资水平

其实我是3月份开始做java，到明年3月份的时候正好一年，虽然我知道自己只有1年的实际工作经验，但是我现在的水平却相当于3年的水平

所以下次工资开始就不能再低于10k了

那么我接下来要学习和复习哪些东西呢？

1. 数据结构和算法，这个也是值得我看的 
2. java基础，内存模型，java集合，java io流，java nio，java并发，java lambda表达式 
3. 设计模式

加油吧，也不能浪费自己的时间了，毕竟自己现在也不小了，明年就28了，希望在30岁之前可以有20w到30w的存款，当然了，我知道这也是比较困难的，但是我会努力的，希望我自己可以成功

### 工厂方法模式

工厂方法模式是类的创建模式，定义了一个创建产品对象的工厂接口，将实际创建工作推迟到子类中

#### 简单工厂的优缺点

1. 允许客户端相对独立于产品创建过程，并且在系统引入新产品时无须修改客户端，在某种程度上支持开闭原则
2. 对开闭原则支持的不够，因为如果有新产品加入到系统中，就需要修改工厂类，将必要的逻辑加入到工厂类中

#### 工厂方法模式的改进

在工厂方法模式中，核心的工厂类不再负责所有产品的创建过程，而是将具体创建的工作交给子类去做，该核心类称为了一个抽象工厂角色，仅负责给出具体工厂子类必须实现的接口，而不接触哪一个产品类应当被实例化这种细节

#### 工厂方法模式的结构

角色：

1. 抽象工厂角色：担任这个角色的是工厂方法模式的核心，它与应用程序是无关的，任何在模式中创建对象的工厂类必须实现这个接口，通常由抽象java类实现
2. 具体工厂角色：实现了抽象工厂接口的具体java类，含有与应用密切相关的逻辑
3. 抽象产品角色：工厂方法模式所创建的对象的超类型
4. 具体产品角色：实现了抽象产品角色所声明的接口

#### 使用java接口或者java抽象类

如果具体工厂角色具有共同的逻辑，那么这些共同的逻辑就可以向上移动到抽象工厂角色中，这也就意味着抽象工厂角色应当用一个java抽象类实现，并由抽象工厂角色提供默认的工厂方法

相反的话，就应该用一个java接口实现

### 抽象工厂模式

抽象工厂模式可以向客户端提供一个接口，使得客户端在不必指定产品的具体类型的情况下，创建多个产品族中的产品对象

工厂方法模式针对的是一个产品等级结构，而抽象工厂模式则需要面对多个产品等级结构

#### 抽象工厂模式的结构

通过使用抽象工厂模式，可以处理具有相同或者相似等级结构的多个产品族中的产品对象的创建问题

角色：

1. 抽象工厂角色
2. 具体工厂角色
3. 抽象产品角色
4. 具体产品角色

这里和工厂方法模式的不同在于，一个抽象工厂角色可以有多个方法来生成不同的产品

#### 在什么情形下应当使用抽象工厂模式

1. 一个系统不应当依赖产品实例如何被创建，组合和表达的细节，这对于所有心态的工厂模式都是重要的
2. 这个系统的产品有多于一个的产品族，而系统只消费其中某一族的产品
3. 同属于一个产品族的产品是在一起使用的，这一约束必须在系统的设计中体现出来
4. 系统提供一个产品类的库，所有的产品以同样的接口出现，从而使客户端不依赖于实现

有多少抽象产品就有多少的工厂方法

开闭原则要求一个软件系统可以在不修改原有代码的情况下，通过扩展达到增强其功能的目的，对于一个涉及到多个产品等级结构和多个产品族的系统，其功能增强不外乎两个方面

1. 增加新的产品族
2. 增加新的产品等级结构

### 单例模式

要点有三个：

1. 某个类只能有一个实例
2. 它必须自行创建这个实例
3. 它必须自行向整个系统提供这个实例

饿汉式单例

懒汉式单例

有状态的单例类

无状态的单例类

### 多例模式

特点：

1. 多例类可以有多个实例
2. 多例类必须自己创建，管理自己的实例，并向外界提供自己的实例

今天是11月份的最后一天，马上就要到12月份了，现在这个工作也开始进入收尾阶段，希望不要再加班了，有点难受了

我明天的主要内容就是完成推送的功能

这里可能还要和他们探讨一下关于推送的类型啊，推送的内容等等，做一个更详细的设计

这里也是最让人烦躁的，竟然让一个程序员参与到产品的设计上，可见 有一个专业的产品经理是多么的重要啊

所以我自己的话也要看看张小龙的ppt，看一下别人是怎么设计产品的，不能再这样瞎搞了啊

没办法啊，谁叫我们是一个小公司呢，小公司就是不专业啊 

希望下次可以找一个大一点的公司，而不是小公司了

12月份再见了哦

2016年12月1日 星期四 天气阴

今天是12月份的第一天，自己仍然不能放弃学习，而且要加紧学习，毕竟留给我的时间不多了，自己还有很多的东西需要去看的

那么来规划一下自己的学习计划吧

1. Java基础，这部分基本上算是看完了，java NIO和Lambda更是掌握的很好，足够应付很多的问题了，当然了最重要的还是要理解其实现方式，以及为什么要这样做
2. 数据结构和算法
3. redis，mongodb
4. rabbitmq
5. 分布式的学习 这个估计要到明年了

继续按照我的计划学习

最近又下了基本书，可以看一下

### 建造模式

建造模式是对象的创建模式，建造模式可以将一个产品的内部表象与产品的生成过程分隔开来，从而可以使一个建造过程生成具有不同的内部表象的产品对象

角色：

1. 抽象建造者角色：一个抽象接口
2. 具体建造者角色
3. 导演者角色
4. 产品角色

在什么时候使用建造模式：

1. 需要生成的产品对象有复杂的内部结构，每一个内部结构成分本身可以是对象，也可以仅仅是一个对象的一个组成成分
2. 需要生成的产品对象属性相互依赖，建造模式可以强制实行一种分步骤进行的建造过程
3. 在对象创建过程中会使用系统中的其他一些对象，这些对象在产品对象的创建过程中不易得到

### 原型模式

原型模式属于对象的创建模式，通过给出一个原型对象来指明所要创建的对象的类型，然后用复制这个原型对象的办法创建出更多同类型的对象

角色：

1. 客户角色：客户类提出创建对象的请求
2. 抽象原型角色：这是一个抽象角色，通常由一个java抽象类或接口来实现
3. 具体原型角色：被复制的对象，需要实现抽象的原型角色的所有接口

深复制和浅复制

浅复制： 被复制对象的所有变量都含有与原来的对象相同的值，而所有的对其他对象的引用都仍然指向原来的对象，换言之，浅复制仅仅复制所考虑的对象，而不复制它所引用的对象

深复制： 被复制的对象的所有的变量都含有与原来对象相同的值，除去那些引用其他对象的变量，那些引用其他对象的变量将指向被复制过来的新对象，而不是原有的那些被引用的对象


### 适配器模式 可能要重点掌握的模式

把一个类的接口变换成客户端所期待的另一种接口，从而使原本因接口不匹配而无法一起工作的两个类能够一起工作

适配器模式有类的适配器模式和对象的适配器模式

#### 类的适配器模式的结构

角色：

1. 目标角色，这就是所期待得到的接口
2. 源角色，现有需要适配的接口
3. 适配器角色，适配器类是本模式的核心，适配器把源接口转换成目标接口，这一角色不可以是接口，必须是具体类

#### 对象的适配器模式将的结构

与类的适配器模式一样，对象的适配器模式把适配的类的API转换为目标类的API，与类的适配器模式不同的是，对象的适配器模式不是成使用继承关系连接到Adaptee类而是使用委派关系连接到Adaptee类

适配器模式的目的就是把源接口转换成目标接口

#### 对象适配器的效果

1. 一个适配器可以把多种不同的源适配到同一个目标
2. 与类的适配器模式相比，要想置换源类的方法就不容易
3. 虽然要想置换源类的方法不容易，但是要想增加一些新的方法则更加方便

### 在什么情况下使用适配器模式

1. 系统需要使用现有的类，而此类的接口不符合系统的需要
2. 想要建立一个可以重复使用的类，用于与一些彼此之间没有太大关联的一些类，包括一些可能在将来引进来的类一起工作

适配器实现了目标接口，才能为目标接口提供方法，同样，适配器类必须包含一个具体的源目标，来提供具体的方法

感觉身体好像被掏空了啊

真的不想再这样下去了，希望以后加班的时候不要再这样了

## 观察者模式

定义了对象之间的一对多依赖，这样一来，当一个对象改变状态时，它的所有依赖都会受到通知并自动更新

角色：

1. 主题接口角色：对象使用此接口注册为观察者，或者把战场从观察者中删除
2. 具体主题角色：总是实现主题接口，除了注册和撤销方法之外，具体主题还实现了notifyObservers()方法，此方法用于在状态改变时更新所有当前观察者
3. 观察者接口角色：所有潜在的观察者必须实现观察者接口，这个接口只有一个`update()`方法，当主题状态改变时它被调用
4. 具体观察者角色：实现了观察者角色接口，观察者必须注册具体主题，以便接收更新

> 设计原则
>
> 为了交互对象之间的松耦合设计而努力

松耦合的设计之所以能让我们建立有弹性的OO系统，能够应对变化，是因为对象之间的互相依赖降到了最低

#### 使用java内置的观察者模式

`java.util.Observer`接口和`java.util.Observable`类，在使用上更方便，因为许多功能都已经事先准备好了，你设置可以使用推或拉的方式传送数据

具体主题角色不再实现抽象主题角色，而是继承java内置的`java.util.Observable`类，并继承到一些增加、删除、通知观察者的方法

具体观察者对象实现观察者接口`java.util.Observer`。然后调用任何Observable对象的`addObserver()`方法，不想再当观察者时，调用`deleteObserver()`方法就可以了

##### 可观察者如何送出通知？

1. 首先需要利用扩展`java.util.Observable`接口产生可观察者类
2. 先调用`setChanged()`方法，标记状态已经改变的事实
3. 然后调用两种`notifyObservers()`方法中的其中一个

##### 观察者如何接受通知？

同以前一样，观察者实现了更新的方法，但是方法签名不太一样，`update(Observable o,Object arg)`。主题本身当做第一个变量，好让观察者知道是哪个主题通知它的，第二个参数正是传入`notifyObservers()`的数据对象，如果没有说明则为空

内置观察者模式的缺点：

1. 可观察者是一个类，而不是一个接口，更糟的是，它甚至没有实现一个接口
2. 因为可观察者对象是一个类，你必须设计一个类继承它，如果某类想同时具有`Observable`类和另外一个超类的行为，就会陷入两难，因为java不支持多重继承
3. 因为没有`Observable`接口，所以你无法建立自己的实现，和Java内置的Observer API搭配使用
4. `setChanged()`方法被保护起来了，这意味着除非你继承自`Observable`否则你无法创建Observable实例并组合到你自己的对象中来，这个设计违反了第二个设计原则：**多用组合，少用继承**

```java
// 主题角色
package learningdesignpattern.observer;

public interface Subject {

    void registerObserver(Observer observer);

    void removeObserver(Observer observer);

    void notifyObservers();
}
```

```java
// 观察者角色
package learningdesignpattern.observer;

public interface Observer {
    void update(float temp,float humidity,float pressure);
}
```

```java
//具体主题对象
package learningdesignpattern.observer;

import java.util.ArrayList;

public class WeatherData implements Subject {
    private ArrayList<Observer> observers;
    private float temperature;
    private float humidity;
    private float pressure;

    public WeatherData() {
        observers = new ArrayList<>();
    }

    @Override
    public void registerObserver(Observer observer) {
        observers.add(observer);
    }

    @Override
    public void removeObserver(Observer observer) {
        int i = observers.indexOf(observer);
        if (i >= 0)
            observers.remove(observer);
    }

    @Override
    public void notifyObservers() {
        observers.forEach(o -> o.update(temperature,humidity,pressure));
    }

    public void measurementsChanged() {
        notifyObservers();
    }

    public void setMeasurements(float temperature, float humidity, float pressure) {
        this.temperature = temperature;
        this.humidity = humidity;
        this.pressure = pressure;
        measurementsChanged();
    }
}
```

```java
// 具体观察者对象
package learningdesignpattern.observer;

public class CurrentConditionsDisplay implements Observer, DisplayElement {
    private float temperature;
    private float humidity;
    private float pressure;
    private Subject weatherData;

    public CurrentConditionsDisplay(Subject weatherData) {
        this.weatherData = weatherData;
        weatherData.registerObserver(this);
    }

    @Override
    public void update(float temp, float humidity, float pressure) {
        this.temperature = temp;
        this.humidity = humidity;
        display();
    }

    @Override
    public void display() {
        System.out.println("Current conditions: " + temperature + "F degress and " + humidity + "% humidity");
    }
}
```



总结：

1. 观察者模式定义了对象之间一对多的关系
2. 主题 也叫可观察者，用一个共同的接口来更新观察者
3. 观察者和可观察者之间用松耦合的方式结合，可观察者不知道观察者的细节，只知道观察者实现了观察者接口
4. 使用此模式时，你可从被观察者处推或拉数据，推的方式更好
5. 有多个观察者时，不可以依赖特定的通知次序
6. Java有多种观察者模式的实现，包括`java.util.Observable`
7. 要注意`java.util.Observable`实现上所带来的一些问题
8. 如果有必要的话，可以实现自己的Observable，这并不难，不要害怕
9. Swing大量的使用了观察者模式，许多GUI框架也是如此
10. 此模式也被应用在许多地方，例如JavaBeans和RMI

OO基础：抽象

OO原则：

1. 封装变化
2. 多用组合，少用继承
3. 针对接口编程，不针对实现编程
4. 为交互对象之间的松耦合设计而努力

OO模式：

观察者模式-在对象之间定义一对多的依赖，这样依赖，当一个对象改变状态，依赖他的对象都会收到通知并自动更新

观察者模式中的设计原则：

1. 在观察者模式中，会改变的是主题的状态，以及观察者的数目和类型，用这个模式，你可以改变依赖于主题状态的对象，却不必改变主题，这就叫做提前规划
2. 主题与观察者都使用接口，观察者利用主题的接口向主题注册，而主题利用观察者接口通知观察者
3. 观察者模式利用组合将许多观察者组合进主题中，对象之间的这种关系不是通过继承产生的，而是在运行时利用组合的方式产生的

## 装饰者模式

> 设计原则
>
> 类应该对扩展开放，对修改关闭

### 要点：

1. 装饰者和被撞死的对象有相同的超类型
2. 你可以用一个或多个装饰者包装一个对象
3. 既然装饰者和被装饰对象有相同的超类，所以在任何需要原始对象的场合，可以用装饰过的对象代替它
4. 装饰者可以在说委托被装饰者的行为之前与之后，加上自己的行为，以达到特定的目的
5. 对象可以在任何时候被装饰，所以可以在运行时动态地，不限量的用你喜欢的装饰者来装饰对象

### 定义装饰者模式

装饰者模式动态地将责任附加到对象上，若要扩展功能，装饰者提供了比继承更有弹性的替代方案

角色：

1. 组件角色：每个组件都可以单独使用，或者被装饰者包起来使用
2. 具体组件角色：是我忙丁克动态地加上新行为的对象，它扩展自组件角色
3. 装饰器角色：每一个装饰者都有一个组件，也就是说，装饰者有一个实例变量以保存某个组件的引用，这是装饰者共同实现的接口，也可以是抽象类
4. 具体装饰器角色：有一个实例变量，可以记录所装饰的事物，装饰者可以扩展组件的状态，装饰者可以加上新的方法，新行为是通过在旧行为前面或后面做一些计算了添加的

使用装饰模式来包装输入流，来达到增加`InputStream`的功能的目的，例如下面的代码就是读取文件中的数据，然后将字母全部转换成小写的例子

```java
package learningdesignpattern.decorator;

import java.io.*;

public class LowCaseInputStream extends FilterInputStream {

    protected LowCaseInputStream(InputStream in) {
        super(in);
    }

    @Override
    public int read() throws IOException {
        int c = super.read();
        return c == -1 ? c : Character.toLowerCase((char) c);
    }

    @Override
    public int read(byte[] b, int off, int len) throws IOException {
        int result = super.read(b, off, len);
        for (int i = off; i < off + result; i++) {
            b[i] = (byte) Character.toLowerCase((char) b[i]);
        }
        return result;
    }

    public static void main(String[] args) throws IOException {
        int c;
        InputStream is = new LowCaseInputStream(new BufferedInputStream(new FileInputStream("D:\\hello.txt")));
        while ((c = is.read()) >=0)
            System.out.print((char) c);
        is.close();
    }
}

```

### 最后总结：

1. 继承属于扩展形式之一，但不见得是达到弹性设计的最佳方案
2. 在我们的设计中，应该允许行为可以被扩展，而无需修改现有的代码
3. 组合和委托可用于在运行时动态的加上新行为
4. 除了继承，装饰者模式也可以让我们扩展行为
5. 装饰者模式意味着一群装饰者类，这些类用来包装具体组件
6. 装饰者模式反映出被装饰组件类型，事实上，他们具有相同的类型，都经过接口或继承实现
7. 装饰者可以在被装饰者的行为前面或后面加上自己的行为，甚至将被装饰者的行为整个取代掉，而达到特定目的
8. 你可以用无数个装饰者包装一个组件
9. 装饰者一般对组件的客户是透明的，除非客户程序依赖于组件的具体类型
10. 装饰者会导致设计中出现许多的小对象，如果过度使用，会让程序变得复杂

## 工厂模式

所有工厂摸底都用来封装对象的创建，工厂方法模式通过让子类决定改创建的对象是什么，来达到将对象创建的过程封装的目的

### 定义工厂方法模式

> 定义了一个创建对象的接口，但由子类决定要实例化的类是哪一个，工厂方法让类的实例化推迟到子类


> 设计原则
>
> 依赖倒置原则：要依赖抽象，不要依赖具体类

创建者类：

抽象创建者类，它定义了一个抽象的工厂方法，让子类实现此方法制造产品

创建者通常会包含依赖于抽象产品的代码，而这些抽象产品由子类制造，创建者不需要真的知道在制造哪种具体产品

具体创建者：负责制造产品，实现了抽象创建者类的方法

产品类：

抽象产品类，工厂生产的产品

具体产品类，实现了抽象产品类，是具体要制造的产品

如何避免在OO设计中违反**依赖倒置原则**

1. 变量不可以持有具体类的引用，如果使用new就会持有具体类的引用，你可以改用工厂来避开这样的做法
2. 不要让类派生自具体类，如果派生自具体类，你就会依赖具体类，请派生自一个抽象，接口或者抽象类
3. 不要覆盖基类中已实现的方法，如果覆盖基类已实现的方法，那么你的基类就不是一个真正适合被继承的抽象，基类中已实现的方法，应该由所有的子类共享

### 定义抽象工厂模式

**抽象工厂模式** 提供了一个接口，用于创建相关或依赖的家族，而不需要明确指定具体类

抽象工厂定义了一个接口，所有的具体工厂都必须实现此接口，这个接口包含一组方法用来生产产品

具体工厂实现不同的产品家族，要创建一个产品，客户主要使用其中的一个工厂而完全不需实例化任何产品对象

抽象产品	

具体产品

工厂方法和抽象工厂的区别：

1. 工厂方法用的是继承，而抽象工厂是通过对象的组合来负责创建对象，利用工厂方法创建对象，需要扩展一个类，并覆盖它的工厂方法

#### 要点

1. 所有的工厂都是用来封装对象的创建
2. 简单工厂，虽然不是真正的设计模式，但仍不失为一个简单的方法，可以将客户程序从具体类解耦
3. 工厂方法使用继承，把对象的创建委托给子类，子类实现工厂方法来创建对象
4. 抽象工厂使用对象组合，对象的创建被实现在工厂接口所暴露出来的方法中
5. 所有工厂模式都通过减少应用程序和具体类之间的依赖促进松耦合
6. 工厂方法允许类将实例化延迟到子类进行
7. 抽象工厂创建相关的对象家族，而不需要依赖它们的具体类
8. 依赖倒置原则，知道我们避免以来具体类型，而要尽量依赖抽象
9. 工厂是很有威力的技巧，帮助我们针对抽象编程，而不要针对具体类编程

## 单例模式

### 经典单例模式的实现

1. 利用一个静态变量来记录Singletion类的唯一实例
2. 把构造器声明为私有的，只有在Singletion类内才可以调用构造器
3. 用getInstance方法实例化对象，并返回这个实例

### 定义单例模式

确保一个类只有一个实例，并提供一个全局访问点

要点：

1. 单例模式确保程序中一个类最多只有一个实例
2. 单例模式也提供访问这个实例的全局点
3. 在java中实现单例模式需要私有的构造器，一个静态方法和一个静态变量
4. 确定在性能和资源上的限制，然后小心地选择适当的方案来实现单例，以解决多线程的问题。我们必须认定所有的程序都是多线程的

## 装饰器模式

装饰模式又名包装模式，装饰模式以对客户端透明的方式扩展对象的功能，是继承关系的一个替代方案

在抽象模式中的各个角色：

1. 抽象构件角色，给出一个抽象接口，以规范准备接收附加责任的对象
2. 具体构件角色，定义一个将要接收附加责任的类
3. 装饰角色，持有一个构件对象的实例，并定义一个与抽象构件接口一致的接口
4. 具体装饰角色，负责给构件对象贴上附加的责任

### 装饰模式应当在什么情况下使用

1. 需要扩展一个类的功能，或给一个雷类增加附加责任
2. 需要动态的给一个对象增加功能，这些功能可以再动态的撤销
3. 需要增加由一些基本功能排列组合而产生的非常大量的功能，从而使继承关系变得不现实


## 代理模式

代理模式是对象的结构模式，代理模式给某一个对象提供一个代理对象，并由代理对象控制对原对象的引用

代理模式的结构

设计的角色有：

1. 抽象主题角色，声明了真实的主题和代理主题的共同接口，这样一来在任何可以使用真实主题的地方都可以使用代理主题
2. 代理主题角色，代理主题角色内部含有对真实主题的引用，从而可以在任何时候操作真实主题对象
3. 真实主题角色，定义了代理角色所代表的真实对象

在使用代理主题时，要将变量的明显类型声明为抽象主题的类型，而将其真实类型设置为代理主题类型

创建动态代理对象的步骤：
1. 指明一系列的接口来创建一个代理对象
2. 创建一个调用处理器`Invocation Handler`对象
3. 将这个代理指定为某个其他对象的代理对象
4. 在调用处理器的`invoke()`方法中采取代理，一方面将调用传递给真实对象，另一方面执行各种需要做的操作


## 命令模式

把方法调用封装起来

通过封装方法调用，我们可以把运算块包装成形，所以调用此运算的对象不需要关心事情是如何进行的，只要知道如何使用包装成形的方法来完成它就可以。通过封装方法调用，也可以做一些很聪明的事情，例如记录日志，或者重复使用这些封装来实现撤销

### 定义命令模式

将请求封装成对象，以便使用不同的请求，队列或者日志参数化其他对象，对象模式也支持可撤销的操作

今天就暂时看到这里吧，还是要花点时间做工作上的事情，不然给别人留下了不好好工作的坏印象了，不过也无所谓了，反正也快过年了，过年之后就要考虑找工作的问题了。按照我现在的水平，还需要再磨炼一下，不过三年的水平应该是有的了

今年的目标，就是夯实基础，不要求掌握多少技术，也不要求解决各种各样的问题

只有比别人更加努力，才能尽可能的缩小人自身的差距

有些东西从一出生就注定了，我们要做的只能用拼死的心态去改变它