## Java泛型

Java泛型是JDK5中引入的一个新特性，**允许在定义类和接口的时候使用类型参数** ，声明的类型参数在使用时用具体的类型来替换

### 类型擦除

Java中的泛型基本上都是在编译器这个层次来实现的，在生成Java字节代码中是不包含泛型中的类型信息的，使用泛型的时候加上的类型参数，会被编译器在编译的时候去掉，这个过程就称为类型擦除

很多泛型的奇怪特性都与这个类型擦除的存在有关，包括：

- 泛型类并没有自己独有的Class类对象，比如并不存在`List<String>.class` 或是`List<Integer>.class` ，而只有`List.class`
- 静态变量是被泛型类的所有实例共享的
- 泛型的类型参数不能用在Java异常处理的catch语句中，因为异常处理是由JVM在运行时刻来进行的，由于类型信息被擦除，JVM无法区分两个异常类型`MyException<String>` 和`MyException<Integer>` 的

### 通配符与上下界

在使用泛型类的时候，既可以指定一个具体的类型，也可以使用通配符？来表示未知类型，通配符代表的其实是一组类型，但具体的类型是未知的

可以使用上下界来限定未知类型的范围，如`List<? extends Number>` 说明List中可能包含的元素类型是Number及其子类

规则：

- 相同类型参数的泛型类的关系取决于泛型类自身的继承体系结构。即`List<String>`是`Collection<String> `的子类型，`List<String>`可以替换`Collection<String>`。这种情况也适用于带有上下界的类型声明。
- 当泛型类的类型声明中使用了通配符的时候， 其子类型可以在两个维度上分别展开。如对`Collection<? extends Number>`来说，其子类型可以在`Collection`这个维度上展开，即`List<? extends Number>`和`Set<? extends Number>`等；也可以在`Number`这个层次上展开，即`Collection<Double>`和` Collection<Integer>`等。如此循环下去，`ArrayList<Long>`和 `HashSet<Double>`等也都算是`Collection<? extends Number>`的子类型。
- 如果泛型类中包含多个类型参数，则对于每个类型参数分别应用上面的规则。



数组扩容的思路

先讲一讲`StringBuffer` 类的实现原理，然后探讨数组扩容的思路

只要涉及到容器，都会涉及到数据结构，目前底层的数据结构 基本上是数组和链表

默认构造的时候，初始容量`capacity` 为16，长度为0

capacity等于内置数组的长度

length等于内置数组中元素的数量

扩容的时机：当数组中的元素个数count 大于内置数组的长度value.length的时候，就进行扩容

新的容量newcapacity = value.length *2 +2

```java
int newCapacity = value.length * 2 + 2;
if (newCapacity - minimumCapacity < 0)
  newCapacity = minimumCapacity;
if (newCapacity < 0){
  if (minimumCapacity < 0)
    throw new OutOfMemoryError();
  newCapacity = Integer.MAX_VALUE;
}
value = Arrays.copyOf(value,newCapacity);
```



### ArrayList类的扩容逻辑及实现

arraylist是以数组为底层存储结构来实现了可变列表的功能

一个类有两个重要的方面，属性和行为

属性规定了类的状态

行为用来改变属性的状态

那么一个集合类应该具有那些状态和行为呢？

默认的容量 也就是默认的数组的长度

默认的空的数组

用来存储元素的数组

那么一个集合的大小就等于该数组中的元素个数

通过这几个属性就可以确定以下字段

```java
// 默认的集合容量
int DEFAULT_CAPACITY = 10;
// 默认的空数组，用在构造函数中
Object[] DEFAULT_CAPACITY_EMPLTY_ELEMENTDATA = {};
// 用来存储元素的数组
Object[] elementData;
// 用来代表元素数组中的元素个数
int size;
// 代表数组最大长度的常量
int MAX_ARRAY_SIZE = Integer.MAX_VALUE - 8;
```

然后再来看看ArrayList是如何实现扩容的吧

首先通过默认的构造函数创建ArrayList

```java
ArrayList<String> list = new ArrayList<>();
```

这时候的属性值分别是：

```java
elementData = DEFAULT_CAPACITY_EMPTY_ELEMENTDATA;
size = 0;
```

当执行`list.add(E e)` 方法的时候：

```java
// 第一次添加元素时minCapacity = size + 1 = 1;
int minCapacity = size + 1;
// 首先判断elementData是否等于默认的空数组，如果等于。那么minCapacity 就等于默认容量和minCapacity中最大的值
if elementData = DEFAULT_CAPACITY_EMPTY_ELEMENTDATA
// 这时候minCapacity = 10；
  minCapacity = Math.max(DEFAULT_CAPACITY,minCapacity);
// 然后判断 minCapacity 是否大于 elementData的长度，如果大于，就说明要扩容了
if minCapacity > elementData.length;
// 扩容的核心逻辑 newCapacity = oldCapacity + （oldCapacity >>1）
oldCapacity = elementData.length;
newCapacity = oldCapacity + (oldCapacity >> 1)
// 然后判断newCapacity 和minCapacity的值
// 如果newCapacity小于minCapacity，那么newCapacity = minCapacity
 if newCapacity - minCapacity < 0
   newCapacity = minCapacity;
 if newCapacity > MAX_ARRAY_SIZE
   newCapacity = MAX_ARRAY_SIZE;
// 这时候如果newCapacity 小于0 就让newCapacity = MAX_ARRAY_SIZE
// 这样就获得了新的容量
// 使用Array.copyOf(elementData,newCapacity)将原来的数组中的数据转移到新的数组中
 elementData = Arrays.copyOf(elementData,newCapacity);
// 这样就扩容成功了
// 执行elementData[size++] = e 进行添加元素
elementData[size++] = e;
return true;
```

第一次扩容的时机是第一次添加元素的时候，默认容量为10

第二次扩容的时机 10 + 10 >> 1 = 15

第三次扩容的时机 15 + 15 >> 1 = 22

....

扩容的时机和逻辑基本上搞清楚了，下面开始研究最重要的两个方法，添加方法和删除方法

添加方法有两种

1. add(E e) 自动添加到数组元素后
2. add(int index , E e) 在指定位置添加元素

这里只讲第二种，因为这个方法涉及到了元素的移动

```java
// 首先检查index的有效性
checkIndex(index);
// 其次检查是否需要扩容
ensureCapacity(size +1);
// 计算需要移动的元素个数
numMoved = size - index;
// 使用系统的方法移动元素
if numMoved > 0
System.arraycopy(elementData,index,elementData,index+1,numMoved);
// 将元素添加到数组
elementData[index] = e;
// 将size加1
size ++ ;
```

删除的方法 只讲一个根据index删除元素的方法

remove (int index , E e);

```java
// 1. 检查index范围
checkIndex(index);
// 2. 计算需要移动的元素个数,注意这里和添加不一样的
E oldValue = elementData[index];
numMoved = size - index -1 ;
// 3. 如果numMoved>0 表示有元素需要移动
if numMoved > 0
	System.arraycopy(elementData,index+1,elementData,index,numMoved);
// 4. 删除该index位置上的元素
elementData[--size] = null;
return oldValue;
```

代码的鲁棒性





