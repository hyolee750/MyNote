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

`set`是唯一对象的集合

```python
>>> l = ['spam', 'spam', 'eggs', 'spam']
>>> set(l)
{'eggs', 'spam'}
>>> list(set(l))
['eggs', 'spam']
```

`set`的元素必须是可哈希的，`set`类型不是可哈希的，但是`frozenset`是可哈希的

除了保证唯一性，`set`类型实现了基本的set操作

##### `set`文本

##### `set`解析

```python
>>> from unicodedata import name
>>> {chr(i) for i in range(32, 256) if 'SIGN' in name(chr(i),'')}
{'§', '=', '¢', '#', '¤', '<', '¥', 'μ', '×', '$', '¶', '£', '©',
'°', '+', '÷', '±', '>', '¬', '®', '%'}
```

##### 集合操作

- s & z  	s和z的交集
- z & s        反转&操作符
- s &= z
- s|z
- s |=z
- s-z
- s-=z
- s^z
- s^=z
- e in s
- s<=z
- s<z
- s>=z
- s>z

s.add(e) ● Add element e to s
s.clear() ● Remove all elements of s
s.copy() ●●
s.discard(e) ●
Shallow copy of s
Remove element e from s if it is present
s.__iter__() ● ● Get iterator over s
s.__len__() ● ● len(s)
s.pop() ● Remove and return an element from s , raising KeyError if s is empty
s.remove(e) ● Remove element e from s , raising KeyError if e not in s

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

##### 复制UnicodeEncodeError

##### 复制UnicodeDecodeError

##### 加载模块时出现未期望的编码语法错误

##### 怎么发现字节序列的编码

##### BOM: A Useful Gremlin

#### 处理文本文件

##### 编码默认

## 第三部分 函数作为对象

### 5. 一等函数

#### 将函数作为对象看待

#### 高阶函数

##### 使用`map`，`filter`和`reduce`的替换

#### 匿名函数

#### 7种调用对象的方法

调用操作符，如`()`	

测试一个对象是否是可调用的，使用`callable()`内置函数

- 用户定义的函数

  由`def`语句或`lambda`表达式创建

- 内置函数

  以C实现的函数，如`len`或`time.strfttime`

- 内置方法

  以C实现的方法，如`dict.get`

- 方法

  在一个类内定义的函数

- 类

- 类实例

- 生成器函数

#### 用户自定义调用类型

不仅Python的函数是真的对象，而且任意的Python对象也可以行为像函数一样，实现了一个`__call__`实例方法即可

#### 函数内省

函数对象除了`__doc__`之外还由多个属性，使用`dir`函数

```python
>>> dir(factorial)
['__annotations__', '__call__', '__class__', '__closure__', '__code__',
'__defaults__', '__delattr__', '__dict__', '__dir__', '__doc__', '__eq__','__format__', '__ge__', '__get__', '__getattribute__', '__globals__',
'__gt__', '__hash__', '__init__', '__kwdefaults__', '__le__', '__lt__',
'__module__', '__name__', '__ne__', '__new__', '__qualname__', '__reduce__',
'__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__',
'__subclasshook__']
```

#### 从位置到关键字参数

使用`*`解析迭代对象，使用`**`解析映射类型到单个参数当我们调用一个函数

```python
def tag(name, *content, cls=None, **attrs):
    """Generate one or more HTML tags"""
    if cls is not None:
        attrs['class'] = cls
    if attrs:
        attr_str = ''.join(' %s="%s"' % (attr, value) for attr, value in sorted(attrs.items()))
    else:
        attr_str = ''
    if content:
        return '\n'.join('<%s%s>%s</%s>' % (name, attr_str, c, name) for c in content)
    else:
        return '<%s%s />' % (name, attr_str)
```

```python
>>> tag('br')
'<br />'
>>> tag('p', 'hello')
'<p>hello</p>'
>>> print(tag('p', 'hello', 'world'))
<p>hello</p>
<p>world</p>
>>> tag('p', 'hello', id=33)
'<p id="33">hello</p>'
>>> print(tag('p', 'hello', 'world', cls='sidebar'))
<p class="sidebar">hello</p>
<p class="sidebar">world</p>
>>> tag(content='testing', name="img")
'<img content="testing" />'
>>> my_tag = {'name': 'img', 'title': 'Sunset Boulevard',
...
'src': 'sunset.jpg', 'cls': 'framed'}
>>> tag(**my_tag)
'<img class="framed" src="sunset.jpg" title="Sunset Boulevard" />'
```

1. 单个位置参数产生一个带有名称的对象
2. 任何位于第一个参数之后的参数都会被`*content`捕获，作为一个元组
3. 关键字参数没有显示的命名，被`**attrs`捕获作为dict
4. `cls`参数只能被作为关键字参数传递
5. 甚至第一个位置参数都可以被作为一个关键字传递
6. 使用`**`作为my_tag dict前缀，所有它的元素都会分割成参数，然后绑定到命名参数
7. 关键字参数不需要默认值

#### 接收参数的信息

参数的类型

1. POSITIONAL_OR_KEYWORD

   参数可以被作为位置或关键字参数传递，大多数的Python函数参数都是这种类型的

2. VAR_POSITIONAL

   一个位置参数的元组

3. VAR_KEYWORD

   一个关键字参数的字典

4. KEYWORD_ONLY

   一个只能是关键字的参数

5. POSITIONAL_ONLY

   一个只能是位置的参数

#### 函数注解

Python3 提供了语法可以负载元数据到一个函数参数的声明和返回值

#### 函数式编程的包

##### 模块操作符

`operator`模块提供了很多算术操作符的等价函数

`attrgetter`从它的操作符返回一个可调用对象来抓取给定的属性

```python
f = attrgetter('name') # 调用f(r)返回r.name
```

`itemgetter`从它的操作符返回一个可调用对象来抓取给定的item

```python
f = itemgetter(2) # 调用f(r) 返回r[2]
```

`methodcaller`从它的操作符返回一个可调用对象调用给定的方法

```python
f = methodcaller('name'), #调用f(r) 返回r.name()
```

##### 使用`functools.partial`冰冻参数

`functools`模块带来了很多好用的高阶函数，最出名的可能就是`reduce`函数，另外一个最有用的函数是`partial`和它的变种`partialmethod`

`functools.partial`是一个高阶函数，允许一个函数的局部应用

给定一个函数，部分应用程序会产生一些新的可调用函数参数的原始功能固定。这对于适应所需的功能是有用的API的一个或多个参数，需要具有较少参数的回调

```python
>>> from operator import mul
>>> from functools import partial
>>> triple = partial(mul, 3)
>>> triple(7)
21
>>> list(map(triple, range(1, 10)))
[3, 6, 9, 12, 15, 18, 21, 24, 27]
```

`partial`采用一个函数作为第一个参数，后面跟着任意的位置数字或关键字参数来进行绑定

#### 章节总结

这一章的主要目标就是探索Python头等函数的特性

你可以赋值函数到一个变量，将他们作为其他函数的变量，将他们存储到数据结构，和访问函数的属性

Python的函数和他们的注解，有很多丰富的属性集可以使用`inspect`模块进行读取

最后，我们概述了一些来自`operator`模块和`functools.partial`的函数

可以按照需求最小化函数编程的能力

#### 进一步阅读

### 7. 函数装饰器和闭包

函数装饰器可以让我们在源代码上标记函数来以某种方式增强他们的行为

这一章的目标就是解释清楚函数装饰器是如何工作的

- Python是如何封装装饰器语法的
- Python是如何判断一个变量是本地的
- 为什么闭包会存在，它们是如何工作的
- `noncal`可以解决什么样的问题

#### 装饰器101

一个装饰器是一个可调用的函数，将另外一个函数作为参数

装饰器可以使用被装饰的函数执行一些处理。用另外一个函数或可调用对象返回它或替换它

装饰器的语法

```python
@decorate
def target():
	print('running target()')
```

总结一下：

1. 装饰器由能力使用另外一个不同的函数来替换被装饰的函数
2. 当一个模块被加载，装饰器函数会立即执行

#### 什么时候Python执行装饰器

装饰器一个关键的特征就是他们在装饰函数被定义之后立即运行

重点强调：只要模块被导入，函数装饰器就会立刻被执行，但是被装饰的函数只会在它们被显式调用的时候才会运行

#### 使用装饰器增强策略模式

#### 变量范围规则

#### 闭包

总结：闭包是一个函数，当函数定义时，保留自由变量的绑定，当函数被调用时，可以被使用，定义的作用域就不再可用

#### `nonlocal`声明

`nonlocal`声明，可以标记一个变量作为自由变量，当它在一个函数内赋值了新的值

如果一个新的值被赋予了`nonlocal`变量，存储在闭包中的绑定就会被改变

```python
def make_averager():
    count = 0
    total = 0

    def averager(new_value):
        nonlocal count, total
        count += 1
        total += new_value
        return total / count

    return averager
```

#### 实现一个简单的装饰器

```python
import time
import functools


def clock(func):
    @functools.wraps(func)
    def clocked(*args, **kwargs):
        t0 = time.time()
        result = func(*args, **kwargs)
        elapsed = time.time() - t0
        name = func.__name__
        arg_list = []
        if args:
            arg_list.append(', '.join(repr(arg) for arg in args))
        if kwargs:
            pairs = ['%s=%r' % (k, w) for k, w in sorted(kwargs.items())]
            arg_list.append(', '.join(pairs))
        arg_str = ', '.join(arg_list)
        print('[%0.8fs] %s(%s) -> %r ' % (elapsed, name, arg_str, result))
        return result

    return clocked
```

#### 标准库中的装饰器

Python有三个内置的函数被用来设计成装饰方法

`property`，`classmethod`，`staticmethod`

另外一个常用的装饰器就是`functools.wraps`

## 第四部分 面向对象

### 9. 一个Python化的对象

多亏了Python的数据模型，用户自定义的类型可以表现的像内置类型一样自然

如何实现在很多不同类型的Python对象中常见的特殊方法

将会学习到以下内容：

- 支持内置函数可以产生可选的对象表述，如`repr()`,`bytes()`等等
- 实现一个可选的构造器作为一个类的方法
- 使用内置函数`format()`和`str.format()`来扩展格式化
- 提供属性的只读访问
- 使对象可哈希的用于set和dict键
- 使用`__slots__`节约内存

讨论两个概念性的主题：

1. 怎么和什么时候使用`@classmethod`和`@staticmethod`装饰器
2. Python中的私有和受保护的属性的用法，约定和限制

#### 对象表述

Python有两种方式获取对象的字符串表述

- `repr()` 返回对象的一个字符串表述，开发者想要看到的
- `str()`返回对象的一个字符串表述，用户想要看到的

我们可以实现特殊方法`__repr__`和`__str__`来支持`repr()`和`str()`

还有两个额外的特殊方法支持可选的对象表述`__bytes__`和`__format__`

`__bytes__`类似`__str__`，由`bytes()`调用来获取对象的表述作为一个字节序列

对于`__format__`来说，内置的`format()`和`str.format()`方法都会调用它来获取对象使用特殊的格式化代码的字符串显示

#### Vector类的终极版

```python
from array import array
import math


class Vector2d:
    typecode = 'd'

    def __init__(self, x, y):
        self.x = float(x)
        self.y = float(y)

    def __iter__(self):
        return (i for i in (self.x, self.y))

    def __repr__(self):
        class_name = type(self).__name__
        return '{}({!r},{!r})'.format(class_name, *self)

    def __str__(self):
        return str(tuple(self))

    def __bytes__(self):
        return bytes([ord(self.typecode)] + bytes(array(self.typecode, self)))

    def __eq__(self, other):
        return tuple(self) == tuple(other)

    def __abs__(self):
        return math.hypot(self.x, self.y)

    def __bool__(self):
        return bool(abs(self))
```

#### 	一个可选的构造器

因为我们可以导出一个Vector2d作为字节，自然的，我们需要一个方法从一个二进制序列导入Vector2d

可以使用`array.array`的类方法`.frombytes`完成该目的

```python
@classmethod
def frombytes(cls, octes):
    typecode = chr(octes[0])
    memv = memoryview(octes[1:]).cast(typecode)
    return cls(*memv)
```

1. 类方法通过`classmethod`装饰器被修改了
2. 没有`self`参数，相反，类本身被作为cls参数传递
3. 从第一个字节读取typecode
4. 从二进制序列创建了一个`memoryview`，并使用typecode进行转换
5. 解包`memoryview`的结果到构造器的参数对

#### classmethod和staticmethod

`classmethod`定义了在类上而不是在类的实例上操作的方法

`classmethod`改变了方法被调用的方式，所以它接收类本身作为第一个参数，而不是一个类的实例

它最常见的用法就是构造可选的构造函数

相反，`staticmethod`装饰器改变一个方法，以便它接收非特殊的第一个参数。本质上，一个静态方法就像一个普通的函数，碰巧写在class体内，而不是被定义在模块级别

```python
class Demo:
	@classmethod
	def klassmeth(*args):
		return args #
	@staticmethod
	def statmeth(*args):
		return args #
>>> Demo.klassmeth() #
(<class '__main__.Demo'>,)
>>> Demo.klassmeth('spam')
(<class '__main__.Demo'>, 'spam')
>>> Demo.statmeth()
()
>>> Demo.statmeth('spam')
('spam',)
```

#### 格式化的显示

`format()`内置函数和`str.format()`方法会委托每个类型的实际格式化方法通过调用他们的`__format__(format_spec)`方法

```python
>>> brl = 1/2.43 # BRL to USD currency conversion rate
>>> brl
0.4115226337448559
>>> format(brl, '0.4f') #
'0.4115'
>>> '1 BRL = {rate:0.2f} USD'.format(rate=brl)
'1 BRL = 0.41 USD'
```

```python
>>> from datetime import datetime
>>> now = datetime.now()
>>> format(now, '%H:%M:%S')
'18:49:05'
>>> "It's now {:%I:%M %p}".format(now)
"It's now 06:49 PM"
```

#### 一个可哈希的Vector2d

到目前为止，我们的Vector2d是不可哈希的，所以我们不能把他们放到集合中

为了使Vector2d可哈希的，我们必须实现`__hash__`方法，同时，`__eq__`也是必须的，同时，我们也可以使Vector2d的实例是不可变的

我们可以标记x和y组件为只读的属性

```python
def __init__(self, x, y):
    self.__x = float(x)
    self.__y = float(y)

    @property
    def x(self):
        return self.__x

    @property
    def y(self):
        return self.__y
```

1. 使用两个下划线来使一个属性为私有的
2. `@property`装饰器标记了一个属性的get方法

现在我们的Vector2d是不可变的了，我们可以实现`__hash__`方法

```python
def __hash__(self):
    return hash(self.x) ^ hash(self.y)
```

#### 私有的和受保护的属性

如果你命令一个实例的属性以两个下划线开头，Python会在实例的`__dict__`中使用类的前缀来保存名称

```python
>>> v1 = Vector2d(3, 4)
>>> v1.__dict__
{'_Vector2d__y': 4.0, '_Vector2d__x': 3.0}
>>> v1._Vector2d__x
3.0
```

单下划线对Python解释器来说没有任何意义，但是它是在Python程序员中强烈的约束，你不应该从一个类的外部来访问这样的属性

属性由一个下划线开头的，叫做受保护的

#### 使用`__slots__`属性节约内存

默认情况下，Python存储实例属性在每个实例的dict中

使用`__slots__`属性，可以让解释器存储实例的属性在一个元组也不是字典

为了定义`__slot__`，你使用该名称创建了一个类属性，然后把它赋值给一个可迭代对象str，使用实例属性的身份

```python
__slots__ = ('__x', '__y')
```

通过在类中定义`__slots__`，你告诉解释器，所有的实例属性都在这个类中，Python会存储他们在每一个实例的一个类似元组的结构中，避免了每个实例`__dict__`的内存负载

##### 使用`__slots__`的问题

总结以下：`__slots__`可能提供非常大的内存节省如果适当的使用，但是还有一些问题：

- 你必须记得在每一个子类重新声明`__slots__`，因为继承的属性会被解释器忽略
- 实例只能够有列在`__slots__`里面的属性，除非你包括`__dict__`到`__slots__`里
- 实例不能是弱引用的目标，除非你记得把`__weakref__`包括到`__slots__`里

##### 覆盖类的属性

类属性可以被用来作为实例属性的默认值

如果你想要改变一个类属性，你必须在类上直接设置，而不能通过实例

类属性是公共的，他们可以被子类继承。所以可以使用子类的形式去覆盖类的属性

#### 章节总结

这一章主要演示了特殊方法的用法，和构造一个良好的Python化的类的约束

**简单比复杂要好**

## 第五部分 控制流

### 15. 上下文管理器和else代码块

在这一章，我们将会讨论控制流在其他语言不太常用的特性

- `with`语句和上下文管理器
- 在`for`.`while`,`try`语句中的`else`代码块


#### 做这个然后再做那个：除了if之外的else代码块

规则

- `for`：`else`只会在for循环运行完毕后才会运行，不包括使用`break`终止循环
- `while`:`else`代码块只会在while循环退出后才会运行，不包括使用`break`终止循环
- `try`：`else`代码块只会在try代码块没有异常产生的时候运行

和这些语句一起使用else，会使代码更容易阅读，解决了控制流标记或增加额外if语句的麻烦

```python
for item in my_list:
    if item.flavor == 'banana':
        break
else:
    raise ValueError('No banana flavor found!')
```

#### 上下文管理器和代码块

上下文管理器存在用来控制一个`with`语句

`with`语句设计用来简化`try/finally`模式，保证了一些操作会在代码块之后执行，即使代码块因为异常被终止执行了

上下文管理器协议包含了`__enter__`和`__exit__`方法

在with的开始，上下文管理器调用`__enter__`方法

在with的结束，上下文管理器调用`__exit__`方法

最常见的例子就是确保一个文件对象被关闭

```python
>>> with open('mirror.py') as fp: #
...
src = fp.read(60) #
...
>>> len(src)
60
>>> fp #
<_io.TextIOWrapper name='mirror.py' mode='r' encoding='UTF-8'>
>>> fp.closed, fp.encoding #
(True, 'UTF-8')
>>> fp.read(60) #
Traceback (most recent call last):
File "<stdin>", line 1, in <module>
ValueError: I/O operation on closed file.
```

解决pip无法安装的问题

`python-pip` is in the universe repositories, therefore use the steps below:

```shell
sudo apt-get install software-properties-common
sudo apt-add-repository universe
sudo apt-get update
sudo apt-get install python-pip
```


