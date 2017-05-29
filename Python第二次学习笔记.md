# Fluent Python

## 第一部分. 序幕

### 1. Python 数据模型

Python最好的特质就是它的一致性

你可以认为数据模型是python作为框架的描述，它组织了语言本身的代码块，像序列，迭代器，函数，类，内容管理器等等

Python解释器调用特殊方法来执行基本的对象操作，经常被特殊语法触发，特殊方法的名称总是以两个下划线开始

特殊方法的名称允许你的对象实现，支持，交互同基础的语法构造

- 迭代
- 集合
- 属性访问
- 操作符重载
- 函数和方法调用
- 对象创建和销毁
- 字符串表述和格式化
- 内容管理器

####  一个Python化的卡牌

下面是一个非常简单的例子，但是演示了实现两个特殊方法`__getitem__`和`__len__`的强大之处

```python
import collections

Card = collections.namedtuple('Card', ['rank', 'suit'])


class FrenchDeck:
    ranks = [str(n) for n in range(2, 11)] + list('JQKA')
    suits = 'spades diamonds clubs hearts'.split()

    def __init__(self):
        self._cards = [Card(rank, suit) for suit in self.suits
                       for rank in self.ranks]

    def __len__(self):
        return len(self._cards)

    def __getitem__(self, position):
        return self._cards[position]
```

使用`collections.namedtuple`构造了一个简单的类来代表单个卡

`namedtupe`可以用来构造只有一系列属性而没有自定义方法的对象的类

使用`random.choice`在序列中随机选择一个选项

使用特殊的方法覆盖Python数据模型的两个好处：

1. 你的类的用户不需要记住任意标准操作的方法名
2. 更容易从丰富的Python标准库获取好处，并避免重复造轮子

#### 特殊方法是如何被使用的

第一个需要知道的事情就是特殊方法被Python解释器调用，而不是你

大多数情况下，特殊方法的调用是隐式的

通常来说，你的代码不应该有太多特殊方法的直接调用，只有一个特殊方法被用户代码频繁地直接调用`__init__`方法，用来初始化超类

如果你需要调用一个特殊方法，最好去调用相应的内置函数

避免创建任意的自定义的`__foo__`语法，因为这样的名称可能在未来有特殊的意义

##### 仿效数字类型

```python
from math import hypot


class Vector:
    def __init__(self, x=0, y=0):
        self.x = x
        self.y = y

    def __repr__(self):
        return 'Vector(%r,%r)' % (self.x, self.y)

    def __abs__(self):
        return hypot(self.x, self.y)

    def __bool__(self):
        return bool(abs(self))

    def __add__(self, other):
        x = self.x + other.x
        y = self.y + other.y
        return Vector(x, y)

    def __mul__(self, scalar):
        return Vector(self.x * scalar, self.y * scalar)

    def __str__(self):
        return 'Vector(x=%r,y=%r)' % (self.x, self.y)

    def sum(self):
        return self.x + self.y
```

`abs`内置函数的功能就是一个整数或浮点数或者复杂类型数值的绝对值

尽管我们实现了4个特殊方法，除了`__init__`，他们没有被直接调用

##### 字符串表述

`__repr__`特殊方法由内置的`repr`函数调用来获取一个对象的字符串表述

如果没有实现`__repr__`，vector的实例将会显示成这样的结果`<Vector object at 0x10e100070>`

和`__repr__`相比还有一个叫`__str__`，被`str()`构造器调用，同时，也会被`print`函数隐式地调用

如果你只实现这些特殊方法的其中一个，选择`__repr__`,因为当没有自定义的`__str__`可用的时候，Python将会调用`__repr__`方法

##### 算数操作符

上面的例子实现了两个操作符`+`和`*`，来显示`__add_`和`__mul__`的基础用法

注意在所有的情况下，这些操作创建并返回一个Vector的新的实例，不会修改其中任意的操作数，`self`和`other`仅仅是可读的

##### 自定义的布尔值

默认情况下，用户自定义的类被认为是真，除非实现了`__bool__`或`__len__`方法，一般来说，`bool(x)`调用`x.__bool__()`并使用其结果，如果`__bool__`没有实现，Python试图调用`x.__len__()`方法，如果该方法返回0，bool返回False，否则bool返回True

#### 特殊方法概述

特殊方法的名称

| 分类         | 方法名                                      |
| ---------- | ---------------------------------------- |
| 字符串/字节表述   | `__repr__`,`__str__`,`__format__`,`__bytes__` |
| 转换到数字      | `__abs__`,`__bool__`,`__complex__`,`__int__`,`__float__`,`__hash__`,`__index__` |
| 模拟集合       | `__len__`,`__getitem__`,`__setitem__`,`__delitem__`,`__contains__` |
| 迭代         | `__iter__`,`__reversed__`,`__next__`     |
| 模拟callable | `__call__`                               |
| 上下文管理      | `__enter__`,`__exit__`                   |
| 实例创建和销毁    | `__new__`,`__init__`,`__del__`           |
| 属性管理       | `__getattr__`,`__getattribute__`,`__setattr__`,`__delattr__`,`__dir__` |
| 属性描述       | `__get__`,`__set__`,`__delete__`         |
| 类服务        | `__prepare__`,`__instancecheck__`,`__subclasscheck__` |

特殊方法操作符



| 分类        | 方法名                                      |
| --------- | ---------------------------------------- |
| 二元数字操作符   | `__neg__`-,`__pos__`+,`__abs__`abs()     |
| 比较操作符     | `__lt__`>,`__le__`<=,`__eq__`==,`__ne__`!=,`__gt__`>,`__ge__`>= |
| 算术操作符     | `__add__`,`__sub__`,`__mul__`,`__truediv__`,`__floordiv__`,`__mod__`,`__divmod__` |
| 翻转算术操作符   | `__radd__`,`__rsub__`                    |
| 增强赋值算术操作符 | `__iadd__`,`__isub__`,`__imul__`,`__itruediv__` |
| 位操作符      | `__invert__`,`__lshift__`,`__rshift__`,`__and__`,`__or__`,`__xor__` |

#### 为什么`len`不是一个方法

`len`不是被作为一个方法来调用的，因为它作为Python数据模型的一部分获得了特殊对待

#### 章节总结

通过实现特殊方法，你的对象可以表现的像内置类型一样，可以编写Python化的代码

一个python对象的基本需求就是提供可用的字符串表述，这也是为什么特殊方法`__repr__`和`__str__`存在于数据模型的原因

模拟序列，是特殊方法最广泛的使用之一

多亏了操作符重载，Python提供了丰富的数字类型选择，像`decimal.Decimal`和`fractions.Fraction`都支持中缀算术操作符

#### 进一步阅读

Python语言参考的数据模型章节

Python in a Nutshell

Python Cookbook

## 第二部分 数据结构

### 2. 一系列序列

#### 内置序列概述

标准库提供了丰富的由C实现的序列类型

- 容器序列

  `list`,`tuple`和`collections.deque`可以保存任意类型的项

- 平面序列

  `str`,`bytes`,`bytearray`,`memoryview`和`array.array`只能保存同一类型的项

另一种方式来分组序列类型：

- 可变序列

  `list`,`bytearray`,`arrary.array`,`collections.deque`和`memoryview`

- 不可变序列

  `tuple`,`str`和`bytes`

#### 列表解析和生成表达式

##### 列表解析和可读性

```python
>>> symbols = '$¢£¥€¤'
>>> codes = [ord(symbol) for symbol in symbols]
>>> codes
[36, 162, 163, 165, 8364, 164]
```

`for`循环可以做很多不同的事情，如扫描一个序列来计数或筛选项，计算集合数据，或任意其他处理任务

相反，列表解析只做一件事情：**构建一个新的列表**

##### 列表解析和`map`,`filter`的对比

```python
>>> symbols = '$¢£¥€¤'
>>> beyond_ascii = [ord(s) for s in symbols if ord(s) > 127]
>>> beyond_ascii
[162, 163, 165, 8364, 164]
>>> beyond_ascii = list(filter(lambda c: c > 127, map(ord, symbols)))
>>> beyond_ascii
[162, 163, 165, 8364, 164]
```

##### 笛卡尔产品

```python
>>> colors = ['black', 'white']
>>> sizes = ['S', 'M', 'L']
>>> tshirts = [(color, size) for color in colors for size in sizes]
>>> tshirts
[('black', 'S'), ('black', 'M'), ('black', 'L'), ('white', 'S'),
('white', 'M'), ('white', 'L')]
```

##### 生成表达式

为了初始化元组，数组，或其他类型的序列，你可以使用列表解析，但是一个生成表达式可以节约内存，因为**它使用迭代器协议产生一个一个的项而不是构造整个列表**

生成表达式使用和列表相同的语法，只是写在小括号里而不是中括号

```python
>>> symbols = '$¢£¥€¤'
>>> tuple(ord(symbol) for symbol in symbols)
(36, 162, 163, 165, 8364, 164)
>>> import array
>>> array.array('I', (ord(symbol) for symbol in symbols))
array('I', [36, 162, 163, 165, 8364, 164])
```

- 如果生成表达式是一个函数调用唯一的参数，小括号可以省略
- 如果一个函数调用有多个参数，生成表达式必须要使用小括号包裹

#### 元组不仅仅是不可变的列表

##### 元组作为记录

元组保存记录，每项都可以保存一个字段的记录和位置

```python
>>> lax_coordinates = (33.9425, -118.408056)
>>> city, year, pop, chg, area = ('Tokyo', 2003, 32450, 0.66, 8014)
>>> traveler_ids = [('USA', '31195855'), ('BRA', 'CE342567'),
... ('ESP', 'XDA205856')]
>>> for passport in sorted(traveler_ids):
... print('%s/%s' % passport)
...
BRA/CE342567
ESP/XDA205856
USA/31195855
>>> for country, _ in traveler_ids:
... print(country)
...
USA
BRA
ESP
```

如果对一个项不感兴趣，我们可以赋值`_`给它，代表一个假的变量

##### 元组解包

元组解包最常见的形式就是并行赋值，从一个可迭代的到一个元组的变量赋值

另外一种元组解包的例子就是当调用摔成而函数时，参数之前使用了`*`

```python
>>> divmod(20, 8)
(2, 4)
>>> t = (20, 8)
>>> divmod(*t)
(2, 4)
>>> quotient, remainder = divmod(*t)
>>> quotient, remainder
(2, 4)
```

```python
>>> a, b, *rest = range(5)
>>> a, b, rest
(0, 1, [2, 3, 4])
>>> a, b, *rest = range(3)
>>> a, b, rest
(0, 1, [2])
>>> a, b, *rest = range(2)
>>> a, b, rest
(0, 1, [])
```

##### 嵌套的元组解包

元组接收一个表达式解包可以使用嵌套的元组

Python会做正确的事，如果表达式匹配嵌套的结构

```python
metro_areas = [
    ('Tokyo', 'JP', 36.933, (35.689722, 139.691667)),  #
    ('Delhi NCR', 'IN', 21.935, (28.613889, 77.208889)),
    ('Mexico City', 'MX', 20.142, (19.433333, -99.133333)),
    ('New York-Newark', 'US', 20.104, (40.808611, -74.020386)),
    ('Sao Paulo', 'BR', 19.649, (-23.547778, -46.635833)),
]

print('{:15} | {:^9} | {:^9}'.format('', 'lat.', 'long.'))
fmt = '{:15} | {:9.4f} | {:9.4f}'
for name, cc, pop, (latitude, longitude) in metro_areas:  #
    if longitude <= 0:  #
        print(fmt.format(name, latitude, longitude))
```

##### 命名的元组

`collections.namedtuple`函数是一个工厂创建`tuple`的子类，使用字段名和一个类名进行了增强，可以帮助调试

```python
>>> from collections import namedtuple
>>> City = namedtuple('City', 'name country population coordinates')
>>> tokyo = City('Tokyo', 'JP', 36.933, (35.689722, 139.691667))
>>> tokyo
City(name='Tokyo', country='JP', population=36.933, coordinates=(35.689722,
139.691667))
>>> tokyo.population
36.933
>>> tokyo.coordinates
(35.689722, 139.691667)
>>> tokyo[1]
'JP
```

- 创建一个命名元组需要两个参数，一个类的名称，一个字段名称的列表
- 数据比如以位置参数传递给构造器
- 你可以通过名称或位置进行访问

一个命名元组除了从tuple继承的那些属性，还有一些额外的属性

`_fields`类属性

`_make(iterable)`类方法

`_asdict()`实例方法

```python
>>> City._fields
('name', 'country', 'population', 'coordinates')
>>> LatLong = namedtuple('LatLong', 'lat long')
>>> delhi_data = ('Delhi NCR', 'IN', 21.935, LatLong(28.613889, 77.208889))
>>> delhi = City._make(delhi_data)
>>> delhi._asdict()
OrderedDict([('name', 'Delhi NCR'), ('country', 'IN'), ('population',
21.935), ('coordinates', LatLong(lat=28.613889, long=77.208889))])
>>> for key, value in delhi._asdict().items():
print(key + ':', value)
```

1. `_fields`是一个类的字段名的元组
2. `_make(iterable)`允许你从一个可迭代对象实例化一个命名元组
3. `_asdict()`返回一个`collections.OrderedDict`实例

##### 元组作为不可变列表 

s.__add__(s2) ● ● s + s2—连接
s.__iadd__(s2) ● s += s2—就地连接
s.append(e) ● 在最后添加元素
s.clear() ● 删除所有元素
s.__contains__(e) ● ● e in s
s.copy() ● 列表浅复制
s.count(e) ● ● 计算一个元素出现的次数t
s.__delitem__(p) ● 根据位置p删除元素
s.extend(it) ● 从可迭代对象添加元素
s.__getitem__(p) ● ● s[p]—根据位置获取元素
s.__getnewargs__() ● Support for optimized serialization with pickle
s.index(e) ● ● 找到元素e第一次出现的位置
s.insert(p, e) ● 在位置p的元素之前插入e
s.__iter__() ● ●获取迭代器
s.__len__() ● ● 获取元素的个数
s.__mul__(n) ● ● s * n—重复的连接

s.__imul__(n) ● s *= n—就地重复连接
s.__rmul__(n) ● ● n * s—翻转的重复连接
s.pop([p]) ● 删除并返回条目
s.remove(e) ● 根据值删除第一个出现的e
s.reverse() ● 就地翻转列表的顺序
s.__reversed__() ● 获取迭代器从后到前扫描
s.__setitem__(p, e) ● s[p] = e—put e in position p, overwriting existing item
s.sort([key], [reverse]) ● Sort items in place with optional keyword arguments key and reverse

#### 切片

##### 为什么切片和范围排除最后一个项目

- 更容易看到切片或范围的长度，当只有一个终止位置给定。`range(3)`和`my_list[:3]`都会产生3个元素
- 更容易计算切片或范围的长度，当起始和终止位置给定了，只需要`stop-start`
- 更容易分割一个序列成2部分，只需要简单的获取`my_list[:x]`和`my_list[x:]`

```python
>>> l = [10, 20, 30, 40, 50, 60]
>>> l[:2] # split at 2
[10, 20]
>>> l[2:]
[30, 40, 50, 60]
>>> l[:3] # split at 3
[10, 20, 30]
>>> l[3:]
[40, 50, 60]
```

##### 切片对象

使用`s[start:stop:step]`切片对象

step可以是负的，以翻转的形式返回元素

```python
>>> s = 'bicycle'
>>> s[::3]
'bye'
>>> s[::-1]
'elcycib'
>>> s[::-2]
'eccb'
```

`start:stop:step`的符号只适用于`[]`，它会产生一个切片对象`sliece(start,stop,step)`,为了计算表达式`seq[start:stop:step]`，python调用了`seq.__getitem__(slice(start,stop,step))`方法

```python
invoice = """
    0.....6.................................40........52...55........
    1909  Pimoroni PiBrella                     $17.50    3    $52.50
    1489  6mm Tactile Switch x20                $4.95     2     $9.90
    1510  Panavise Jr. - PV-201                 $28.00    1    $28.00
    1601  PiTFT Mini Kit 320x240                $34.95    1    $34.95
"""
SKU = slice(0, 6)
DESCRPTION = slice(6, 40)
UNIT_PRICE = slice(40, 52)
QUANTITY = slice(52, 55)
ITEM_TOTAL = slice(55, None)
line_items = invoice.split('\n')[2:]
for item in line_items:
    print(item[UNIT_PRICE], item[DESCRPTION])
```

##### 多维切片和省略号

##### 给切片赋值

```python
>>> l = list(range(10))
>>> l
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
>>> l[2:5] = [20, 30]
>>> l
[0, 1, 20, 30, 5, 6, 7, 8, 9]
>>> del l[5:7]
>>> l
[0, 1, 20, 30, 5, 8, 9]
>>> l[3::2] = [11, 22]
>>> l
[0, 1, 20, 11, 5, 22, 9]
>>> l[2:5] = 100
Traceback (most recent call last):
File "<stdin>", line 1, in <module>
TypeError: can only assign an iterable
>>> l[2:5] = [100]
>>> l
[0, 1, 100, 22, 9]
```

**当赋值的目标是一个切片的时候，右侧必须是一个可迭代对象，即使它只有一个元素**

#### 序列使用`+`和`*`操作符

通常来说`+`的操作符必须是同样的序列类型

```python
>>> l = [1, 2, 3]
>>> l * 5
[1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3]
```

##### 构建列表的列表

```python
>>> board = [['_'] * 3 for i in range(3)]
>>> board
[['_', '_', '_'], ['_', '_', '_'], ['_', '_', '_']]
>>> board[1][2] = 'X'
>>> board
[['_', '_', '_'], ['_', '_', 'X'], ['_', '_', '_']]
```

#### 用序列增强赋值

特殊方法使+=工作的是`__iadd__`。如果`__iadd__`没有实现，Python会调用`__add__`方法

```python
>>> a += b
```

如果a实现了`__iadd__`，该方法将会被调用，在这种情况下，可变序列将会就地发生改变，如果没有实现该方法，表达式`a += b`等价于`a = a+b`，会产生一个新的对象，然后绑定到a上

##### A += 赋值 谜题

```python
>>> t = (1, 2, [30, 40])
>>> t[2] += [50, 60]
```

- 将可变元素放入元组不是一个好主意
- 增强赋值不是一个原子操作
- 检查Python字节码并不困难

#### `list.sort`和内置的`sorted`函数

`list.sort`方法就地排序列表，而不是进行复制，它返回`None`提醒我们，它改变的是目标对象，并不会创建一个新的列表

相反，内置的`sorted`函数会创建一个list，然后返回它

事实上，它接收任意可迭代的对象作为参数，包括不可变序列和生成表达式，不管可迭代对象的类型是说明，它总是返回一个新创建的list

```python
>>> fruits = ['grape', 'raspberry', 'apple', 'banana']
>>> sorted(fruits)
['apple', 'banana', 'grape', 'raspberry']
>>> fruits
['grape', 'raspberry', 'apple', 'banana']
>>> sorted(fruits, reverse=True)
['raspberry', 'grape', 'banana', 'apple']
>>> sorted(fruits, key=len)
['grape', 'apple', 'banana', 'raspberry']
>>> sorted(fruits, key=len, reverse=True)
['raspberry', 'banana', 'grape', 'apple']
>>> fruits
['grape', 'raspberry', 'apple', 'banana']
>>> fruits.sort()
>>> fruits
['apple', 'banana', 'grape', 'raspberry']
```

一旦你的序列是有序的，就可以有效地进行搜索，`bisect`模块提供了二分查找法

#### 使用`bisect`管理有序序列

`bisect`模块提供了两个主要的函数`bisect`和`insort`，使用二分查找法快速的找到和插入元素在任意有序的序列

##### 使用`bisect`搜索

```python
import bisect
import sys

HAYSTACK = [1, 4, 5, 6, 8, 12, 15, 20, 21, 23, 23, 26, 29, 30]
NEEDLES = [0, 1, 2, 5, 8, 10, 22, 23, 29, 30, 31]

ROW_FMT = '{0:2d} @ {1:2d} {2}{0:<2d}'


def demo(bisect_fn):
    for needle in reversed(NEEDLES):
        position = bisect_fn(HAYSTACK, needle)
        offset = position * '  |'
        print(ROW_FMT.format(needle, position, offset))


if __name__ == '__main__':
    if sys.argv[-1] == 'left':
        bisect_fn = bisect.bisect_left
    else:
        bisect_fn = bisect.bisect

    print('DEMO:', bisect_fn.__name__)
    print('haystack ->', ' '.join('%2d' % n for n in HAYSTACK))
    demo(bisect_fn)
```

##### 使用`bisect.insort`插入

```python
import bisect
import random

SIZE = 7

random.seed(1729)

my_list = []
for i in range(SIZE):
    new_item = random.randrange(SIZE * 2)
    bisect.insort(my_list, new_item)
    print('%2d ->' % new_item, my_list)
```

#### 什么时候列表不是答案

`list`是灵活的，易于使用的，但是取决于特殊的需求，有一些其他更好的选择

如果你需要存储百万浮点值，`array`会更有效

如果你经常从一个list的尾部添加和删除元素，`deque`工作的更快

##### 数组

如果列表只包含数字，`array.array`会比列表更有效。它支持所有可变序列的操作，和额外的方法用来快速加载和保存`.frombytes`和`.tofile`

```python
from array import array
from random import random

floats = array('d',(random() for i in range(10**7)))
print(floats[-1])

fp = open('floats.bin','wb')
floats.tofile(fp)
fp.close()

floats2 =array('d')
fp = open('floats.bin','rb')
floats2.fromfile(fp,10**7)
fp.close()
print(floats2[-1])
print(floats2 == floats)
```

array的方法

- `s.byteswap()` 交换数组中所有项目的字节
- `s.frombytes(b)`
- `s.fromfile(f,n)`
- `s.fromlist(l)`
- `s.tobytes()`
- `s.tofile(f)`
- `s.tolist()`
- `s.typecode`

##### 内存视图

内置的`memoryview`类是一个共享内存序列类型，可以让你切片数组也不用复制字节

```python
>>> numbers = array.array('h', [-2, -1, 0, 1, 2])
>>> memv = memoryview(numbers)
>>> len(memv)
5
>>> memv[0]
-2
>>> memv_oct = memv.cast('B')
>>> memv_oct.tolist()
[254, 255, 255, 255, 0, 0, 1, 0, 2, 0]
>>> memv_oct[5] = 4
>>> numbers
array('h', [-2, -1, 1024, 1, 2])
```

##### `NumPy`和`SciPy`

为了进行高级数组和矩阵操作，NumPy和SciPy是Python为什么会在科学计算应用变成主流的原因

NumPy实现了多维同质数组和矩阵类型可以保存不仅仅是数字，也可以保存用户定义的记录，提供了有效的元素操作

SciPy是在NumPy之上编写的库，提供了很多科学计算算法如线性代数，数值计算和统计

```python
>>> import numpy
>>> a = numpy.arange(12)
>>> a
array([ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11])
>>> type(a)
<class 'numpy.ndarray'>
>>> a.shape
(12,)
>>> a.shape = 3, 4
>>> a
array([[ 0, 1, 2, 3],
[ 4, 5, 6, 7],
[ 8, 9, 10, 11]])
>>> a[2]
array([ 8, 9, 10, 11])
>>> a[2, 1]
9
>>> a[:, 1]
array([1, 5, 9])
>>> a.transpose()
array([[ 0, 4, 8],
[ 1, 5, 9],
[ 2, 6, 10],
[ 3, 7, 11]])
```

NumPy也支持高水平的操作，如加载，保存，在所有元素上操作等等

```python
>>> import numpy
>>> floats = numpy.loadtxt('floats-10M-lines.txt')
>>> floats[-3:]
array([ 3016362.69195522, 535281.10514262, 4566560.44373946])
>>> floats *= .5
>>> floats[-3:]
array([ 1508181.34597761, 267640.55257131, 2283280.22186973])
>>> from time import perf_counter as pc
>>> t0 = pc(); floats /= 3; pc() - t0
0.03690556302899495
>>> numpy.save('floats-10M', floats)
>>> floats2 = numpy.load('floats-10M.npy', 'r+')
>>> floats2 *= 6
>>> floats2[-3:]
memmap([ 3016362.69195522, 535281.10514262, 4566560.44373946])
```

##### 双端队列和其他队列

`.append`和`.pop`方法可以让一个列表作为一个栈或队列使用

但是从一个列表的左端进行插入和删除操作是非常费时的，因为整个列表都必须要移动

`collections.deque`是一个线程安全的双端队列，设计为在两端进行快速的插入和删除

因为队列是有边界的，使用一个最大长度来创建队列，当它满的时候，当你在一端插入元素时，另一端的元素会被丢弃

```python
>>> from collections import deque
>>> dq = deque(range(10), maxlen=10)
>>> dq
deque([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], maxlen=10)
>>> dq.rotate(3)
>>> dq
deque([7, 8, 9, 0, 1, 2, 3, 4, 5, 6], maxlen=10)
>>> dq.rotate(-4)
>>> dq
deque([1, 2, 3, 4, 5, 6, 7, 8, 9, 0], maxlen=10)
>>> dq.appendleft(-1)
>>> dq
deque([-1, 1, 2, 3, 4, 5, 6, 7, 8, 9], maxlen=10)
>>> dq.extend([11, 22, 33])
>>> dq
deque([3, 4, 5, 6, 7, 8, 9, 11, 22, 33], maxlen=10)
>>> dq.extendleft([10, 20, 30, 40])
>>> dq
deque([40, 30, 20, 10, 3, 4, 5, 6, 7, 8], maxlen=10)
```

除了`deque`，其他python标准库包实现了队列：

- `queue`：

  提供了线程安全的类`Queue`和`LifoQueue`和`PriorityQueue`

- `multiprocessing`

- `asyncio`

- `heapq`

#### 章节总结

#### 进一步阅读

### 3. 字典和集合

`dict`类型不仅在我们的程序中广泛使用，同时也是Python实现的基础部分

模块命名空间，类，实例属性和函数关键字参数

内置函数在`__builtins__.__dict__`中

该章简要轮廓

- 常用的字典方法
- 特殊处理不存在的key
- 标准库中不同的dict
- set和frozenset类型
- 哈希表是如何工作的
- 哈希表的启示

#### 常用的映射类型

不同方式构造dict

```python
a = dict(one=1, two=2, three=3)
b = {'one': 1, 'two': 2, 'three': 3}
c = dict(zip(['one', 'two', 'three'], [1, 2, 3]))
d = dict([('one', 1), ('two', 2), ('three', 3)])
e = dict({'one': 1, 'two': 2, 'three': 3})
print(a == b == c == d == e)
print(a)
```

#### `dict`解析

一个字典解析构造一个字典实例通过从任意的迭代对象产生`key:value`对

```python
DIAL_CODES = [
    (86, 'China'),
    (91, 'India'),
    (1, 'United States'),
    (62, 'Indonesia'),
    (55, 'Brazil'),
    (92, 'Pakistan'),
    (880, 'Bangladesh'),
    (234, 'Nigeria'),
    (7, 'Russia'),
    (81, 'Japan'),
]
country_code = {country: code for code, country in DIAL_CODES}
print(country_code)
{'China': 86, 'Japan': 81, 'Nigeria': 234, 'Pakistan': 92, 'Russia': 7, 'Bangladesh': 880, 'United States': 1, 'Indonesia': 62, 'India': 91, 'Brazil': 55}

c = {code: country.upper() for country, code in country_code.items() if code < 66}
print(c)
{1: 'UNITED STATES', 55: 'BRAZIL', 62: 'INDONESIA', 7: 'RUSSIA'}
```

#### 常用映射方法概述

dict有两个常用的变量`defaultdict`和`OrderedDict`

常用的方法

- `d.clear()` 删除所有元素
- `d.copy()`浅复制
- `d.fromkeys(it, [initial])`
- `d.get(k, [default])`
- `d.items()`
- `d.keys()`
- `d.pop(k, [default])`
- `d.popitem()`
- `d.setdefault(k, [default])`
- `d.update(m, [**kargs])`
- `d.values()`

##### 使用`setdefault`处理不存在的key

快速失败机制下，使用`d[k]`访问`dict`会抛出异常，如果k是一个不存在的键

```python
"""
    Build an index mapping word -> list of occurences
"""
import sys
import re

WORD_RE = re.compile('\w+')

index = {}

with open(sys.argv[1], encoding='utf-8') as fp:
    for line_no, line in enumerate(fp, 1):
        for match in WORD_RE.finditer(line):
            word = match.group()
            column_no = match.start() + 1
            location = (line_no, column_no)
            # use dict setdefault function
            index.setdefault(word, []).append(location)
for word in sorted(index, key=str.upper):
    print(word, index[word])
```

#### 使用灵活的键查询映射

有两种方式

1. 使用`defaultdict`代替普通的`dict`
2. 继承`dict`获取其他映射类型，添加一个`__missing__`方法

##### `defaultdict`：另一种方式处理不存在的键

例如：`dd = defaultdict(list)`如果`new_key`不在`dd`,表达式`dd['new_key']`做以下步骤：

1. 调用`list()`创建一个新的列表
2. 使用`'new_key'`作为键插入`dd`
3. 返回一个引用到那个列表

##### `__missing__`方法

```python
class StrKeyDict0(dict):
    def __missing__(self, key):
        if isinstance(key, str):
            raise KeyError(key)
        return self[str[key]]

    def get(self, key, default=None):
        try:
            return self[key]
        except KeyError:
            return default

    def __contains__(self, key):
        return key in self.keys() or str(key) in self.keys()
```

#### 不同的 `dict`

`collections.OrderedDict`

`collections.ChainMap`

`collections.Counter`

`collections.UserDict`

#### `UserDict`子类

#### 不可变的映射

#### 集合理论



##### `set`文本

##### `set`解析

##### 集合操作

#### `dict`和`set`在引擎罩下

##### 性能测试

##### 字典中的哈希表

##### `dict`工作的实际工作

#### 章节总结

#### 进一步阅读

### 4. 文本VS字节

#### 字符问题

#### 字节基础

##### 结构和内存视图

#### 基本的编码和解码

#### 理解编码和解码问题

##### 

