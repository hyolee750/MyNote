这次一定要坚持，不管多困难，多无聊，都不能放弃

也不用每天学习多少

花半个小时到一个小时的时间来学习

把平时花在看直播的时间上，花在学习上

现在的这个工作对我来说，没有任何提升的地方，我现在要做的就是努力学习，提升自己，为自己以后将来的路做打算

今年的主要目标

加深数据结构和算法的学习

开始学习大数据和分布式

开始学习python

说不定以后我就会找关于人工智能和机器学习的方向的工作呢

---

### 要素

#### 要素1：数据类型

使用int表示整数，使用str类型表示字符串

使用方括号([]) 来存取字符串等序列的某一项

使用语法datatype(item)来将一个数据项从某种类型转换为另一种类型，如：`int("45")` ，`str(912)`

#### 要素2：对象引用

在Python中`=`的作用是将对象引用与内存中的某个对象进行绑定，如果对象引用已经存在，就简单地进行重绑定，如果对象尚未存在，就由`=`操作符创建对象引用

Python使用动态类型机制：在任何时刻，只要需要，某个对象引用都可以从新引用一个不同的对象(可以是不同的数据类型)

`type()`函数会返回给定数据项的数据类型

#### 要素3：组合数据类型

元组和列表

可以用于存储任意数量，任意类型的数据项

元组是固定的，创建之后就不能改变，相当于数组

列表是可变的，在需要的时刻可以插入或移除数据项，相当于集合

元组使用逗号创建

空元组使用空的()创建

逗号还可以用于在函数调用时分隔参数，如果需要将元组常值作为参数传递，就必须使用括号对其进行封装

列表可以使用方括号创建，[]表示一个空列表

列表与元组并不真正存储数据项，而是存放对象引用

`len()` 获取该数据项的长度

常规函数调用方式functionName(arguments)

方法调用方式objectName.methodName(arguments)

#### 要素4：逻辑操作符

身份操作符

is 如果其左端的对象引用于右端的对象引用指向的是同一个对象，则会返回True

最常见的使用is的情况是：将数据项与内置的空对象None进行比较，None通常用做位置标记值，指示未知 或不存在

Python比较操作符的一个特别好用的特性就是可以进行链式比较

如 `0 <=a<=10`

成员操作符 in 

对序列或集合这一数据类型，比如字符串，元组，列表，可以使用操作符in来测试成员关系，用not in 来测试非成员关系

逻辑运算符

and or not 都会返回决定结果的操作数，而不是返回布尔值

not 单一操作符，总是返回布尔值结果

#### 要素5：控制流语句

预定义为常量False的布尔表达式，特殊对象None，空序列或集合，值为0的数值类型数据项等的布尔结果为False，其他则为True

关键字 pass 是一条空语句，不进行任何操作

```Python
if boolean_expression1:
    suite1
elif boolean_expression2:
    ...
elif boolean_expressionN:
    suiteN
else:
    else_suite
```

while语句

for ... in语句

for variable in iterable：

​    suite

##### 基本的异常处理

语句

```python
try:
    try_suite
except exception1 as variable1:
    exception_suite1
    
```

#### 要素6：算术操作符

列表+=操作符右边的操作数必须是一个iterable

#### 要素7：输入/输出

`input()`函数，用来接收自用户的输入

#### 要素8：函数的创建与调用

```python
def functionName(arguments):
    suite
```

使用模块中函数的语法格式为moduleName.methodName(arguments)

