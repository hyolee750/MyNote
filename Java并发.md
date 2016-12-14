## 1. 线程管理

#### 创建和运行线程

创建线程的两种方式：

1. 继承`Thread` 类，覆盖`run()` 方法
2. 实现`Runnable` 接口

每个java程序至少有一个执行线程，当你运行程序时，JVM执行main方法的执行线程

当我们调用一个线程对象的`start()` 方法时，我们在创建另一个执行线程，调用了多少次`start()` 方法就会有多少个执行线程

当所有的非守护线程结束时，程序结束了，如果初始线程结束了，其余的线程将会继续执行直到它们完成，如果一个线程使用了`System.exit()` 方法结束程序的执行，那么所有的线程都会结束它们的执行

创建一个`Thread` 类的对象不会创建新的执行线程，同样，调用一个实现了`Runnable` 接口的类的`run()`方法也不会创建新的执行线程，只有调用`start()` 方法才会创建新的执行线程

#### 获取和设置线程信息

1.  ID： 该属性存储了每个线程的唯一标识符
2.  Name： 该属性存储了线程的名称
3.  Priority： 该属性存储了线程对象的优先级，线程的优先级从1-10，1是最低的优先级，10是最高的优先级，不推荐改变线程的优先级
4.  Status： 该属性存储了线程的状态，在java，线程可以是6种状态的其中之一： new，runnable，blocked，waiting，time waiting，terminated

#### 中断线程

java提供了中断机制来表明一个线程我们想要结束它，这种机制的一个特点就是线程必须检查它是否已经被中断了，并且它可以决定它是否响应于完成请求，线程可以忽略它并继续执行

`Thread` 类有一个属性存储了布尔值表明线程是否被中断，当你调用一个线程的`interrupt()` 方法，你设置该值为true。`isInterrupted()` 方法仅仅返回该属性的值

`Thread` 类还有另外一个方法用来检查线程是否被中断，这就是静态方法`interrupted()` ，用来检查是否当前正在执行的线程是否已经被中断

#### 控制线程的中断

使用java异常来控制线程的中断

#### 睡眠和挂起线程

使用`Thread.sleep(n)` 方法来使线程睡眠，挂起

#### 等待线程最终确定

使用`join()` 方法，当调用该方法时，它会挂起当前调用线程的执行，直到被调用的对象完成它的执行

记住，调用哪个线程的join方法，就会引起该线程立即执行，而当前线程挂起，直到被调用的线程完成执行

java提供了额外两种形式的join方法

1. `join(long milliseconds)`
2. `join(long milliseconds,long nanos)`

第一个版本的join方法，等待具体的毫秒值之后执行

#### 创建和运行守护线程

使用Thread类的`setDaemon(true);` 设置线程为守护线程

使用`isDaemon()` 方法检查一个线程是否是守护线程

#### 处理线程未控制的异常

使用`thread.setUncaughtExceptionHandler(eh)`方法设置未捕获异常处理器

当一个线程抛出一个异常，没有被捕获(该异常必须是非检查型异常)，JVM检查是否线程有一个未捕获异常处理器，如果有，JVM调用该异常处理器的方法，如果线程没有设置异常处理器，JVM打印堆栈信息到控制台，然后退出程序

静态方法`setDefaultUncaughtExceptionHandler()` 建立一个异常处理器为该应用的所有线程对象

当线程抛出一个未捕获异常，JVM为该异常寻找3种可能的处理器

首先，它寻找线程的未捕获异常处理器，如果不存在

其次，它寻找该线程的线程组的未捕获异常处理器，如果不存在

再次，它寻找默认的未捕获异常处理器，如果还不存在

最后，打印堆栈信息到控制台

#### 使用本地线程变量

使用`ThreadLocal`来存储本地线程变量

使用`get()` 方法读取该值

使用`set()` 方法设置该值

如果没有值，调用`initialValue()` 初始化一个值

使用`remove()` 方法删除该值

#### 线程组

`ThreadGroup` 对象的使用

#### 处理线程组的未控制的异常

覆盖`ThreadGroup` 的`public void uncaughtException(Thread t, Throwable e)` 方法，设置自定义处理

#### 通过工厂创建线程

`ThreadFactory` 的接口的应用

## 2.基本线程同步

核心部分：是一个代码块访问一个共享资源并且在同一时刻不能被多个线程执行

同步机制：

#### 同步方法

使用`synchronized` 关键字来控制并发访问方法

静态方法有不同的行为，只有一个执行线程可以访问一个声明了`synchronized` 关键字的静态方法，但是另一个线程可以访问该对象的其他非静态方法，你必须要小心处理这一点

#### 在同步类中排列独立属性

使用对象作为锁 `private final Object lock = new Object()`

#### 在同步代码中使用条件

处理**生产者-消费者** 模式产生的问题，使用`wait()` ,`notify()` ,`notifyAll()` 方法来实现

#### 使用Lock同步代码块

Lock接口和它的实现ReentrantLock，该机制的优点：

1. 允许更灵活的组织同步代码块
2. 比`synchronized` 关键字提供了额外的功能，比如tryLock()方法
3. Lock接口允许分开读和写操作，有多个读者和只有一个修改的
4. Lock接口提供了更好的性能

```java
public void printJob(Object document) {
        queueLock.lock();
        try {
            Long duration = (long) (Math.random() * 10000);
            System.out.println(Thread.currentThread().getName() + ":PrintQueue: Printing a Job during " + (duration / 1000) + " seconds");
            Thread.sleep(duration);
        } catch (InterruptedException e) {
            e.printStackTrace();
        } finally {
            queueLock.unlock();
        }
    }
```

#### 使用读写锁同步数据访问

`ReadWriteLock` 接口和`ReentrantReadWriteLock` 实现类

该类有两个锁，一个用来进行读操作，另一个用来进行写操作

多个线程可以使用读操作，但是只有一个线程可以使用写操作

当一个线程正在进行写操作时，任何线程都不能进行读操作

#### 修改Lock公平

ReentrantLock和ReentrantReadWriteLock的构造器接收一个布尔参数，它允许控制类的行为，false值是默认值，叫不公平模式，在这个模式中，无条件选择等待的线程，true为公平模式，它会选择等待时间最长的线程

#### 在一个Lock中使用多个条件

Condition接口提供了机制来挂起一个线程和唤醒一个被挂起的线程

## 3. 线程同步工具集

在第2章，基本线程同步，教会我们下面基础的同步机制：

1. `synchronized` 关键字
2. Lock接口和它的实现类，`ReentrantLock` ，`ReentrantReadWriteLock.ReadLock` ，`ReentrantReadWriteLock.WriteLock` 

这一章，我们将会学习如何使用高水平机制来获取多线程的同步，这些高水平的机制如下所示：

1. **Semaphores** ：信号是一个计数器，用来控制访问一个或多个共享资源，该机制是并发编程的基础工具之一，绝大多数编程语言都有支持
2. **CountDownLatch** ： 倒数锁存器，由java语言实现，允许一个线程等待多个操作的终止
3. **CyclicBarrier** ： 环状屏障，该类是java语言提供的另外一个机制，允许多个线程在一个普通点同步
4. **Phaser** ： 阶段，该类是java语言提供的另外一个机制，控制并发任务划分成阶段执行，所有的线程必须完成一个阶段在它们能继续下一个的阶段的时候
5. **Exchanger** ： 交换器，提供了在两个线程之间数据交换的点

#### 控制资源的并发访问

一个信号是一个计数器来保护访问一个或多个共享资源

当一个线程想要访问这些共享资源之一的时候，首先，它必须获取信号，如果信号内部的计数器大于0，信号减少计数器，允许访问共享资源，计数器大于0意味着有免费的资源可以使用，所以线程可以访问其中之一

如果，信号的计数器是0，信号使线程睡眠直到计数器大于0，计数器为0意味着所有共享资源都已被其他线程使用，所以该线程想要使用其中之一必须等到一个资源被释放

当某线程已经完成共享资源的使用，它必须释放信号，以便其他信号可以访问共享资源，这个操作增加信号内部计数器的值

记住：一切用于同步的方法，都和共享资源有关，当有操作共享资源的方法，必须要使用同步来进行保护 ，防止多线程并发访问

信号的使用方法：

1.  使用`semaphore.acquire();` 方法获取信号，如果信号内计数器大于0，就可以获取到访问的权限，如果等于0，则需要等待，直到有一个线程释放了资源
2.  处理资源
3.  使用`semaphore.release();` 方法释放信号，该操作会导致信号内计数器增加

`Semaphore` 类有两个额外版本的`acquire()` 方法：

1. `acquireUninterruptibly()` `acquire()` 方法的原理：当信号内部计数器等于0，阻塞线程，知道信号被释放，在阻塞期间，线程可能被中断，该方法会抛出一个中断异常，该版本的请求操作将会忽略该该线程的中断，不会抛出任何异常
2. `tryAcquire()` 该方法试图获取信号，如果可以，该方法返回true，如果不可以，该方法返回false，不会被阻塞和等待信号的释放，基于返回的值，可以决定采用正确的行为

信号的公平模式

和之前的机制类型，设置为公平模式，会选择等待时间最长的线程

#### 控制并发访问一个资源的多个复制

使用二进制信号，这种类型的信号被用来保护访问一个共享的资源或者同一时间只能被一个线程执行的核心部分，但是信号也可以用来保护一个资源的多个复制，或者同一时间可以被多个线程执行的核心部分

#### 等待多个并发事件

Java API提供了一个类允许一个或多个线程等待直到一系列操作完成，这就是`CountDownLatch` 类，该类初始化一个整数，代表线程将要等待的操作数，当一个线程想要等待这些操作的执行，它使用`await()` 方法，这个方法使该线程睡眠直到所有操作被完成，当这些操作的其中之一完成后，它调用`countDown()` 方法减少内部计数器的值，当该计数器达到0时，`CountDownLatch` 类唤醒所有睡眠的线程

`CountDownLatch` 类有三个基本元素：

1. 初始化值决定了`CountDownLatch` 类有多少个事件需要等待
2. `await()` 方法被所有的线程调用等待所有事件的终止
3. `countDown() 方法，被事件调用当它们完成它们的执行`

不可能重新初始化`CountDownLatch` 对象的内部计数器或修改它的值，一旦计数器被初始化，你可以唯一使用的方法来修改它的值就是`countDown()` 方法，当计数器到达0时，所有调用`await()` 方法的线程都会立即返回

和其他同步方法的不同：

1.  `CountDownLatch` 机制不能用来保护一个共享的资源或一个核心部分，它被用来同步一个或多个执行不同任务的线程
2. 它只允许使用一次，一旦该类的计数器到达0，再次调用该类的方法都没有效果，如果你想要再次做同样的同步，你必须创建一个新的对象

#### 同步任务在一个共同点

Java并发API提供了一个同步工具集允许同步两个或多个线程在一个决定的点，这个类就是`CyclicBarrier` 这个类和`CountDownLatch` 类类似。但是提供了一些不同

该类初始化一个整数，是线程的数量将会被一个决定点的同步，当那些线程之一到达了决定点，它调用`await()` 方法等待其他线程，当线程调用该方法，`CyclicBarrier` 类阻塞线程，睡眠知道其他线程达到，当最后一个线程调用await() 方法时，它唤醒所有等待的线程，然后继续它的工作

一个有有趣的优点就是你可以传递一个额外的runnable对象作为一个初始化参数，该类执行这个对象作为一个线程，当所有的线程达到指定点，这个特性使得该类适合于使用除法和征服编程技术的任务的并行化。

#### 运行并发阶段任务

java并发API提供的最复杂和最强大的功能，就是可以执行并发阶段任务的能力

这个类就是`Phaser` 类，该类提供了一个机制，在每个步骤的结尾处同步线程，所以没有线程能开启下一个步骤，直到所有的线程都已经完成了第一个步骤

和其他同步工具类一样，我们必须初始化一个任务数，但是我们可以动态的修改这个数通过增加和减少

#### 在并发任务中改变数据

`Exchanger` 类允许两个并发任务之间交换数据



## 4. 线程执行器

创建Runnable对象和相应的线程对象来执行它们，这些有一些缺点的：

1. 你必须实现所有代码相关的信息来管理线程对象，创建，结束，获取数据
2. 你每次任务创建一个对象，如果你必须执行大量的任务。这会影响 你整个应用
3. 你必须有效的控制和管理计算机资源，如果你创建了太多的线程，你可能使系统饱和

从Java5开始，java并发api提供了一个机制来解决这类问题，这个机制叫做执行器框架，包括`Executor` 接口，子接口`ExecutorService` 和实现类`ThreadPoolExecutor` 

这种机制分开了任务的创建和执行，使用执行器，你只需要实现Runnable对象，然后发送它们到执行器，执行器来负责它们的执行，初始化和运行必要的线程

执行器框架另外一个重要的优点就是`Callable` 接口，它和Runnable接口相似，但是提供了两个改善：

1. 主要的方法`call()` 可能返回一个结果
2. 当你发送一个callable对象到一个执行器，你获得了一个对象实现了futrue接口，你可以使用该对象来控制callable对象的状态和结果

#### 创建一个线程执行器

1. ```java
   static ExecutorService newFixedThreadPool(int nThreads) //创建一个固定数目的线程池
   ```

2. ```java
   static ExecutorService newSingleThreadExecutor() //创建单个线程池
   ```

3. ```java
   static ExecutorService newCachedThreadPool() //创建缓存的线程池
   ```

4. ```java
   static ScheduledExecutorService newSingleThreadScheduledExecutor() // 创建单个线程调度执行器
   ```

5. ```java
   static ScheduledExecutorService newScheduledThreadPool(int corePoolSize) // 创建指定数目的调度线程池
   ```

6. ```java
   static ThreadFactory defaultThreadFactory() // 获取默认的线程工厂
   ```

7. ```java
   static Callable<Object> callable(Runnable task) //调用有返回结果的Runnable对象
   ```

`java.util.concurrent.ExecutorService` 的主要方法

```java
void shutdown();
List<Runnable> shutdownNow();
boolean isShutdown();
boolean isTerminated();
<T> Future<T> submit(Callable<T> task);
```

`getPoolSize()` 该方法返回执行器线程池中的实际线程数

`getActiveCount()` 该方法返回执行器中正在执行任务的线程数

`getCompletedTaskCount()` 该方法返回执行器已经完成的任务数

一般情况下，你必须显示的结束执行器，如果你不这样做，执行器将会继续执行，程序永远不会结束，如果执行器没有任务执行，它也会继续等待新的任务，但是不会结束执行器的执行，所以，你的应用程序也不会结束

使用`shutdown()` 方法来结束执行器

当你调用shutdown() 方法之后，如果你试图发送新的任务给执行器，该任务会被拒绝，然后执行器将会抛出一个`RejectedExecutionException` 异常

#### 创建一个固定大小的线程执行器

当你使用执行器类的`newCachedThreadPool()` 方法创建的基础的`ThreadPoolExecutor` 类，你可能会有一个线程数的问题，该执行器为每一个接收到的任务创建一个线程，如果你发送大量的任务，并且持续很长时间的话，你可能要造成系统过载

如果你想解决这个问题，执行器类提供了一个方法创建固定大小的线程执行器

该执行器有一个最大的线程数，如果你发送的任务操作了最大线程数，执行器不会创建额外的线程，剩余的的任务将会阻塞知道执行器有一个可用的线程

使用这个方法，你可以保证执行器不会给你的应用提供可怜的性能

`Executors.newFixedThreadPool(5);`

#### 在执行器中执行返回结果的任务

执行器框架的一个优点就是你可以运行返回结果的并发任务

java 并发API完成该功能使用以下两个接口：

1. Callable 该接口有call()方法，在这个方法中，你必须实现任务的逻辑，该接口是一个参数化接口，意味着你必须表明call方法将会返回的数据类型
2. Future： 该接口有一些方法可以获得callable对象产生的结果和管理它们的状态

你可以控制任务的状态，你可以取消任务和检查任务是否完成，你可以使用isDone()方法来检查任务是否完成

你可以获取由call()方法返回的结果，使用get()方法，这个方法会等待直到callable对象已经完成call方法的执行，并且已经返回了结果，如果当get方法在等待结果的时候线程中断了，它会抛出一个中断异常，如果call方法抛出了异常，该方法会抛出一个`ExecutionException` 异常

当你调用一个Future对象的get方法，但是这个对象还没有完成，该方法会阻塞直到任务完成

#### 运行多个任务处理第一个结果

在并发编程中一个常见的问题就是当你有不同的并发任务来解决同一个问题，你只感兴趣那些任务的第一个结果，例如，你想要排序一个数组，你有不同的排序算法，你可以加载所有。然后获取第一个排序的结果，也就是，最快的排序算法

```java
<T> T invokeAny(Collection<? extends Callable<T>> tasks)
```

#### 运行多个任务处理所有的结果

```java
<T> List<Future<T>> invokeAll(Collection<? extends Callable<T>> tasks)
```

#### 延迟执行任务

```java
public ScheduledFuture<?> schedule(Runnable command,
                                   long delay, TimeUnit unit);
```

#### 间隔的在一个执行器中运行任务

```
scheduleAtFixedRate();
```

```
scheduleWithFixedDelay();
```

#### 取消任务

当你和一个执行器一起工作的时候，你不需要管理线程，你需要实现Runnable或Callable接口，并把它们发送给执行器

这是执行器的责任来创建线程，在线程池中管理它们，完成它们，

有时，你也可以使用cancel()方法来取消任务

当你想要取消一个已经发送到执行器的任务时，你可以使用Future接口的cancel()方法，取决于cancel()方法的参数和任务的状态，该方法的行为是不同的：

1. 如果任务已经完成或者已经被取消或者不能被取消，该方法将会返回false，任务不能被取消
2. 如果任务在等待执行，任务被取消并永远不会开始执行，如果任务已经在运行，它取决于该方法的参数，cancel方法接收一个布尔值作为参数，如果该参数是true，并且任务在运行，它将会被取消，如果该值是false，并且任务在运行，它不会被取消

如果你使用Future对象的get方法来获取一个已经被取消的任务，get方法会抛出`CancellationException` 异常

#### 控制任务的完成

`FutureTask` 类提供了一个done()方法，允许你在任务执行终止之后执行一些代码

它可以被用来做一些后处理的操作，生成一个报告，发送一个邮件，或者释放一些资源

默认情况下，该方法是空的，你可以覆盖`FutureTask` 类实现该方法来改变行为

#### 分割任务的加载和结果的处理

一般来说，当你使用执行器来执行并发任务的时候，你会发送一个Runnable或Callable任务到执行器，然后获取Future对象来控制该方法，你可能会发现这种情形，你需要在一个对象发送任务到执行器，然后在另外一个对象处理结果

对于这样的情景，java并发API提供了`CompletionService` 类

该类有一个方法发送任务到执行器，一个方法来获取Future对象为下一个任务已经执行完毕的，

内部的，它使用Executor或对象来执行任务

#### 控制拒绝的任务

当你想要结束一个执行器的执行时，你使用shutdown()方法来表明它应该结束了

执行器等待正在运行和在等待执行的任务的完成

如果你在shutdown方法和执行的结束之间发送给执行器一个任务，任务会被拒绝，因为执行器不再接收任何新的任务。

`ThreadPoolExecutor` 类提供了一个机制，当一个任务被拒绝时调用

也就是`RejectedExecutionHandler`的使用

处理被拒绝的任务，你应该创建一个类实现`RejectedExecutionHandler` 接口，该接口有一个方法叫`rejectedExecution()` 有两个参数：

1. Runnable对象，存储已经被拒绝的任务
2. Executor对象，存储被拒绝任务的执行器

## 5. Fork/Join框架

这框架设计用来解决问题可以被划分成小的任务

在一个任务内部，你检查你想要解决的问题的大小，如果它大于初始值，你使用该框架把它划分成更小的任务，如果问题的大小 小于初始值，你可以直接解决它，可选的，可以返回一个结果

你可以把ForkJoinPool看做一个特殊的Executor

该框架基于以下两个操作

1. fork操作，当你把一个任务划分成更小的任务，然后使用该框架来执行它们
2. join操作，一个任务等待它已经创建的任务终止

Fork/Join和Executor框架的不同之处在于工作窃取算法

不像Executor框架，当一个任务使用join操作等待它已经创建的子任务的终止时，该线程会寻找其他还没有执行的任务，然后开始执行，按照这种方式，线程充分利用了运行时间，因此，提供了应用的性能

为了完成该目标，由Fork/Join框架执行的任务有以下限制：

1. 任务只能使用fork()和join()操作作为同步机制，如果使用其他同步机制，当它们在同步操作时，工作线程不能执行其他任务
2. 任务不应该执行I/O操作，像读和写文件
3. 任务不能抛出检查型异常，它必须包括必要的代码来处理

Fork/Join框架的核心由一下两个类组成：

1. ForkJoinPool：它实现了ExecutorService接口和工作窃取算法，它管理工作线程提供了任务状态的信息和它们的执行
2. ForkJoinTask： 将会在ForkJoinPool执行的任务的基类，它提供了在一个任务内部执行fork()和join()操作的机制，和控制任务的状态。通常来说，实现你自己的Fork/Join框架，你必须实现这两个类RecursiveAction 没有结果返回 RecursiveTask 返回一个结果

#### 创建一个Fork/Join pool

1. 创建一个ForkJoinPool对象来执行任务
2. 创建一个将要在pool中被执行的ForkJoinTask的子类
3. 你将要以同步的方式执行任务，当一个任务执行两个或多个子任务时，它等待它们的终止，按照这种方式，线程正在执行那个任务的线程会寻找其他任务来执行，充分利用它们的执行时间
4. 你将要实现的任务不会返回任何结果，所以才用RecursiveAction作为它们实现的基类

执行一个任务创建的子任务，调用invokeAll()方法，这是一个同步调用，任务会等待子任务的终止之后才会继续它的执行，当一个任务在等待子任务的时候，工作线程要执行其他要执行的任务，基于这种行为，fork/join框架提供了比Runnable和Callable对象本身更有效的任务管理

ForkJoinTask类的invokeAll方法是Executor和Fork/join框架的主要不同之一

ForkJoinPool类提供了其他方法来执行一个任务，这些方法如下：

1. execute(Runnable task) 这是另外一个版本的执行方法，在这个方法中，你发送一个Runnable任务到ForkJoinPool类，注意，ForkJoinPool类不会在Runnable对象上使用工作窃取算法，它只能被使用在ForkJoinTask对象上
2. invoke(ForkJoinTask task) 该方法会产生同步调用，不会返回，直到作为参数传递的任务完成执行
3. 你也可以使用invokeAll()和invokeAny()方法，这些方法接收Callable对象作为参数，ForkJoinPool类不会使用工作窃取算法在Callable对象上，所以你最好使用一个执行器来执行它们

#### 联合任务的结果

Fork/Join框架提供了执行任务返回结果的能力

这种类型的任务由`RecursiveTask` 实现，该类继承了ForkJOinTask类，实现了Future接口

ForkJoinPool提供了另外一种方法来完成任务的执行，并返回结果，这就是complete()方法