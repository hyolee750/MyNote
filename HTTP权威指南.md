Web客户端和服务端

资源

媒体类型

Web服务器会为所有的HTTP对象数据附加一个MIME类型，当Web浏览器从服务器中取回一个对象时，会去查看
相关的MIME类型，看看它是否知道应该如何处理这个对象

URI

服务器的资源名被称为统一资源标识符

URL

统一资源定位符是资源标识符最常见的形式，遵循一种标准格式，这种格式包含三个部分

  1. 方案 scheme 说明了访问资源所使用的协议类型，通常就是HTTP协议
  2. 给出了服务器的因特网地址
  3. 其余部分指定了Web服务器上的某个资源

事务

一个HTTP事务由一条(从客户端发往服务器的)请求命令和一个(从服务器发回客户端的)响应结果组成，这种通信
是通过名为HTTP报文的格式化数据块进行的

方法

状态码

报文的结构

包含以下三个部分

  1. 起始行 在请求报文中用来说明要做些什么，在响应报文中说明出现了什么情况
  2. 首部字段 有零个或多个首部字段，每个首部字段都包含一个名字和一个值，用冒号分割，首部以一个空行结束
  3. 主体 包含了所有类型的数据，请求主体中包括了要发送给web服务器的数据，响应主体中装载了要返回给客户端的数据

连接

TCP/IP

连接/IP地址/端口号

浏览器是怎样通过HTTP显示位于远端服务器中的某个简单的文档的

  1. 浏览器从URL中解析出服务器的主机名
  2. 浏览器将服务器的主机名转换成服务器的IP地址
  3. 浏览器将端口号从URL中解析出来
  4. 浏览器建立一条与Web服务器的TCP连接
  5. 浏览器向服务器发送一条HTTP请求报文
  6. 服务器向浏览器发回一条HTTP响应报文
  7. 关闭连接，浏览器显示文档

Web的结构组件

代理，缓存，网关，隧道，Agent代理

URL的语法

<scheme>://<user>:<password>@<host>:<port>/<path>;<params>?<query>#<frag>

最重要的三个部分是方案，主机和路径

URL字符集

默认使用的是ASCII字符集

编码机制：通过一种转义表示法来表示不安全的字符，这种转义表示法包含一个百分号，后面跟着两个表示字符ASCII码的十六进制数

字符限制

保留及受限的字符

  1. % 保留作为编码字符的转义标志
  2. / 保留作为路径组件中分割路径段的定界符
  3. .
  4. ..
  5. #
  6. ?
  7. ;
  8. :
  9. ............
