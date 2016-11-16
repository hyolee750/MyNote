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
