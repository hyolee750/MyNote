这里打算稍微记录一下学习Python Cookbook中遇到的库和API，提升自己的Python知识。

学习不是一蹴而就的事情，不能急躁，需要静下心来，一点一点的进行学习和理解，写在书上是没有用的。要在脑子中记住，要多编码练习肌肉习惯，做笔记也不是为了以后可以让自己复习，只是让自己在学习过程中集中精力的一种方式。

加油！

我学Python的话，目前来说是以web开发为主，后期可能会朝着机器学习和人工智能方向去发展，而同时由于我自己的主要开发语言还是java，所以java深层次的东西还是要继续学习。

在以后的日子里，我就花大量的时间进行知识的学习，为了将来做准备

首先学习的是`collections`模块中的常用API

### `collections`

这个模块实现了特殊的容器数据类型

- `namedtuple`： 工厂函数使用命名字段创建元组的子类
- `deque`： 类似列表的容器提供了在两端进行快速的添加和删除操作
- `ChainMap`： 类似字典的容器用来创建多个映射的单个视图
- `Counter`： 字典的子类用来计算哈希对象的个数
- `OrderedDict`：字典的子类用来记住实体被添加的顺序
- `defaultdict`： 字典的子类调用工厂函数来提供不存在的值
- `UserDict`： 字典对象的包装对象更容易继承
- `UserList`： 列表对象的包装对象更容易继承
- `UserString`： 字符串对象的包装对象更容易继承

#### `OrderedDict`

记住插入顺序的字典

`__init__`方法：

初始化一个有序的字典，这个签名和普通字典的签名一样，但是不推荐使用关键字参数，因为关键字参数的插入顺序是任意的。这个方法只能接收最多一个参数。

`__setitem__(self,key,value)`方法：

等价于`od[key] = value `，设置一个新的项会在链表的尾部创建一个新的节点，然后使用新的键值对更新继承的字典。

`__delitem__`方法：

等价于`del od[key]`，删除一个存在的项

`__iter__`方法：

等价于`iter(od)`，按顺序遍历双端链表

`__reversed__`方法：

`等价于reversed(od)`反转一个字典

常用方法

`clear()`:从字典中删除所有的项

`popitem(last=True)`：如果为True，以先进后出的顺序返回和删除键值对，否则以先进先出的方式返回和删除键值对

`keys()`返回字典中所有的键

`items()`： 返回字典中所有的项

`values()` 返回字典中所有的值

`pop(self,key,default=_maker)`： 删除具体的键并返回相应的值，如果键没找到，返回给定的默认值，否则会抛出一个`KeyError`异常

`copy()`：一个顺序字典的浅复制

`fromkeys(cls,iterable,value=None)`： 使用来自s的键创建一个新的顺序字典，如果没有定义，默认值为None

```python
from collections import OrderedDict

odd = OrderedDict()
odd['name'] = 'zhangsan'
odd['age'] = 28
odd['score'] = 91.1
odd['loves'] = ['zhangsan','lisi']
print(odd)
for key in odd:
    print(key,odd[key])
```

输出结果

```python
OrderedDict([('name', 'zhangsan'), ('age', 28), ('score', 91.1), ('loves', ['zhangsan', 'lisi'])])
name zhangsan
age 28
score 91.1
loves ['zhangsan', 'lisi']
```

