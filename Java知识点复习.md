1. ClassLoader 加载流程

   当运行一个程序的时候，JVM启动，运行bootstrap classloader，该classloader加载Java 核心API (ExtClassLoader和AppClassLoader也在此时被加载)

   然后调用ExtClassloader加载扩展API

   最后APPCLassloader加载CLASSPATH目录下定义的Class

2. JVM和垃圾回收机制

3. Hashmap和ConcurrentHashmap的数据结构

4. NIO框架

5. 各种排序，快速排序>归并排序>堆排序...

6. 事务的理解

#### ConcurrentHashmap的原理和理解

锁分段技术 1.8之前用的技术

首先将数据分成一段一段的存储，然后给每一段数据配一把锁，当一个线程占用锁访问其中一个段数据的时候，其他段的数据也能被其他线程访问

原子变量 提供了原子性的读-写-修改操作，可以在不适用锁的情况下安全地更新共享变量

原子变量的内存语义与volatile变量类似

CAS算法 非阻塞算法，一个线程的失败或挂起不应该引起另外一个线程的失败或挂起

利用硬件层面支持的原子化操作指令来取代锁的

CAS = compare and swap

synchronized是一种独占锁，独占锁是一种悲观锁，当一个线程访问共享资源的时候，其他线程必须处在阻塞状态

JVM实现阻塞的方式通常是挂起阻塞的线程

1.8的实现已经坡起了Segment分段锁机制，利用CAS+Synchronized来保证并发更新的安全

