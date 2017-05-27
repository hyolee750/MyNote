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

#### `open`的文档说明

语法
```python
open(file,mode='r',buffering=-1,encoding=None,errors=None,newline=None,closefd=True,opener=None)
```

打开文件，返回一个流，如果失败则抛出`IOError`错误

文件是一个文本或二进制字符串

模式是一个可选的字符串定义了文件被打开的模式，默认为`r` 表示以文本模式打开 进行读操作

其它常用的值有`w` 写操作(如果文件已经存在，会清空文件内容)

可用的模式

- `r` 打开文件进行读操作(默认)
- `w` 打开文件进行写操作，首先会清空文件内容
- `x` 创建一个新的文件，然后打开进行写操作,如果文件存在，会抛出`FileExistsError`错误
- `a` 打开文件进行写操作，如果文件已经存在，会将内容添加到文件的末尾
- `b` 二进制模式
- `t` 文本模式 (默认)
- `+` 打开一个磁盘文件进行更新操作 (读或写)

二进制模式和文本模式的区别

- 文件以二进制模式打开，会返回没有任何编码的字节对象内容
- 文件以文本模式打开，文件的内容以字符串的形式返回，字节的话首先会使用平台依赖的或给定的字符集进行编码

缓冲是一个可选的整数用来设置缓冲策略

传递0 将缓冲关闭(只允许在二进制模式)，1 选择行缓冲(只能在文本模式使用)，大于1的整数声明一个固定大小缓冲块的大小，如果没有给定缓冲参数，默认的缓冲策略

#### 函数相关的语句和表达式

- 调用表达式 `myfunc('spam','eggs',meat=ham,*rest)`
- `def` 定义函数
- `return` 返回数据
- `global` 全局变量
- `nonlocal` 非本地变量
- `yield` 产生数据
- `lambda` lambda表达式 `func = [lambda:x:x**2,lambda:x:x**3]`

函数的两个作用：
1. 最大化代码重用，最小化代码冗余
2. 过程分解

`def`的作用：
1. `def`是可执行的代码
2. `def`创建了一个对象，然后给它赋值了一个名字
3. `lambda`创建了一个对象，当会把它当做结果返回
4. `return`发送结果对象给调用者
5. `yield` 发送结果对象给调用者，但是会记住结果在何处离开
6. `global`声明了模块级别的变量

##### `def`语句

语法格式：
```python
def name(arg1,arg2,... argN):
    statements
```

### 参数

- 参数的传递是通过自动将对象赋值给本地变量来实现的
- 在函数内部的参数名的赋值不会影响调用者
- 改变函数的可变对象参数的值也会对调用者有影响
- 不可变参数通过值传递
- 可变对象是通过指针进行传递的

在默认情况下，参数是通过其位置进行匹配的，从左至右，而且必须精确地传递和函数头部参数名一样多的参数

#### 基础知识 

位置：从左至右进行匹配

关键字参数：通过参数名进行匹配

默认参数：为没有传入值的参数定义参数值

可变参数：收集任意多基于位置或关键字的参数，以字符`*`开头，收集任意多的额外参数

可变参数解包：传递任意多的基于位置或关键字的参数，意味着传递任意多的参数

只有关键字参数：参数必须按照名称传递

#### 匹配语法

| 语法                       | 位置   | 解释                             |
| ------------------------ | ---- | ------------------------------ |
| `func(value)`            | 调用者  | 常规参数：通过位置进行匹配                  |
| `func(name=value)`       | 调用者  | 关键字参数：通过变量名匹配                  |
| `func(*sequence)`        | 调用者  | 以name传递所有对象，并作为独立的基于位置的参数      |
| `func(**dict)`           | 调用者  | 以name成对的传递所有的关键字/值，并作为独立的关键字参数 |
| `def func(name)`         | 函数   | 常规参数：通过位置或变量名进行匹配              |
| `def func(name=value)`   | 函数   | 默认参数值，如果没有在调用中传递的话             |
| `def func(*name)`        | 函数   | 匹配并收集(在元组中)所有包含位置的参数           |
| `def func(**name)`       | 函数   | 匹配并收集(在字典中)所有包含位置的参数           |
| `def func(*args,name)`   | 函数   | 参数必须在调用时按照关键字传递                |
| `def func(*,name=value)` |      |                                |

#### 细节

- 在函数调用中，参数必须以此顺序出现，任何位置参数后面跟着任何关键字参数和`*sequence`形式的组合，后面跟着`**dict`形式
- 在函数头部，参数必须以此顺序出现，任何一般参数，紧跟着任何默认参数，如果有的话，后面是`*name`的形式，后面跟着任何name 或name=value的参数，后面跟着`**name`形式

在调用和函数头部中，如果出现`**arg`形式的话，都必须出现在最后

##### Python内部使用以下步骤在赋值前进行参数匹配的

1. 通过位置分配非关键字参数
2. 通过匹配变量名分配关键字参数
3. 其他额外的非关键字参数分配到`*name`元组中
4. 其他额外的关键字参数分配到`**name`字典中
5. 用默认值分配给在头部未得到分配的参数

#### 任意参数的实例

##### 收集参数

第一种用法：在函数定义中，在元组中收集不匹配的位置参数

```python
def f(*args):print(args)
```

当这个函数调用时，Python将所有位置相关的参数收集到一个新的元组中，并将这个元组赋值给变量args

`**`特性类似，但是它只对关键字参数有效，将这些关键字参数传递给一个新的字典

```python
def f(**args):print(args)
```

最后，在函数头部能够混合一般参数，`*`参数以及`**`去实现更灵活的调用方式

```python
def f(a,*pargs,**kargs):print(a,pargs,kargs)
>>> f(1,2,3,x=1,y=2)
1 (2,3) {'y':2,'x':1}
```

#### 解包参数

在调用函数时能够使用`*`语法，它会解包参数的集合，而不是创建参数的集合，例如，我们能够通过一个元组给一个函数传递四个参数，并且让Python将它们解包成不同的参数

```python
>>> def func(a,b,c,d):print(a,b,c,d)
...
>>> args = (1,2,3,4)
>>> func(*args)
1 2 3 4
```

相似地，在函数调用时，`**`会以键/值对的形式解包一个字典，使其成为独立的关键字参数

```python
>>> args = {'a':1,'b':2,'c':3,'d':4}
>>> func(**args)
1 2 3 4
```

**注意：**

1. `*args`是一个元组，通过位置来进行匹配
2. `**kwargs`是一个字典，通过关键字来进行匹配

### 函数的高级话题

- 耦合性：对于输入使用参数并且对于输出使用return语句
- 耦合性：只有在真正必要的情况下使用全局变量
- 耦合性：不要改变可变类型的参数，除非调用者希望这样做
- 聚合性：每一个函数都应该有一个单一的，统一的目标
- 大小：每一个函数应该相对较小
- 耦合：避免直接改变在另外一个模块文件中的变量

#### 递归函数

示例

```python
def my_sum(L):
    if not L:
        return 0
    else:
        return L[0] + my_sum(L[1:])
print(advanced.my_sum([1, 2, 3, 4, 5]))
>>> 15
```

Python强调像循环这样的简单的过程式语句，循环语句通常更为自然

更好的情况，for循环为我们自动迭代，使得递归在大多数情况下不必使用

递归在内存空间和执行时间方面效率较低

有了循环语句，我们不需要在调用堆栈上针对每次迭代都有一个本地作用域的副本

#### 处理任意结构

示例

```python
def sub_tree(L):
    tot = 0
    for x in L:
        if not isinstance(x, list):
            tot += x
        else:
            tot += sub_tree(x)
    return tot
>>>
L = [1, [2, [3, 4], 5], 6, [7, 8]]
print(advanced.sub_tree(L))
```

#### 间接函数调用

由于Python函数是对象，我们可以编写通用的处理它们的程序

函数对象可以赋值给其他的名字，传递给其他函数，嵌入到数据结构，从一个函数返回给另一个函数

#### 函数内省

#### 函数属性

也可以向函数附加任意定数定义的属性

#### 函数注解

#### 匿名函数：lambda

创建了一个之后能够调用的函数，但是它返回了一个函数而不是将这个函数赋值给一个变量名

##### lambda表达式

```python
lambda argument1,argument2,...argumentN:expression using arguments
```

- lambda是一个表达式，而不是一个语句
- lambda的主体是一个单个的表达式，而不是一个代码块

示例

```python
f = lambda x, y, z: x + y + z
print(f(1, 2, 3))
```

#### 在序列中映射函数：map

map函数会对一个序列对象中的每一个元素应用传入的函数，并且返回一个包含了所有函数调用结果的一个列表

由于map期待传入一个函数，它恰好是lambda通常出现的地方之一

```python
list(map(lambda x:x+3),counters)
```

filter 和reduce的用法

```python
list(filter((lambda x: x > 0), range(-5, 5)))
reduce((lambda x, y: x + y), [1, 2, 3, 4])
```

1. lambda和def都会创建函数对象，不过因为lambda是表达式，可以嵌入函数定义中def语法上无法出现的地方。lambda只允许单个返回值表达式，因为它不支持语句代码块，因此不适用于较大的函数
2. lambda允许内联小单元可执行代码，推迟其执行，并且以默认参数和封闭作用域变量形式为其提供状态
3. map把每一项传递给函数并收集结果，filter收集那些函数返回True值的项，reduce通过对一个累加器和后续项应用函数来计算一个单个的值

### 迭代和解析

列表解析的示例

1. 收集整个字符串中的所有字符的ASCII码

   ```python
   [ord(x) for x in 'Spam']
   ```


2. 收集从0-9数字的平方

   ```python
   [x ** 2 for x in range(10)]
   ```

3. 选择出从0-4的偶数

   ```python
   [x for x in range(5) if x%2 == 0]
   ```

4. 列表解析支持任意数量的嵌套的for循环

   ```python
   [x+y for x in [0,1,2]  for y in [100,200,300]]
   ```

5. 复杂嵌套中添加条件判断

   ```python
   [(x,y) for x in range(5) if x%2 ==0 for y in range(5) if y%2 ==1]
   ```

#### 生成器

- 生成器函数：编写为常规的def语句，但是使用`yeild`语句一次返回一个结果，在每个结果之间挂起和继续他们的状态
- 生成器表达式返回按需产生的结果的一个对象，而不是构建一个结果列表

```python
def gensquares(N):
    for i in range(N):
        yield i ** 2
```

### 模块

模块可以由两个语句和一个重要的内置函数进行处理

1. import 使客户端以一个整体获取一个模块
2. from 允许客户端从一个模块文件中获取特定的变量名
3. imp.reload 在不终止python程序的情况下，提供了一种重新载入模块文件的方法

