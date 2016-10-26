### Quartz学习笔记
时间：2016年10月25日 星期二
作者：李形形

Quartz 一个非常重要的调度框架，值得学习，今天我就打算完成对quartz的学习和理解

#### 第一课：使用Quartz
`Scheduler` 调度器

`Trigger`触发器

在使用任何调度器之前，你需要先实例化它，你可以使用`SchedulerFactory`来完成该功能。

一旦调度器被实例化，它可以被开始，置于待机模式和关闭

注意：一旦调度器被关闭，它需要重新实例化之后才能被重新启动

触发器不会启动(工作不会执行) 直到调度器已经被开始，也不当它处于暂停状态

```
SchedulerFactory schedFact = new org.quartz.impl.StdSchedulerFactory();

  Scheduler sched = schedFact.getScheduler();

  sched.start();

  // define the job and tie it to our HelloJob class
  JobDetail job = newJob(HelloJob.class)
      .withIdentity("myJob", "group1")
      .build();

  // Trigger the job to run now, and then every 40 seconds
  Trigger trigger = newTrigger()
      .withIdentity("myTrigger", "group1")
      .startNow()
      .withSchedule(simpleSchedule()
          .withIntervalInSeconds(40)
          .repeatForever())
      .build();

  // Tell quartz to schedule the job using our trigger
  sched.scheduleJob(job, trigger);
```
需要关注的接口和类有：
- `SchedulerFactory` 负责获得Scheduler对象实例的接口
- `StdSchedulerFactory` 标准实现了`SchedulerFactory`接口
- `JobDetail` 定义了具体的需要执行的工作
- `Trigger` 触发器，用来触发具体工作的执行
- `JobBuilder` 构建工作的构造者帮助类
- `TriggerBuilder` 构建触发器的构造者帮助类
- `SimpleScheduleBuilder` 简单调度构造者帮助类

#### 第二课：Quartz API，Jobs和Triggers

##### Quartz API
Quartz API的核心接口：
1. `Scheduler` 和调度交互的主API
2. `Job` 一个被组件实现的接口，你希望使用该调度执行的组件
3. `JobDetail` 用来定义Job的实例
4. `Trigger` 定义一个job将会被执行的调度
5. `JobBuilder` 用来定义`JobDetail`实例
6. `TriggerBuilder` 用来定义和构造`Trigger`实例

##### Jobs和Triggers
Job接口
```
public interface Job {

    public void execute(JobExecutionContext context)
      throws JobExecutionException;
  }
```

当Job的触发生效，`execute()`方法被调度器的工作线程之一调用，`JobExecutionContext`对象被传递到给方法提供给job实例信息关于运行环境
	
	一个处理调度器会执行的
	一个处理触发器触发执行
	job的`JobDetail`对象
	其他一些条目

最常用的触发器`SimpleTrigger`和`CronTrigger`

Jobs和Triggers被给确定的key当它们注册到Quartz调度器上

`JobKey`和`TriggerKey`允许它们被放进groups里，对于按类别组织Jobs和Triggers非常有用。job和Triggers的key在同一个组里必须是唯一的

#### 第三课： 更多关于Jobs和JobDetail

JobDetail包含的属性
1. `JobKey` 包含job的名称和组名称
2. `description` 该job的描述信息
3. `jobClass` 该job实例的class信息
4. `durability` 是否可持久化
5. `shouldRecover` 是否应该恢复的
6. `jobDataMap` 保存数据的map

JobDataMap 可以被用来保存你希望当job实例执行时可用的任意数量的数据对象

`JobExecutionContext` 这个对象厉害了，基本上可以获取Quartz所有的组件了

job状态和并发

1. `@DisallowConcurrentExecution` 禁用并发执行
2. `@PersistJobDataAfterExecution` job执行后持久化数据

#### 第四课：更多关于Triggers

常用Triggers的属性
1. `jobKey` 当触发器启动时应该被执行的job的id
2. `startTime` 触发器第一次产生效果的时间
3. `endTime` 触发器不再生效的时间

#### 第五课：SimpleTrigger

包含以下属性
1. `start-time` 开始时间
2. `end-time` 结束时间
3. 重复次数
4. 重复间隔

#### 第六课：CronTrigger
cron表达式 这个已经算是掌握了，就不写了

#### 第七课： TriggerListeners 和 JobListeners
触发器相关的事件：触发点火，触发失火，触发完成
```
public interface TriggerListener {

    public String getName();

    public void triggerFired(Trigger trigger, JobExecutionContext context);

    public boolean vetoJobExecution(Trigger trigger, JobExecutionContext context);

    public void triggerMisfired(Trigger trigger);

    public void triggerComplete(Trigger trigger, JobExecutionContext context,
            int triggerInstructionCode);
}
```
job相关的事件：即将执行的通知，执行已经完成的通知
```
public interface JobListener {

    public String getName();

    public void jobToBeExecuted(JobExecutionContext context);

    public void jobExecutionVetoed(JobExecutionContext context);

    public void jobWasExecuted(JobExecutionContext context,
            JobExecutionException jobException);

}
```

使用自己的监听器

为了便捷，可以继承`JobListenerSupport`或`TriggerListenerSupport`类，简单的覆盖你感兴趣的事件

增加一个`JobListener`到一个具体的job
`scheduler.getListenerManager().addJobListener(myJobListener, KeyMatcher.jobKeyEquals(new JobKey("myJobName", "myJobGroup")));`

#### 第八课：SchedulerListeners
调度器包含的事件：job/trigger的添加，删除，调度器的严重错误，调度器关闭的通知

添加一个`SchedulerListener`

`scheduler.getListenerManager().addSchedulerListener(mySchedListener);`

删除一个`SchedulerListener`

`scheduler.getListenerManager().removeSchedulerListener(mySchedListener);`

#### 第九课：Job Stores
RAMJobStore 是最简单的jobStore，也是最高性能的，它保存所有的数据在RAM中
配置Quartz使用RAMJobStore

`org.quartz.jobStore.class = org.quartz.simpl.RAMJobStore`

JDBCJobStore

配置Quartz使用JDBCJobStore

`org.quartz.jobStore.class = org.quartz.impl.jdbcjobstore.JobStoreTX`

配置JDBCJobStore使用DriverDelegate

`org.quartz.jobStore.driverDelegateClass = org.quartz.impl.jdbcjobstore.StdJDBCDelegate`

配置JDBCJobStore的表的前缀

`org.quartz.jobStore.tablePrefix = QRTZ_`

配置JDBCJobStore使用的数据源的名称

`org.quartz.jobStore.dataSource = myDS`

