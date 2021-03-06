### Nginx的功能特性
可以作为**HTTP服务器**，也可以作为**反向代理服务器**或**邮件服务器**。能够快速响应静态页面的请求，支持FastCGI，SSL，Virtual Host，URL Rewrite，HTTP Basic Auth，Gzip等大量实用功能，并且支持更多的第三方功能模块的扩展。

基本功能服务从大体上归纳为基本HTTP服务，高级HTTP服务和邮件服务

1. 提供基本的HTTP服务，可以作为HTTP代理服务器和反向代理服务器，支持通过缓存加速访问，可以完成简单的负载均衡和容错，支持包过滤功能，支持SSL
2. 提供高级HTTP服务，可以进行自定义配置，支持虚拟主机，支持URL重定向，支持网络监控，支持流媒体传输
3. 作为邮件服务器，支持IMAP/POP3代理服务功能，支持内部SMTP代理服务功能

常用功能介绍
1. HTTP代理和反向代理
2. 负载均衡

  负载均衡策略可以划分为两大类即内置策略和扩展策略，内置策略包括轮询，加权轮询和IP hash三种

  1. 轮询策略：将每个前端请求按顺序逐一分配到不同的后端节点上，对于出现问题的后端节点自动排除
  2. 加权轮询策略：在基本的轮询策略上考虑各后端节点接受请求的权重，指定到各后端节点的几率
  3. IP hash策略，是将前端访问的ip进行hash操作，然后根据hash结果将请求分配给不同的后端节点
  
3.  Web缓存

### Nginx服务的启动停止控制

1. 通过信号机制来实现

  Nginx服务在运行时，会保持一个主进程和一个或多个worker process工作进程。通过给Nginx服务的主进程发送信号就可以控制服务的启动和停止

  使用`ps -ef|grep nginx`来获取Ngin服务主进程的PID

  Nginx服务可接收的信号：
  1. TERM 或 INT 快速停止Nginx服务
  2. QUIT 平缓停止Nginx服务
  3. HUP 使用新的配置文件启动进程，之后平缓停止原有进程，也就是所谓的平滑重启
  4. USR1 重新打开日志文件，常用于日志切割
  5. USR2 使用新版本的Nginx文件启动服务，之后平缓停止原有的Nginx进程，也就是所谓的平滑升级
  6. WINCH 平缓停止worker process，用于Nginx服务器平滑升级

  使用kill命令发送信号：`kill SINGAL PID`
2. Nginx服务的启动

  Nginx命令
  1. -？，-h 显示该帮助信息
  2. -v 打印版本号并退出
  3. -V 打印版本号和配置并退出
  4. -t 测试配置正确性并退出
  5. -q 配置测试时只显示错误
  6. -s signal 向主进程发送信号
  7. -p prefix 指定Nginx服务器路径前缀
  8. -c filename 指定Nginx配置文件路径
  9. -g 指定Nginx附加配置文件路径

  启动Nginx服务：`./sbin/nginx `

3. Nginx服务的停止

  `./sbin/nginx -g TERM | INT | QUIT`

4. Nginx服务的重启

  `./sbin/nginx -g HUP [-c newConfFile]`

5. Nginx服务器的升级

  `./sbin/nginx -g USR2`

### Nginx服务器基础配置指令
nginx.conf的内容和基本配置方法

nginx.conf一共由三部分组成，分别为全局块，events块和http块

在http块又包含http全局块，多个server块

每个server块可以包含server全局块和多个location块

```
#user  nobody;
worker_processes  1;

#error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;

#pid        logs/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       mime.types;
    default_type  application/octet-stream;

    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent" "$http_x_forwarded_for"';

    #access_log  logs/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    keepalive_timeout  65;

    #gzip  on;

    server {
        listen       80;
        server_name  localhost;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;

        location / {
            root   html;
            index  index.html index.htm;
        }

        #error_page  404              /404.html;

        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }

        # proxy the PHP scripts to Apache listening on 127.0.0.1:80
        #
        #location ~ \.php$ {
        #    proxy_pass   http://127.0.0.1;
        #}

        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        #
        #location ~ \.php$ {
        #    root           html;
        #    fastcgi_pass   127.0.0.1:9000;
        #    fastcgi_index  index.php;
        #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
        #    include        fastcgi_params;
        #}

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        #location ~ /\.ht {
        #    deny  all;
        #}
    }


    # another virtual host using mix of IP-, name-, and port-based configuration
    #
    #server {
    #    listen       8000;
    #    listen       somename:8080;
    #    server_name  somename  alias  another.alias;

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}


    # HTTPS server
    #
    #server {
    #    listen       443 ssl;
    #    server_name  localhost;

    #    ssl_certificate      cert.pem;
    #    ssl_certificate_key  cert.key;

    #    ssl_session_cache    shared:SSL:1m;
    #    ssl_session_timeout  5m;

    #    ssl_ciphers  HIGH:!aNULL:!MD5;
    #    ssl_prefer_server_ciphers  on;

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}

}

```

各个块的作用：
1. 全局块

  主要设置一些影响Nginx服务器整体运行的配置指令，作用域是Nginx服务器全局

  通常包括配置运行Nginx服务器的用户组，允许生成的worker process数，Nginx进程PID存放路径，日志存放路径和类型以及配置文件的引入

2. events块

  主要影响Nginx服务器于用户的网络连接，常用的设置包括是否开启对多worker process下的网络连接进行序列化，是否允许同时接收多个网络连接，选取哪种事件驱动模型处理连接请求，每个worker process可以同时支持最大的连接数

  这一部分的指令对Nginx服务器的性能影响较大

3. http块

  代理，缓存和日志定义等绝大多数功能和第三方模块的配置都可以放在这个模块中

  配置文件引入，Mime类型定义，日志自定义，是否使用sendfile传输文件，连接超时时间，单连接请求数上限

4. server块

  每一个http块都可以包含多个server块，而每个server块就相当于一台虚拟主机
  它内部可有多台主机联合提供服务

5. location块

  location其实是server块的一个指令，基于Nginx服务器接受到的请求字符串例如`server_name/uri-string`
  对除虚拟主机名称之外的字符串进行匹配

  对特定请求进行处理，地址定向，数据缓存和应答控制等功能

### 全局配置
user
worker_processses
pid
error_log

#### 配置运行Nginx服务器用户(组)
指令user,其语法格式为： user username [group]

username 指定可以运行Nginx服务器的用户
group 可选项，指定可以运行Nginx服务器的用户组

只有被设置的用户或者用户组才有权限启动Nginx进程，如果是其他用户尝试启动，将会报错

希望所有用户都可以启动Nginx进程，有两种办法，一，将此指令注释掉，二，将用户设置为nobody
这也是user指令的默认配置，user指令只能在全局块中配置

#### 配置允许生成的worker process数
指令 worker_processses number | auto;

number 指定Nginx进程最多可以产生worker process数

auto 设置此值，Nginx进程将自动检测

#### 配置Nginx进程PID存放路径
Nginx进程作为系统的守护进程运行，我们需要在某文件中保存当前运行程序的主进程号

指令 `pid file` 。 例如 pid logs/nginx.pid;

#### 配置错误日志的存放路径
指令`error_log logs/error.log error;`

#### 配置文件的引入
指令 `include file；`

### events块 配置

#### 设置网络连接的序列化
指令 `accept_mutex on | off` 当其设置为开启的时候，将会对多个Nginx进程接收连接进行序列化，防止多个进程对连接的争抢

#### 设置是否允许同时接收多个网络连接
`multi_accept on | off` 此指令默认为关闭状态，即每个worker process一次只能接收一个新到达的网络连接

#### 事件驱动模型的选择
指令 `use method；` 其中method可以选择select，poll，kqueue，epoll，rtsig，/dev/poll以及eventport

#### 配置最大连接数
`worker_connections number;`

#### 定义MIME类型


### Nginx服务器基础配置实例
nginx.conf 文件的完整内容
```
### 全局块开始 ###
user nobody nobody;       # 配置允许运行Nginx服务器的用户和用户组
worker_processes 3;       # 配置允许Nginx进程生成的worker process数
error_log logs/error.log; # 配置Nginx服务器运行对错误日志的存放路径
pid  nginx.pid;           # 配置Nginx服务器运行时pid文件的存放路径和名称
### 全局块结束 ###

### events块开始 ###
events
{
  use epoll;              # 配置事件驱动模型
  worker_connections 1024;# 配置最大连接数
}
### events块结束 ###
### http块开始 ###
http {
  inclue mime.types;
  default_type application/octet-stream;
  sendfile on;
  keepalive_timeout 65;
  log_format access_log '$remote_addr-[$time_local]-"$request"-"$http_user_agent"';
  ### server块开始　###
  ## 配置虚拟主机myServer1
  server{
    listen 8081;
    server_name myServer1;
    access_log /myWeb/server1/log/access.log;
    error_page 404 /404.html;
    location /server1/location1 {
      root /myWeb;
      index index.svr1-loc1.html;
    }

    location /server1/location2 {
      root /myWeb;
      index index.svr1-loc2.html;
    }
  }
}

```
