2016年11月28日 星期一

今天一天基本上没有做什么工作上的事情，学习了一天的时间，学习了Java8两个重要的类Stream和Collectors的用法以及函数式接口的使用

明天开始做一些工作上的事情，开始做push模块，睡觉之前可以先想一想，看如何实现好

那么今天晚上呢，我还是继续学习java8吧

知识点：
	
	1. 一个lambda表达式是一个带参数的代码块
	2. 当你想要代码块在以后某个时间点执行，可以使用lambda表达式
	3. lambda表达式可以被转换为函数式接口
	4. lambda表达式可以在闭包作用域中有效的访问final变量
	5. 方法和构造器引用可以引用方法或构造器，但无须调用他们
	6. 你现在可以向接口添加默认和静态方法来提供具体的实现
	7. 你必须解决接口中的多个默认方法的冲突
	
lambda表达式的格式：参数、箭头 -> 以及一个表达式

如果lambda表达式没有参数，提供一对小括号

如果一个lambda表达式的参数类型是可以被推导的，那么就可以省略他们的类型

如果某个方法只有一个参数，并且该参数的类型可以被推导，那么可以省略小括号

永远不要为一个lambda表达式执行返回类型，它总是会从上下文中被推导出来

对于只包含一个抽象方法的接口，你可以通过lambda表达式来创建该接口的对象，这种接口被称为函数式接口

当一个lambda表达式被转换为一个函数式接口的实例时，请注意处理检查期异常

#### 方法引用

:: 操作符将方法名和对象或类的名字分隔开来，以下是三种主要的使用情况
	
	1. 对象::实例方法
	2. 类::静态方法
	3. 类::实例方法
	4. super::实例方法
	5. this::实例方法

#### 构造器引用

构造器引用中方法名是new

对于拥有多个构造器的类，选择使用哪个构造器取决于上下文

可以使用数组类型来编写构造器引用

#### 变量作用域

lambda表达式可以捕获闭合作用域中的变量值，被引用的变量的值不可以更改

在lambda表达式中不允许声明一个与局部变量同名的参数或者局部变量

如果一个接口中定义了一个默认方法，而另外一个父类或接口中又定义了一个同名的方法，该选择哪个呢？

默认方法的选择机制：
	
	1. 选择父类中的方法，如果一个父类提供了具体的实现方法，那么接口中具有相同名称和参数的默认方法会被忽略
	2. 接口冲突，如果一个父接口提供了一个默认方法，而另外一个接口也提供了一个具有相同名称和参数类型的方法，那么你必须通过覆盖该方法来解决冲突


### Stream API

要点：
	
	1. 迭代器意味着特定的遍历策略，禁止了高效的并发执行
	2. 可以从集合，数组，生成器或者迭代器中创建Stream
	3. 使用过滤器filter来选择元素，使用map来改变元素
	4. 要从stream中获得结果，请使用reduction操作，比如min，max等等
	5. Optional类型的目的是为了安全的替代使用null值，要想安全的使用它，借助ifPersent和orElse方法
	6. 可以收集集合，数组，字符串或map中的Stream结果
	






2016年11月16日 星期三

今天开始重新学习Java的API，看有哪些是自己没有用到过的，主要目的有两个，

    一，掌握API的使用，了解用法和实现原理，
    二，学习其中的设计思想和编码思想，提高自己的编码能力和重构能力。

`java.util.Objects` 常量类

常量类的设计

  1. 使用final关键字修饰类，这里要知道final的作用
  2. 构造方法私有化
  3. 只包含静态的方法

这里需要掌握两个知识点`final`和`static`关键字的用法

  1. `final`关键字

    可以用来声明成员变量，方法，类以及本地变量，final变量是只读的，final的方法不可以被子类的方法重写，final的类不能被继承

    final关键字的好处：

    final关键字提高了性能，JVM和Java应用都会缓存final变量

    final变量可以安全的在多线程环境下进行共享，而不需要额外的同步开销

    使用final关键字，JVM会对方法，变量及类进行优化

    final重要的知识点：

    1. final关键字可以用于成员变量，本地变量，方法以及类
    2. final成员变量必须在声明的时候初始化或者在构造器中初始化，否则会报编译错误
    3. 不能对final变量再次赋值
    4. 在匿名类中所有变量都必须是final变量。
    5. final方法不能被重写。
    6. final类不能被继承。
    7. final关键字不同于finally关键字，后者用于异常处理。
    8. 接口中声明的所有变量本身是final的。
    9. final和abstract这两个关键字是反相关的，final类就不可能是abstract的。
    10. final方法在编译阶段绑定，称为静态绑定(static binding)。

  2. `static`关键字

    被`static`修饰的方法或变量不需要依赖对象来进行访问，只要类被加载了，就可以通过类名进行访问

    在静态方法中不能访问类的非静态成员变量和非静态成员方法，因为非静态成员方法/变量必须依赖具体的对象才能够调用

    即使没有显示的声明为static，类的构造器实际上也是静态方法

    静态变量被所有对象共享，在内存中只有一个副本，它当且仅当在类初次被加载时会被初始化

    static是不允许用来修饰局部变量的

    以后会继续了解类的初始化过程的

```
public final class Objects{
    private Objects(){}
    public static boolean equals(Object a,Object b){
      return (a == b) || (a != null && a.equals(b));
    }

    public static int hashCode(Object o){
      return  o != null ? o.hashCode() : 0;
    }

    public static String toString(Object o){
      return String.valueOf(o);
    }

    public static <T> int compare(T a,T b,Comparator<? super T> c){
      return (a == b) ? 0 : c.compare(a,b);
    }

    public static <T> T requireNonNull(T obj,String message){
      if(obj == null)
        throw new NullPointerException(message);
      return obj;
    }
}
```

从比较新的API开始学起，毕竟新的技术要更高超

Java NIO2的切入点 `java.nio.file.Path`，该类是NIO2的里程碑，每个应用涉及I/O操作都会开采该类强大的能力
实际上，它是NIO2最常用的类，因为很多I/O操作都是基于`Path`资源的

`Path`类支持两种类型的操作 句法操作和基于文件的操作

`java.nio.file.FileSystems` 用来获取我们想要工作在`java.nio.file.FileSystem`上的实例

`java.nio.file.Paths`的API学习

常量类的设计已经没问题了，下面开始继续进行下一步的学习

这里就要强调代码的结构的优美性和鲁棒性

重点掌握NIO2的以下几个类

`java.nio.file.Paths` 工具类，主要目的是获取`java.nio.file.Path`类
`java.nio.file.Path` 最核心的类，包含各种操作路径的方法
`java.nio.file.FileSystems` 获取默认的文件系统
`java.nio.file.Files` 操作文件的工具类

多使用静态内部类

`java.nio.file.Path` 继承了`Comparable`，`iterable`，`Watchable`，所以Path对象是可比较的，可迭代的，可观察的

让我们来看一下Path接口都提供了哪些方法

    1. `FileSystem getFileSystem();` 获取创建该Path对象的文件系统
    2. `boolean isAbsolute();` 判断该Path对象是否是绝对的
    3. `Path getRoot();` 获取根路径，如果没有，返回Null
    4. `Path getFileName();` 获取该Path对象的文件名称，文件是距离最远的元素
    5. `Path getParent();` 获取父目录，不存在，则返回null
    6. `int getNameCount();` 获取Path中名称元素的个数
    7. `Path getName(int index);` 获取某个索引对应的名称
    8. `Path subpath(int beginIndex, int endIndex);` 获取子路径
    9. `boolean startsWith(Path other);` 判断是否以什么开头
    10. `boolean endsWith(String other);` 判断是否以什么结尾
    11. `Path normalize();` 正常化
    12. `Path resolve(Path other);`
    13. `Path resolveSibling(String other);`
    14. `Path relativize(Path other);`
    15. `URI toUri();`
    16. `Path toAbsolutePath();`
    17. `Path toRealPath(LinkOption... options) throws IOException;`
    18. `File toFile();`
    19. `Iterator<Path> iterator();`
    20. `int compareTo(Path other);`
    21. `boolean equals(Object other);`

设计类的时候
首先设计接口，然后设计抽象类，最后再设计实现类 ，接口可以有默认方法，抽象类可以实现部分方法，实现类实现具体的方法

一个接口 `Path`

一个获取接口帮助类 `Paths`

一个抽象类 `AbstractPath`

一个具体实现类 `UnixPath`

定义一个path `Paths.get(String path);`

定义一个绝对路径

定义一个路径使用快捷路径如 ../../Path path.normalize
使用filesystems.getdefault.getpath

`Path Paths.get(URI uri);`的设计思想
1. 根据URI获取方案，如果方案为空，则抛出异常
2. 如果方案等于默认文件系统提供的方案，那么就使用默认的文件系统生成路径
3. 如果不是默认的，则查询所有的文件系统提供器，找到方案相等的
4. 如果这样都没有找到，那么就要抛出异常
非常完美的设计方案，


文件属性元数据
文件的属性由视图完成
NIO2支持的视图有哪些呢？
支持六种视图，分别是

  1. `BasicFileAttributeView` 这是一个视图的基本属性，所有的文件系统实现类都必须支持，属性视图名是`basic`
  2. `DosFileAttributeView` 提供了标准的四种属性支持DOS属性的文件系统，属性视图名为`dos`
  3. `PosixFileAttributeView` UNix特有的属性 属性名为`posix`
  4. `FileOwnerAttributeView` 属性名为`owner`
  5. `AclFileAttributeView` 属性名为`acl`
  6. `UserDefinedFileAttributeView` 用户自定义的属性 属性名为`user`

帮助类并不做实际上的工作，而是将工作交给内部静态类来实现
`java.nio.file.FileSystems` 工厂类，主要用来获取`FileSystem`和创建新的`FileSystem`

掌握文件属性的6种视图，有其包括了哪些属性以及简写情况下都是什么东西

1. basic 基本视图 BasicFileAttributeView

唉，微信支付给我做的啊，难受死了，感觉不是这样的，但是也没有办法了，我也不想这样的，只能这样了

2016年11月17日 星期四

买的机械键盘终于到了，虽然是入门级，但是感觉很不错，打字的那种爽快感无与伦比，实在是刺激极了
嘿嘿，希望这个机械键盘可以陪伴我度过我的编码时间
等明年再说吧，明年争取换一个背光的机械键盘

今天就是星期五了，非常的高兴，又可以休息了，打算最近开始重新继续学习，不可以辜负我自己的期望啊

昨天没怎么学习文件属性，今天继续
首先从基本的basic 属性开始学起

使用`Files.readAttributes` 获取指定的属性的集合

使用`Files.getAttribute` 获取单个属性

Basic属性名：

  1. lastModifiedTime 上次修改时间
  2. lastAccessTime 上次访问时间
  3. creationTime 创建时间
  4. size 文件大小
  5. isRegularFile 是不是普通文件
  6. isDirectory 是否是目录
  7. isSymbolicLink 是否是符号链接
  8. isOther 是否是其他
  9. fileKey 这个是什么鬼

使用`Files.getFileAttributeView().setTimes`来更新属性

Dos属性名

  1. hidden 文件是否隐藏
  2. readonly 文件是否只读
  3. system 文件是否是系统文件
  4. archive 文件是否是档案


文件拥有者视图

  1. owner 只有该一个属性名

可以有多种方式设置文件的拥有者

  1. 使用`Files.setOwner()` 设置文件拥有者，通过路径的文件系统来获取用户信息
  2. 使用`FileOwnerAttributeView.setOwner()` 使用文件拥有者属性视图来设置拥有者
  3. 使用`Files.setAttribute()` 设置文件拥有者
  4. 使用`FileOwnerAttributeView.getOwner()` 获取文件拥有者
  5. 使用`Files.getAttribute()` 获取文件拥有者

POSIX属性视图名

  1. group 该文件属于哪个组
  2. permissions 该文件的九个权限

ACL视图名

  1. acl 获取访问控制列表
  2. owner 获取文件拥有者

`File Store` 文件存储属性

用户自定义属性就不看了，可能用到的机会比较小

加油了 时间不多了

硬链接和软连接的区别

  1. 硬链接只能为文件创建，不能为目录，软连接既可以是一个文件，也可以是一个目录
  2. 硬链接不能跨文件系统而存在，但是软连接可以
  3. 硬链接的目标文件必须存在，软连接的目标可能不存在
  4. 删除源文件，硬链接仍然可用，但软连接就会不起作用了
  5. 删除硬链接和软连接不会影响源文件本身

这个稍微了解一下就可以了，准备开始新的知识的学习

文件和目录

下面开始学习`java.nio.file.Files`类了，这个类可是一个非常重要的类啊

  1. `Files.exists(path)` 检查文件或目录是否存在
  2. `Files.notExists(path)` 检查文件或目录是否不存在

检查文件的可访问性

  1. `Files.isReadable(path);` 判断文件是否可读的
  2. `Files.isWritable(path);` 判断文件是否可写的
  3. `Files.isExecutable(path);` 判断文件是否是可执行的
  4. `Files.isRegularFile` 判断文件是否是普通文件

检查两个路径是否指向同一个文件

  1. `Files.isSameFile(path_1, path_2);` 判断两个路径是否指向同一个文件

检查文件的可见性

  1. `Files.isHidden(path);` 判断一个文件是否是隐藏的

列出文件系统所有的根目录

  1. `FileSystems.getDefault().getRootDirectories()` 获取所有的根目录

创建一个新的目录 或者多级目录

  1. `Files.createDirectory(newdir);`
  2. `Files.createDirectories(newdir);`

列出一个目录下的内容

  1. `Files.newDirectoryStream(path)` 创建一个目录流来遍历

使用 内置的glob过滤器来过滤文件名称

glob的使用规则 和正则表达式差不多

  1. * : 匹配0或多个字符
  2. ** : 跨目录的匹配
  3. ？ ： 匹配0个或1个字符
  4. {} ：代表一个匹配集合，以逗号隔开
  5. [] : 匹配一系列字符

用户自定义过滤器 来过滤文件名称

  ```
  Path path = Paths.get("/home/hyolee/mavin/upload");
  DirectoryStream.Filter<Path> filter = entry -> Files.isDirectory(entry, LinkOption.NOFOLLOW_LINKS);
  try (DirectoryStream<Path> directoryStream = Files.newDirectoryStream(path, filter)) {
      directoryStream.forEach(System.out::println);
  } catch (IOException e) {
      e.printStackTrace();
  }
  ```

简单的几行代码，竟然包含了多个知识点
lambda表达式，try-with-resource 方法引用

`StandardOpenOption` 类

  1. `READ` 打开一个文件 进行读操作
  2. `WRITE` 打开一个文件，进行写操作
  3. `CREATE` 如果文件不存在，就创建一个新的文件
  4. `CREATE_NEW` 创建一个新的文件，如果文件已存在，就抛出异常
  5. `APPPEND` 添加数据到文件的末尾，配合WRITE和CREATE使用
  6. `DELETE_ON_CLOSE` 当流关闭时，删除文件，用来删除临时文件
  7. `TRUNCATE_EXISTING` 清空文件到0字节
  8. `SPARSE` 使新创建的文件变稀疏的
  9. `SYNC` 保持文件内容和元数据和潜在的存储设备同步
  10. `DSYNC` 保持文件内容和潜在的存储设备同步

现在来学一个小的包，然后再去学其他的api

`java.nio.charset` 这个是字符编码的包，所有的字符集都可以从这个包中来获取

再也不用自己手写了，多累啊

使用`java.nio.charset.StandardCharsets` 来获取字符编码

`Charset charset = StandardCharsets.UTF_8;` 获取UTF8的字符编码

`Files`， `FileStore`，`FileSystem`，`FileSystems`，`Paths`，`SimpleFileVisitor`

这几个类是`java.nio.file`包中最重要的类了，一定要学习会

递归遍历

使用`Files.walkFileTree();` 来对目录进行遍历

实现 `FileVisitor` 接口或者继承 `SimpleFileVisitor` 类都可以啊

使用Glob模式来查询文件或目录

需要使用到的类`PathMatcher`，可以用来接收glob字符串

日了狗了

当时自己就是这样设计的，非要一个漫展一个票，结果搞成这个样子，后期返工啊，最是头疼

早知当初 何必今日啊
没办法，自己的坑需要自己来填
估计下个星期我的主要任务就是更改漫展实体和门票实体，以及他们之间的关系了，

所以一个良好的架构设计是非常有必要的

这也是我一直在努力的原因

同时也希望提高自己带团队的经验，如何才能管理一个团队，如果提供员工最大的积极性

首先是需求，一定要去调研 才能 得到结果

需求不能变来变去，不然会产生一些很难看的问题

最好和程序员讨论表的设计 实体的设计 功能的实现 等等一些基础的东西

提供自己的编码能力

再见了，不说了，明天休息了

哈哈

Selector 复用器的使用以及非阻塞socket的编写

`java.nio.channels.Selector` 复用器，首先来研究一下java的文档

`SelectableChannel`对象的多路复用器

创建复用器的几种方法

  1. 使用`Selector.open()`方法将会创建系统默认的复用器
  2. 使用`SelectorProvider.openSelector()`方法将会创建自定义的复用器，一般来说，使用默认的就行了

复用器会一直打开，直到使用`close()`方法才会关闭

复用器处理多个socket的 I/O 读/写操作在一个单线程，

`SelectionKey` 对象

每次一个channel注册了一个selector，它由一个`java.nio.channels.SelectionKey`类的实例代表

有四种可能类型的key：

  1. SelectionKey.OP_ACCEPT 可接受的，相关联的客户端请求一个连接，通常由服务端创建
  2. SelectionKey.OP_CONNECT 可连接的，服务端接收连接，通常由客户端创建
  3. SelectionKey.OP_READ 可读的，这表明一个读的操作
  4. SelectionKey.OP_WRITE 可写的，这表明一个写操作

复用器负责操作三个selection keys的集合

  1. key-set 包含该复用器注册的channel的keys
  2. selected-key 已被检测到准备操作
  3. cancelled-key 已经取消但还没有解除注册的key

`Selector`的方法

  1. `Selector.open()` 创建一个新的复用器
  2. `Selector.select()` 通过执行阻塞选择操作来选择一组键
  3. `Selector.select(t)` 同上，只不过是该方法只阻塞特定的时间，超过这个时间之后就会返回0
  4. `Selector.selectNow()` 同select，但是不阻塞选择操作，如果没有选择任何东西，就会返回0
  5. `Selector.selectedKeys()` 返回复用器选择的key
  6. `Selector.keys()` 返回该复用器的key集合
  7. `SelectionKey.isValid()` 检查一个key是否是有效的，被取消，channel关闭，复用器关闭等 都是无效的
  8. `SelectionKey.isReadable()` 测试是否可读
  9. `SelectionKey.isWritable()` 测试是否可写
  10. `SelectionKey.isConnectable()` 测试是否连接着
  11. `SelectionKey.cancel()` 取消key
  12. `SelectionKey.interestOps()` 返回该key感兴趣的集合
  13. `SelectionKey.interestOps(t)` 设置该key感兴趣的集合
  14. `SelectionKey.readyOps()` 返回该key准备操作的集合

`ServerSocketChannel` 和`SocketChannel` 可以通过`register()` 方法，用来注册当前channel和给定的复用器
并且返回一个可选择的key

#### 写服务端的代码的步骤

  1. 准备工作 一个Map用来存放每个socketchannel的字节数据，一个bytebuffer充当缓存
  2. 使用`ServerSocketChannel.open();`和`Selector.open();` 打开channel和Selector
  3. 使用`server.isOpen() && selector.isOpen()` 来判断channel和Selector是否已经打开
  4. 打开成功后，使用`server.configureBlocking(false);`配置非阻塞
  5. 使用`server.setOption(StandardSocketOptions.SO_RCVBUF, 4 * 1024);` 配置相关属性
  6. 使用`server.bind(new InetSocketAddress("127.0.0.1", 7777));` 绑定地址
  7. 使用`server.register(selector, SelectionKey.OP_ACCEPT);` 注册Selector到channel上
  8. 使用`selector.select();` 获取一组键
  9. 使用`selector.selectedKeys()` 获取所有已选择的key进行遍历
  10. 判断key的状态
  11. `key.isValid()` = false 表示无效，继续执行
  12. `key.isAcceptable()` = true，表示服务端，通过key.channel获取的是serversocketchannel，这样可以向客户端写数据
  13. `key.isReadable()` =true 表示客户端是可读的，
  14. `key.isWritable()` 表示客户端是可写的

#### 写客户端的代码的步骤

写客户端的步骤就简单了一点

  1. 打开channel，打开Selector
  2. 判断是否已打开，然后配置非阻塞，配置其他属性
  3. channel注册Selector，属性为connect
  4. channel 连接服务端
  5. Selector.select(t) >0 的时候，对所有已选择的key进行遍历
  6. 通过`key.isConnectable()` 判断key是否已连接了，连接了，就可以进行读写操作了，这个和之前的代码差不多的

为了更方面的学习这个api，我决定把源码复制进来

服务端代码：

```
private static Map<SocketChannel, List<byte[]>> keepDataTrack = new HashMap<>();
final ByteBuffer buffer = ByteBuffer.allocate(1024);
ServerSocketChannel server = ServerSocketChannel.open();
final Selector selector = Selector.open();
if (server.isOpen() && selector.isOpen()) {
    server.configureBlocking(false);
    server.setOption(StandardSocketOptions.SO_RCVBUF, 4 * 1024);
    server.setOption(StandardSocketOptions.SO_REUSEADDR, true);

    // 绑定
    server.bind(new InetSocketAddress("127.0.0.1", 7777));
    server.register(selector, SelectionKey.OP_ACCEPT);

    while (true) {
        selector.select();
        final Iterator<SelectionKey> keys = selector.selectedKeys().iterator();
        while (keys.hasNext()) {
            final SelectionKey key = keys.next();
            keys.remove();
            if (!key.isValid())
                continue;
            if (key.isAcceptable()) {
                ServerSocketChannel serverSocketChannel = (ServerSocketChannel) key.channel();
                SocketChannel socketChannel = serverSocketChannel.accept();
                socketChannel.configureBlocking(false);
                System.out.println("Incoming connection from: " + socketChannel.getRemoteAddress());
                socketChannel.write(ByteBuffer.wrap("来自服务端的HELLO!\n".getBytes()));
                keepDataTrack.put(socketChannel, new ArrayList<>());
                socketChannel.register(selector, SelectionKey.OP_READ);
            } else if (key.isReadable()) {
                SocketChannel socketChannel = (SocketChannel) key.channel();
                buffer.clear();
                int numRead = socketChannel.read(buffer);
                if (numRead == -1) {
                    keepDataTrack.remove(socketChannel);
                    System.out.println("Connection closed by: " + socketChannel.getRemoteAddress());
                    socketChannel.close();
                    key.cancel();
                    return;
                }
                byte[] data = new byte[numRead];
                System.arraycopy(buffer.array(), 0, data, 0, numRead);
                System.out.println(new String(data, "UTF-8") + " from " +
                        socketChannel.getRemoteAddress());
                final List<byte[]> channelData = keepDataTrack.get(socketChannel);
                channelData.add(data);
                key.interestOps(SelectionKey.OP_WRITE);
            } else if (key.isWritable()) {
                SocketChannel socketChannel = (SocketChannel) key.channel();
                List<byte[]> channelData = keepDataTrack.get(socketChannel);
                Iterator<byte[]> its = channelData.iterator();
                while (its.hasNext()) {
                    byte[] it = its.next();
                    its.remove();
                    socketChannel.write(ByteBuffer.wrap(it));
                }
                key.interestOps(SelectionKey.OP_READ);
            }
        }
    }
}

```

客户端代码：

```
final int DEFAULT_PORT = 7777;
final String IP = "127.0.0.1";
ByteBuffer buffer = ByteBuffer.allocateDirect(2 * 1024);
ByteBuffer randomBuffer;
CharBuffer charBuffer;
Charset charset = Charset.defaultCharset();
CharsetDecoder decoder = charset.newDecoder();
try (final Selector selector = Selector.open();
     SocketChannel socketChannel = SocketChannel.open()) {
    if (socketChannel.isOpen() && selector.isOpen()) {
        socketChannel.configureBlocking(false);
        socketChannel.setOption(StandardSocketOptions.SO_RCVBUF, 4 * 1024);
        socketChannel.setOption(StandardSocketOptions.SO_SNDBUF, 4 * 1024);
        socketChannel.setOption(StandardSocketOptions.SO_REUSEADDR, true);
        socketChannel.setOption(StandardSocketOptions.SO_KEEPALIVE, true);
        socketChannel.register(selector, SelectionKey.OP_CONNECT);
        socketChannel.connect(new InetSocketAddress(IP, DEFAULT_PORT));
        System.out.println("Localhost: " + socketChannel.getLocalAddress());
        while (selector.select(1000) > 0) {
            final Iterator<SelectionKey> keys = selector.selectedKeys().iterator();
            while (keys.hasNext()) {
                final SelectionKey key = keys.next();
                keys.remove();
                SocketChannel channel = (SocketChannel) key.channel();
                if (key.isConnectable()) {
                    System.out.println("I am connected!");
                    if (channel.isConnectionPending())
                        channel.finishConnect();

                    while (channel.read(buffer) != -1) {
                        buffer.flip();
                        charBuffer = decoder.decode(buffer);
                        System.out.println(charBuffer.toString());

                        if (buffer.hasRemaining())
                            buffer.compact();
                        else
                            buffer.clear();

                        int r = new Random().nextInt(100);
                        if (r == 50) {
                            System.out.println("50 was generated! Close the socket channel!");
                            break;
                        } else {
                            randomBuffer = ByteBuffer.wrap("Random number:"
                                    .concat(String.valueOf(r)).getBytes("UTF-8"));
                            channel.write(randomBuffer);
                            try {
                                Thread.sleep(1500);
                            } catch (InterruptedException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                }
            }
        }
    }
} catch (IOException e) {
    e.printStackTrace();
}
```


### 异步I/O 重头戏来了

这个必须掌握！！！！

Java NIO需要掌握的类

`java.nio.ByteBuffer` 字节缓存区，主要用来存放数据和传输数据

`java.nio.channels.SeekableByteChannel` 主要用来进行随机读写文件的功能的

三个异步NIO的类必须要掌握

`java.nio.channels.AsynchronousServerSocketChannel` 异步serversocketchannel

`java.nio.channels.AsynchronousSocketChannel`

`java.nio.channels.AsynchronousFileChannel` 用于处理文件的channel

`java.nio.channels.Selector` 这个也要了解一下

`java.nio.charset.Charset` 字符编码集

`java.nio.charset.StandardCharsets` 标准字符编码集

`java.nio.file.Files`

`java.nio.file.Paths`

`java.nio.file.FileSystems`

`java.nio.file.Path`

`java.nio.file.StandardOpenOption` 这个枚举类也要注意一下，比较重要

六种文件属性 了解一下

恩，掌握这些内容，基本上nio的api就算学习完成了，其中重点掌握的就是`Files`，`Paths`这两个工具类，特别特别重要

## Java Lambda表达式

#### Stream的基本概念

Stream和集合的区别：

  1. Stream不会自己存储元素。元素储存在底层集合或者根据需要产生。
  2. Stream操作符不会改变源对象。相反，它会返回一个持有结果的新的Stream。
  3. 3.Stream操作可能是延迟执行的，这意味着它们会等到需要结果的时候才执行。

Stream操作的基本过程,可以归结为3个部分：

  1. 创建一个Stream。
  2. 在一个或者多个中间操作中，将指定的Stream转换为另一个Stream的中间操作。
  3. 通过终止（terminal）方法来产生一个结果。该操作会强制它之前的延时操作立即执行，这之后该Stream就不能再被使用了。

中间操作都是filter()、distinct()、sorted()、map()、flatMap()等，其一般是对数据集的整理（过滤、排序、匹配、抽取等）。

终止方法往往是完成对数据集中数据的处理，如forEach()，还有allMatch()、anyMatch()、findAny()、 findFirst()，数值计算类的方法有sum、max、min、average等等。终止方法也可以是对集合的处理，如reduce()、 collect()等等。reduce()方法的处理方式一般是每次都产生新的数据集，而collect()方法是在原数据集的基础上进行更新，过程中不产生新的数据集。

下面介绍强大的聚合操作，其主要分为两种：

  1. 可变聚合：把输入的元素们累积到一个可变的容器中，比如Collection或者StringBuilder；
  2. 其他聚合：除去可变聚合，剩下的，一般都不是通过反复修改某个可变对象，而是通过把前一次的汇聚结果当成下一次的入参，反复如此。比如reduce，count，allMatch；

####  聚合操作reduce

Stream.reduce，返回单个的结果值，并且reduce操作每处理一个元素总是创建一个新值。常用的方法有average, sum, min, max, count，使用reduce方法都可实现。这里主要介绍reduce方法：

`T reduce(T identity, BinaryOperator<T> accumulator)`

 identity：它允许用户提供一个循环计算的初始值。accumulator：计算的累加器，其方法签名为apply(T t,U u)，在该reduce方法中第一个参数t为上次函数计算的返回值，第二个参数u为Stream中的元素，这个函数把这两个值计算apply，得到的和会被赋值给下次执行这个方法的第一个参数。

#### 收集结果collect

当你处理完流时，通常只是想查看一下结果，而不是将他们聚合为一个值。先看collect的基础方法，它接受三个参数：

`<R> R collect(Supplier<R> supplier, BiConsumer<R,? super T> accumulator, BiConsumer<R,R> combiner)`

supplier：一个能创造目标类型实例的方法。accumulator：一个将当元素添加到目标中的方法。combiner：一个将中间状态的多个结果整合到一起的方法（并发的时候会用到）。

单词学习时间
```
  hassle
  英 ['hæs(ə)l]  美 ['hæsl]
  vt. 找麻烦，搅扰；与…争辩；使…烦恼
  n. 困难，麻烦；激战
  vi. 争论，争辩
  n. (Hassle)人名；(瑞典)哈斯勒
  [ 过去式 hassled 过去分词 hassled 现在分词 hassling ]
```

```
imperative
英 [ɪm'perətɪv]  美 [ɪm'pɛrətɪv]
adj. 必要的，不可避免的；紧急的；命令的，专横的；势在必行的；[语]祈使的
n. 必要的事；命令；需要；规则；[语]祈使语气
```

elegant 高雅的

concise 简洁的

prone 倾向于

函数式编程的好处：

  1. 避免了显示的修改和重赋值变量
  2. 更容易并行
  3. 代码更容易表达
  4. 更简洁
  5. 代码更直观

下午开始看JAVA8 关于lambda的两个包的API

`java.util.function`和`java.util.stream`

`java.util.stream.Collectors` 工具类的介绍

恩，基本上这个类的常用方法都看完了，也自己练习了一下其中的一些方法的使用

接下来，我将会按照使用频繁和重要程度对该类的方法进行排序

```
	1.  toList() 将流转换成集合
	2.  toSet() 将流转换成集合
	3.  joining() 将字符串流组合成字符串返回
	4.  groupingBy() 按条件进行分组
	5.  partitioningBy() 按条件分片
	6.  toMap() 将流转换成map
	7. toCollection() 将流转换成集合
	8. mapping() 对流进行转换
	9. maxBy/minBy 求最大/最小的元素
	10. summingInt/summingLong/summingDouble 
	11. averagingInt 。。
	12. reducing
	13. summarizingInt/summarizingLong/summarizingDouble	
```

去学习function了，发现不先了解一下function的话，不好理解stream的参数

`Supplier<T>` 代表结果的供应商，没有参数，返回T结果

`Predicate<T>` 代表一个布尔值，有一个参数，返回布尔值

`Function<T,R>`代表一个函数，接收一个参数，返回一个结果

`Consumer<T>` 代表一个消费者，接收一个参数，没有返回结果

`BinaryOperator` 二进制操作符？ 接收两个同类型的参数，产生一个同类型的结果

`BiConsumer<T,U>` 接收两个参数，不返回结果

基本上就这几种类型，希望自己能看明白每个接口的作用，以及每个类型的意义

`java.util.stream.Stream<T>` 研究一下这个类的方法吧 
	
	1. boolean	allMatch(Predicate<? super T> predicate) 返回是否该流所有的元素都匹配给定的谓语
	2. boolean	anyMatch(Predicate<? super T> predicate) 返回是否有元素匹配给定的谓语
	3. <R,A> R	collect(Collector<? super T,A,R> collector) 执行一个可变的聚合操作
	4. static <T> Stream<T>	concat(Stream<? extends T> a, Stream<? extends T> b) 连接两个流
	5. long	count() 返回流中元素的个数
	6. Stream<T>	distinct() 去重
	7. Stream<T>	filter(Predicate<? super T> predicate) 过滤
	8. <R> Stream<R>	flatMap(Function<? super T,? extends Stream<? extends R>> mapper)  这个方法不知道干嘛用的，等会研究一下
	9. void	forEach(Consumer<? super T> action) 迭代
	10. static <T> Stream<T>	generate(Supplier<T> s) 生成
	11. Stream<T>	limit(long maxSize) 限制
	12. <R> Stream<R>	map(Function<? super T,? extends R> mapper) 转换
	13. static <T> Stream<T>	of(T... values) 将元素转换成流
	14. Optional<T>	reduce(BinaryOperator<T> accumulator)
	15. Stream<T>	sorted() 排序
	
反正流就三个操作，开始操作，中间操作，终止操作

开始操作
	
	1. static <T> Stream<T>	of(T... values)
	2. static <T> Stream<T>	empty()
	3. static <T> Stream<T>	generate(Supplier<T> s)
	4. static <T> Stream<T>	iterate(T seed, UnaryOperator<T> f)
	
中间操作
	
	1. Stream<T>	distinct()
	2. Stream<T>	filter(Predicate<? super T> predicate)
	3. <R> Stream<R>	flatMap(Function<? super T,? extends Stream<? extends R>> mapper)
	4. Stream<T>	limit(long maxSize)
	5. <R> Stream<R>	map(Function<? super T,? extends R> mapper)
	6. Stream<T>	skip(long n)
	7. Stream<T>	sorted()

终止操作

	1. boolean	allMatch(Predicate<? super T> predicate)
	2. boolean	anyMatch(Predicate<? super T> predicate)
	3. <R,A> R	collect(Collector<? super T,A,R> collector)
	4. long	count()
	5. Optional<T>	findAny()
	6. Optional<T>	findFirst()
	7. void	forEach(Consumer<? super T> action)
	8. Optional<T>	max(Comparator<? super T> comparator)
	9. Optional<T>	min(Comparator<? super T> comparator)
	10. Optional<T>	reduce(BinaryOperator<T> accumulator)
	11. <A> A[]	toArray(IntFunction<A[]> generator)
 

可能会有疑问的几个方法，其中flatmap这个方法是什么鬼啊


