# Redis学习笔记

## 入门

### 1.1 热身

1. 获取符合规则的键名列表

   ```
   KEYS pattern	
   ```

2. 判断一个键是否存在

   ```
   EXISTS key
   ```

3. 删除键

   ```
   DEL key [key ...]
   ```

4. 获取键值的数据类型

   ```
   TYPE key
   ```

### 1.2 字符串类型

#### 1.2.1 介绍

字符串类型是Redis中最基本的数据类型，它能存储任何形式的字符串，包括二进制数据，一个字符串类型键允许存储的数据的最大容量为512MB

#### 1.2.2 命令

1. 赋值与取值

   ```
   SET key value
   GET key
   ```

2. 递增数字

   ```
   INCR key
   ```

   当存储的字符串是整数形式时，Redis提供了一个实用的命令INCR，其作用是让当前的键值递增，并返回递增后的值

   当要操作的键不存在时会默认键值为0，当键值不是整数时，Redis会提示错误

#### 1.2.3 实践

1. 文档访问量统计

   博客的一个常见的功能是统计文章的访问量，我们可以为每篇文章使用一个名为post:文章ID:page.view的键来记录文章的访问量，每次访问文章的时候使用INCR命令使响应的键值递增

2. 生成自动ID

   对于每一类对象使用为对象类型(复数形式):count的键(如：users:count)来存储当前类型对象的数量，每增加一个对象时都使用INCR命令递增该键的值，由于使用INCR命令建立的键的初始值是1，所以很容易得知，INCR命令的返回值即是加入该对象后的当前类型的对象总数，又是该新增对象的ID

3. 存储文章数据

   由于每个字符串类型的键只能存储一个字符串，而一篇博客文章是由标题，正文，作者与发布时间等多个元素构成，为了存储这些元素，我们可以使用序列化函数，将它们转换成一个字符串，除此之外因为字符串类型键可以存储二进制数据，也可以序列化成二进制数据

#### 1.2.4 命令拾遗

1. 增加指定的整数

   ```
   INCRBY key increment
   ```

2. 减少指定的整数

   ```
   DECR key
   DECRBY key decrement
   ```

3. 增加指定浮点数

   ```
   INCRBYFLOAT key increment
   ```

4. 向尾部追加值

   ```
   APPEND key value
   ```

   APPEND作用是向键值的末尾追加value，如果键不存在则将该键的值设置为value，返回值是追加后字符串的总长度

5. 获取字符串的长度

   ```
   STRLEN key
   ```

   STRLEN命令是返回键值的长度，如果键不存在，则返回0

6. 同时获取/设置多个键值

   ```
   MGET key [key ...]
   MSET key value [key value ...]
   ```

7. 位操作

   ```
   GETBIT key offset
   SETBIT key offset value
   BITCOUNT key [start] [end]
   BITOP operation destkey key [key ...]
   ```

### 1.3 散列类型

#### 1.3.1 介绍

散列类型hash的键值也是一种字典结构，其存储了字段和字段值的映射，但字段值只能是字符串，不支持其他数据，换句话说，散列类型不能嵌套其他的数据类型

散列类型适合存储对象，使用对象类型和ID构成键名，使用字段表示对象的属性，而字段值者存储属性值

#### 1.3.2 命令

1. 赋值与取值

   ```
   HSET key field value
   HGET key field
   HMSET key field value [field value ...]
   HMGET key field [field ...]
   HGETALL key
   ```

   HSET命令用来给字段赋值，而HGET命令用来获取字段的值

   HSET命令的方便之处在于不区分插入和更新操作，当执行的是插入操作时，即之前的字段不存在，HSET命令会返回1，当执行的是更新操作时，HSET命令会返回0，当键本身不存在时，HSET命令还会自动建立它

2. 判断字段是否存在

   ```
   HEXISTS key field
   ```

   如果存在，返回1，否则返回0

3. 当字段不存在时赋值

   ```
   HSETNX key field value
   ```

   HSETNX命令与HSET命令类似，区别在于如果字段已经存在HSETNX命令将不执行任何操作

4. 增加数字

   ```
   HINCRBY key field increment
   ```

5. 删除字段

   ```
   HDEL key field [field ...]
   ```

#### 1.3.3 实践

1. 存储文章数据

   使用散列类型存储文章数据，更加直观也更加容易维护，另外存储同样的数据散列类型往往比字符串类型更加节约空间

2. 存储文章缩略名

   我们可以使用一个散列类型的键slug.to.id来存储文章缩略名和ID之间的映射关系，其中字段用来记录缩略名，字段值用来记录缩略名对应的ID

   可以使用HEXISTS命令来判断缩略名是否存在，使用HGET命令来获取缩略名对应的文章ID了

   当用户访问文章时，我们从网址中得到文章的缩略名，并查询slug.to.id键来获得文章ID

#### 1.3.4 命令拾遗

1. 只获取字段名或字段值

   ```
   HKEYS key
   HVALS key
   ```

2. 获取字段数量

   ```
   HLEN Key
   ```

### 1.4 列表类型

#### 1.4.1 介绍

列表类型list 可以存储一个有序的字符串列表，常见的操作是向列表两端添加元素，或者获得列表的某一个片段

列表类型内部使用双端链表实现的，所以向列表两端添加元素的时间复杂度为O(1)

列表类型能快速完成关系数据库难以应付的场景：如社交网站的新鲜事

列表类型也适合用来记录日志，可以保证加入新日志的速度不会受到已有日志数量的影响

借助列表类型，Redis还可以作为队列使用

#### 1.4.2 命令

1. 向列表两端增加元素

   ```
   LPUSH key value [value ...]
   RPUSH key value [value ...]
   ```

2. 从列表两端弹出元素

   ```
   LPOP key
   RPOP key
   ```

3. 获取列表中元素的个数

   ```
   LLEN key
   ```

   当键不存在时，LLEN会返回0

4. 获取列表片段

   ```
   LRANGE key start stop
   ```

   LRANGE 命令将返回索引从start 到 stop之间的所有元素，包含两端的元素，redis的列表索引从0开始

   LRANGE key 0 -1 可以获取列表中所有的元素。另外一些特殊情况如下：

   1. 如果start的索引位置比stop的索引位置靠后，这回返回空列表
   2. 如果stop大于实际的索引范围，则会返回到列表最右边的元素

5. 删除列表中指定的值

   ```
   LREM key count value
   ```

   该命令会删除列表中前count个值为value的元素，返回值是实际删除的元素的个数，根据count值的不同，LREM命令的执行方式会略有差异

   - 当count>0时，LREM命令会从列表左边开始删除前count个值为value的元素
   - 当count<0时，LREM命令会从列表右边开始删除前count个值为value的元素
   - 当count=0时，LREM命令会删除所有值为value的元素

#### 1.4.3 实践

1. 存储文章ID列表

   使用列表类型键posts:list记录文章ID列表，当发布新文章时使用LPUSH命令把新文章的ID加入到这个列表中，另外删除文章也要记得把列表中的文章ID删除 `LREM posts:list 1 要删除的文章ID` 

   有了文章ID列表，就可以使用LRANGE命令实现文章的分页显示

   使用列表类型键存储文章的ID列表有以下两个问题：

   - 文章的发布时间不易修改
   - 当文章数量较多时，访问中间的页面性能较差

2. 存储评论列表

   可以将一条评论的各个元素序列化成字符串后作为列表类型键中的元素来存储

   可以使用列表类型键posts:文章ID:comments来存储某个文章的所有评论

#### 1.4.5 命令拾遗

1. 获得/设置指定索引的元素值

   ```
   LINDEX key index
   LSET key index value
   ```

2. 只保留列表指定片段

   ```
   LTRIM key start end
   ```

3. 向列表中插入元素

   ```
   LINSERT key BEFORE|AFTER provt value
   ```

4. 将元素从一个列表转到另一个列表

   ```
   RPOPLPUSH source destination
   ```

### 1.5 集合类型

#### 1.5.1 介绍

在集合中每个元素都是不同的，且没有顺序

多个集合类型的键之间可以进行并集，交集和差集的运算

#### 1.5.2 命令

1. 增加/删除元素

   ```
   SADD key member [member ...]
   SREM key member [member ...]
   ```

2. 获得集合中的所有元素

   ```
   SMEMBERS key
   ```

3. 判断元素是否在集合中

   ```
   SISMEMBER key member
   ```

4. 集合间运算

   ```
   SDIFF key [key ...]
   SINTER key [key ...]
   SUNION key [key ...]
   ```

#### 1.5.3 实践

1. 存储文章标签

   考虑到一个文章的所有标签都是不同的，而且展示时对这些标签的排列顺序并没有要求，我们可以使用集合类型的键来存储文章的标签

   对每篇文章使用键名为`post:文章ID:tags` 的键存储该篇文章的标签

2. 通过标签搜索文章

   列出某个标签下的所有文章，甚至需要获得同时属于某几个标签的文章列表

   具体做法是为每个标签使用一个名为`tags:标签名称:posts` 的集合类型键存储标有该标签的文章ID列表

   当需要获取标记mysql标签的文章时，只需要使用命令SMEMBERS tag:mysql:posts即可

   当需要实现找到同时属于java，mysql，redis这三个标签的文章，只需要使用SINTER 命令取每个键的集合的交集

#### 1.5.4 命令拾遗

1. 获得集合中元素的个数

   ```
   SCARD key
   ```

2. 进行集合运算并将结果存储

   ```
   SDIFFSTORE destination key [key ...]
   SINTERSTORE destination key [key ...]
   SUNIONSTORE destination key [key ...]
   ```

3. 随机获得集合中的元素

   ```
   SRANDOMEMBER key [count]
   ```

4. 从集合中弹出一个元素

   ```
   SPOP key
   ```

### 1.6 有序集合类型

#### 1.6.1 介绍

有序集合类型和列表类型的相似和不同之处：

相似点：

- 二者都是有序的
- 二者都可以获得某一范围的元素

不同点：

- 列表类型是通过链表实现的，获得靠近两端的数据速度较快，而当元素增多后，访问中间数据的速度会较慢，更适合新鲜事或日志这样的应用
- 有序集合类型是使用散列表和跳跃表实现的，所以即使读取位于中间部分的数据速度也很块
- 列表中不能简单的调整某个元素的位置，但是有序集合可以
- 有序集合要比列表类型跟耗费内存

#### 1.6.2 命令

1. 增加元素

   ```
   ZADD key score member [score member ...]
   ```

   如果该元素已经存在，则会用新的分数替换原有的分数，返回值是新加入到集合中的元素个数

2. 获取元素的分数

   ```
   ZSCORE key member
   ```

3. 获取排名在某个范围的元素列表

   ```
   ZRANGE key start stop [WITHSCORES]
   ZREVRANGE key start stop [WITHSCORES]
   ```

4. 获取指定分数范围的元素

   ```
   ZRANGEBYSCORE key min max [WITHSCORES]
   ```

   如果希望分数范围不包含端点值，可以在分数前加上"("符号

5. 增加某个元素的分数

   ```
   ZINCRBY key increment member
   ```

#### 1.6.3 实践

1. 实现按点击量排序

   要按照文章的点击量排序，就必须再额外使用一个有序集合类型的键来实现，在这个键中以文章的ID作为元素，以该文章的点击量作为该元素的分数，将该键命名为`posts:page.view` 每次用户访问一篇文章时，博客程序就通过`ZINCRBY posts:page.view 1 文章ID` 更新访问量

   ```
   $postsPerPage = 10
   $start = ($currentPage -1) * $postsPerPage
   $end = $currentPage * $postsPerPage -1
   $postID = ZREVRANGE posts:page.view,$start,$end
   for each $id in $postID
   	$postData = HGETALL post:$id
   	print 文章标题:$postData.title
   ```

2. 改进按时间排序

   为了能够自由滴更改文章发布时间，可以使用有序集合类型代替列表类型，

   元素仍然是文章的ID，元素的分数是文章发布的UNIX时间，通过修改元素对应的分数就可以达到更改时间的目的

   另外借助ZREVRANGEBYSCORE 命令还可以轻松获得指定时间范围的文章列表

#### 1.6.4 命令拾遗

1. 获取集合中元素的数量

   ```
   ZCARD key
   ```

2. 获取指定分数范围内的元素个数

   ```
   ZCOUNT key min max
   ```

3. 删除一个或多个元素

   ```
   ZREM key member [member ...]
   ```

4. 按照排名范围删除元素

   ```
   ZREMRANGEBYRANK key start stop
   ```

5. 按照分数范围删除元素

   ```
   ZREMRANGEBYSCORE key min max
   ```

6. 获取元素的排名

   ```
   ZRANK key member
   ZREVRANK key member
   ```

7. 计算有序集合的交集

   ```
   ZINTERSTORE destination numkeys key [key ...] []
   ```

## 第2章 进阶

### 2.1 事务

#### 2.1.1 概述

事务，不多解释了，关系型数据库听的太多了，最小的执行单位，一个事务中的命令要么都执行，要么都不执行

redis开启事务的方式

首先使用MULTI命令开启事务

执行redis的其他命令

最后使用EXEC 执行等待执行的事务队列中的所有命令按照发送顺序依次执行

#### 2.1.2 错误处理

1. 语法错误，只要有一个错误，其他命令都不会执行
2. 运行错误，错误的命令不会执行，但是其他命令会继续执行

### 2.2 生存时间

#### 2.2.1 命令介绍

使用EXPIRE命令设置一个键的生存时间，到时间后Redis会自动删除它

```
EXPIRE key seconds
```

使用TTL命令，查看一个键还有多久的时间会删除，返回值是剩余时间

没有为键设置生存时间的 同样会返回-1

使用PERSIST 命令取消键的生存时间设置

使用SET或GETSET命令为键赋值也会同时清除键的生存时间

