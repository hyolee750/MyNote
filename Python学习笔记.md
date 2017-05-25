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

### 4. Python对象类型

Python程序可以分成模块，语句，表达式和对象

1. 程序由模块组成
2. 模块包含语句
3. 语句包含表达式
4. 表达式创建和处理对象

#### 4.1 Python的核心数据类型

| 对象类型   | 示例                                       |
| ------ | ---------------------------------------- |
| 数字     | `1234`,`3.1415`，`3+4j`,`ob111`,`Decimal()`,`Fraction()` |
| 字符串    | `'spam'`,`"bob's"`,`b'a\x01c'`,`u'sp\xc4m'` |
| 列表     | `[1,[2,'three'],4.5]`,`list(range(10))`  |
| 字典     | `{'food':'spam','taste':'yum'}`,`dict(hours=10)` |
| 元组     | `(1,'spam',4,'U')`,`tuple('spam')`,`namedtuple` |
| 文件     | `open('eggs.txt')`,`open(r'c:\ham.bin','wb')` |
| 集合     | `set(a,b,c)`,`{'a','b','c'}`             |
| 其他核心类型 | `Boolean`,`types`,`None`                 |
| 程序单元类型 | `Function`,`module`,`class`              |
| 相关实现类型 | 已编译的代码，栈记录                               |

##### 4.1.1 数字

模块是额外的工具包，我们可以导入使用

```python
import math
math.pi
math.sqrt(85)
```

```python
import random
random.random()
random.choice([1,2,3,4])
```

### 5. 数值类型

#### 5.1 数值类型基础

包括以下类型：

- 整型和浮点型对象
- 复杂数值对象
- Decimal：固定精度对象
- Fraction：分数
- Set：使用数值操作符的集合
- Boolean：True和False
- 内置函数和模块：`round`，`math`,`random`等等
- 表达式
- 第三方扩展

十六进制以`0x`或`0X`开头，后接十六进制字符串(0-9和A-F)

八进制以`0o`或`0O`开头，后接八进制字符串(0-7)

二进制以`0b`或`0B`开头，后接二进制字符串(0-1)

`hex(I)` 将十进制的数值转换成十六进制

`oct(I)`将十进制的数值转换成八进制

`bin(I)`将十进制的数值转换成二进制

`int(str,base)`将字符串按照指定进制进行转换

复杂类型的数值也可以通过`complext(real,imag)`创建

#### 5.2 内置数值工具

表达式操作符

```python
+,-,×,/，>>,**,&
```

内置的算术函数

```python
pow,abs,round,int,hex,bin
```

工具类模块

```python
random,math
```

#### 字符串的格式化

使用位置

```python
>>> template = '{0}, {1} and {2}'
>>> template.format('spam', 'ham', 'eggs')
'spam, ham and eggs'
```

使用关键字

```python
>>> template = '{motto}, {pork} and {food}'
>>> template.format(motto='spam', pork='ham', food='eggs')
'spam, ham and eggs'
```

同时使用位置和关键字

```python
>>> template = '{motto}, {0} and {food}'
>>> template.format('ham', motto='spam', food='eggs')
'spam, ham and eggs'
```

使用相对位置

```python
>>> template = '{}, {} and {}'
>>> template.format('spam', 'ham', 'eggs')
'spam, ham and eggs'
```

使用表达式

```python
>> template = '%s, %s and %s'
>>> template % ('spam', 'ham', 'eggs')
'spam, ham and eggs'
```

```python
>>> template = '%(motto)s, %(pork)s and %(food)s'
>>> template % dict(motto='spam', pork='ham', food='eggs')
'spam, ham and eggs'
```

`%s`可以使用任意对象类型

```python
>>> '{motto}, {0} and {food}'.format(42, motto=3.14, food=[1, 2])
'3.14, 42 and [1, 2]'
```

##### 添加键，属性和偏移量

使用`[]`来引用字典的键

使用`.`来调用对象的属性

```python
>>> import sys
>>> 'My {1[kind]} runs {0.platform}'.format(sys, {'kind': 'laptop'})
'My laptop runs win32'
```

```python
>>> 'My {map[kind]} runs {sys.platform}'.format(sys=sys, map={'kind': 'laptop'})
'My laptop runs win32'
```

#### 元组

元组是不可变的，由`()`构成。而不是`[]`

- *任意对象的有序集合*
- *按索引访问*
- *属于不可变序列目录*
- *固定长度，复杂的，任意嵌套的*
- *对象引用的数组*

```python
()		# 一个空元组
T = (0,) # 包含一个元素的元组
T = (0,'Ni',1.2,3) # 4个元素的元组
T = 0,'Ni',1.2,3 # 另一种4个元素的元组
T = ('Bob',('dev','mgr')) # 嵌套的元组
T = tuple('spam') 
T[i] # index
T[i][j] # index of index
T[i:j] # slice
len(T) # length
T1+T2 # 串联
T * 3 # 重复
for x in T:print(x) # 迭代
'spam' in T # 测试成员关系
[x**2 for x in T] # 表达式
T.index('Ni') # 'Ni'第一次出现的位置
T.count('Ni') # ‘Ni’ 的个数
namedtuple('Emp',['name','jobs'])
```

#### 文件

内置`open`函数创建了一个Python文件对象，

常用的文件操作

- `output = open(r'C:\spam','w')` 写文件 `'w'` 意味着写
- `input = open('data','r') 创建读文件`
- `input = open('data') 
- `aString = input.read()`读取整个文件到一个字符串
- `aString = input.read(N)`读取N个字符或字节到字符串
- `aString = input.readline()` 读取一行到字符串
- `aList = input.readlines()` 读取整个文件到一个行的列表
- `output.write(aString)` 写字符串到文件
- `output.writelines(aList)` 将所有的行写到文件
- `output.close()` 手动关闭
- `output.flush()` 刷新缓存到磁盘
- `anyFile.seek(N)` 改变文件位置到N进行下次操作
- `for line in open('data'): use line` 文文件迭代器一行一行读取
- `open('f.txt', encoding='latin-1')`
- `open('f.bin', 'rb')`

