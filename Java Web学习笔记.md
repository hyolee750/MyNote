### 第三章 写你的第一个Servlet

####创建一个Servlet类
- 该继承什么
- 使用初始化和销毁方法

#### 配置Servlet并部署



*******************************
# 第三章  写你的第一个Servlet

这一章的主要内容

1.	 创建一个Servlet类
2.	 配置一个Servlet部署
3.	 理解`doGet()`,`doPost()`和其他方法
4.	 使用参数和接受表单提交
5.	 使用初始化参数配置应用
6.	 从表单上传文件
7. 	使你的应用在多线程中安全

## 创建一个Servlet类

Servlet是一个小的java程序运行在web服务器上，使用HTTP协议来接受和响应web客户端的请求。	

每一个`Servlet` 实现了`javax.servlet.Servlet`接口。

Servlet是一个简单的接口，包含了初始化和销毁Servlet，服务请求的方法

毫无疑问，你的Servlet将总是继承`HttpServlet`。它提供了所有你需要的工具来接收和响应不同类型的HTTP请求，它的方法接收`javax.servelt.HttpServletRequest`和`javax.servlet.HttpServletResponse`参数，你可以很容易的访问具体的HTTP属性。

默认情况下，Servlet接收到第一次请求才会调用`init()`方法

而当Servlet不再接收任何请求时会立即调用`destroy()`方法，比如web应用停止了，或者web容器关闭了

### 获取请求参数

`getParameter` 返回一个参数的单个值,如果该参数有多个值，返回第一个
`getParameterValues`返回该参数的值的数组，如果该参数只有一个值，则返回包含该一个值的数组
`getParameterMap` 返回一个`java.util.Map<String,String[]>`对象，包含所有的参数和其对应的值
`getParameterNames`返回所有可用参数的枚举，用来迭代所有的请求参数

`getContentType`返回请求的MIME 类型
`getContentLength` 返回请求体的字节长度
`getCharacterEncoding` 返回请求内容的字符编码
`getInputStream` 返回一个`javax.servlet.ServeltInputStream`
`getReader` 返回一个`java.io.BufferReader`，都可以用来读取请求的内容
`getRequestURL`返回整个URL，包括协议，服务器名，端口号，服务路径，但是不包含查询参数
`getRequestURI`只会返回URL的路径部分
`getServletPath`获取servlet的路径
`getHeader` 获取消息头
`getHeaderNames`返回请求头中名称的枚举
`getIntHeader` 获取整型类型的消息头
`getDateHeader` 获取日期类型的消息头
`getSession` 获取Session对象
`getCookie` 获取Cookie对象

### 使用`HttpServletResponse`

作用：
	1. 设置响应头
	2. 写响应体
	3. 重定向请求
	4. 设置HTTP状态码
	5. 设置发送到客户端的Cookie
	
`getOutputStream` 获取`javax.servlet.ServletOutputStream`对象
`getWriter` 获取`java.io.PrintWriter`对象
`setContentType`设置内容类型
`setCharacterEncoding`设置字符编码
`setHeader` 设置消息头
`setIntHeader` 设置整型消息头
`setDateHeader`设置日期类型的消息头
`addHeader` 和`addIntHeader`和`addDateHeader` 这样只会添加，而不会覆盖已有的值
