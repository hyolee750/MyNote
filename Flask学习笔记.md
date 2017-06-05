# Flask Web Development

## 第一部分 Flask介绍

### 第一章 安装

Flask是一个是一个小框架，按照大部分标准，足够小的 也叫做微框架

它是足够小的，一旦你熟悉了它，你可能阅读和理解它所有的源代码。

但是小不意味着它比其他框架做的事情少。Flask被设计为一个可扩展的框架，它提供了基本服务的坚固的核心，其他由扩展提供，因为你可以选择你想要的扩展包

Flask有两个主要依赖，来自于`Werkzeug`的路由，调试和WSGI。模式支持由`Jinja2`提供

在这一章，我们将学会如何安装Flask。唯一的要求就是你的电脑已经安装了Python

#### 使用虚拟环境

最便捷的方式安装Flask就是使用一个虚拟环境

使用第三方的`virtualenv`工具箱可以创建虚拟环境。为了检查你的系统是否已经安装了该工具，输入以下命令

```shell
$ virtualenv --version
```

如果你获得一个错误，你必须安装这个工具箱

使用以下命令进行安装

```shell
$ sudo apt-get install python-virtualenv
```

下一步是创建Python虚拟环境，该命令只有一个必须的参数：虚拟环境的名称

一个常用的虚拟环境的命名约束就是叫它们`venv`：

```shell
$ virtualenv venv
New python executable in venv/bin/python2.7
Also creating executable in venv/bin/python
Installing setuptools............done.
Installing pip...............done.
```

如果要指定Python的版本，可以使用以下的命令

```shell
$ virtualenv -p /usr/bin/python3 venv
```

使用	以下命令激活虚拟环境

```shell
$ source venv/bin/activate
```

当你想要退出虚拟环境，返回全局的Python解释器，使用以下命令

```shell
deactivate
```

#### 使用pip安装Python包

安装Flask到虚拟环境，使用以下命令

```shell
(venv) $ pip install flask
```

校验Flask是否正确安装，使用以下命令

```shell
(venv) $ python3
>>> import flask
>>>
```

如果没有报错，说明安装成功了

### 第二章 基本应用结构

在这一章，你将会了解到一个Flask应用的不同组成部分。你也会编写和运行你的第一个Flask Web应用

#### 初始化

所有的Flask应用都必须创建一个**应用实例**。Web服务器会把它从客户端接收的所有请求传递给这个对象进行处理，使用承恩叫`WSGI`的协议。应用实例是一个`Flask`类的对象。通常由下面语句创建

```python
from flask import Flask
app = Flask(__name__)
```

Flask类的构造器唯一必须的参数就是主模块或应用的包的名称，对于大多数应用来说，Python的`__name__`变量是正确的值。

#### 路由和视图函数

客户端像网页浏览器发送请求到服务器，然后发送它们到Flask的应用实例。应用实例需要知道需要哪些代码来运行每个URL请求，所以它会保存一个URL到Python函数的映射。一个URL和处理它的函数之间的联系就叫做路由

在Flask应用中最容易的方法定义路由就是通过`app.route`装饰器，注册被装饰的函数作为一个路由。

```python
@app.route('/')
def index():
    return '<h1>Hello World!</h1>'
```

像`index()`这样的函数叫做**视图函数**，由一个视图函数返回的响应可以是一个简单的HTML内容的字符串，也可以是更复杂的形式

Flask通过在`route`装饰器中使用特殊的语法支持带有路径变量的URL。

```python
@app.route('/user/<name>')
def user(name):
    return '<h1>Hello, %s!</h1>' % name
```

在路由中的动态组件默认是字符串的，但是你也可以定义其他类型，例如，路由`/user/<int:id>`将会只匹配URL的id动态片段有一个整数的URL

Flask支持的类型有`int`.`float`,`path`

#### 启动服务

应用实例有一个`run`方法加载Flask集成的web 开发服务器

```python
if __name__ == '__main__':
	app.run(debug=True)
```

`__name__ == '__main__'`Python的惯用方法来确保当该脚本被直接执行时才会启动Web服务器

非常容易启用调试模式，使用debug 设置成True

#### 一个完整的应用

```python
from flask import Flask
app = Flask(__name__)

@app.route('/')
def index():
	return '<h1>Hello World!</h1>'

if __name__ == '__main__':
	app.run(debug=True)
```

为了运行应用，确保虚拟环境已激活，Flask已安装。

使用以下命令启动应用

```python
(venv) $ python3 hello.py
* Running on http://127.0.0.1:5000/
* Restarting with reloader
```

应用增强的版本增加了第二个路由是动态的，当你访问这个URL，你会看到一个个人的问候

```python
from flask import Flask
app = Flask(__name__)

@app.route('/')
def index():
	return '<h1>Hello World!</h1>'

@app.route('/user/<name>')
def user(name):
	return '<h1>Hello, %s!</h1>' % name

if __name__ == '__main__':
	app.run(debug=True)
```

#### 请求-响应循环

现在你已经学会了Flask的基础，你可能想要知道更多Flask是如何工作的，下面的部分描述了这个框架的一些设计的方面

##### 应用和请求上下文

当Flask从客户端接收一个请求，它需要使一些对象对处理请求的视图函数可用。一个好的例子就是`请求对象`	，封装了由客户端发送的HTTP请求。

Flask使用上下文来暂时的使特定的对象全局可访问，多亏了上下文，视图函数可以写成下面的样子：

```python
from flask import request

@app.route('/')
def index():
    user_agent = request.headers.get('User-Agent')
    return '<p>Your browser is %s</p>' % user_agent
```

上下文可以让Flask对特定的变量让一个线程全局访问而不用受到其他线程的干扰

在Flask中有两个上下文：*应用上下文*和*请求上下文*。

| 变量名         | 上下文   | 描述                                |
| ----------- | ----- | --------------------------------- |
| current_app | 应用上下文 | 激活应用的应用实例                         |
| g           | 应用上下文 | 一个应用在处理请求时用来临时存储的对象，这个变量在每次请求都会重置 |
| request     | 请求上下文 | 请求对象，封装了由客户端发送的HTTP请求内容           |
| session     | 请求上下文 | 用户会话，一个字典应用可以使用它来在两个请求之间记住的值      |

Flask在转发一个请求之前激活应用和请求上下文，然后当请求处理完成后删除它们。当应用上下文激活后，`current_app`和`g`变量对线程可用。当请求上下文被激活后，request和session同样可用。如果这些变量在没有应用或请求上下文访问的时候，会产生错误。

```python
>>> from hello import app
>>> from flask import current_app
>>> current_app.name
Traceback (most recent call last):
...
RuntimeError: working outside of application context
>>> app_ctx = app.app_context()
>>> app_ctx.push()
>>> current_app.name
'hello'
>>> app_ctx.pop()
```

##### 请求转发

Flask使用`app.route`装饰器构建URL映射，或者使用等价的非装饰器版本`app.add_url_rule()`

```python
(venv) $ python
>>> from hello import app
>>> app.url_map
Map([<Rule '/' (HEAD, OPTIONS, GET) -> index>,
<Rule '/static/<filename>' (HEAD, OPTIONS, GET) -> static>,
<Rule '/user/<name>' (HEAD, OPTIONS, GET) -> user>])
```

##### 请求钩子

有时这是非常有用的在请求被处理之前或之后执行代码。例如，在每次请求的开始，可能有必要创建数据库连接或认证发送该请求的用户。相比在每个视图函数都编写这样重复的代码，Flask给你一个选择注册常用的函数在一个请求被转发到一个视图函数之前或之后调用。

请求钩子被作为装饰器来实现，Flask支持4种钩子：

- `before_first_request`：注册一个函数在第一次请求被处理之前运行
- `before_request`:注册一个函数在每次请求之前运行
- `after_request`:注册一个函数，在每次请求之后运行，如果没有未处理的异常出现
- `teardown_request`：注册一个函数在每次请求之后运行，即使发生未处理的异常

一个常用的模式在请求钩子函数和视图函数之间共享数据就是使用全局`g`上下文。例如，一个`before_request`处理器可以从数据库加载登录的用户，然后把它存储在`g.user`，稍后，当视图函数被调用时，它可以访问user

##### 响应

HTTP协议不仅仅需要一个字符串作为一个请求的响应。HTTP响应的一个非常重要的部分就是*状态码*，Flask默认是200，表明请求被成功执行。

当一个视图函数需要使用不同的状态码进行响应时，它可以在响应文本之后添加数字码作为第二个返回值。例如，下面的视图函数返回一个400状态码，表示是一个坏的请求错误：

```python
@app.route('/')
def index():
    return '<h1>Bad Request</h1>',400
```

由视图函数返回的响应也可以接收第三个参数，一个消息头的字典被添加到HTTP响应中。这个不是必须的。

相比返回一个，两个或三个值作为元组，Flask视图函数可以返回一个`Response`对象。有时，这是有用的在视图函数中执行转换，接着使用响应对象的方法来更深层次的配置响应。下面的示例创建了一个响应对象，然后写Cookie：

```python
from flask import make_reponse

@app.route('/')
def index():
    response = make_response('<h1>This document carries a cookie!')
    response.set_cookie('answer','42')
    return response
```

有一个特殊类型的响应叫做*重定向*。这个响应不会包含一页文档，它只是给浏览器一个新的URL，用来加载一个新的页面。

重定向在表单中非常常用

一个重定向带有一个302的响应码，要重定向的URL会写在Location消息头中

一个重定向响应可以使用三值返回生成，也可以使用一个`response`对象

但是Flask提供一个`redirect()`帮助函数创建这样的响应：

```python
from flask import redirect

@app.route('/')
def index():
    return redirect('http://www.example.com')
```

另外一个特殊的响应是abort函数，用来进行错误处理。下面的例子返回状态码404，如果在URL中给定的动态参数id不能代表一个有效的用户：

```python
from flask import abort

@app.route('/user/<id>')
def get_user(id):
    user = load_user(id)
    if not user:
        abort(404)
    return '<h1>Hello, %s</h1>' % user.name
```

注意到，abort不会返回控制到调用它的函数，而是通过抛出一个异常返回控制给web服务器

#### Flask扩展

有很多不同的扩展适用于不同的目的

##### Flask-Script和命令行参数

Flask-Script是一个Flask的扩展，给你的Flask应用增加一个命令行解析器。

使用pip安装扩展

```shell
(venv) $ pip install flask-script
```

给`hello.py`增加命令行解析

```python
from flask.ext.script import Manager
manager = Manager(app)
# ...
if __name__ == '__main__':
manager.run()
```

为Flask特殊开发的扩展存在于`flask.ext`命名空间之下

在这种情况下，服务器启动被路由到`manager.run()`方法，命令行会被解析

使用这些改变，应用需要一系列基础的命令行选项。

```python
$ python3 hello.py 
hello.py:3: ExtDeprecationWarning: Importing flask.ext.script is deprecated, use flask_script instead.
  from flask.ext.script import Manager
usage: hello.py [-?] {runserver,shell} ...

positional arguments:
  {runserver,shell}
    runserver        Runs the Flask development server i.e. app.run()
    shell            Runs a Python shell inside Flask application context.

optional arguments:
  -?, --help         show this help message and exit
```

`shell`命令用来在应用的上下文启动一个Python 脚本会话，你可以使用这个会话来运行可维护的任务或测试

`runserver`命令，正如它的名字所示，启动web服务器。运行`python3 hello.py runserver`以调试模式启动web服务器，也由很多可用的选项

```python
(venv) $ python3 hello.py runserver --help
usage: hello.py runserver [-h] [-t HOST] [-p PORT] [--threaded]
[--processes PROCESSES] [--passthrough-errors] [-d]
[-r]
Runs the Flask development server i.e. app.run()
optional arguments:
-h, --help
show this help message and exit
-t HOST, --host HOST
-p PORT, --port PORT
--threaded
--processes PROCESSES
--passthrough-errors
-d, --no-debug
-r, --no-reload
```

下面的命令使web服务器监听公有网络接口的连接，启用在网络的其他电脑连接：

```shell
(venv) $ python3 hello.py runserver --host 0.0.0.0
* Running on http://0.0.0.0:5000/
* Restarting with reloader
```

