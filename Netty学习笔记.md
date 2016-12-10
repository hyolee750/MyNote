# Netty in Action学习笔记

写一个Echo Server包含以下两个主要部分：

1. 初始化-配置server功能，像线程和端口
2. 实现server handler

步骤：

1. 创建一个`ServerBootstrap`实例初始化服务端并在稍后绑定它
2. 创建和假定`NioEventLoopGroup` 实例来处理事件处理，像接收新的连接，接收数据，写数据等等
3. 定义一个本地的`InetSocketAddress` 到server绑定
4. 建立了一个`childHandler` 执行每次请求的连接
5. 经过每件事都完成了，调用`ServerBootstrap.bind( )` 绑定到服务端

```java
// 1. 事件循环组
EventLoopGroup group = new NioEventLoopGroup();
ServerBootstrap b = new ServerBootstrap();
b.group(group)
  .channel(NioServerSocketChannel.class)
  .localAddress(new InetSocketAddress(port))
  .childHandler(new ChannelInitializer<SocketChannel>() {
    @Override
    protected void initChannel(SocketChannel ch) throws Exception {
      ch.pipeline().addLast(new EchoServerHandler());
    }
  });
final ChannelFuture channelFuture = b.bind().sync();
System.out.println(EchoServer.class.getName() + " started and listen on " + channelFuture.channel().localAddress());
channelFuture.channel().closeFuture().sync();
group.shutdownGracefully().sync();
```

