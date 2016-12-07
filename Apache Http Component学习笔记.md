# Apache HttpComponents 学习

主要学习其中的设计思想，复习Java的面向对象的三大特征：封装，继承和多态，学习其中用到了哪些设计模式，同时加深自己对HTTP概念的认识

[TOC]

## 第一部分 HttpCore

### 第1章 基础原理

#### 1.1 HTTP消息

##### 1.1.1 结构

一个HTTP消息包含一个消息头`header`和 一个可选的消息体`body`。一个HTTP请求的消息头包含一个**请求行** 和多个**消息头** 字段。一个HTTP响应的消息头包含一个**状态行** 和多个**消息头** 字段。所有的HTTP消息都必须包含协议版本，一些HTTP消息可选的包含一个**内容体** 

##### 1.1.2 基本操作

###### 1.1.2.1 HTTP请求消息

HTTP请求是一个从客户端发送到服务端的消息，消息的首行包含资源使用的方法，资源的定位符和使用的协议版本

接口`org.apache.http.HttpRequest`

抽象类 `org.apache.http.message.AbstractHttpMessage`

具体实现`org.apache.http.message.BasicHttpRequest`

```java
HttpRequest request = new BasicHttpRequest("GET", "/",
 HttpVersion.HTTP_1_1);
System.out.println(request.getRequestLine().getMethod());
System.out.println(request.getRequestLine().getUri());
System.out.println(request.getProtocolVersion());
System.out.println(request.getRequestLine().toString());
```

###### 1.1.2.2 HTTP响应消息

HTTP响应是服务器在接收并解释请求消息之后发送回客户端的消息。消息的首行包含协议版本，一个状态码和相关的文本短语

接口`org.apache.http.HttpResponse`

```java
HttpResponse response = new BasicHttpResponse(HttpVersion.HTTP_1_1,
 HttpStatus.SC_OK, "OK");
System.out.println(response.getProtocolVersion());
System.out.println(response.getStatusLine().getStatusCode());
System.out.println(response.getStatusLine().getReasonPhrase());
System.out.println(response.getStatusLine().toString());
```

介绍一些常量对象

`org.apache.http.HttpVersion`代表一个HTTP版本，HTTP使用`major.minor`号码模式来表明协议的版本

`org.apache.http.HttpStatus` 这个挺重要的，代表HTTP状态码的常量

###### 1.1.2.3 HTTP消息常用的属性和方法

一个HTTP消息可以包含数个消息头描述消息的属性，例如内容长度，内容类型等等，HttpCore提供了方法来获取，添加，删除和遍历这样的消息头

```java
HttpResponse response = new BasicHttpResponse(HttpVersion.HTTP_1_1,
 HttpStatus.SC_OK, "OK");
response.addHeader("Set-Cookie",
 "c1=a; path=/; domain=localhost");
response.addHeader("Set-Cookie",
 "c2=b; path=\"/\", c3=c; domain=\"localhost\"");
Header h1 = response.getFirstHeader("Set-Cookie");
System.out.println(h1);
Header h2 = response.getLastHeader("Set-Cookie");
System.out.println(h2);
Header[] hs = response.getHeaders("Set-Cookie");
System.out.println(hs.length);
```

有一个更有效的方式来获取所有给定类型的消息头，使用`HeaderIterator`接口

```java
HeaderIterator it = response.headerIterator("Set-Cookie");
while (it.hasNext()) {
 System.out.println(it.next());
}
```

也提供了便捷的方法来解析HTTP消息到独立的消息头元素中

```java
HeaderElementIterator it = new BasicHeaderElementIterator(
 response.headerIterator("Set-Cookie"));
while (it.hasNext()) {
 HeaderElement elem = it.nextElement();
 System.out.println(elem.getName() + " = " + elem.getValue());
 NameValuePair[] params = elem.getParameters();
 for (int i = 0; i < params.length; i++) {
 System.out.println(" " + params[i]);
 }
```

##### 1.1.3 HTTP实体

HTTP消息可以携带一个与请求或响应相关的内容实体。实体可以在部分请求和响应中发现，因为实体是可选的，请求使用实体被看做包围实体的请求，HTTP规范定义了两种包围实体的方法：**POST** 和**PUT** 。响应通常被期望可以包含一个内容实体。该规则有一些例外，比如响应到HEAD方法和204 No Content ，304 Not Modified，205 Reset Content响应

HttpCore根据它们的内容来源，分成三种类型的实体：

- 基于流的： 内容从一个流中接收或者即时生成。流实体通常是不可重复的
- 自我包含的： 内容保存在内存中，或者通过不依赖连接或其他实体的方法取得，自我包含的实体通常是可重复的
- 包装： 实体从另外一个实体中取得

###### 1.1.3.1 可重复的实体

一个实体可以是可重复的，意味着它的内容可以被多次读取，只有自我包含的实体可以，像`ByteArrayEntity`和`StringEntity`

###### 1.1.3.2 使用HTTP实体

因为一个实体可以被二进制数据和文本内容所表示，它支持字符编码

当执行一个包含内容的请求或者当请求成功，响应体用来发送结果到客户端的时候，实体被创建了

从一个实体中读取内容，可以通过`HttpEntity#getContent()`方法获取一个输入流，或者通过` HttpEntity#writeTo(OutputStream)`方法写到一个输出流，注意，一些非流的实体不能有效的描述它们的内容作为一个`java.io.InputStream`，这样是不合法的，会抛出异常。

`EntityUtils`暴露了几个静态方法来简化从实体中提取内容或信息

```java
StringEntity myEntity = new StringEntity("important message",
 Consts.UTF_8);
System.out.println(myEntity.getContentType());
System.out.println(myEntity.getContentLength());
System.out.println(EntityUtils.toString(myEntity));
System.out.println(EntityUtils.toByteArray(myEntity).length);
```

###### 1.1.3.3 确保系统资源的释放

为了确保系统资源的恰当释放，必须关闭和实体相关的内容流

```java
HttpResponse response;
HttpEntity entity = response.getEntity();
if (entity != null) {
 InputStream instream = entity.getContent();
 try {
 // do something useful
 } finally {
 instream.close();
 }
```

当工作于流实体的时候，可以使用` EntityUtils#consume(HttpEntity)`方法确保实体内容已经被完全消费，相应的流已经被关闭

##### 1.1.4 创建实体

有多种方式创建实体，HttpCore提供了以下实现：

- `BasicHttpEntity`
- `ByteArrayEntity`
- `StringEntity`
- `InputStreamEntity`
- `FileEntity`
- `EntityTemplate`
- `HttpEntityWrapper`
- `BufferedHttpEntity`

###### 1.1.4.1 `BasicHttpEntity`

正如名称所暗示的，这个基本实体表示基础流,一般情况下，使用该类从HTTP消息中接收实体

该实体有一个空的构造器，经过构造之后，它代表没有内容，有一个负的内容长度

一个需要设置内容流和可选的长度，可以使用相应的` BasicHttpEntity#setContent(InputStream)`和` BasicHttpEntity#setContentLength(long)`方法

```java
BasicHttpEntity myEntity = new BasicHttpEntity();
myEntity.setContent(someInputStream);
myEntity.setContentLength(340); // sets the length to 340
```

###### 1.1.4.2 `ByteArrayEntity`

ByteArrayEntity是自给自足的，可重复的实体从一个给定的字节数组获取内容，设置字节数组到该类的构造器

```java
ByteArrayEntity myEntity = new ByteArrayEntity(new byte[] {1,2,3},
 ContentType.APPLICATION_OCTET_STREAM);
```

###### 1.1.4.3 `StringEntity`

StringEntity是自给自足的，可重复的实体，从一个`java.lang.String`对象获取内容，它有三个构造方法，第一个简单的使用给定的`java.lang.String` 对象构造，第二个包含一个字符编码，第三个允许设置具体的媒体类型

```java
StringBuilder sb = new StringBuilder();
Map<String, String> env = System.getenv();
for (Map.Entry<String, String> envEntry : env.entrySet()) {
 sb.append(envEntry.getKey())
 .append(": ").append(envEntry.getValue())
 .append("\r\n");
}
// construct without a character encoding (defaults to ISO-8859-1)
HttpEntity myEntity1 = new StringEntity(sb.toString());
// alternatively construct with an encoding (mime type defaults to "text/plain")
HttpEntity myEntity2 = new StringEntity(sb.toString(), Consts.UTF_8);
// alternatively construct with an encoding and a mime type
HttpEntity myEntity3 = new StringEntity(sb.toString(),
 ContentType.create("text/plain", Consts.UTF_8));
```

###### 1.1.4.4 `InputStreamEntity`

InputStreamEntity是一个流的，不可重复的实体，从一个输入流获取内容，提供一个输入流和内容长度来构造

```java
InputStream instream = getSomeInputStream();
InputStreamEntity myEntity = new InputStreamEntity(instream, 16);
```

###### 1.1.4.5 `FileEntity`

FileEntity是一个自给自足的，可重复的实体，从一个文件获取内容，通过使用该实体用来流化不同类型的大文件，你需要设置文件的内容类型，例如，发送一个zip文件，需要设置内容类型为`application/zip`，对于XML来说是`application/xml`

```java
HttpEntity entity = new FileEntity(staticFile,
 ContentType.create("application/java-archive"));
```

###### 1.1.4.6 `HttpEntityWrapper`

这是基类创建包装的实体，包装的实体持有一个引用到一个被包装的实体，并且委托所有的调用到该对象，包装实体的实现可以从这个类和需要仅覆盖那些不应该委托给包装实体的方法

###### 1.1.4.7 `BufferedHttpEntity`

BufferedHttpEntity是HttpEntityWrapper的子类，提供另一个实体来构造它，它从提供的实体中读取内容，然后缓存到内存中

这可以使从一个非重复的实体创建一个可重复的实体成为可能，如果提供的实体已经是可重复的，它仅仅传递调用给响应的实体

```java
myNonRepeatableEntity.setContent(someInputStream);
BufferedHttpEntity myBufferedEntity = new BufferedHttpEntity(myNonRepeatableEntity);
```

#### 1.2 HTTP协议处理器

HTTP协议拦截器是实现HTTP协议的特定方面的例程