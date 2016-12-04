总是要学点什么才可以啊，不能一直玩游戏，今天的主要目标就是学习AMQP和Rabbitmq的用法

### 理解消息通信

#### 生产者和消费者

生产者创建消息，然后发布到代理服务器RabitMq，消息包含两部分内容，有效载荷和标签，有效载荷是你想要传输的数据，可以是任何内容，标签描述了有效载荷

消费者连接到代理服务器上，并订阅到队列上

#### 队列

AMQP消息路由必须有三部分，交换器，队列，绑定

生产者把消息发布到交换器上，消息最终到达队列，并被消费者接收，绑定决定了消息如何从路由器到特定的队列

当Rabbitmq队列拥有多个消费者时，队列收到的消息将会以循环的方式发送给消费者

每条消息只会发送给一个订阅的消费者

消费者收到的每一条消息都必须进行确认，消费者必须通过AMQP的`basic.ack`命令显式的向Rabbitmq发送一个确认，或者在订阅队列的时候就将`auto_ack`参数设置为true

一条消息被确认之前，rabbit会认为这个消费者并没有准备好接收下一条消息

如果消费者收到一条消息，在确认之前从rabbit断开连接，rabbitmq会认为这条消息没有分发，然后重新分发给下一个订阅的消费者

队列设置的另外一些有用的参数：

1. `exclusive` 如果设置为true的话，队列将变成私有的，此时只有你的应用程序才能够消费队列消息
2. `auto-delete` 当最后一个消费者取消订阅的时候，队列就会自动删除

如果尝试声明一个已经存在的队列，只要声明的参数完全匹配现存的队列的话，rabbit就什么都不做，并成功返回，就像这个队列已经创建成功一样

队列是AMQP消息通信的基础模块：

1. 为消息提供了处所，消息在此等待消费
2. 对负载均衡来说，队列是绝佳的方案，只需附加一堆消费者，并让rabbitmq以循环的方式均匀的分配发来的消息
3. 队列是rabbit中消息的最后终点

交换器，绑定，路由键 exchange，binding，routingkey

交换器的类型direct,fanout,topic,headers

回顾：

1. AMQP架构中最关键的几个组件分别是交换器，队列，绑定
2. 根据绑定规则将队列绑定到交换器上
3. 消息是发布到交换器上的
4. 有三种类型的交换器，direct.fanout,topic
5. 基于消息的路由键和交换器类型，服务器会决定将消息投递到哪个队列去

#### 多租户模式：虚拟主机和隔离

默认的vhost为"/",缺省的用户guest，缺省的密码guest

虚拟主机之间使绝对隔离的

使用rabbitmqctl add_vhost [vhostname] 来创建虚拟主机

使用rabbitmqctl delete_vhost [vhostname] 来删除虚拟主机

使用rabbitmqctl list_vhosts 来查看服务器上运行着哪些vhost


#### 持久化策略

每个队列和交换器的durable属性，该属性默认情况下为FALSE，它决定了rabbimq是否需要在崩溃或重启后重新创建队列或交换器

1. 把它的投递模式选项设置为2，持久
2. 发送到持久化的交换器
3. 到达持久化的队列

rabbitmq确保持久性消息能从服务器重启中恢复的方式是。将它们写入磁盘上的一个持久化日志文件，

要保证消息的投递这一关键本质决定了相对于其他类型的消息，会有更低的吞吐量

如果消费者应答未在合理时间范围内到达，生产者就重新发送消息

发送方确认模式

你需要告诉rabbit将信道设置成confirm模式，所有在信道上发布的消息都会被指派一个唯一的ID号，从1开始，

一旦消息被投递给所有匹配的队列后，信道会发送一耳光发送方确认模式给生产者的应用程序

发布者需要完成以下任务

1. 连接到RabbitMQ
2. 获取信道
3. 声明交换器
4. 创建消息
5. 发布消息
6. 关闭信道
7. 关闭连接

消费者需要完成以下任务

1. 连接到RabbitMQ
2. 获取信道
3. 声明交换器
4. 声明队列
5. 把队列和交换器绑定起来
6. 消费消息
7. 关闭信道
8. 关闭连接

使用发送方确认模式来确认投递

### 运行和管理Rabbit

1. 启动节点

   运行rabbitmq-server 启动节点，或者使用rabbitmq-server -detached以守护程序的方式在后台运行

2. 停止节点

   使用rabbitmqctl stop来停止节点，rabbitmqctl会和本地节点通信并指示其干净的关闭

#### 关闭和重启应用程序有何差别

rabbitmq-server同时启动了节点和应用程序

rabbitmqctl stop会把应用程序和节点同时关闭

停止rabbitmq，使用rabbitmqctl stop_app

#### rabbit配置文件

##### 管理用户

使用rabbitmqctl add_user [username] [password] 创建用户

使用rabbitmqctl delete_user [username] 删除用户

使用rabbitmqctl list_users 来查看当前服务器存在哪些用户

使用rabbitmqctl change_password [username] [newpassword] 来更改用户的密码

#### rabbitmq权限系统

读 有关消费消息的任何操作，包括清除整个队列

写 发布消息

配置 队列和交换器的创建和删除

AMQP命令

1. exchange.declare 声明交换器
2. exchange.delete 删除交换器
3. queue.declare 声明队列
4. queue.delete  删除队列
5. queue.bind 绑定队列
6. basic.publish 发布消息
7. basic.get 获取消息
8. basic.consume 消费消息
9. queue.purge 合并队列

使用rabbitmqctl set_permissions -p [vhost] [username] [config][w][r]

使用rabbitmqctl list_permissions -p [vhost]验证权限是否正确的赋予给了[vhost]

使用rabbitmqctl clear_permissions -p [vhost] [username] 移除用户在vhost上的权限

#### 检查

列出队列和消息数目 rabbitmqctl list_queues

Commands:
    stop [<pid_file>]
    stop_app
    start_app
    wait <pid_file>
    reset
    force_reset
    rotate_logs <suffix>
    hipe_compile <directory>
    
    join_cluster <clusternode> [--ram]
    cluster_status
    change_cluster_node_type disc | ram
    forget_cluster_node [--offline]
    rename_cluster_node oldnode1 newnode1 [oldnode2] [newnode2 ...]
    update_cluster_nodes clusternode
    force_boot
    sync_queue [-p <vhost>] queue
    cancel_sync_queue [-p <vhost>] queue
    purge_queue [-p <vhost>] queue
    set_cluster_name name
    
    add_user <username> <password>
    delete_user <username>
    change_password <username> <newpassword>
    clear_password <username>
    authenticate_user <username> <password>
    set_user_tags <username> <tag> ...
    list_users
    
    add_vhost <vhost>
    delete_vhost <vhost>
    list_vhosts [<vhostinfoitem> ...]
    set_permissions [-p <vhost>] <user> <conf> <write> <read>
    clear_permissions [-p <vhost>] <username>
    list_permissions [-p <vhost>]
    list_user_permissions <username>
    
    set_parameter [-p <vhost>] <component_name> <name> <value>
    clear_parameter [-p <vhost>] <component_name> <key>
    list_parameters [-p <vhost>]
    
    set_policy [-p <vhost>] [--priority <priority>] [--apply-to <apply-to>] <name> <pattern>  <definition>
    clear_policy [-p <vhost>] <name>
    list_policies [-p <vhost>]
    
    list_queues [-p <vhost>] [--offline|--online|--local] [<queueinfoitem> ...]
    list_exchanges [-p <vhost>] [<exchangeinfoitem> ...]
    list_bindings [-p <vhost>] [<bindinginfoitem> ...]
    list_connections [<connectioninfoitem> ...]
    list_channels [<channelinfoitem> ...]
    list_consumers [-p <vhost>]
    status
    node_health_check
    environment
    report
    eval <expr>
    
    close_connection <connectionpid> <explanation>
    trace_on [-p <vhost>]
    trace_off [-p <vhost>]
    set_vm_memory_high_watermark <fraction>
    set_vm_memory_high_watermark absolute <memory_limit>
    set_disk_free_limit <disk_limit>
    set_disk_free_limit mem_relative <fraction>
    encode [--decode] [<value>] [<passphrase>] [--list-ciphers] [--list-hashes] [--cipher <cipher>] [--hash <hash>] [--iterations <iterations>]

#### 理解RabbitMQ的日志

### 解决Rabbit相关问题：编码和模式

解耦：

1. 异步状态思维，分离请求和动作
2. 提供扩展性
3. 零成本API

发后即忘模型：

批处理任务：针对大型数据集合的工作或者转换，这种类型的任务可以构建为单一的任务请求，或者多个任务对数据集合的独立部分进行操作

通知： 对发生事件的描述，内容可以是消息的日志，也可以是以真实的报告通知给另外一个程序或者管理员

使用场景：

1. 告警框架，它允许基础架构中的应用生成管理员告警通知，你不需要担心他们需要发送到哪里以及如何到达
2. 将单张图片上传并将其转换成众多图片尺寸和格式

> 用无须应答的消息来触发工作
>

告警框架的设计

1. 选择什么样的AMQP交换器类型？ 应该使用fanout类型，然后为每种告警传输类型创建队列，好处是web应用不需要知道告警信息是如何投递给最终接收者的，它只是发布消息，然后继续工作，坏处是每个告警传输者都会得到一份拷贝，所以每次告警发生的时候，你都会被IM，文本消息等消息淹没
2. 为其创建三种严重级别的告警，info，warning，critical，使用topic交换器


### 使用reply_to来实现简单的JSON RPC

简单的API服务器，实现了一个ping应用，该方法的唯一功能是接收来自客户端的ping调用，发回一个pong应答，并携带了客户端初始调用的时间戳

要让RabbitMQ变成高可用有两种方式，一种是设置Rabbit集群，另外一种是扩大程序规模以提升性能

RabbitMQ会始终记录以下四种类型的内部元数据：

1. 队列元数据-队列的名称和它们的属性，是否可持久化，是否自动删除
2. 交换器元数据-交换器名称，类型和属性 
3. 绑定元数据-一张简单的表格展示了如何将消息由路由到队列
4. vhost元数据-为vhost内部的队列，交换器和绑定提供命名空间和安全属性

通过设置集群中的唯一节点来负责任何特定队列，只有该负责节点才会因队列消息而遭受磁盘活动的影响，所有其他节点需要将接收到的该队列的消息传递给该队列的所有者节点

