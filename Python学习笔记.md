# Python3 程序开发指南

## 第1章 过程型程序设计快速入门

### 1.1 创建并运行Python程序

注释：在Python中，注释以#开始，作用范围为该行

空行：Python会忽视空行，但空行通常有助于将大块代码分割，以便于阅读

.py文件中的每个语句都是顺序执行的

### 1.2 Python的关键要素

#### 1.2.1 要素#1 : 数据类型

Python提供了几种内置的数据类型，现在我们只关注其中的两种，python使用int类型来表示整数，正整数或负整数。使用str类型表示字符串

python使用方括号[]来存取字符串等序列中的某一项，比如

```python
>>> "Hard TImes"[5]
'T'
```

Python语法中，索引位置是从0开始计数的

在Python中，str类型与基本的数字类型都是固定的，也就是说，一旦设定，其值就不能改变

如果需要将一个数据项从某种类型转换为另外一种类型，那么可以使用语法`datatype(item)` 例如：

```python
>>> int('45')
45
>>> str(921)
'921'
```

#### 1.2.2 要素#2：对象引用

在Python中，=的作用是将对象引用与内存中的某对象进行绑定，如果对象引用已经存在，就简单的进行重绑定，以便应用=操作符右边的对象，如果对象引用尚未存在，就由=操作符创建对象引用

标识符的限制：

1. 不能与任何Python关键字相同
2. 必须以字母或下划线引导，其后跟谁0个或多个非空格支付，下划线或数字
3. 标识符没有长度限制
4. Python标识符是大小写敏感的

#### 1.2.3 要素#3：组合数据类型

Python提供了几种组合数据类型，包括关联数组与集合等类型，这里，只讨论其中的两种：元组与列表

可以用于存储任意数量，任意类型的数据项

元组是固定的，创建之后就不能改变

列表是可变的，在需要的时候，可以插入或移除数据项

元组使用逗号创建

在输出元组时，Python使用圆括号将其封装在一起。如果某个元组只有一个数据项，又需要使用圆括号，就仍然必须使用逗号，比如(1,)。空元组则使用空的()创建，逗号还可以用于在函数调用时分隔参数，因此，如果需要将元组常值作为参数传递，就必须使用括号对其进行封装，以免混淆。

列表可以使用方括号创建

实质上，列表与元组并不真正存储数据项，而是存放对象引用。

len()函数，该函数以某个单独的数据项作为参数，并返回该数据项的长度

元组，列表以及字符串都数据类型，都是有大小的，也就是说，对这些数据类型而言，长度或大小等度量是有意义的

所有Python数据项都是某种特定数据类型的对象

对象可以有方法，方法就是在某特定对象可以调用的函数

数据类型list有一个append()方法，可以添加对象

所有Python对象都知道自身的数据类型，因此，不需要明确的指定数据类型

Python有一种常规的函数调用方式functionName(arguments)，方法调用方式objectName.methodName(arguments)

点操作符用于存取对象的某个属性

list类型有很多其他方法，包括insert()方法，该方法用于在某给定的索引位置插入数据项，remove()方法，该方法用于移除某给定索引位置上的数据项

#### 元素#4：逻辑操作符

Python提供了4组逻辑运算

##### 1.2.4.1 身份操作符

所有的Python变量实际上都是对象引用

is操作符是一个二元操作符，如果其左端的对象引用与右端的对象引用指向的是同一个对象，则会返回true

is操作符只需要对对象所在的内存地址进行比较，同样的地址存储的是同样的对象

最常见的使用is的情况是将数据项与内置的空对象None进行比较，Node通常用作位置标记值，指示未知或不存在

身份操作符的作用是查看两个对象引用是否指向相同的对象，或者查看某个对象是否为None

如果我们需要比较对象值，就应该使用比较操作符

##### 1.2.4.2 比较操作符

`<` 表示小于

`<=` 表示小于或等于

`==` 表示等于

`!=` 表示不等于

`>=` 表示大于或等于

`>` 表示大于

这些操作符对对象值进行比较，也就是对象引用在比较中指向的具体对象

Python比较操作符的一个特别好用的特性就是可以进行结链比较

##### 1.2.4.3 成员操作符

对序列或集合这一类数据类型，比如字符串，列表或元组，我们可以使用操作符in来测试成员关系，用not in来测试非成员关系

##### 1.2.4.4 逻辑运算符

Python提供了3个逻辑运算符 and ， or ， not

and和or都使用short-circuit逻辑，并返回决定结果的操作数，而不是返回布尔值，除非实际上就是布尔操作数

#### 1.2.5 要素#5：控制流语句

在Python中，预定义为常量False的布尔表达式，特殊对象None，空序列或集合，值为0的数值类型数据项等的布尔结果为False

##### 1.2.5.1 if语句

Python的常规if语句语法如下：

```python
if boolean_expression1:
	suite1
elif boolean_expression2:
	suite2
...
elif boolean_expressionN:
	suiteN
else:
	else_suite
```

与if语句对应的可以有0个或多个elif分支，最后的else分支是可选的，可以使用pass作为该分支的suite

冒号是上面语法中的一个组成部分，冒号与else，elif一起使用

Python使用缩排来标识其块结构

建立是每层缩排4个空格，并且只有空格

##### 1.2.5.2 while语句

while语句用于0次或多次执行某个suite，循环执行的次数取决于while循环中布尔表达式的状态，下面给出其语法格式：

```python
while boolean_expression:
	suite
```

break 语句用于跳出循环，continue语句是将控制流导向到循环起始处

```python
while True:
	item = get_next_item()
	if not item:
		break
	process_item(item)
```

##### 1.2.5.3 for ... in 语句

Python的for循环语句重用了关键字in，并使用如下的语法格式：

```python
for variable in iterable:
	suite
```

```python
for letter in "ABCDEFGHIJKLMNOPQRSTUVWXYZ":
        if letter in "AEIOU":
                print(letter,"is avowel")
        else:
                print(letter,"is a consonant")
```

##### 1.2.5.4 基本的异常处理

Python的很多函数与方法都会产生异常，并将其作为发生错误或重要事件的标识，异常也是一个对象，异常处理的简单语法格式如下：

```python
try:
	try_suite
except exception1 as variable1:
	exception_suite1
...
except exceptionN as variableN:
	exception_suiteN
```

要注意的是，as variable 部分是可选的，我们可以直观性产生了某个特定的异常，而不关心其具体的消息本文

#### 1.2.6 要素#6：算术操作符

Python提供了完整的算术运算符集，+ - * /

Python的除法操作符会产生一个浮点值，而不是一个整数值

#### 1.2.7 要素#7：输入/输出

Python提供了内置的input()函数，用来接收来自用户的输入

```python
print("Type integers,each followed by Enter;or just Enter to finish")

total = 0
count = 0

while True:
    line = input("integer:")
    if line:
        try:
            number = int(line)
        except ValueError as err:
            print(err)
            continue
        total += number
        count += 1
    else:
        break
if count:
    print("count=", count, "total=", total, "mean=", total / count)
```

#### 1.2.8 要素#8：函数的创建与调用

Python提供了一种将多个suites封装为函数的途径，函数就可以参数化，并通过传递不同的参数来调用，下面给出的是用于创建函数的通常语法格式：

```python
def functionName(arguments):
	suite
```

这里，arguments是可选的，如果有多个参数，就必须使用逗号进行分隔，每个Python函数有一个返回值，默认情况下为None，除非我们使用语法return value来从函数返回，此时value是实际的返回值，返回值可以是仅仅一个值，也可以是一组值。调用者可以忽略返回值，并简单的将其丢弃

```python
def get_int(msg):
    while True:
        try:
            i = int(input(msg))
            return i
        except ValueError as err:
            print(err)
```

要导入一个模块，必须使用import语句，其后跟随.py文件名，但是不需要写出该扩展名

```python
import sys
```

常规的做法是将所有import语句放在.py文件的起始处，首先导入标准库模块，之后导入第三方库模块，最后才导入自己编写的模块

### 1.3 总结

本章大部分在于解决注意编写实际Python程序的8个要素--python的关键要素

基本的两个数据类型 int和str

字符串也是序列

对于固定的对象，比如字符串，整数与元组，我们可以编写自己的代码

Python提供了几种内置的组合数据类型

is与is not的用法

Python支持标准的逻辑操作符 and or not

in和not in操作符的用法

Python提供了几种控制结构，包括条件分支，条件循环，序列上的迭代与异常处理

Python支持常见的算术操作符

通过input()和print()函数，可以实现控制台I/O

Python提供了广泛的标准库，在使用import语句导入