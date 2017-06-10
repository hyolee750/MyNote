# Flask Web Development

[TOC]

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

### 第三章 模板

写易于管理的应用的关键就是写干净的和结构良好的代码。你之前看到的例子太多简单而不能演示这个要求

一个视图函数明显的任务就是为一个请求生成响应，正如你之前看到的例子一样，对于最简单的请求来说这是足够的，但是一般来说一个请求会触发应用状态的改变，而视图函数也是这个改变被生成的地方。

例如，考虑一个用户在一个网站注册了一个新的账户。用户输入在web表单输入邮箱和密码，然后点击提交按钮，在服务器端，包含用户数据的请求到达，Flask会转发它到处理注册请求的视图函数。视图函数需要连接数据库获取新增加的用户，然后生成响应发送回浏览器，这两种任务类型被叫做业务逻辑和表述逻辑。

混合业务和表述逻辑会导致代码很难理解和维护。将表述逻辑移动到模板会帮助改善应用的可维护性。

一个模板是一个包含响应文本的文件，代表请求上下文知道的动态部分的容器变量。用实际值替换变量然后返回一个最终的响应字符串的过程叫做*渲染*。对于渲染模板的任务，Flask使用一个叫*Jinja2*的强大的模板引擎。

#### Jinja2模板引擎

在它最简单的形式，一个Jinja2模板是一个包含响应文本的文件。

```html
Example 3-1. templates/index.html: Jinja2 template
<h1>Hello World!</h1>
```

由视图函数`user()`返回的响应有一个动态组件，由一个*变量*代表。

```html
Example 3-2. templates/user.html: Jinja2 template
<h1>Hello, {{ name }}!</h1>
```

##### 渲染模板

默认情况下，Flask会在应用文件夹内的*templates*子文件夹内寻找模板。对于下面版本的`hello.py`，你需要在*templates*文件夹内存储事先定义好的模板*index.html* 和*user.html*

在应用中的视图函数需要修改去渲染这些模板

*Example 3-3. hello.py: 渲染一个模板*

```python
from flask import Flask
from flask import request
from flask_script import Manager
from flask import render_template

app = Flask(__name__)
manager = Manager(app)


@app.route('/')
def index():
    # user_agent = request.headers.get('User-Agent')
    # return '<p>Your browser is %s</p>' % user_agent
    return render_template('index.html')


@app.route('/user/<name>')
def user(name):
    # return '<h1>Hello, %s!</h1>' % name
    return render_template('user.html', name=name)


if __name__ == '__main__':
    # app.run(debug=True)
    manager.run()
```

由Flask提供的`render_template`函数集成了Jinja2模板引擎到应用中。这个函数接收模板的文件名作为第一个参数。任意额外的参数是键/值对代表模板中的变量的实际值。这个例子中，第二个模板接收一个`name`变量。

##### 变量

在上面显示的模板使用`{{ name }}`构造来引用一个变量，一个特殊的容器告诉模板引擎，放在这地方的值应该在模板被渲染的同时的取得提供的数据。

Jinja2 识别任意类型的变量，甚至像列表，字典和对象这样的复杂对象。下面是一些在模板中使用的变量的例子：

```html
<p>A value from a dictionary: {{ mydict['key'] }}.</p>
<p>A value from a list: {{ mylist[3] }}.</p>
<p>A value from a list, with a variable index: {{ mylist[myintvar] }}.</p>
<p>A value from an object's method: {{ myobj.somemethod() }}.</p>
```

变量可以使用*过滤器*进行修改，在变量名之后增加一个`|`符号作为分隔符。例如，下面的模板显示了变量名的首个字母大写：

```html
Hello, {{ name|capitalize }}
```

*Table 3-1. Jinja2 变量过滤器*

| 过滤器名       | 描述               |
| ---------- | ---------------- |
| safe       | 不使用转义渲染值         |
| capitalize | 转换值的第一个字符大写，其余小写 |
| lower      | 转换值到小写           |
| upper      | 转换值到大写           |
| title      | 转换值中每个单词的首个字符大写  |
| trim       | 删除空格             |
| striptags  | 在渲染之前删除任何的HTML标签 |

默认情况下，Jinja2 为了安全的目的转义所有的变量。例如，如果一个变量被设置成值`'<h1>Hello</h1>'，Jinja2会渲染这个字符串作为

```
'&lt;h1&gt;Hello&lt;/h1&gt;'
```

完整的过滤器列表可以从JInja2的官方文档获得

##### 控制结构

Jinja2提供了几种控制结构可以用来选择模板流向。这一部分使用简单的例子介绍了一些最常用的结构。

条件语句

```html
{% if user %}
	Hello, {{ user }}!
{% else %}
	Hello, Stranger!
{% endif %}
```

另外一个在模板中常用的就是渲染元素列表：

```html
<ul>
	{% for comment in comments %}
		<li>{{ comment }}</li>
	{% endfor %}
</ul>
```

Jinja2也支持*宏*，和Python代码中的函数相似。例如：

```html
{% macro render_comment(comment) %}
	<li>{{ comment }}</li>
{% endmacro %}

<ul>
	{% for comment in comments %}
		{{ render_comment(comment) }}
	{% endfor %}
</ul>
```

为了使宏更可重用的，他们可以被存储在单独的文件中，然后当需要他们的时候可以被导入

```HTML
{% import 'macros.html' as macros %}
<ul>
  	{% for comment in comments %}
		{{ macros.render_comment(comment) }}
	{% endfor %}
</ul>
```

需要在几个地方重复模板代码的部分可以单独存储在一个文件，然后使用*included*包含进来避免重复。

```html
{% include 'common.html' %}
```

然后，另外一个强大的重用方式是通过模板继承，和Python代码中的类继承相似。例如一个基本的模板使用*base.html*的名字被创建

```html
<html>
<head>
	{% block head %}
		<title>{% block title %}{% endblock %} - My Application</title>
	{% endblock %}
</head>
<body>
	{% block body %}
	{% endblock %}
</body>
</html>
```

这儿`block`标签定义了一个元素，是一个可以被改变的派生模板。在这个例子中，有多个叫`head`,`title`，`body`的块。注意`title`被`head`包含。下面的例子是基本模板的派生模板：

```html
{% extends "base.html" %}
{% block title %}Index{% endblock %}
{% block head %}
	{{ super() }}
	<style>
	</style>
{% endblock %}
{% block body %}
<h1>Hello, World!</h1>
{% endblock %}
```

`extends`指令声明了这个模板派生于	*base.html*。

#### 使用Flask-Bootstrap集成Twitter Bootstrap

Bootstrap是一个来自Twitter的开源的框架，提供了用户界面组件来创建兼容所有现代web浏览器的干净和有吸引力的网页。

Bootstrap是一个客户端的框架，所以服务器不会直接调用它。服务器所要做的事情就是提供引用Bootstrap的CSS和Javascript文件的HTML响应。

最明显的方式集成Bootstrap就是给模板做所有必要的改变。一个简单的方法就是使用叫Flask-Bootstrap的Flask扩展，简化了集成的努力。Flask-Bootstrap可以使用pip安装：

```shell
(venv) $ pip install flask-bootstrap
```

Flask扩展通常在应用实例被创建的时候初始化。

*Example 3-4. hello.py: Flask-Bootstrap初始化*

```python
from flask_bootstrap import Bootstrap
# ...
bootstrap = Bootstrap(app)
```

一旦Flask-Bootstrap被初始化，一个包含所有Bootstrap文件的基本模板对应用就可用了。这个模板利用了JInja2的模板继承。应用继承一个基本模板有常用的网页结构包括从Bootstrap导入的元素。

*Example 3-5. templates/user.html: 使用Flask-Bootstrap的模板*

```html
{% extends "bootstrap/base.html" %}
{% block title %}Flasky{% endblock %}
{% block navbar %}
<div class="navbar navbar-inverse" role="navigation">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
 			</button>
			<a class="navbar-brand" href="/">Flasky</a>
		</div>
		<div class="navbar-collapse collapse">
			<ul class="nav navbar-nav">
				<li><a href="/">Home</a></li>
			</ul>
		</div>
	</div>
</div>
{% endblock %}

{% block content %}
<div class="container">
	<div class="page-header">
		<h1>Hello, {{ name }}!</h1>
	</div>
</div>
{% endblock %}
```

Jinja2 `extends`指令通过来自Flask-Bootstrap的*bootstrap/base.html*实现了模板继承。来自Flask-Bootstrap的基本模板提供了一个包含所有Bootstrap CSS和JavaScript文件的骨架网页。

基本模板定义的*blocks*可以被派生模板覆盖。`block`和`endblock`指令定义了被增加到基本模板的内容块。

Flask-Bootstrap的*base.html* 模板定义了几个其他块可以用于派生的模板。

*Table 3-2. Flask-Bootstrap’的基本模板块*

| 块名称                              | 描述                 |
| -------------------------------- | ------------------ |
| `doc`                            | 整个HTML文档           |
| `html_attribs` | 在`<html>`标签内的属性 |                    |
| `html`         | `<html>`标签的内容   |                    |
| `head`         | `<head>`标签的内容   |                    |
| `title`        | `<title>`标签的内容  |                    |
| `metas`        | `<meta>`标签列表    |                    |
| `styles`                         | 级联样式表定义            |
| `body_attribs` | `<body>`标签内的属性  |                    |
| `body`         | `<body>`标签的内容   |                    |
| `navbar`                         | 用户自定义的导航栏          |
| `content`                        | 用户自定义的页面内容         |
| `scripts`                        | 在文档底部声明的JavaScript |

在表3-2的大部分代码块被Flask-Bootstrap本身使用，所以直接覆盖他们会引起问题。例如，`styles`和`scripts`是Bootstrap文件被声明的地方，如果应用需要增加它自己的内容到已经有一些内容的代码块。Jinja2的`super()`函数必须被使用。

这是`scripts`代码块在派生的模板中需要被写的方式，来增加一个新的JS文件到文档：

```html
{% block scripts %}
{{ super() }}
<script type="text/javascript" src="my-script.js"></script>
{% endblock %}
```

#### 自定义错误页面

Flask允许应用像普通的路由一样定义基于模板的自定义错误页面。

最常用的错误代码是404，当客户端请求一个页面或路由不错在

另外一个是500 ，当有一个未处理的异常时触发。

*Example 3-6. hello.py: 自定义的错误页面*

```python
@app.errorhandler(404)
def page_not_found(e):
	return render_template('404.html'), 404

@app.errorhandler(500)
def internal_server_error(e):
	return render_template('500.html'), 500
```

错误处理器像视图函数一样返回一个响应，它们也会返回错误响应的数字状态码

在错误处理器中引用的模板需要被重写，这些模板应该遵循普通页面同样的布局。所以在这种情况下，它们会有一个导航栏和一个显示错误信息的页头。

Jinja2的模板继承可以解决这个问题，以同样的方式，Flask-Bootstrap提供了一个基本模板有着基本的页面布局，应用可以使用一个更完整的页面布局定义它自己的基本模板。

*Example 3-7. templates/base.html: 有导航栏的基本应用模板*

```html
{% extends "bootstrap/base.html" %}

{% block title %}Flasky{% endblock %}

{% block navbar %}
<div class="navbar navbar-inverse" role="navigation">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle"
data-toggle="collapse" data-target=".navbar-collapse">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="/">Flasky</a>
		</div>
		<div class="navbar-collapse collapse">
			<ul class="nav navbar-nav">
				<li><a href="/">Home</a></li>
			</ul>
		</div>
	</div>
</div>
{% endblock %}

{% block content %}
<div class="container">
	{% block page_content %}{% endblock %}
</div>
{% endblock %}
```

在这个模板的`content`代码块只是一个`<div>`元素容器包裹了一个空的派生模板可以定义的`page_content`代码块

应用的模板现在会从这个模板而不是直接从Flask-Bootstrap继承。

*Example 3-8. templates/404.html: 使用模板继承自定义404错误页面*

```html
{% extends "base.html" %}

{% block title %}Flasky - Page Not Found{% endblock %}

{% block page_content %}
    <div class="page-header">
        <h1>Not Found</h1>
    </div>
{% endblock %}
```

`templates/user.html`模板可以让它继承基本模板进行简化

```html
{% extends "base.html" %}

{% block title %}Flasky{% endblock %}

{% block page_content %}
    <div class="page-header">
        <h1>Hello, {{ name }}</h1>
    </div>
{% endblock %}
```

#### 链接

任何应用都会有多个路由需要包含链接到不同页面的链接

Flask提供了`url_for`帮助函数，从存储在应用URL映射的信息生成URL

最简单的用法，这个函数接收视图名作为唯一的参数，然后返回它的URL

例如，在当前版本的*hello.py* 中调用`url_for('index')`将会返回`/`，调用`url_for('index',_external=True)`将会返回一个绝对URL，如*http://localhost:5000/*

动态URL可以使用`url_for()`通过传递动态部分作为一个关键字参数。例如

`url_for('user',name='john',_external=True)`将会返回`http://localhost:5000/user/john`

发送给`url_for()`的关键字参数不限制参数。函数会增加额外的参数到查询字符串。例如，`url_for('index',page=2)`将会返回`/?page=2`

#### 静态文件

Web应用不仅仅是由Python代码和模板组成。大多数应用也会使用像HTML代码引用的图片，JS源文件，CSS等静态文件。

静态文件的引用被当做一个特殊的路由，被定义为`/static/<filename>`。

例如，一个调用`url_for('static',filename='css/styles.css',_external=True)`将会返回`http://localhost:5000/static/css/styles.css`/

默认情况下，Flask会在应用的根目录下寻找`static`子目录。

*Example 3-10. templates/base.html:定义图标*

```html
{% block head %}
{{ super() }}
<link rel="shortcut icon" href="{{ url_for('static', filename = 'favicon.ico') }}"	type="image/x-icon">
<link rel="icon" href="{{ url_for('static', filename = 'favicon.ico') }}"	type="image/x-icon">
{% endblock %}
```

图标的声明被插入到了`head`块的尾部。注意`super()`是如何被使用的，为了保留在基础模板中定义的源内容块

#### 使用Flask-Moment本地化日期和时间

在Web应用中处理日期和时间不是一个微不足道的问题，当用户来自世界各个地方。

服务器需要统一的时间单元，和每个用户的所在位置无关。一般情况下使用UTC。对于用户来说，看到使用UTC表达的时间是令人迷惑的，因为用户总是期望看到日期和时间在他们的本地时间和根据他们的地区格式化。

一个优雅的解决方法是允许服务器只工作在UTC，然后把这些时间单元发送到Web浏览器，它们可以被转换到本地时间，然后被渲染。

Flask-Moment是一个Flask应用的扩展在JInja2中集成了*moment.js* 。Flask-Moment使用pip安装：

```shell
(venv) $ pip install flask-moment
```

*Example 3-11. hello.py: 初始化Flask-Moment*

```python
from flask_moment import Moment
moment = Moment(app)
```

Flask-Moment除了依赖`moment.js`之外，还依赖*jquery.js*。

有两个库需要包含在HTTP文档的某个地方。

因为Bootstrap已经包含了*jQuery.js*，只需要添加*moment.js*就可以了

*Example 3-12. templates/base.html: 导入moment.js库*

```html
{% block scripts %}
{{ super() }}
{{ moment.include_moment() }}
{% endblock %}
```

为了使用时间戳，Flask-Moment为模板创建了一个`moment`类的变量。

下面的例子传递一个叫`current_time`的变量给模板进行渲染。

```python
from datetime import datetime

@app.route('/')
def index():
	return render_template('index.html',current_time=datetime.utcnow())
```

*Example 3-14. templates/index.html: 使用Flask-Moment渲染时间戳*

```html
<p>The local date and time is {{moment(current_time).format('LLL') }}.</p>
<p>That was {{ moment(current_time).fromNow(refresh=True) </p>
```

`format('LLL')`格式根据时区和在客户端电脑的本地设置来渲染日期和时间。参数决定了渲染类型，从`'L'`到`'LLLL'`四种不同的详细水平。

`format()`函数也可以接收自定义的格式类型

`fromNow()`渲染类型渲染一个相对的时间戳，随着时间的流逝会自动刷新。

初始化该时间戳会显示几秒前，但是刷新选项会随着时间一直更新，比如1分钟前，2分钟前，等等

Flask-Moment实现了`format()`,`fromNow()`,`fromTime()`,`calendar()`,`valueOf()`和`unix()`方法

由Flask-Moment渲染的时间戳可以本地化到多种语言，通过在模板中传递语言代码到`lang()`函数可以选择一种语言。

```html
{{ moment.lang('es') }}
```

使用所有在这一章讨论的技术，你应该能够为你的应用构建现代的和用户友好的网页了。下一章我们将接触模板还没有被讨论的方面：怎样通过表单和	用户交互

### 第四章 表单

请求对象，暴露了由客户端请求发送的所有信息，具体来说，`request.form`提供了访问`POST`请求提交的表单数据。

尽管Flask提供的支持处理表单是有效的，有许多任务可能是乏味的和重复的

Flask-WTF拓展让使用表单拥有更好的体验

使用pip安装Flask-WTF和它的依赖

```shell
(venv) $ pip install flask-wtf
```

#### 跨站点请求伪造(CSRF)保护

默认情况下，Flask-WTF保护所有的表单防止CSRF攻击。

为了实现CSRF保护，Flask-WTF需要应用配置一个加密的key。Flask-WTF使用这个key生成加密的令牌，使用表单数据校验请求的权限

*Example 4-1. hello.py: Flask-WTF配置*

```python
app = Flask(__name__)
app.config['SECRET_KEY'] = 'hard to guess string'
```

`app.config`字典是一个一般目的的地方用来存储框架，扩展或应用本身使用的变量，配置的值可以使用标准的字典语法添加到`app.config`对象中。

配置对象也有方法从文件或环境导入配置的值。

`SECRET_KEY`配置变量被作为一个一般目的的加密key被Flask和其他第三方扩展使用。正如它的名字所示，在每个应用选择不同的加密key，你可以构建和确保这个字符串不会被任何人知道。

#### 表单类

当使用Flask-WTF，每个表单由一个继承自`Form`类的类表示。类定义了表单的字段列表，每个都代表一个对象。每个字段对象都可以有一个或多个校验器，校验器是一个函数用来检查用户提交的输入是否有效。

*Example 4-2. hello.py: 表单类定义*

```python
from flask_wtf import Form
from wtforms import StringField, SubmitField
from wtforms.validators import DataRequired


class NameForm(Form):
    name = StringField('What is your name?', validators=[DataRequired()])
    submit = SubmitField('Submit')
```

表单的字段被定义为类变量，每个类变量被赋值一个字段类型的对象。在之前的例子，`NameForm`表单有一个文本字段叫`name`,一个提交按钮叫`submit`。`StringField`类代表一个有一个`type="text"`的`<input>`元素，`SubmitField`类代表一个有一个`type="submit"`的`<input>`元素，字段构造器的第一个参数是用来渲染表单到HTML的标签。

包括在`StringField`构造器内的可选的`validators`参数定义了一个检查器的列表，用来校验用户提交的数据，`DataRequired()`校验器确保字段不能提交空。

由WTF表单支持的标准HTML字段列表

 

| 字段类型                                     | 表述             |
| ---------------------------------------- | -------------- |
| `StringField`                            | 文本字段           |
| `TextAreaField`                          | 文本域字段          |
| `PasswordField`                          | 密码文本字段         |
| `HiddenFIeld`                            | 隐藏文本字段         |
| `DateField`           | 文本字段接受一个给定格式的`datetime.date`值 |                |
| `DateTimeField`       | 文本字段接受一个给定格式的`datetime.datetime`值 |                |
| `IntegerField`                           | 文本字段接受一个整数     |
| `DecimalField`        | 文本字段接受一个`decimal.Decimal`值 |                |
| `FloatField`                             | 文本字段接受一个浮点值    |
| `BooleanField`                           | True和False的复选框 |
| `RadioField`                             | 单选框按钮列表        |
| `FileField`                              | 文件上传字段         |
| `SubmitField`                            | 表单提交按钮         |
| `FormField`                              | 嵌入表单           |
| `SelectField`                            | 下拉选择框          |
| `SelectMultipleField`                    | 多选下拉选择框        |
| `FieldList`                              | 给定类型的字段列表      |

WTF表单内置的校验器列表

| 校验器            | 描述               |
| -------------- | ---------------- |
| `Email`        | 校验邮箱地址           |
| `EqualTo`      | 比较两个字段的值是否相等     |
| `IPAddress`    | 校验一个IPv4网络地址     |
| `Length`       | 校验驶入字符串的长度       |
| `NumberRange`  | 校验输入的值是否在一个数字范围内 |
| `Optional`     | 允许字段为空           |
| `DataRequired` | 校验字段不能为空         |
| `Regexp`       | 使用正则表达式校验输入      |
| `URL`          | 校验一个URL          |
| `AnyOf`        | 校验输入的值是否可能的值之一   |
| `NoneOf`       | 校验驶入的值不在可能的值列表   |

#### 表单的HTML渲染

当调用时，表单字段是可调用的，从一个模板渲染他们自己到HTML。

假如视图函数传递一个`NameForm`实例到模板作为一个参数名`form`，表单可以生成一个简单的HTML表单：

```html
<form method="POST">
	{{ form.name.label }} {{ form.name() }}
	{{ form.submit() }}
</form>
```

当然，这个结果是相当赤裸的，为了改善表单的外观，发送给调用的任意参数都会渲染字段转换到该字段的HTML属性。

例如，你可以给一个字段id或class属性，接着定义CSS：

```html
<form method="POST">
{{ form.name.label }} {{ form.name(id='my-text-field') }}
{{ form.submit() }}
</form>
```

Flask-Bootstrap提供了一个高水平的帮助函数使用Bootstrap预定义的表单类型渲染整个Flask-WTF表单，使用Flask-Bootstrap，之前的表单可以渲染成下面这样的：

```html
{% import "bootstrap/wtf.html" as wtf %}
{{ wtf.quick_form(form) }}
```

`import`指令可以像普通的Python脚本一样工作，允许模板元素被导入，并做多个模板使用，导入的*bootstrap/wtf.html*文件定义了帮助类使用Bootstrap渲染Flask-WTF表单。

`wtf.quick_form()`函数接收一个Flask-WTF表单对象，并使用默认的Bootstrap类型渲染

*Example 4-3. templates/index.html: 使用Flask-WTF和Flask-Bootstrap渲染表单*

```html
{% extends "base.html" %}
{% import "bootstrap/wtf.html" as wtf %}

{% block title %}Flasky{% endblock %}

{% block page_content %}
<div class="page-header">
	<h1>Hello, {% if name %}{{ name }}{% else %}Stranger{% endif %}!</h1>
</div>
{{ wtf.quick_form(form) }}
{% endblock %}
```

模板的内容区域现在有两个部分，第一部分是一个显示问候的页头。这儿使用了一个条件模板，在Jinja2中的条件模板使用`{% if variable %}...{% else %}...{% endif %}`格式。如果条件计算为True，出现在if和else指令之间的内容会被渲染，如果条件计算为False，else和elif之间的内容会被渲染。

第二个部分是使用`wtf.quick_form()`函数渲染内容

#### 在视图函数中处理表单

在新版本的*hello.py*中，`index()`函数将会渲染表单同时也接收它的数据

```python
@app.route('/', methods=['GET', 'POST'])
def index():
    name = None
    form = NameForm()
    if form.validate_on_submit():
        name = form.name.data
        form.name.data = ''
    return render_template('index.html', form=form, name=name)
```

添加到`app.route`装饰器的`methods`参数告诉Flask注册视图函数作为GET和POST请求的处理器，当methods没有给定时，视图函数被注册只能处理GET请求。

增加POST到方法列表是必要的，因为表单提交通常被作为POST请求处理。也有可能使用GET方法提交表单，但是GET方法没有方法体，数据会作为查询参数添加到URL，在浏览器的地址栏会变成可见的，因为这个原因和其他的理由，表单提交通常由POST请求处理

#### 重定向和用户会话

最后一个版本的*hello.py* 有一个可用的问题，如果你输入你的姓名并提交，接着点击浏览器的刷新按钮，你可能会得到一个明显的警告，要求确认之前提交的表单。这是因为浏览器重复上次的请求当他们被要求刷新页面。

当最后一个请求是POST请求，一个刷新会导致重复表单提交，大多数情况下都不是期望的行为

一个web应用的最佳实践就是不要让POST请求作为最后一个浏览器发送的请求

该实践可以通过用*重定向* 响应POST请求而不是直接返回一个普通的响应

这个技巧被叫做`POST/REDIRECT/GET`模式

但是这个方法会产生第二个问题，当应用处理POST请求的时候，它在`form.name.data` 访问用户输入的名称.但是只要请求结束了，表单数据就丢失了。因为POST请求被一个重定向处理，应用需要存储名称以便重定向可以访问并使用它构造实际的响应。

通过用户会话来保存数据

```python
from flask import Flask, render_template, session, redirect, url_for

@app.route('/', methods=['GET', 'POST'])
def index():
	form = NameForm()
	if form.validate_on_submit():
		session['name'] = form.name.data
		return redirect(url_for('index'))
	return render_template('index.html', form=form,name=session.get('name'))
```

在之前版本的应用，一个本地变量`name`被用来存储由用户在表单中输入的姓名，现在变量被放在以`session['name']`的形式放在用户会话中，以便它可以在请求之外被记住。

使用`url_for()`来生成URL是被鼓励的，因为这个函数使用URL映射来生成URL。所以URL保证可以兼容已定义的路由，任何路由名称的改变都会自动可用。

第一个也是唯一一个必需的参数就是*端点名*，默认情况下，路由的端点是视图函数的名字。

最后一个在`render_template()`函数，现在直接使用`session.get('name')`从用户会话中获取`name`参数。作为一个普通的字典，使用`get()`请求一个字典的key避免了key没有找到的异常，因为`get()`对于不存在的键会返回一个默认值None。

#### 消息闪烁

有时，在一个请求完成之后给用户一个状态更新是很有用的。这可以是一个确认或警告或错误信息，一个典型的例子就是当你提交一个登录有错误的时候，服务器会重新渲染登录表单和一个消息通知你你的用户名或密码不合法。

使用`flash()`函数可以完成这个目的

```python
from flask import Flask, render_template, session, redirect, url_for, flash

@app.route('/', methods=['GET', 'POST'])
def index():
	form = NameForm()
	if form.validate_on_submit():
		old_name = session.get('name')
		if old_name is not None and old_name != form.name.data:
			flash('Looks like you have changed your name!')
		session['name'] = form.name.data
		form.name.data = ''
		return redirect(url_for('index'))
	return render_template('index.html',
form = form, name = session.get('name'))
```

在这个例子中，如果两个名字不同，`flash()`函数被调用，一个消息会被显示在发送给客户端的下一个响应上。

为了获取消息调用`flash()`是不足够的，应用的模板需要渲染这些消息。渲染闪烁消息最好的地方就是基本模板。因为这会在所有页面启用这些消息。

Flask有一个`get_flashed_messages()`方法对模板可用，用来接收消息和渲染它们

*Example 4-7. templates/base.html: 闪烁消息渲染*

```html
{% block content %}
<div class="container">
	{% for message in get_flashed_messages() %}
	<div class="alert alert-warning">
		<button type="button" class="close" data-dismiss="alert">&times;</button>
		{{ message }}
	</div>
	{% endfor %}
  
	{% block page_content %}{% endblock %}
</div>
{% endblock %}
```

### 第五章 数据库

数据库以一个已组织的方式存储应用数据。应用使用查询来获取他们需要的特殊部分。web应用最常用的数据库是那些基于关系模型的

#### SQL数据库

关系型数据库以表的形式存储数据。

一个表有固定数量的列和不同数量的行

#### 使用Flask-SQLAlchemy管理数据库

使用`pip`安装

```shell
(venv) $ pip install flask-sqlalchemy
```

在Flask-SQLAlchemy，一个数据库被具体定义为一个URL

| 数据库引擎           | URL                                      |
| --------------- | ---------------------------------------- |
| MySQL           | `mysql://username:password@hostname/database` |
| Postgres        | `postgresql://username:password@hostname/database` |
| SQLite(Unix)    | `sqlite:////absolute/path/to/database`   |
| SQLite(Windows) | `sqlite:///c:/absolute/path/to/database` |

在这些URL中，*hostname*指向Mysql服务的服务器主机，可以是一个*localhost*也可以是一个远程服务器。数据库服务器可以有多个数据库，所以*database*表明要使用的数据库的名称，对于数据库来说需要授权，*username*和`password`是数据库用户的身份。

应用数据库的URL必须被定义为`SQLALCHEMY_DATABASE_URI` 在Flask的配置对象中。

另一个有用的选项是配置键`SQLALCHEMY_COMMIT_ON_TEARDOWN`，可以设置为True启用在每次请求之后自动提交数据库改变。

*Example 5-1. hello.py: 数据库配置*

```python
from flask.ext.sqlalchemy import SQLAlchemy

basedir = os.path.abspath(os.path.dirname(__file__))

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] =\
'sqlite:///' + os.path.join(basedir, 'data.sqlite')
app.config['SQLALCHEMY_COMMIT_ON_TEARDOWN'] = True

db = SQLAlchemy(app)
```

`db`对象从`SQLAlchemy`类实例化，代表数据库提供了访问所有Flask-SQLAlchemy函数的能力。

#### 模型定义

术语*模型*被用来指向由应用使用的持久化实体。在ORM的上下文中，模型典型地是一个Python类，属性匹配相应数据库表的列。

*Example 5-2. hello.py: 角色和用户模型定义*

```python
class Role(db.Model):
	__tablename__ = 'roles'
	id = db.Column(db.Integer, primary_key=True)
	name = db.Column(db.String(64), unique=True)
    
	def __repr__(self):
		return '<Role %r>' % self.name
    
class User(db.Model):
	__tablename__ = 'users'
	id = db.Column(db.Integer, primary_key=True)
	username = db.Column(db.String(64), unique=True, index=True)
    
	def __repr__(self):
		return '<User %r>' % self.username
```

`__tablename__`变量定义了在数据库中表的名字，如果该变量忽略，Flask-SQLAlchemy会赋值一个默认的表名，最好是显式地命名表名，剩余的类变量是模型的属性，由`db.Column`类的实例定义。

`db.Column`构造器的第一个参数是数据库列的类型和模型属性。

*Table 5-2. 最常用的SQLAlchemy列类型*

| 类型名          | Python类型             | 描述              |
| ------------ | -------------------- | --------------- |
| Integer      | `int`                | 普通的整数，一般32位     |
| SmallInteger | `int`                | 短范围的整数，一般16位    |
| BigInteger   | `int`或`long`         | 无限位的整数          |
| Float        | `float`              | 浮点数             |
| Numeric      | `decimal.Decimal`    | 固点数             |
| String       | `str`                | 可变长度的字符串        |
| Text         | `str`                | 可变长度的字符串，用于无边界的 |
| Unicode      | `unicode`            | 可变长度的unicode字符串 |
| UnicodeText  | `unicode`            | 可变长度的unicode字符串 |
| Boolean      | `bool`               | 布尔值             |
| Date         | `datetime.date`      | 日期值             |
| Time         | `datetime.time`      | 时间值             |
| DateTime     | `datetime.datetime`  | 日期时间值           |
| Interval     | `datetime.timedelta` | 时间间隔            |
| Enum         | `str`                | 字符串值列表          |
| PickleType   | 任意Python对象           | 自动Pickle序列化     |
| LargeBinary  | `str`                | 二进制数据           |

`db.Column`的剩余参数定义了每个属性的特殊配置选项

*Table 5-3. 最常用的SQLAlchemy 列选项*

| 选项名称          | 描述                                  |
| ------------- | ----------------------------------- |
| `primary_key` | 如果设置为True，该列是表的主键                   |
| `unique`      | 如果设置为True，该列不允许重复值                  |
| `index`       | 如果设置为True，为该列创建一个索引，可以让查询更有效        |
| `nullable`    | 如果设置为True。该列允许空值，如果设置为False，该列不允许为空 |
| `default`     | 为该列定义一个默认值                          |

尽管不是特别必要，两个模型包括了一个`__repr__()`方法可以让他们生成一个可读的字符串表述。

#### 关系

关系型数据库通过使用关系来连接两个不同表的行。

角色和用户是一个一对多的关系，一个角色可以属于多个用户，一个用户只能有一个角色

*Example 5-3. hello.py: 关系*

```python
class Role(db.Model):
# ...
users = db.relationship('User', backref='role')

class User(db.Model):
# ...
role_id = db.Column(db.Integer, db.ForeignKey('roles.id'))
```

`db.relationship`定义了两个实体的关系

`backref`翻转两个实体的引用关系

`db.ForeignKey`定义外键

*Table 5-4. 常用的SQLAlchemy关系选项*

| 选项名             | 描述                      |
| --------------- | ----------------------- |
| `backref`       | 在关系中的另一个模型中添加一个反向引用     |
| `primaryjoin`   | 显式地定义两个模型之间的连接条件。使用主键连接 |
| `lazy`          | 定义相关的项是如何被加载的。          |
| `uselist`       | 如果设置为False，使用标量代替列表     |
| `order_by`      | 用来定义在关系中项的顺序            |
| `secondary`     | 在多对多关系中定义关联表的名称         |
| `secondaryjoin` | 指定多对多关系的辅助连接条件          |

`lazy`可能的值：

- `select`：项会在第一次被访问的时候加载
- `immediate`：当源代码被加载的时候项被加载
- `joined`： 项被立即加载，但是被作为连接
- `subquery`： 项被立即加载，但是被作为子查询
- `noload`： 项永远不被加载
- `dynamic`： 使用给出可以加载它们的查询来加载项

如果你想要使用多对多关系，你需要定义一个帮助表，强烈推荐帮助表是一个实际的表而不是一个模型

```python
tags = db.Table('tags',
    db.Column('tag_id', db.Integer, db.ForeignKey('tag.id')),
    db.Column('page_id', db.Integer, db.ForeignKey('page.id'))
)

class Page(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    tags = db.relationship('Tag', secondary=tags,
        backref=db.backref('pages', lazy='dynamic'))

class Tag(db.Model):
    id = db.Column(db.Integer, primary_key=True)
```

#### 数据库操作

##### 创建表

第一件要做的事情就是调用Flask-SQLAlchemy基于模型类创建一个数据库

`db.create_all()`函数就是用来做这个的

```python
(venv) $ python hello.py shell
>>> from hello import db
>>> db.create_all()
```

`db.create_all()`不会重新创建或更新一个数据库表如果它已经存在于数据库了

这可能不方便的当模型被修改需要改变到一个已经存在的数据库，更新已经存在的数据库的表的蛮力解决方案就是先把老的表删除：

```python
>>> db.drop_all()
>>> db.create_all()
```

不幸的是，这个方法会摧毁在老的数据库中的所有数据。

##### 插入行

下面的例子创建了一些角色和用户：

```python
>>> from hello import Role, User
>>> admin_role = Role(name='Admin')
>>> mod_role = Role(name='Moderator')
>>> user_role = Role(name='User')
>>> user_john = User(username='john', role=admin_role)
>>> user_susan = User(username='susan', role=user_role)
>>> user_david = User(username='david', role=user_role)
```
这些对象目前只存在与Python这边，还没有被写到数据库，因为他们的id还没有被赋值

```python
>>> print(admin_role.id)
None
>>> print(mod_role.id)
None
>>> print(user_role.id)
None
```

保存到数据是通过数据库`session`来管理的，Flask-SQLAlchemy提供了`db.session`

```python
>>> db.session.add(admin_role)
>>> db.session.add(mod_role)
>>> db.session.add(user_role)
>>> db.session.add(user_john)
>>> db.session.add(user_susan)
>>> db.session.add(user_david)
```

或者更简洁的：

```python
>>> db.session.add_all([admin_role, mod_role, user_role,
...		user_john, user_susan, user_david])
```

为了把对象写到数据库，session需要调用`commit()`方法进行提交

```python
>>> db.session.commit()
```

再次检查id属性，他们现在被设置为：

```python
>>> print(admin_role.id)
1
>>> print(mod_role.id)
2
>>> print(user_role.id)
3
```

##### 修改行

数据库session的`add()`方法也可以用来更新对象。

```python
>>> admin_role.name = 'Administrator'
>>> db.session.add(admin_role)
>>> db.session.commit()
```

##### 删除行

使用数据库session的`delete()`方法

```python
>>> db.session.delete(mod_role)
>>> db.session.commit()
```

注意删除，像插入和更新一样，只有当数据库session被提交后才执行

##### 查询行

Flask-SQLAlchemy在每个模型类上都有一个`query`对象可用。最基础的查询就是返回响应表的所有内容

```python
>>> Role.query.all()
[<Role u'Administrator'>, <Role u'User'>]
>>> User.query.all()
[<User u'john'>, <User u'susan'>, <User u'david'>]
```

使用过滤器，一个查询对象可以被配置成解决更特殊的数据库搜索。

```python
>>> User.query.filter_by(role=user_role).all()
[<User u'susan'>, <User u'david'>]
```

检查SQLAlchemy从一个给定的查询生成的本地SQL查询通过转换查询对象到一个字符串

```python
>>> str(User.query.filter_by(role=user_role))
'SELECT users.id AS users_id, users.username AS users_username,
users.role_id AS users_role_id FROM users WHERE :param_1 = users.role_id'
```

如果你退出shell会话，在之前例子中创建的对象会被作为Python对象擦除，但会继续作为行存在于相应的数据库表中。

```python
>>> user_role = Role.query.filter_by(name='User').first()
```

像`filter_by`这样的过滤器被一个查询对象所调用，会返回一个新的查询对象，可以以序列的形式调用多个过滤器。

*Table 5-5. 常用的SQLAlchemy查询过滤器*

| 选项            | 描述                    |
| ------------- | --------------------- |
| `filter()`    | 返回一个增加了额外过滤器到原始查询的新查询 |
| `filter_by()` | 返回一个增加了额外过滤器到原始查询的新查询 |
| `limit()`     | 返回一个新查询，限制了返回的行数      |
| `offset()`    | 返回一个新的查询，从某个偏移量开始     |
| `order_by()`  | 根据某个属性进行排序            |
| `group_by()`  | 根据某个属性进行分组            |

使用了期望的过滤器之后，调用`call()`会让查询去执行，然后返回一个列表结果

*Table 5-6. 最常用的QLAlchemy 查询执行器*

| 选项                                       | 描述                             |
| ---------------------------------------- | ------------------------------ |
| `all()`                                  | 返回所有的结果作为一个列表                  |
| `first()`                                | 返回查询的第一个结果，如果没有结果则为None        |
| `first_or_404()`                         | 返回查询的第一个结果，如果没有，则发送一个404错误作为响应 |
| `get()`                                  | 根据主键返回行，如果没找到，返回None           |
| `get_or_404()`                           | 根据主键返回行，如果没找到，产生404错误          |
| `count()`                                | 返回查询结果的个数                      |
| `paginate()`     | 返回一个`Pagination`对象包含具体范围的结果 |                                |

关系与查询类似。

```python
>>> users = user_role.users
>>> users
[<User u'susan'>, <User u'david'>]
>>> users[0].role
<Role u'User'>
```

`user_role.users`查询有一点小问题。隐式的查询执行了当`user_role.users`表达式内部调用`call()`返回用户的列表。因为查询对象是隐藏的，不可能使用额外的查询过滤器来精致它。在这个特别的例子中，请求用户列表以字母表顺序返回是很有用的。

关系的配置被修改成`lazy='dynamic'` 不会自动执行

```python
class Role(db.Model):
# ...
users = db.relationship('User', backref='role', lazy='dynamic')
# ..
```

以这种方式配置关系，`user_role.users`返回了一个还没有执行的查询。所以可以为它增加过滤器

```python
>>> user_role.users.order_by(User.username).all()
[<User u'david'>, <User u'susan'>]
>>> user_role.users.count()
2
```

#### 在视图函数中使用数据库

在之前部分描述的数据库操作可以在视图函数内直接使用。

下面显示了一个新版本的主页路由记录用户输入的名称到数据库

```python
@app.route('/', methods=['GET', 'POST'])
def index():
	form = NameForm()
	if form.validate_on_submit():
		user = User.query.filter_by(username=form.name.data).first()
		if user is None:
			user = User(username = form.name.data)
			db.session.add(user)
			session['known'] = False
		else:
			session['known'] = True
		session['name'] = form.name.data
		form.name.data = ''
		return redirect(url_for('index'))
	return render_template('index.html',form = form, name =session.get('name'),known = session.get('known', False))
```

更新之后的模板

*Example 5-6. templates/index.html*

```html
{% extends "base.html" %}
{% import "bootstrap/wtf.html" as wtf %}

{% block title %}Flasky{% endblock %}

{% block page_content %}
    <div class="page-header">
        <h1>Hello, {% if name %}{{ name }}{% else %}Stranger{% endif %}</h1>
        {% if not known %}
            <p>Pleased to meet you!</p>
        {% else %}
            <p>Happy to see you again!</p>
        {% endif %}
    </div>
    {{ wtf.quick_form(form) }}
{% endblock %}
```

#### 集成Python Shell

每次一个Shell被开启，然后导入数据库实例和模型是非常乏味的工作。为了避免不断的重复这些导入操作，Flask-Script的shell命令行可以被配置成自动导入特定的对象

为了添加对象到shell命令的导入列表，需要注册一个`make_context`回调函数

*Example 5-7. hello.py: 添加shell上下文*

```python
from flask.ext.script import Shell
def make_shell_context():
    return dict(app=app, db=db, User=User, Role=Role)
manager.add_command("shell", Shell(make_context=make_shell_context))
```

`make_shell_context()`函数注册 应用，数据库实例和模型以便他们可以自动被导入到shell

```python
$ python hello.py shell
>>> app
<Flask 'app'>
>>> db
<SQLAlchemy engine='sqlite:////home/flask/flasky/data.sqlite'>
>>> User
<class 'app.User'>
```

#### 使用Flask-Migrate进行数据库迁移

当你进行一个应用的开发，你会发现你的数据库模型需要改变，同时数据库也需要被更新

Flask-SQLAlchemy只在他们已经不存在的时候才会创建数据库表，所以唯一的方式更新表就是先摧毁之前的老表，当然，这会引起数据库中所有的数据丢失。

一个更好的解决方案是使用*数据库迁移*框架，和源代码版本控制工具跟踪源代码文件的改变一样，一个数据库迁移框架会根据一个数据库模式的改变，增加的改变可以应用到数据库

Flask应用可以使用Flask-Migrate框架，一个轻量级的Alembic包装集成了Flask-Script提供了所有Flask-Script命令行的操作

##### 创建一个迁移仓库

开始之前，Flask-Migrate必须被安装到虚拟环境

```shell
(venv) $ pip install flask-migrate
```

*Example 5-8. hello.py: Flask-Migrate 配置*

```python
from flask.ext.migrate import Migrate, MigrateCommand
# ...
migrate = Migrate(app, db)
manager.add_command('db', MigrateCommand)
```

为了暴露数据库迁移命令，Flask-Migrate暴露了一个`MigrateCommand`类被附加到Flask-Script的`manager`对象上。在这个例子中，使用`db`命令被附加了。

在数据库迁移可以被操作之前，必须要使用`init`子命令创建一个迁移仓库

```shell
(venv) $ python hello.py db init
Creating directory /home/flask/flasky/migrations...done
Creating directory /home/flask/flasky/migrations/versions...done
Generating /home/flask/flasky/migrations/alembic.ini...done
Generating /home/flask/flasky/migrations/env.py...done
Generating /home/flask/flasky/migrations/env.pyc...done
Generating /home/flask/flasky/migrations/README...done
Generating /home/flask/flasky/migrations/script.py.mako...done
Please edit configuration/connection/logging settings in
'/home/flask/flasky/migrations/alembic.ini' before proceeding
```

这个命令创建一个*migrations*文件夹，迁移脚本将会被存储到这个地方。

##### 创建一个迁移脚本

在Alembic，一个数据库迁移被一个*migration script*表示。这个脚本有两个函数叫`upgrade()`和`downgrade()`。`upgrade()`保存数据库改变，`downgrade()`删除他们。

通过添加和删除改变的能力，Alembic可以在改变历史的任何一点上重新配置数据库

Alembic迁移可以使用`revision`和`migrate`命令手动或自动创建，相应地，手动迁移创建了一个迁移骨架脚本使用空的`upgrade()`和`downgrade()`函数需要被开发人员来实现

一个自动迁移，为`upgrade()`和`downgrade()`函数生成代码，通过比较模型定义和数据库当前状态

`migrate`子命令创建了一个自动迁移脚本

```shell
(venv) $ python hello.py db migrate -m "initial migration"
INFO [alembic.migration] Context impl SQLiteImpl.
INFO [alembic.migration] Will assume non-transactional DDL.
INFO [alembic.autogenerate] Detected added table 'roles'
INFO [alembic.autogenerate] Detected added table 'users'
INFO [alembic.autogenerate.compare] Detected added index
'ix_users_username' on '['username']'
Generating /home/flask/flasky/migrations/versions/1bc
594146bb5_initial_migration.py...done
```

##### 升级数据库

一旦一个迁移脚本被接收到，它就会使用`db upgrade`命令更新数据库

```shell
(venv) $ python hello.py db upgrade
INFO [alembic.migration] Context impl SQLiteImpl.
INFO [alembic.migration] Will assume non-transactional DDL.
INFO [alembic.migration] Running upgrade None -> 1bc594146bb5, initial migration
```

对于第一个迁移来说，这个是有效等价于调用`db.create_all()`，但是在成功的迁移，`upgrade`命令更新表而不会影响他们的内容

### 第六章 邮件

很多类型的应用当特定的事件发生时需要提醒用户。通常交流的方式就是邮件，尽管来自Python标准库的`smtplib`可以被用来发送邮件，Flask-Mail扩展包装了smtplib，和Flask优雅的集成

#### 使用Flask-Mail支持邮件

使用pip安装FLask-Mail

```shell
(venv) $ pip install flask-mail
```

*Table 6-1. Flask-Mail SMTP server configuration keys*

| 键             | 默认值       | 描述             |
| ------------- | --------- | -------------- |
| MAIL_HOSTNAME | localhost | 邮件服务器的主机名或IP地址 |
| MAIL_PORT     | 25        | 邮件服务器的端口号      |
| MAIL_USE_TLS  | False     | 启用TLS安全        |
| MAIL_USE_SSL  | False     | 启用SSL安全        |
| MAIL_USERNAME | None      | 邮箱账户名          |
| MAIL_PASSWORD | None      | 邮箱密码           |

在开发过程中使用一个额外的SMTP服务器会更便捷

```python
import os
# ...
app.config['MAIL_SERVER'] = 'smtp.googlemail.com'
app.config['MAIL_PORT'] = 587
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USERNAME'] = os.environ.get('MAIL_USERNAME')
app.config['MAIL_PASSWORD'] = os.environ.get('MAIL_PASSWORD')
```

Flask-Mail初始化

```python
from flask.ext.mail import Mail
mail = Mail(app)
```

两个保存邮件服务器的用户名和密码的环境变量需要在环境中被定义，设置这些变量

```shell
(venv) $ export MAIL_USERNAME=<Gmail username>
(venv) $ export MAIL_PASSWORD=<Gmail password>
```

##### 从Python Shell发送邮件

发送一个测试邮件

````python
(venv) $ python hello.py shell
>>> from flask.ext.mail import Message
>>> from hello import mail
>>> msg = Message('test subject', sender='you@example.com',
...		recipients=['you@example.com'])
>>> msg.body = 'text body'
>>> msg.html = '<b>HTML</b> body'
>>> with app.app_context():
...		mail.send(msg)
````

注意到Flask-Mail的`send()`函数使用`current_app`，所以它需要在一个激活的应用上下文中执行

##### 应用集成邮件

为了避免每次都要手动的创建邮箱消息，最好应用邮件常用的部分到一个函数，这个函数可以使用JInja2的模板引擎渲染邮件

```python
from flask.ext.mail import Message

app.config['FLASKY_MAIL_SUBJECT_PREFIX'] = '[Flasky]'
app.config['FLASKY_MAIL_SENDER'] = 'Flasky Admin <flasky@example.com>'

def send_email(to, subject, template, **kwargs):
	msg = Message(app.config['FLASKY_MAIL_SUBJECT_PREFIX'] + subject,
			sender=app.config['FLASKY_MAIL_SENDER'], recipients=[to])
	msg.body = render_template(template + '.txt', **kwargs)
	msg.html = render_template(template + '.html', **kwargs)
	mail.send(msg)
```

这个函数依赖两个应用特殊的配置key，定义了一个主题的前缀字符串，一个被用作发送者点地址，`send_email`函数接收目的地址，主题行，一个邮箱主体的模板，一个关键字参数列表。模板名不能有扩展名，以便那两个版本的模板可以被用来进行普通文本和富文本的主体。

*Example 6-4. hello.py: Email example*

```python
# ...
app.config['FLASKY_ADMIN'] = os.environ.get('FLASKY_ADMIN')
# ...
@app.route('/', methods=['GET', 'POST'])
def index():
	form = NameForm()
	if form.validate_on_submit():
		user = User.query.filter_by(username=form.name.data).first()
		if user is None:
			user = User(username=form.name.data)
			db.session.add(user)
			session['known'] = False
			if app.config['FLASKY_ADMIN']:
    			send_email(app.config['FLASKY_ADMIN'], 'New User',
'mail/new_user', user=user)
		else:
			session['known'] = True
		session['name'] = form.name.data
		form.name.data = ''
		return redirect(url_for('index'))
	return render_template('index.html',form=form,name=session.get('name'),known=session.get('known', False))
```

除了MAIL_USERNAME和MAIL_PASSWORD环境变量，这个版本的应用需要FLASKY_ADMIN环境变量

```shell
(venv) $ export FLASKY_ADMIN=<your-email-address>
```

##### 发送匿名邮件

如果你发送了一些测试邮件，你可能注意到`mail.send()`方法会阻塞几秒，当邮件被发送的时候，使浏览器在这段时间内好像没有响应一样，为了避免不必要的延迟，邮件发送函数可以被移动到一个背景线程

*Example 6-5. hello.py: Asynchronous email support*

```python
from threading import Thread

def send_async_email(app, msg):
	with app.app_context():
    	mail.send(msg)
        
def send_email(to, subject, template, **kwargs):
	msg = Message(app.config['FLASKY_MAIL_SUBJECT_PREFIX'] + subject,
		sender=app.config['FLASKY_MAIL_SENDER'], recipients=[to])
	msg.body = render_template(template + '.txt', **kwargs)
	msg.html = render_template(template + '.html', **kwargs)
	thr = Thread(target=send_async_email, args=[app, msg])
	thr.start()
	return thr
```

### 第七章 大型应用结构

尽管一个小应用存储在一个脚本是非常便捷的，但是这种方法可扩展性不好。随着应用变得复杂，使用一个大的源文件变得非常有问题。

不像大多数其他web框架，	Flask不会给大型项目强加一个具体的组织结构。

组织应用的结构完全交给程序员来处理。在这一章，一个可能的方式组织一个大型应用在一个包或模块内。

#### 项目结构

```python
|-flasky
	|-app/
		|-templates/
		|-static/
		|-main/
			|-__init__.py
			|-errors.py
			|-forms.py
			|-views.py
		|-__init__.py
		|-email.py
		|-models.py
|-migrations/
|-tests/
	|-__init__.py
	|-test*.py
|-venv/
|-requirements.txt
|-config.py
|-manage.py
```

这个结构有4个顶级文件夹

- Flask应用放在app文件夹
- migrations文件夹包含数据库迁移脚本
- 单元测试放在tests包内
- venv文件夹包含Python的虚拟环境

也有一些其他新的文件

- requirement.txt列出了包的依赖
- config.py存储配置设置
- manage.py启动应用和其他应用任务

为了帮助完全的理解这个结构，下面的部分描述了处理hello.py的过程

#### 配置选项

应用经常需要多个配置集合，最好的例子是在开发，测试，生产阶段使用不同的数据库。以便他们不会互相干扰

*Example 7-2. config.py: Application configuration*

```python
import os

basedir = os.path.abspath(os.path.dirname(__file__))

class Config:
	SECRET_KEY = os.environ.get('SECRET_KEY') or 'hard to guess string'
	SQLALCHEMY_COMMIT_ON_TEARDOWN = True
	FLASKY_MAIL_SUBJECT_PREFIX = '[Flasky]'
	FLASKY_MAIL_SENDER = 'Flasky Admin <flasky@example.com>'
	FLASKY_ADMIN = os.environ.get('FLASKY_ADMIN')
    
	@staticmethod
	def init_app(app):
		pass
    
class DevelopmentConfig(Config):
	DEBUG = True
	MAIL_SERVER = 'smtp.googlemail.com'
	MAIL_PORT = 587
	MAIL_USE_TLS = True
	MAIL_USERNAME = os.environ.get('MAIL_USERNAME')
	MAIL_PASSWORD = os.environ.get('MAIL_PASSWORD')
	SQLALCHEMY_DATABASE_URI = os.environ.get('DEV_DATABASE_URL') or \
		'sqlite:///' + os.path.join(basedir, 'data-dev.sqlite')

class TestingConfig(Config):
	TESTING = True
	SQLALCHEMY_DATABASE_URI = os.environ.get('TEST_DATABASE_URL') or \
		'sqlite:///' + os.path.join(basedir, 'data-test.sqlite')
    
    
class ProductionConfig(Config):
	SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL') or \
		'sqlite:///' + os.path.join(basedir, 'data.sqlite')
        
config = {
	'development': DevelopmentConfig,
	'testing': TestingConfig,
	'production': ProductionConfig,
	'default': DevelopmentConfig
}
```

`Config`基础类包含了所有常用的配置，不同的子类定义了具体的配置。额外的配置可以按需添加。

为了让配置更灵活更安全，一些变量可以可选的从环境变量中导入。例如，`SECRET_KEY`的值，因为它敏感的特性，可以在环境变量中设置，但是如果环境中没有定义它可以提供一个默认的值。

在三个配置中`SQLALCHMEY_DATABASE_URI`被赋值了三个不同的值。这可以让应用运行在不同的配置，每个配置使用一个不同的数据库。

配置类可以定义一个`init_app()`方法接收一个应用实例作为参数。这样具体配置的初始化可以被执行。对于现在来说，基础类`Config`实现了一个空的`init_app()`方法

在配置脚本的底部，不同的配置文件被注册到了一个`config`字典中。其中一个配置被作为默认的注册。

#### 应用包

应用包是所有应用代码，模板和静态文件存在的地方。现在简单的叫`app`。当然你也可以定义一个应用具体的名称。*templates*和`static`文件夹是应用包的一部分。所以这两个文件夹被移动到了`app`内部。数据库模型和email支持函数也被移动到了这个包内。分别在它自己的模块`app/models.py`和`app/email.py`。

##### 使用一个应用工厂

如果应用在全局领域内被创建，没有办法动态的改变配置。脚本一运行，应用实例就已经被创建了。这对单元测试来说特别重要，因为有时必须运行应用在不同的配置文件下为了更好的测试覆盖率

这个问题的解决方案就是推迟应用的创建，通过把它移动到一个工厂函数中。这不仅给了脚本时间去设置配置，也有能力去创建多个应用实例。在测试中这个是非常有用的。

应用工厂在`app`包构造器中定义

这个构造器导入当前使用的大部分Flask扩展，但是因为没有应用实例来初始化他们，构造器创建他们未初始化的，通过不传递参数给他们的构造器。

`create_app()`是应用工厂，接收一个应用要使用的配置文件名。

配置设置存储在config.py定义的类中可以使用`from_object()`方法直接导入到应用中。

一般应用被创建和被配置，扩展可以被初始化。调用扩展的`init_app()`方法完成他们的初始化

*Example 7-3. app/__init__.py: Application package constructor*

```python
from flask import Flask
from flask_bootstrap import Bootstrap
from flask_mail import Mail
from flask_moment import Moment
from flask_sqlalchemy import SQLAlchemy

from config import config

bootstrap = Bootstrap()
mail = Mail()
moment = Moment()
db = SQLAlchemy()


def create_app(config_name):
    app = Flask(__name__)
    app.config.from_object(config[config_name])
    config[config_name].init_app(app)

    bootstrap.init_app(app)
    mail.init_app(app)
    moment.init_app(app)
    db.init_app(app)

    # attach routes and custom error pages here

    return app
```

工厂方法返回了创建的应用实例，但是注意由工厂方法创建的应用的当前状态是未完成的。因为他们没有路由和自定义错误页面处理器。这是下一部分的主题

##### 使用蓝图实现应用功能

现在应用在运行时创建，`app.route`装饰器只在`create_app()`被调用之后才存在，不过已经太迟了。像路由，错误页面处理器都会出现同样的问题，因为他们使用`app.errorhandler`装饰器定义。

Flask提交了一个较好的方案叫*蓝图*。一个蓝图和应用相似，它也可以用来定义路由，不同之处在于蓝图中的路由会处在休眠状态，直到蓝图被注册到应用中。

像应用一样，蓝图可以被定义在一个单独文件或者更复杂的多个模板在一个包内的结构。

为了最大的灵活性，在应用包中的一个子包内创建来保存蓝图。

示例7-4显示了包构造器来创建蓝图

*Example 7-4. app/main/__init__.py: Blueprint creation*

```python
from flask import Blueprint
main = Blueprint('main', __name__)
from . import views, errors
```

蓝图通过实例化一个`Blueprint`类的对象创建。这个类的构造器接收两个必须的参数，蓝图的名称和蓝图所在的模块或包的名称。

与应用程序一样，在大多数情况下，Python的`__name__`变量是正确的值

应用的路由存储在包内的`app/main/views.py`模块，错误处理器存储在`app/main/errors.py`模块。导入这些模板使路由和错误处理器和蓝图关联。

非常重要要注意，模块在`app/__init__.py`脚本的底部被导入。这样避免了循环依赖，因为`views.py`和`errors.py`需要被导入到`main`蓝图

蓝图注册到应用在`create_app()`工厂函数中。

```python
def create_app(config_name):
# ...
from .main import main as main_blueprint
app.register_blueprint(main_blueprint)
return app
```

*Example 7-6. app/main/errors.py: Blueprint with error handlers*

```python
from flask import render_template
from . import main

@main.app_errorhandler(404)
def page_not_found(e):
	return render_template('404.html'), 404

@main.app_errorhandler(500)
def internal_server_error(e):
	return render_template('500.html'), 500
```

当在一个蓝图内部写错误处理器的不同地方在于，如果`errorhandler`装饰器被使用，处理器只会被蓝图内部产生的错误有效。

为了安装应用范围的错误处理器，必须使用`app_errorhandler`

*Example 7-7. app/main/views.py: Blueprint with application routes*

```python
from datetime import datetime
from flask import render_template, session, redirect, url_for
from . import main
from .forms import NameForm
from .. import db
from ..models import User

@main.route('/', methods=['GET', 'POST'])
def index():
	form = NameForm()
	if form.validate_on_submit():
		# ...
		return redirect(url_for('.index'))
	return render_template('index.html',form=form,name=session.get('name'),known=session.get('known', False),current_time=datetime.utcnow())
```

在蓝图内部写视图函数有两个主要的不同的地方。

第一，像之前错误处理器一样，路由装饰器来自于蓝图。

第二个不同的地方是`url_for()`函数的用法。

这个函数的第一个参数是路由的端点名，对于基于应用的路由来说，默认的端点名是视图函数的名称。

使用蓝图的不同地方在于Flask 为所有来自蓝图的端点使用了一个命名空间。所以多个蓝图可以使用相同的端点名定义视图函数而不会产生冲突。

命名空间是蓝图的名称(蓝图构造器的第一个参数)，所以`index()`视图函数使用端点名`main.index`注册，它的URL可以使用`url_for('main.index')`获得。

`url_for()`函数也支持在蓝图中短格式的端点名，蓝图的名称被忽略。像`url_for('.index')`。使用这个符号，蓝图为当前请求所使用，这意味着在同一个蓝图内重定向，可以使用短格式。跨蓝图的重定向必须使用命令空间的端点名。

##### 启动脚本

在顶层文件夹的`manage.py`	文件用来启动应用

*Example 7-8. manage.py: Launch script*

```python
#!/usr/bin/env python3
import os
from app import create_app, db
from app.models import User, Role
from flask.ext.script import Manager, Shell
from flask.ext.migrate import Migrate, MigrateCommand

app = create_app(os.getenv('FLASK_CONFIG') or 'default')
manager = Manager(app)
migrate = Migrate(app, db)

def make_shell_context():
	return dict(app=app, db=db, User=User, Role=Role)
manager.add_command("shell", Shell(make_context=make_shell_context))
manager.add_command('db', MigrateCommand)

if __name__ == '__main__':
manager.run()
```

脚本通过创建一个应用开始，如果环境变量FLASK_CONFIG被定义，使用它的配置，如果没有定义，使用默认的配置。

Flask-Script，Flask-Migrate和自定义Python shell上下文接着被初始化。

##### 需求文件

应用必须包含一个需求文件，记录了所有包依赖和对应的版本号。在虚拟环境需要在多个机器上生成的情况下是非常重要的。

这个文件可以使用pip的命令自动生成

```shell
(venv) $ pip freeze >requirements.txt
```

这是一个好主意，每次一个包被安装或更新的时候刷新该文件。

```shell
Flask==0.10.1
Flask-Bootstrap==3.0.3.1
Flask-Mail==0.9.0
Flask-Migrate==1.1.0
Flask-Moment==0.2.0
Flask-SQLAlchemy==1.0
Flask-Script==0.6.6
Flask-WTF==0.9.4
Jinja2==2.7.1
Mako==0.9.1
MarkupSafe==0.18
SQLAlchemy==0.8.4
WTForms==1.0.5
Werkzeug==0.9.4
alembic==0.6.2
blinker==1.3
itsdangerous==0.23
```

当你需要构建一个完美的虚拟环境复制。你可以创建一个新的虚拟环境，然后运行下面的命令

```shell
(venv) $ pip install -r requirements.txt
```

##### 单元测试

*Example 7-9. tests/test_basics.py: Unit tests*

```python
import unittest
from flask import current_app
from app import create_app, db

class BasicsTestCase(unittest.TestCase):
	def setUp(self):
		self.app = create_app('testing')
		self.app_context = self.app.app_context()
		self.app_context.push()
		db.create_all()
        
	def tearDown(self):
		db.session.remove()
		db.drop_all()
		self.app_context.pop()
        
	def test_app_exists(self):
		self.assertFalse(current_app is None)
        
	def test_app_is_testing(self):
		self.assertTrue(current_app.config['TESTING'])
```

测试使用来自Python标准库的标准`unittest`包编写的。`setUp()`和`tearDown()`方法在每次测试之前和之后执行。

任何方法有一个以`test_`开头的名字都会被当做测试执行。

为了运行单元测试，一个自定义的命令可以被增加到`manage.py`脚本

*Example 7-10. manage.py: Unit test launcher command*

```python
@manager.command
def test():
	"""Run the unit tests."""
	import unittest
	tests = unittest.TestLoader().discover('tests')
	unittest.TextTestRunner(verbosity=2).run(tests)
```

`manage.command`装饰器可以让实现一个自定义命令更简单。被装饰的函数的名字被用作命令名

单元测试可以像下面一样被执行

```shell
(venv) $ python manage.py test
test_app_exists (test_basics.BasicsTestCase) ... ok
test_app_is_testing (test_basics.BasicsTestCase) ... ok
.----------------------------------------------------------------------
Ran 2 tests in 0.001s
OK
```

##### 数据库建立

重构的应用使用了不同的数据库。

数据库的表可以被创建或更新到最新的版本使用一个命令：

```shell
(venv) $ python manage.py db upgrade
```

## 第二部分 例子：一个社交博客应用

### 第八章 用户认证

大多数应用需要跟踪它的用户是谁。当用户连接到应用，他们认证它，让他们的身份已知。一旦应用知道它的用户是谁，它可以提供一个自定义的体验。

大多数常用的认证方法需要用户提供一份身份信息，和一个安全密码。在这一章，由Flask创建一个完整的认证系统。

#### 使用Flask认证扩展

下面是将会用到的包：

- Flask-Login 为登录的用户管理用户会话
- Werkzeug 密码哈希和校验
- itsdangerous 加密安全的token生成和校验

除了具体认证的包，下面一般目的的扩展也会被用到：

- Flask-Mail发送认证相关的邮件
- Flask-Bootstrap HTML模板
- Flask-WTF web表单

#### 密码安全

安全的存储用户密码的关键是不存储密码本身，而是存储密码的哈希值。

一个密码哈希函数接收一个密码作为输入，使用一个或多个加密策略进行转换。密码的哈希可以就地和真实的密码校验，因为哈希函数是可重复的，给定同样的输入，总是产生同样的结果

##### 使用Werkzeug 哈希密码

Werkzeug的安全模块便捷的实现了安全的密码哈希。

这个功能由两个函数提供，相应的使用在注册和校验阶段。

- `enerate_password_hash(password, method=pbkdf2:sha1, salt_length=8)`：这个函数接收一个普通文本的密码，返回一个密码哈希作为字符串可以被存储在用户数据库。`method`和`salt_length`的默认值对大多数情况下都是有效的。
- `check_password_hash(hash, password)`：这个函数接收一个从数据库获取的密码哈希和用户输入的密码。一个True的返回值表明密码是正确的。

*Example 8-1. app/models.py: Password hashing in User model*

```python
from werkzeug.security import generate_password_hash, check_password_hash

class User(db.Model):
	# ...
	password_hash = db.Column(db.String(128))
    
	@property
	def password(self):
		raise AttributeError('password is not a readable attribute')
        
	@password.setter
	def password(self, password):
		self.password_hash = generate_password_hash(password)
        
	def verify_password(self, password):
r		eturn check_password_hash(self.password_hash, password)
```

密码哈希函数通过一个叫`password`的只读属性实现。当这个属性被设置时会调用Werkzeug的`generate_password_hash()`并将结果写到`password_hash`字段。试图读取`password`将会返回一个错误，因为源密码一旦被哈希就不能被恢复。

`verify_password`方法接收一个密码并把它传递给Werkzeug的`check_password_hash()`进行校验，如果这个方法返回True，说明密码正确。

密码哈希的功能现在完成了，可以在shell中进行测试

```shell
(venv) $ python manage.py shell
>>> u = User()
>>> u.password = 'cat'
>>> u.password_hash
'pbkdf2:sha1:1000$duxMk0OF$4735b293e397d6eeaf650aaf490fd9091f928bed'
>>> u.verify_password('cat')
True
>>> u.verify_password('dog')
False
>>> u2 = User()
>>> u2.password = 'cat'
>>> u2.password_hash
'pbkdf2:sha1:1000$UjvnGeTP$875e28eb0874f44101d6b332442218f66975ee89'
```

注意用户u和u2有完全不同的密码哈希，尽管他们都使用同一个密码，为了确保这个功能在未来继续工作，以上的测试可以被作为一个单元测试，很容易被重复。

*Example 8-2. tests/test_user_model.py: Password hashing tests*

```python
import unittest
from app.models import User


class UserModelTestCase(unittest.TestCase):
    def test_password_setter(self):
        u = User(password='cat')
        self.assertTrue(u.password_hash is not None)

    def test_no_password_getter(self):
        u = User(password='cat')
        with self.assertRaises(AttributeError):
            u.password

    def test_password_verification(self):
        u = User(password='cat')
        self.assertTrue(u.verify_password('cat'))
        self.assertFalse(u.verify_password('dog'))

    def test_password_salts_are_random(self):
        u = User(password='cat')
        u2 = User(password='cat')
        self.assertTrue(u.password_hash != u2.password_hash)

```

#### 创建一个认证蓝图

相关用户认证系统的路由可以被添加到`auth`蓝图。

为不同的应用功能集合使用不同的蓝图 保持代码有组织的一个很好的方式。

`auth`蓝图将会放在同样名字的Python包中，蓝图的包构造器创建蓝图对象，并从views.py模块中导入路由

*Example 8-3. app/auth/__init__.py: Blueprint creation*

```python
from flask import Blueprint
auth = Blueprint('auth', __name__)
from . import views
```

`app/auth/views.py`模块，导入蓝图，并使用它的route装饰器定义了和认证相关的路由。现在增加了一个`/login`路由，渲染同个名字的容器模板

*Example 8-4. app/auth/views.py: Blueprint routes and view functions*

```python
from flask import render_template
from . import auth
@auth.route('/login')
def login():
	return render_template('auth/login.html')
```

注意到`render_template()`的模板文件被存储在auth文件夹内。通过存储蓝图模板在他们自己的文件夹，不会和其他蓝图发生冲突。

`auth`蓝图需要在`create_app()`工厂函数中附加到应用上。

```python
def create_app(config_name):
# ...
from .auth import auth as auth_blueprint
app.register_blueprint(auth_blueprint, url_prefix='/auth')

return app
```

在注册蓝图中的`url_prefix`参数是可选的，当使用的时候，所有在这个蓝图定义的路由都会有这个给定的前缀，例如`/auth`，`/login`路由将会被注册为`/auth/login`，全限定URL变成了`http://localhost:5000/auth/login`。

#### 使用Flask-Login进行用户认证

当用户登录到应用，他们的认证状态必须被记录，以便当他们导航到其他页面时会被记住。Flask-Login是一个小的但是非常有用的扩展，尤其在一个用户认证系统中。

开始之前，扩展需要被安装到虚拟环境：

```shell
(venv) $ pip install flask-login
```

##### 准备用来登录的用户模型

为了能够应用的User模型工作，Flask-Login扩展需要实现一些方法。

*Table 8-1. Flask-Login user methods*

| 方法                   | 描述                                       |
| -------------------- | ---------------------------------------- |
| `is_authenticated()` | 如果用户有登录身份，必须返回True，否则返回False             |
| `is_active()`        | 如果用户允许登录，必须返回True，否则返回False，一个False返回值可以用来禁用账户 |
| `is_anonymous()`     | 对于正常用户必须总是返回False                        |
| `get_id()`           | 必须返回用户的唯一身份，使用Unicode字符串编码               |

这四个方法直接在模型类里作为方法实现，但是Flask-Login提供了更容易的选择`UserMixin`类默认实现对于大多情况下都是合适的。

*Example 8-6. app/models.py: Updates to the User model to support user logins*

```python
from flask.ext.login import UserMixin

class User(UserMixin, db.Model):
	__tablename__ = 'users'
	id = db.Column(db.Integer, primary_key = True)
	email = db.Column(db.String(64), unique=True, index=True)
	username = db.Column(db.String(64), unique=True, index=True)
	password_hash = db.Column(db.String(128))
	role_id = db.Column(db.Integer, db.ForeignKey('roles.id'))
```

注意到`email`字段也被添加了。在这个应用，用户将会使用他们的email登录，因为相比较他们的用户名来说他们不太可能忘记他们的邮箱地址。

Flask-Login在应用的工厂函数被初始化

*Example 8-7. `app/__init__.py`: Flask-Login initialization*

```python
from flask.ext.login import LoginManager

login_manager = LoginManager()
login_manager.session_protection = 'strong'
login_manager.login_view = 'auth.login'

def create_app(config_name):
	# ...
	login_manager.init_app(app)
	# ...
```

`LoginManager`的`session_protection`的属性可以设置成None，`'basic'`，`'strong'`来提供不同级别的安全。使用`'strong'`设置，Flask-Login跟踪客户端的IP地址和浏览器类型，如果侦测到改变会使用户退出。

`login_view`属性设置了登录页面的端点，因为路由是在一个蓝图内部，所以它需要蓝图名的前缀

最后，Flask-Login需要应用建立一个回调函数根据给定的身份来加载用户

*Example 8-8. app/models.py: User loader callback function*

```python
from . import login_manager

@login_manager.user_loader
def load_user(user_id):
	return User.query.get(int(user_id))
```

加载用户的回调函数接收一个用户的ID作为一个Unicode字符串，这个函数的返回值必须是一个用户对象，否则是None

##### 保护路由

为了保护路由以便只能被认证过的用户可以访问，Flask-Login提供了一个`login_required`装饰器，用法如下：

```python
from flask.ext.login import login_required

@app.route('/secret')
@login_required
def secret():
	return 'Only authenticated users are allowed!'
```

如果这个路由被一个没有认证的用户访问，Flask-Login将会拦截这个请求，然后把用户发送到登录页面

##### 添加一个登录表单

登录表单有一个邮件地址的文本字段，一个密码字段，一个记住我的复选框，一个提交按钮

*Example 8-9. app/auth/forms.py: Login form*

```python
from  flask_wtf import Form
from wtforms import StringField, PasswordField, BooleanField, SubmitField
from wtforms.validators import DataRequired, Email, Length


class LoginForm(Form):
    email = StringField('Email', validators=[DataRequired(), Length(1, 64), Email()])
    password = PasswordField('Password', validators=[DataRequired()])
    remember_me = BooleanField('Keep me logged in')
    submit = SubmitField('Log In')
   
```

email字段利用了来自WTForm的`Length()`和`Email()`校验器。`PasswordField`代表一个`type="password"`的`<input>`元素。`BooleanField`类代表一个复选框。

和登录页面相关的模板被放在了`auth/login.html`。这个模板需要使用Flask-Bootstrap的`wtf.quick_form(form)`宏来渲染表单。

在*base.html*模板中的导航栏需要额外的显示`Sign In`或`Sign Out`链接取决于当前用户的登录状态

*Example 8-10. app/templates/base.html: Sign In and Sign Out navigation bar links*

```html
<ul class="nav navbar-nav navbar-right">
	{% if current_user.is_authenticated() %}
	<li><a href="{{ url_for('auth.logout') }}">Sign Out</a></li>
	{% else %}
	<li><a href="{{ url_for('auth.login') }}">Sign In</a></li>
	{% endif %}
</ul>
```

额外使用的`current_user`变量由Flask-Login定义，自动对视图函数和模板可用。这个变量包含了当前登录的用户，如果用户没有登录的话是一个代理匿名用户对象。

匿名对象响应`is_authenticated()`方法为False。所以这是便捷的方式知道当前用户用否登录。

##### 用户登录

实现`login()`视图函数

*Example 8-11. app/auth/views.py: Sign In route*

```python
from flask import render_template, redirect, request, url_for, flash
from flask_login import login_user
from . import auth
from ..models import User
from .forms import LoginForm


@auth.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        user = User.query.filter_by(email=form.email.data).first()
        if user is not None and user.verify_password(form.password.data):
            login_user(user, form.remember_me.data)
            return redirect(request.args.get('next')) or url_for('main.index')
        flash('Invalid username or password')
    return render_template('auth/login.html', form=form)

```

视图函数创建了一个`LoginForm`对象，并像一个表单一样使用它。当请求是GET的时候，视图函数只会渲染模板，然后显示表单。当表单以POST请求提交时，Flask-WTF的`validate_on_submit()`函数会校验表单的变量，接着试图登录用户

为了登录用户，函数使用表单提供的email从数据库加载用户，如果一个给定邮件地址的用户存在，接着会使用`verify_password()`方法校验表单中的Password字段，如果密码是有效的，Flask-Login的`login_user()`函数被调用，在当前用户会话记录用户已经登录。`login_user()`函数接收需要登录的用户和一个可选的记住我布尔值，如果这个参数的值是False，用户浏览器窗口关闭，用户会话就会失效。所以用户下次必须要重新登录。

如果这个参数值是True，一个长期的cookie被设置到用户的浏览器，用户会话可以被重新存储。

如果登录表单显示给用户来阻止一个访问受保护的URL的未授权访问，FLask-Login保存原来的URL路径在查询字符串参数的next，可以从`request.args`字典中访问。

如果next查询字符串参数不可用，使用重定向到主页代替。

如果用户提供的邮箱或密码不正确，一个闪烁消息被设置表单会被重新渲染，让用户重试

登录模板需要被更新来渲染表单

*Example 8-12. app/templates/auth/login.html: Render login form*

```html
{% extends "base.html" %}
{% import "bootstrap/wtf.html" as wtf %}

{% block title %}Flasky - Login{% endblock %}

{% block page_content %}
<div class="page-header">
	<h1>Login</h1>
</div>
<div class="col-md-4">
{{ wtf.quick_form(form) }}
 </div>
{% endblock %}
```

##### 用户退出

退出路由的实现显示在下方

*Example 8-13. app/auth/views.py: Sign Out route*

```python
from flask.ext.login import logout_user, login_required

@auth.route('/logout')
@login_required
def logout():
	logout_user()
	flash('You have been logged out.')
	return redirect(url_for('main.index'))
```

为了让用户退出，Flask-Login的`logout_user()`函数被调用，删除和重置用户会话，退出被完成有一个闪烁消息确认行为并重定向到主页

##### 测试登录

为了校验登录功能工作，主页可以更新到问候根据登录用户的名字

*Example 8-14. app/templates/index.html: Greet the logged-in user*

```html
Hello,
{% if current_user.is_authenticated %}
{{ current_user.username }}
{% else %}
Stranger
{% endif %}!
```

在这个模板中再次使用`current_user.is_authenticated`来判断用户是否登录

因为用户注册功能还没有实现，一个新的用户可以通过shell注册：

```shell
(venv) $ python manage.py shell
>>> u = User(email='john@example.com', username='john', password='cat')
>>> db.session.add(u)
>>> db.session.commit()
```

之前创建的用户现在可以登录了。

#### 新用户注册

当新的用户想要变成应用的会员，他们注册以便他们被知道和可以登录。在登录页面的一个链接会发送他们到注册页面，他们可以输入他们的邮箱，用户名和密码

##### 添加一个用户注册表单

这个表单将会被用在注册页面，要求用户输入邮箱，用户名和密码

*Example 8-15. app/auth/forms.py: User registration form*

```python
from flask.ext.wtf import Form
from wtforms import StringField, PasswordField, BooleanField, SubmitField
from wtforms.validators import Required, Length, Email, Regexp, EqualTo
from wtforms import ValidationError
from ..models import User

class RegistrationForm(Form):
	email = StringField('Email', validators=[Required(), Length(1, 64),Email()])
	username = StringField('Username', validators=[Required(), Length(1, 64), Regexp('^[A-Za-z][A-Za-z0-9_.]*$', 0,'Usernames must have only letters, numbers, dots or underscores')])
	password = PasswordField('Password', validators=[Required(), EqualTo('password2', message='Passwords must match.')])
	password2 = PasswordField('Confirm password', validators=[Required()])
	submit = SubmitField('Register')
    
def validate_email(self, field):
	if User.query.filter_by(email=field.data).first():
		raise ValidationError('Email already registered.')
        
def validate_username(self, field):
	if User.query.filter_by(username=field.data).first():
		raise ValidationError('Username already in use.')
```

这个表单使用WTForm的Regexp校验器确保username字段只包含字母，数字，下划线和点。正则表达式之后的两个校验器参数是正则表达式的标志和出现错误时显示的信息。

密码被输入两次作为安全测量，这个步骤是必须的校验两个密码字段具有相同的内容，使用`EqualTo`校验器来完成这个功能。

这个表单也有两个自定义的校验器作为方法实现，当一个表单使用`validate_`前缀定义了一个方法，除了其他常规定义的校验器，这个方法也会被调用。这种情况下，email和username的自定义校验器确保给定的值不会重复。自定义校验器通过抛出一个`ValidationError`异常声明一个校验错误，使用错误消息的文本作为参数。

代表这种格式的模板叫做`/templates/auth/register.html`。像登录模板一样，这一个也使用`wtf.quick_form()`方法渲染表单。

注册页面需要从登录页面链接，以便没有账户的用户可以很容易的发现它

*Example 8-16. app/templates/auth/login.html: Link to the registration page*

```html
<p>
New user?
	<a href="{{ url_for('auth.register') }}">
		Click here to register
	</a>
</p>
```

##### 注册新的用户

*Example 8-17. app/auth/views.py: User registration route*

```python
@auth.route('/register', methods=['GET', 'POST'])
def register():
	form = RegistrationForm()
	if form.validate_on_submit():
		user = User(email=form.email.data,
					username=form.username.data,
					password=form.password.data)
		db.session.add(user)
		flash('You can now login.')
		return redirect(url_for('auth.login'))
	return render_template('auth/register.html', form=form)
```

#### 账户确认

对于特定的应用来说，确保在注册期间提供的用户信息是有效的是非常重要的。一个常见的需求就是通过邮件地址可以到达用户。

为了校验邮箱地址，应用会在他们注册之后立即发送了一封确认邮件。新注册的用户初始状态为未确认的，直到邮件被接收了，证明用户是可到达的。账户确认过程通常涉及点击特殊的包含一个确认token的链接。

##### 使用itsdangerous生成确认token

最简单的账户确认链接是一个格式为`http://www.example.com/auth/confirm/<id>`的URL，id是用户在数据库的ID，当用户点击链接后，视图函数处理这个路由接收用户的ID来作为参数确认，可以很容易的更新用户的确认状态。

但是这明显不是一个安全的实现，因为任何用户发现了这个确认链接的格式都能够通过发送随机数字来确认任意的账户。使用包含安全加密后的相同信息的token替换URL中的id是个不错的主意。

Flask使用加密签名的Cookie来保护用户会话的内容，这些安全的Cookie使用一个叫itsdangerous的包进行签名。同样的想法可以用于确认token上

下面是在一个短的shell会话中显示itsdangerous是如何生成一个包含用户id在里面的安全的token

```python
(venv) $ python manage.py shell
>>> from manage import app
>>> from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
>>> s = Serializer(app.config['SECRET_KEY'], expires_in = 3600)
>>> token = s.dumps({ 'confirm': 23 })
>>> token
'eyJhbGciOiJIUzI1NiIsImV4cCI6MTM4MTcxODU1OCwiaWF0IjoxMzgxNzE0OTU4fQ.ey ...'
>>> data = s.loads(token)
>>> data
{u'confirm': 23}
```

Itsdangerous提供了几种类型的token生成器，在他们之中，`TimedJSONWebSignatureSerializer`类使用一个过期时间生成JSON Web Signatrues(JWS) 。这个构造器接收一个加密的key作为参数，在Flask中可以被配置成SECRET_KEY。

`dumps()`方法以给定的数据作为参数生成加密的签名，接着序列化数据和签名，转换成一个token字符串。`expires_in`参数以秒为单位设置token过期的时间。

为了解码token，序列化器对象提供了一个`load()`方法，只接收token作为参数，函数校验签名和过期时间，如果是有效的，它会返回原始数据，当`load()`方法接收了一个无效的token或者一个有效的过期的token，将会抛出一个异常。

使用这个功能生成和校验token可以添加到User模型

*Example 8-18. app/models.py: User account confirmation*

```python
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
from flask import current_app
from . import db

class User(UserMixin, db.Model):
	# ...
	confirmed = db.Column(db.Boolean, default=False)
    
	def generate_confirmation_token(self, expiration=3600):
		s = Serializer(current_app.config['SECRET_KEY'], expiration)
		return s.dumps({'confirm': self.id})
    
	def confirm(self, token):
		s = Serializer(current_app.config['SECRET_KEY'])
		try:
    		data = s.loads(token)
		except:
			return False
		if data.get('confirm') != self.id:
			return False
		self.confirmed = True
		db.session.add(self)
		return True
```

`generate_confirmation_token()`方法使用一个默认有效时间为1小时的过期时间生成一个token。`confirm()`方法校验token，如果有效，设置新的`confirmed`属性为True。

除了校验Token，`confirm()`方法检查token中的id是否匹配登录的用户，存储在current_user。这确保了即使一个恶毒的用户发现了如何生成签名token，它也不能确认其他人的账户。

User模型新增的两个方法很容易在单元测试中进行测试

##### 发送确认邮件

当前`/register`路由重定向到`/index`在添加新的用户到数据库之后。在重定向之前，现在这个路由需要发送一封确认邮件

*Example 8-19. app/auth/views.py: Registration route with confirmation email*

```python
from ..email import send_email

@auth.route('/register', methods = ['GET', 'POST'])
def register():
	form = RegistrationForm()
	if form.validate_on_submit():
		# ...
		db.session.add(user)
		db.session.commit()
		token = user.generate_confirmation_token()
		send_email(user.email, 'Confirm Your Account','auth/email/confirm',user=user,token=token)
		flash('A confirmation email has been sent to you by email.')
		return redirect(url_for('main.index'))
	return render_template('auth/register.html', form=form)
```

注意一个`db.session.commit()`必须被添加，即使应用配置了在请求之后自动提交。问题是新用户获取赋值的id当他们被提交到数据库，因为确认token需要id，提交不能被推迟。

认证蓝图需要的Email模板被放在*templates/auth/email*让他们和其他的HTML模板分隔。对于每个email需要两个模板，一个是普通文本版本，一个是富文本版本

*Example 8-20. app/auth/templates/auth/email/confirm.txt: 确认邮件的文本主体*

```html
Dear {{ user.username }},
Welcome to Flasky!
To confirm your account please click on the following link:
{{ url_for('auth.confirm', token=token, _external=True) }}
Sincerely,
The Flasky Team
Note: replies to this email address are not monitored.
```

默认情况下，`url_for()`生成相对URL路径，所以要使用`_external=True`来生成绝对路径的URL

*Example 8-21. app/auth/views.py: Confirm a user account*

```python
from flask.ext.login import current_user

@auth.route('/confirm/<token>')
@login_required
def confirm(token):
	if current_user.confirmed:
		return redirect(url_for('main.index'))
	if current_user.confirm(token):
		flash('You have confirmed your account. Thanks!')
	else:
		flash('The confirmation link is invalid or has expired.')
	return redirect(url_for('main.index'))
```

每个应用可以决定一个未确认的用上允许做什么，在他们确认账户之前。一种可能性是允许未确认的用户登录，但是只显示一个页面，要求他们在获得访问之前确认他们的账户。

这个步骤可以使用Flask的`before_request`钩子实现。对于一个蓝图来说，`before_request`钩子只适用于属于这个蓝图的请求。为了安装对所有应用的请求的回调，必须使用`before_app_request`装饰器

*在`before_app_request`处理器中过滤未确认的账户*

```python
@auth.before_app_request
def before_request():
	if current_user.is_authenticated() \
		and not current_user.confirmed \
		and request.endpoint[:5] != 'auth.':
	return redirect(url_for('auth.unconfirmed'))

@auth.route('/unconfirmed')
def unconfirmed():
	if current_user.is_anonymous() or current_user.confirmed:
		return redirect('main.index')
	return render_template('auth/unconfirmed.html')
```

`before_app_request`处理器当满足三个条件时会拦截请求：

1. 一个用户登录了(`current_user.is_authenticated`必须返回True)
2. 用户的账户是未确认的
3. 请求的端点在认证蓝图之外，访问认证路由需要被提供，因为那些是将会使用户确认账户或执行其他账户管理功能的路由

如果三个条件都被满足了，接着重定向到一个新的`/auth/unconfirmed`路由，显示一页关于账户确认的信息

这个页面只显示给未确认的用户看，渲染一个模板告诉用户如何确认账户并提供一个链接请求一个新的确认邮件，这种情况下原来的邮件就失效了。

重新发送确认邮件的路由如下所示：

*Example 8-23. app/auth/views.py: Resend account confirmation email*

```python
@auth.route('/confirm')
@login_required
def resend_confirmation():
    token = current_user.generate_confirmation_token()
    send_email(current_user.email, 'Confirm Your Account', 'auth/email/confirm', user=current_user, token=token)
    flash('A new confirmation email has been sent to you by email.')
    return redirect(url_for('main.index'))

```

这个路由使用`current_user`重复了在注册路由中所做的事情，登录的用户作为目标用户，这个路由也被`login_required`所保护确保当它被访问时，制造这个请求的用户被知道。

#### 账户管理

应用有账户的用户可能需要时不时的改变他们的账户，下列任务可以使用这一章的技术增加到认证蓝图中：

- 密码更新

  具有安全意识的用户可能想要在一段时间内就改变他们的密码。这是一个容易实现的功能，因为只要用户登录了，这是安全的显示一个表单求旧密码和一个新密码去替换它。

- 密码重置

  为了避免用户被锁在应用之外，当他们忘记了密码。可以提供一个密码重置选项。为了以安全的方式实现密码重置，有必要使用和用户确认账户相似的token。当一个用户请求一个密码重置，有一个重置token的邮件被发送到注册的邮件地址。用户在邮件中点击链接，token校验通过以后，显示一个表单让用户输入新密码

- 邮件地址改变

  用户可以被给予一个改变注册邮箱的功能，但是在新邮箱被接受之前它必须要被一个确认邮件校验。为了使用这个功能，用户在表单中输入新的邮件，为了确认邮件地址，一个token被发送到那个地址。当服务器接收返回的token，它可以更新用户对象。在服务器等待接收token时，它可以存储新的邮件地址到一个新的数据库字段，等待新的邮件地址。或者它可以存储地址在token中，使用一个id标识。

### 第九章 用户角色

并不是所有的web应用的用户都是同种方式创建的。在大多数应用中，一小部分用户是被信任的，具有额外的权限来让应用运行顺畅。管理员就是最好的例子，但是在大多数情况下，中等水平权限的用户像内容版主也会存在。

在应用中有多种方式实现角色。恰当的方法绝大程度上依赖需要支持多少角色，他们的作用是什么样的。例如，一个简单的应用可能只有两个角色，一个为普通用户，另一个为管理员。在这种情况下，在`User`模型有一个`is_adminstrator`布尔值字段就可以满足所有的需求。一个更复杂的应用可能需要额外的在普通用户和管理员角色之间的拥有不同级别权限的角色。在一些应用中，讨论离散的角色甚至是没有意义的，相反，给用户一个权限的集合可能是正确的方式。

在这一章实现的用户角色是离散角色和权限之间的混合。用户被赋值一个离散的角色，但是角色是以权限的名义定义的。

#### 角色的数据库表述

*Example 9-1. app/models.py: Role permissions*

```python
class Role(db.Model):
	__tablename__ = 'roles'
	id = db.Column(db.Integer, primary_key=True)
	name = db.Column(db.String(64), unique=True)
	default = db.Column(db.Boolean, default=False, index=True)
	permissions = db.Column(db.Integer)
	users = db.relationship('User', backref='role', lazy='dynamic')
```

如果只有一个角色`default`字段应该被设置为True，其他情况设置成False。标记为默认的角色会在新用户注册的时候赋值给他。

模型第二个额外的字段是`permissions`字段，是一个整数将会被用作位标记。每个任务都会被赋值一个位位置，对于每个角色，被角色允许的任务都会把他们的位设置为1

*Table 9-1. Application permissions*

| 任务名称     | 位值                  | 描述             |
| -------- | ------------------- | -------------- |
| 关注用户     | `0b00000001 (0x01)` | 关注其他用户         |
| 评论其他人的文章 | `0b00000010 (0x02)` | 评论由其他人写的文章     |
| 写文章      | `0b00000100 (0x04)` | 写原始文章          |
| 温和评论     | `0b00001000 (0x08)` | 禁止别人发表的令人反感的评论 |
| 管理员访问    | `0b10000000 (0x80)` | 管理员访问网站        |

注意到总共8位被分配给了任务，到目前为止只有5个被使用了。剩下的3个留作以后进行扩展

*Example 9-2. app/models.py: Permission constants*

```python
class Permission:
	FOLLOW = 0x01
	COMMENT = 0x02
	WRITE_ARTICLES = 0x04
	MODERATE_COMMENTS = 0x08
	ADMINISTER = 0x80
```

*Table 9-2. User roles*

| 用户角色 | 权限                  | 描述                              |
| ---- | ------------------- | ------------------------------- |
| 匿名   | `0b00000000 (0x00)` | 没有登录的用户，只能进行只读的访问               |
| 普通用户 | `0b00000111 (0x07)` | 基本权限，如写文章，评论和关注其他用户，这个是新用户的默认角色 |
| 版主   | `0b00001111 (0x0f)` | 增加了禁用反感或不恰当的评论                  |
| 管理员  | `0b11111111 (0xff)` | 完全访问，包括改变其他用户的角色的权限             |

使用权限组织角色，可以让你在以后使用不同的权限组合来增加新的角色。

手动添加角色到数据库是耗时的和容易出错的。相反，使用一个类方法将被增加到`Role`类来完成这个目的。

*Example 9-3. app/models.py: Create roles in the database*

```python
class Role(db.Model):
# ...
@staticmethod
	def insert_roles():
        roles = {
            'User': (Permission.FOLLOW |
                     Permission.COMMENT |
                     Permission.WRITE_ARTICLES, True),
            'Moderator': (Permission.FOLLOW |
                          Permission.COMMENT |
                          Permission.WRITE_ARTICLES |
                          Permission.MODERATE_COMMENTS, False),
            'Administrator': (0xff, False)
        }
		for r in roles:
			role = Role.query.filter_by(name=r).first()
				if role is None:
					role = Role(name=r)
				role.permissions = roles[r][0]
				role.default = roles[r][1]
				db.session.add(role)
			db.session.commit()
```

`insert_roles()`函数不会直接创建新的角色对象。相反，它试图根据名称来获取已经存在的角色并更新他们。一个新角色对象只在角色名还没有存在于数据库才会创建。这样做以便将来需要改变的时候角色列表可以更新。为了增加一个新的角色，或者改变一个角色的权限，改变roles数组，并返回这个函数。注意到匿名角色不需要在数据库创建，因为它被设计用来代表那些还不在数据库的用户。

为了将这些角色保存到数据库，可以使用一个shell会话：

```shell
(venv) $ python manage.py shell
>>> Role.insert_roles()
>>> Role.query.all()
[<Role u'Administrator'>, <Role u'User'>, <Role u'Moderator'>]
```

#### 赋予角色

当用户在应用中注册一个新账户时，正确角色应该赋予他们。对大多数用户来说，在注册期间赋予的角色将会是`User`角色。因为这个角色被标记为默认角色。只有一个例外是管理员，在开始的时候需要被赋予`Administrator`角色。这个用户由一个存储在FLASKY_ADMIN配置变量中的邮件地址定义。所以只要这个邮件出现在注册请求，它就会给赋予正确的角色。

*Example 9-4. app/models.py: Define a default role for users*

```python
class User(UserMixin, db.Model):
	# ...
	def __init__(self, **kwargs):
		super(User, self).__init__(**kwargs)
		if self.role is None:
			if self.email == current_app.config['FLASKY_ADMIN']:
				self.role = Role.query.filter_by(permissions=0xff).first()
			if self.role is None:
				self.role = Role.query.filter_by(default=True).first()
			# ...
```

`User`构造器首先调用基类的构造器。之后如果对象没有角色被定义，根据邮件地址设置为管理员或默认角色。

#### 角色校验

为了简化角色和权限的实现，一个帮助方法被添加到`User`模型来检查一个特定的权限是否存在。

*Example 9-5. app/models.py: Evaluate whether a user has a given permission*

```python
from flask.ext.login import UserMixin, AnonymousUserMixin

class User(UserMixin, db.Model):
	# ...
	def can(self, permissions):
		return self.role is not None and \
			(self.role.permissions & permissions) == permissions
        
	def is_administrator(self):
		return self.can(Permission.ADMINISTER)
    
class AnonymousUser(AnonymousUserMixin):
	def can(self, permissions):
		return False
    
	def is_administrator(self):
		return False

login_manager.anonymous_user = AnonymousUser
```

添加到`User`模型的`can()`方法在被请求的权限和被赋予的角色的权限进行了按位与操作。该方法如果被请求的位在角色的权限里就会返回True，意味着用户应该被允许执行任务。检查管理员权限是非常常用的，所以以单独的`is_administrator()`方法实现。

为了一致性，创建了一个自定义的`AnonymousUser`类实现了`can()`和`is_administrator()`方法。这个对象继承Flask-Login的`AnonymousUserMixin`类，被注册作为类的对象被赋值给`current_user`，当用户没有登录的时候。这会让应用自由的调用`current_user.can()`和`current_user.is_administrator()`方法而不用先检查用户是否登录。

对于一个完整的视图函数需要对只有特定权限的用户可用的情况，可以使用一个自定义的装饰器。*Example 9-6*实现了两个装饰器，一个用来检查普通权限，一个用来检查管理员权限。

*Example 9-6. app/decorators.py: Custom decorators that check user permissions*

```python
from functools import wraps
from flask import abort
from flask_login import current_user
from .models import Permission


def permission_required(permission):
    def decorator(f):
        @wraps(f)
        def decorator_function(*args, **kwargs):
            if not current_user.can(permission):
                abort(403)
            return f(*args, **kwargs)

        return decorator_function

    return decorator


def admin_required(f):
    return permission_required(Permission.ADMINISTER)(f)
```

这些装饰器由来自Python标准库的*functools*包的帮助来构建的。当当前用户没有被请求的权限，返回一个错误码403，代表`Forbidden`HTTP错误。所以现在403错误页面也需要被添加进来。

下面是两个例子演示了装饰器的用法

```python
from decorators import admin_required, permission_required

@main.route('/admin')
@login_required
@admin_required
def for_admins_only():
	return "For administrators!"

@main.route('/moderator')
@login_required
@permission_required(Permission.MODERATE_COMMENTS)
def for_moderators_only():
	return "For comment moderators!"
```

权限可能也需要在模板中检查，所以`Permission`类和它所有的位常量都需要被访问。为了避免在每个`render_template()`调用中都添加一个模板参数，可以使用一个上下文处理器。上下文处理器使变量对所有的模板全局可用。

*Example 9-7. app/main/__init__.py: Adding the Permission class to the template context*

```python
@main.app_context_processor
def inject_permissions():
	return dict(Permission=Permission)
```

新的角色和权限可以在单元测试中进行测试。

*Example 9-8. tests/test_user_model.py: Unit tests for roles and permissions*

```python
class UserModelTestCase(unittest.TestCase):
	# ...
	def test_roles_and_permissions(self):
	Role.insert_roles()
	u = User(email='john@example.com', password='cat')
		self.assertTrue(u.can(Permission.WRITE_ARTICLES))
		self.assertFalse(u.can(Permission.MODERATE_COMMENTS))
        
	def test_anonymous_user(self):
		u = AnonymousUser()
		self.assertFalse(u.can(Permission.FOLLOW))
```

### 第十章 用户简介

在这一章，实现了Flasky的用户简介。所有的社交网站都会给他们的用户一个简介页面，显示用户在网站的参数总结。用户可以通过分享他们主页的URL广告他们在网站上的存在。所以URL要短和容易记住是非常重要的。

#### 简介信息

为了让用户的主页更有趣，用户的一些额外信息可以被记录

*Example 10-1. app/models.py: User information fields*

```python
class User(UserMixin, db.Model):
# ...
name = db.Column(db.String(64))
location = db.Column(db.String(64))
about_me = db.Column(db.Text())
member_since = db.Column(db.DateTime(), default=datetime.utcnow)
last_seen = db.Column(db.DateTime(), default=datetime.utcnow)
```

新增加的字段存储了用户的真实姓名，地理位置，自我编写的描述，注册日期和上次访问的时间。`about_me`字段被赋予了`db.Text()`类型。`db.String`和`db.Text`的不同之处是`db.Text`不需要最大长度。

两个时间戳被赋予了当前时间为默认值。注意到`datetime.utcnow`没有`()`。这是因为`db.Column()`的`default`参数可以接收一个函数作为默认值。所以每次需要生成一个默认值，这个函数被调用来产生它。

`last_ssen`字段也是在创建时根据当前时间来初始化。但是它需要在每次用户访问网站的时候刷新，在User类中的方法可以完成这个更新

*Example 10-2. app/models.py: Refresh last visit time of a user*

```python
class User(UserMixin, db.Model):
# ...
def ping(self):
	self.last_seen = datetime.utcnow()
	db.session.add(self)
```

`ping()`方法必须在每次用户的请求被收到之前调用。因为在auth蓝图中的`before_app_request`处理器可以在每次请求之前运行，它可以很容易的完成这个要求。

*Example 10-3. app/auth/views.py: Ping logged-in user*

```python
@auth.before_app_request
def before_request():
	if current_user.is_authenticated:
		current_user.ping()
		if not current_user.confirmed \
				and request.endpoint[:5] != 'auth.':
			return redirect(url_for('auth.unconfirmed'))
```

#### 用户简介页面

为每个用户创建一个简介页面没有任何挑战。

*Example 10-4. app/main/views.py: Profile page route*

```python
@main.route('/user/<username>')
def user(username):
	user = User.query.filter_by(username=username).first()
	if user is None:
		abort(404)
	return render_template('user.html', user=user)
```

这个路由被增加到了main蓝图。对于一个名叫John的用户来说，它的主页将会在`http://localhost:5000/user/john`。URL中的用户名会在数据库搜索，如果发现，使用它作为参数渲染模板，如果没找到，将会返回404。

*Example 10-5. app/templates/user.html: User profile template*

```html
{% block page_content %}
<div class="page-header">
	<h1>{{ user.username }}</h1>
	{% if user.name or user.location %}
	<p>
		{% if user.name %}{{ user.name }}{% endif %}
		{% if user.location %}
			From <a href="http://maps.google.com/?q={{ user.location }}">
				{{ user.location }}
			</a>
		{% endif %}
	</p>
	{% endif %}
	{% if current_user.is_administrator() %}
	<p><a href="mailto:{{ user.email }}">{{ user.email }}</a></p>
	{% endif %}
	{% if user.about_me %}<p>{{ user.about_me }}</p>{% endif %}
	<p>
		Member since {{ moment(user.member_since).format('L') }}.
		Last seen {{ moment(user.last_seen).fromNow() }}.
	</p>
</div>
{% endblock %}
```

这个模板有一些非常有趣的实现细节：

- `name`和`location`在单个`<p>`元素内渲染。只有当至少一个字段被定义`<p>`元素才会被创建。
- 用户的`Location`字段被渲染成一个链接到一个谷歌地图查询
- 如果登录的用户是管理员，邮件被显示，作为一个*mailto*链接被渲染

因为大多数用户想要容易的访问他们自己的主页，一个链接可以被增加到导航栏。

*Example 10-6. app/templates/base.html*

```html
{% if current_user.is_authenticated() %}
<li>
	<a href="{{ url_for('main.user', username=current_user.username) }}">
		Profile
	</a>
</li>
{% endif %}
```

为一个主页链接使用一个判断条件是非常有必要的，因为导航栏也被为未授权的用户渲染。主页链接会被跳过。

#### 主页编辑

有两个不同的使用情况与编辑用户主页相关。最明显的是用户需要访问页面，他们可以输入他们自己的信息在他们的主页显示。一个不太明显的但是也是重要的需求是让管理员编辑任何用户的主页。

##### 用户级别的主页编辑

*Example 10-7. app/main/forms.py: Profile edit form*

```python
class EditProfileForm(Form):
    name = StringField('Real name', validators=[Length(0, 64)])
    location = StringField('Location', validators=[Length(0, 64)])
    about_me = TextAreaField('About me')
    submit = SubmitField('Submit')
```

注意到在这个表单所有的字段都是可选的。长度校验器允许长度为0

*Example 10-8. app/main/views.py: Profile edit route*

```python
@main.route('/edit-profile', methods=['GET', 'POST'])
@login_required
def edit_profile():
    form = EditProfileForm()
    if form.validate_on_submit():
        current_user.name = form.name.data
        current_user.location = form.location.data
        current_user.about_me = form.about_me.data
        db.session.add(current_user)
        flash('Your profile has been updated.')
        return redirect(url_for('.user', username=current_user.username))
    form.name.data = current_user.name
    form.location.data = current_user.location
    form.about_me.data = current_user.about_me
    return render_template('edit_profile.html', form=form)
```

这个视图函数在显示表单之前为所有的字段设置初始值。对于任意给定的字段，通过赋值到`form.<field-name>.data`来完成。当`form.validate_on_submit()`是`False`，这个表单中的三个字段从`current_user`响应的字段初始化。当表单被提交后，表单的data属性字段包含更新后的值。

为了更容易的到达这个页面，可以在配置页面直接添加一个链接

*Example 10-9. app/templates/user.html: Profile edit link*

```html
{% if user == current_user %}
<a class="btn btn-default" href="{{ url_for('.edit_profile') }}">
	Edit Profile
</a>
{% endif %}
```

条件包裹这个链接只会当用户查他们的主页 才会显示

##### 管理员级别的主页编辑

来自管理员的主页编辑要比普通用户的主页编辑更复杂。除了三个信息字段，这个表单允许管理员编辑用户的邮件，用户名，确认状态和角色。

*Example 10-10. app/main/forms.py: Profile editing form for administrators*

```python
class EditProfileAdminForm(FlaskForm):
    email = StringField('Email', validators=[DataRequired(), Length(1, 64), Email()])
    username = StringField('Username',
                           validators=[DataRequired(),
                                       Length(1, 64),
                                       Regexp('^[A-Za-z][A-Za-z0-9_.]*$', 0,
                                              message='Usernames must have only letters,numbers,dots or underscores')])
    confirmed = BooleanField('Confirmed')
    role = SelectField('Role', coerce=int)
    name = StringField('Real name', validators=[Length(0, 64)])
    location = StringField('Location', validators=[Length(0, 64)])
    about_me = TextAreaField('About me')
    submit = SubmitField('Submit')

    def __init__(self, user, *args, **kwargs):
        super(EditProfileAdminForm, self).__init__(*args, **kwargs)
        self.role.choices = [(role.id, role.name) for role in Role.query.order_by(Role.name).all()]
        self.user = user

    def validate_email(self, field):
        if field.data != self.user.email and User.query.filter_by(email=field.data).first():
            raise ValidationError('Email already registered.')

    def validate_username(self, field):
        if field.data != self.user.username and User.query.filter_by(username=field.data).first():
            raise ValidationError('Username already in use.')
```

`SelectField`是WTForm提供的HTML元素`<select>`的包装器，实现了一个下拉列表，用来在这个表单中选择一个用户角色，一个`SelectField`的实例必须把项设置到它的`choices`属性。他们必须被作为一个元组的列表，每个元组包含两个值，一个是项的id，另外一个是作为字符串在下拉框显示的文本。`choices`列表在表单的构造器进行设置，它的值从数据库获取，每个元组的ID被设置成每个角色的id，因为他们都是整数，所以一个`coerce=int`的参数被增加到`SelectField`构造器，以便该字段的值被作为整数存储而不是默认的字符串形式。

`email`和`username`字段像在认证表单中的同种方式构造，但是校验需要仔细的处理。为了实现这个逻辑，表单的构造器接收用户对象作为参数，并把它作为一个成员变量保存，稍后会在自定义校验方法中使用。

*Example 10-11. app/main/views.py: Profile edit route for administrators*

```python
@main.route('/edit-profile/<int:id>', methods=['GET', 'POST'])
@login_required
@admin_required
def edit_profile_admin(id):
    user = User.query.get_or_404(id)
    form = EditProfileAdminForm()
    if form.validate_on_submit():
        user.email = form.email.data
        user.username = form.username.data
        user.confirmed = form.confirmed.data
        user.role = Role.query.get(form.role.data)
        user.name = form.name.data
        user.location = form.location.data
        user.about_me = form.about_me.data
        db.session.add(user)
        flash('The profile has been updated.')
        return redirect(url_for('.user', username=user.username))
    form.email.data = user.email
    form.username.data = user.username
    form.confirmed.data = user.confirmed
    form.role.data = user.role_id
    form.name.data = user.name
    form.location.data = user.location
    form.about_me.data = user.about_me
    return render_template('edit_profile.html', form=form, user=user)
```

这个路由和普通用户的路由有大部分都是相同的。在这个视图函数，根据用户id获取用户，所以可以使用Flask-SQLAlchemy的`get_or_404()`便捷函数，如果id是无效的，请求将会返回一个错误码404.

`SelectField`用来选择用户角色需要进一步学习。当设置这个字段的初始值时，`role_id`被赋值到`field.role.data`，因为在`choices`属性中设置的元组列表使用数字id来引用每个选项。当表单提交时，id从字段data属性中提取出来，然后根据它的id去查询对应的角色对象。`coerce=int`参数声明确保data属性的字段是一个整数。

为了链接到这个页面，用户主页增加了另外一个按钮

*Example 10-12. app/templates/user.html: Profile edit link for administrator*

```html
{% if current_user.is_administrator() %}
<a class="btn btn-danger"
		href="{{ url_for('.edit_profile_admin', id=user.id) }}">
	Edit Profile [Admin]
</a>
{% endif %}
```

这个按钮被渲染成不同的Bootstrap样式来引起注意。如果登录用户是一个管理员，判断条件可以让按钮出现。

#### 用户头像

用户主页的外观可以通过实现用户的图片来改善。在这一部分，你将会学习到如何使用Gravatar增加用户头像。Gravatar使用邮件地址关联头像。用户在`http://gravatar.com`注册一个账户，然后上传他们的图片，为了根据特定的邮件地址生成头像URL。它的MD5哈希值被计算：

```shell
(venv) $ python
>>> import hashlib
>>> hashlib.md5('john@example.com'.encode('utf-8')).hexdigest()
'd4c74594d841139328695756648b6bd6'
```

头像URL通过添加MD5哈希值到URL`http://www.gravatar.com/avatar/`或`https://secure.gravatar.com/avatar/`来生成。例如，你可以在才能的浏览器地址栏输入`http://www.gravatar.com/avatar/d4c74594d841139328695756648b6bd6`来获取`john@example.com`邮件地址的头像。如果邮件地址没有一个头像注册会生成一个默认的头像。

这个URL的查询参数可以包括几种参数配置头像图片的特性。

*Table 10-1. Gravatar query string arguments*

| 参数名  | 描述                                       |
| ---- | ---------------------------------------- |
| `s`  | 图片大小，以像素为单位                              |
| `r`  | 图片评级，选项是`g`,`pg`,`r`,`x`                 |
| `d`  | 默认图片生成器，选项是404或一个URL指向默认的图片，图片生成器`mm`,`identicon`,`monsterid`,`wavatar`,`retro`,`blank` |
| `fd` | 强制使用默认头像                                 |

如何构造一个Gravatar URL的技术可以被增加到`User`模型

*Example 10-13. app/models.py: Gravatar URL generation*

```python
import hashlib
from flask import request
class User(UserMixin, db.Model):
    # ...
	def gravatar(self, size=100, default='identicon', rating='g'):
		if request.is_secure:
			url = 'https://secure.gravatar.com/avatar'
		else:
			url = 'http://www.gravatar.com/avatar'
		hash = hashlib.md5(self.email.encode('utf-8')).hexdigest()
		return '{url}/{hash}?s={size}&d={default}&r={rating}'.format(
			url=url, hash=hash, size=size, default=default, rating=rating)
```

该实现选择标准或安全的Gravatar基础URL来匹配客户端请求的安全性。avatar URL由基础URL，用户邮件地址的MD5哈希值，全部都是默认值的参数来生成。通过这个实现，很容易的在Python shell中生成一个头像URL：

```shell
(venv) $ python manage.py shell
>>> u = User(email='john@example.com')
>>> u.gravatar()
'http://www.gravatar.com/avatar/d4c74594d84113932869575bd6?s=100&d=identicon&r=g'
>>> u.gravatar(size=256)
'http://www.gravatar.com/avatar/d4c74594d84113932869575bd6?s=256&d=identicon&r=g'
```

`gravatar()`方法也可以在Jinja2的模板中调用。

*Example 10-14. app/tempaltes/user.html: Avatar in profile page*

```html
...
<img class="img-rounded profile-thumbnail" src="{{ user.gravatar(size=256) }}">
...
```

使用一个相似的方法，基本模板在导航栏增加了一个登录用户的缩略图片。为了更好的在页面中格式化头像图片，可以使用自定义的CSS类。

头像的生成需要一个MD5哈希值被生成，是一个CPU密集型操作。如果一个页面有非常多的头像需要生成，那么计算工作可以是有意义的。因为一个用户的MD5哈希值会保持常量，它可以被缓存在`User`模型。

*Example 10-15. app/models.py: Gravatar URL generation with caching of MD5 hashes*

```python
class User(UserMixin, db.Model):
	# ...
	avatar_hash = db.Column(db.String(32))
    
	def __init__(self, **kwargs):
		# ...
		if self.email is not None and self.avatar_hash is None:
			self.avatar_hash = hashlib.md5(self.email.encode('utf-8')).hexdigest()
            
	def change_email(self, token):
		# ...
		self.email = new_email
		self.avatar_hash = hashlib.md5(
		self.email.encode('utf-8')).hexdigest()
		db.session.add(self)
		return True
    
	def gravatar(self, size=100, default='identicon', rating='g'):
		if request.is_secure:
			url = 'https://secure.gravatar.com/avatar'
		else:
			url = 'http://www.gravatar.com/avatar'
		hash = self.avatar_hash or hashlib.md5(self.email.encode('utf-8')).hexdigest()
		return '{url}/{hash}?s={size}&d={default}&r={rating}'.format(url=url, hash=hash, size=size, default=default, rating=rating)
```

在模型初始化期间，哈希值从邮件被计算并存储，在用户更新邮件地址事件中，哈希值被重新计算。如果模型可用的话`gravatar()`方法使用来自模型的哈希值，如果不可用，它会像之前一样根据邮件地址生成哈希值。

### 第十一章 博客文章

这一章专注于实现Flask的主要功能，就是允许用户读和写文章。这里你将会学到一些新的技术用来重用模板，分页和使用富文本。

#### 文章提交和显示

为了支持文章，一个新的代表他们的数据库模型是必须的。

*Example 11-1. app/models.py: Post model*

```python
class Post(db.Model):
    __tablename__ = 'posts'
    id = db.Column(db.Integer, primary_key=True)
    body = db.Column(db.Text)
    timestamp = db.Column(db.DateTime, index=True, default=datetime.utcnow)
    author_id = db.Column(db.Integer, db.ForeignKey('users.id'))
    
class User(UserMixin, db.Model):
    # ...
    posts = db.relationship('Post', backref='author', lazy='dynamic')
```

一个博客文章由主体，时间戳和一个与用户多对一的关系构成。`body`字段由类型`db.Text`定义，所以它的长度没有限制。

表单将会在应用主页显示可以让用户写博客文章。这个表单是简单的，它只包含了一个可以输入博客文章的文本域和一个提交按钮

*Example 11-2. app/main/forms.py: Blog post form*

```python
class PostForm(Form):
	body = TextAreaField("What's on your mind?", validators=[Required()])
	submit = SubmitField('Submit')
```

`index()`视图函数处理表单和传递博客文章列表到模板

*Example 11-3. app/main/views.py: Home page route with a blog post*

```python
@main.route('/', methods=['GET', 'POST'])
def index():
    form = PostForm()
    if current_user.can(Permission.WRITE_ARTICLES) and form.validate_on_submit():
        post = Post(body=form.body.data, author=current_user._get_current_object())
        db.session.add(post)
        return redirect(url_for('.index'))
    posts = Post.query.order_by(Post.timestamp.desc()).all()
    return render_template('index.html', form=form, posts=posts)
```

这个视图函数传递表单和完整的博客文章列表到模板。文章列表以它们的时间戳降序排序。博客文章表单以正常的方式处理，当收到一个有效的提交之后创建一个`Post`实例，在允许新的文章之前需要检查当前用户是否有写文章的权限。

注意到新文章对象的`author`属性由表达式`current_user._get_current_object()`设置。`current_user`变量来自于Flask-Login，像所有的上下文对象一样，被作为一个本地线程代理对象实现。这个对象表现的像普通用户，但是事实上是一个包装器包含了实际用户在内。数据库需要一个真实的用户对象，通过调用`_get_current_object()`获取。

表单在`index.html`模板下中的问候之后渲染。紧跟着博客文章。博客文章列表首先会试图创建一个博客文章时间流，以时间由近到远的顺序列出数据库中所有的博客文章

*Example 11-4. app/templates/index.html: Home page template with blog posts*

```html
% extends "base.html" %}
{% import "bootstrap/wtf.html" as wtf %}
...
<div>
	{% if current_user.can(Permission.WRITE_ARTICLES) %}
	{{ wtf.quick_form(form) }}
	{% endif %}
</div>
<ul class="posts">
	{% for post in posts %}
	<li class="post">
		<div class="profile-thumbnail">
			<a href="{{ url_for('.user', username=post.author.username) }}">
				<img class="img-rounded profile-thumbnail" src="{{ post.author.gravatar(size=40) }}">
			</a>
		</div>
		<div class="post-date">{{ moment(post.timestamp).fromNow() }}</div>
		<div class="post-author">
			<a href="{{ url_for('.user', username=post.author.username) }}">
				{{ post.author.username }}
			</a>
		</div>
		<div class="post-body">{{ post.body }}</div>
	</li>
	{% endfor %}
</ul>
...
```

注意到`User.can()`方法用来对那些没有写文章权限的用户略过博客文章表单。博客文章列表以HTML无序列表实现，使用CSS类给它一个漂亮的格式。一个作者的小头像被渲染到了左边，头像和文章都被渲染为链接可以链接到用户的主页。使用的CSS样式存储在应用`static`文件夹中的`styles.css`中。

#### 主页的博客文章

用户主页可以通过显示该用户的博客文章来进行改善。

*Example 11-5. app/main/views.py: Profile page route with blog posts*

```python
@main.route('/user/<username>')
def user(username):
	user = User.query.filter_by(username=username).first()
		if user is None:
			abort(404)
	posts = user.posts.order_by(Post.timestamp.desc()).all()
	return render_template('user.html', user=user, posts=posts)
```

一个用户的博客文章列表从`User.posts`关系中取得，是一个查询对象，所以像`order_by()`的过滤器也可以使用

`user.html`模板需要`<ul>`HTML元素树来像在`index.html`中一样渲染博客文章列表。需要管理两份一样的HTML片段是不完美的，所以这种情况下，Jinja2的`include()`指令就非常有用了。`user.html`模板包含一个外部文件的列表。

*Example 11-6. app/templates/user.html: Profile page template with blog posts*

```html
...
<h3>Posts by {{ user.username }}</h3>
{% include '_posts.html' %}
...
```

为了完成这个重构，来自`index.html`的`<ul>`树被移动到新的模板文件`_posts.html`,使用另一个`include()`指令替换。注意到，在`_posts.html`中使用一个下划线前缀不是必须的。这仅仅是约束来区别独立的和部分的模板。

#### 长博客文章列表分页

随着网站的增长，博客文章的数目真多，它会变量和不实际的在主页和用户主页显示完整的博客文章列表。大的页面需要花费更长的时间来生成，下载，和在浏览器中渲染，所以用户体验的质量会随着页面变大而下降。解决方案就是分页数据，然后以块的形式渲染。

##### 创建博客文章假数据

为了能够演示多页的博客文章，很有必要有一个拥有大量数据的测试数据库。手动添加数据库记录是浪费时间的和乏味的。一个自动的解决方法更适合。有几个Python包可以用来生成假信息，一个相当完整的例子就是`ForgeryPy`。使用pip安装：

```shell
venv) $ pip install forgerypy
```

严格来说，ForgeryPy包不是应用的依赖，因为它在开发阶段需要，*requirement.txt*可以被一个`requirements`

的文件夹替换来存储不同的依赖。在这个新的文件夹，一个*dev.txt*文件可以列出在开发阶段的依赖，而一个*prod.txt*列出在生产阶段的依赖。因为由很多依赖都会在两个列表，所以可以增加一个*commons.txt*文件，接着*dev.txt*和*prod.txt* 使用`-r`前缀来包括它.

*Example 11-7. requirements/dev.txt: Development requirements file*

```html
-r common.txt
ForgeryPy==0.1
```

*Example 11-8. app/models.py: Generate fake users and blog posts*

```python
class User(UserMixin, db.Model):
	# ...
    @staticmethod
    def generate_fake(count=100):
        from sqlalchemy.exc import IntegrityError
        from random import seed
        import forgery_py

        seed()
        for i in range(count):
            u = User(email=forgery_py.internet.email_address(),
                     username=forgery_py.internet.user_name(True),
                     password=forgery_py.lorem_ipsum.word(),
                     confirmed=True,
                     name=forgery_py.name.full_name(),
                     location=forgery_py.address.city(),
                     about_me=forgery_py.lorem_ipsum.sentence(),
                     member_since=forgery_py.date.date(True))
            db.session.add(u)
            try:
                db.session.commit()
            except IntegrityError:
                db.session.rollback()
 
class Post(db.Model):
	# ...
    @staticmethod
    def generate_fake(count=100):
        from random import seed, randint
        import forgery_py

        seed()
        user_count = User.query.count()
        for i in range(count):
            u = User.query.offset(randint(0, user_count - 1)).first()
            p = Post(body=forgery_py.lorem_ipsum.sentences(randint(1, 3)),
                     timestamp=forgery_py.date.date(True),
                     author=u)
            db.session.add(p)
            db.session.commit()
```

这些假数据对象的属性由ForgeryPy随机信息生成器生成，可以生成好看的姓名，邮箱，句子和更多的属性。

用户的邮箱地址和用户名必须是唯一的，但是因为ForgeryPy以完全随机的形式生成这些信息，会有重复的风险，在这种不可能的情况下，数据库会话提交会抛出一个`IntegrityError`异常。在继续之前这种异常通过回滚会话来处理。循环迭代产生重复的值不会写到用户的数据库，所以假用户的总数可能小于要求的数。

新的方法可以很容易的创建很多假的用户和文章

```shell
(venv) $ python manage.py shell
>>> User.generate_fake(100)
>>> Post.generate_fake(100)
```

如果你现在运行应用，你将会在主页看到一系列随机的博客文章

##### 在页面上渲染数据

*Example 11-9. app/main/views.py: Paginate the blog post list*

```python
@main.route('/', methods=['GET', 'POST'])
def index():
	# ...
	page = request.args.get('page', 1, type=int)
	pagination = Post.query.order_by(Post.timestamp.desc()).paginate(page, per_page=current_app.config['FLASKY_POSTS_PER_PAGE'],error_out=False)
	posts = pagination.items
	return render_template('index.html', form=form, posts=posts,pagination=pagination)
```

要渲染的当前页码从当前请求的查询字符串中获得，作为`request.args`可用。当一个显示的页码没有提供，一个默认为1的页码被使用。`type=int`参数确保如果参数不能被转换到整数，默认值可以被返回。

为了加载一个单页数据，调用`all()`被Flask-SQLAlchemy的`paginate()`方法替换。`paginate()`方法接收页码作为第一个和唯一一个必须的参数。一个可选的`per_page`参数可以被提供表明每页项的大小，如果参数没有提供，默认是每页20项。另一个可选的参数的叫`error_out`可以被设置为True(默认设置)来抛出一个404错误，当一个页码不在被请求的有效范围内。如果`error_out`是False，返回一个空项列表。为了让页面大小可配置的，`per_page`参数的值从应用的具体配置的变量叫`FLASKY_POSTS_PER_PAGE`读取。

应用这些改变，在主页的博客文章列表将会显示有限的项，为了看第二页的文章，在浏览器地址栏的URL后增加`?page=2`查询字符串

##### 增加分页部件

`paginate()`方法返回的值是一个`Pagination`对象，由Flask-SQLAlchemy定义的类。这个对象包含几种属性对在模板中生成页码链接是有用的。所以把它作为一个参数传递给模板。分页对象的属性总结显示在下面

*Table 11-1. Flask-SQLAlchemy pagination object attributes*

| 属性         | 描述          |
| ---------- | ----------- |
| `items`    | 当前页的记录      |
| `query`    | 用来分页的源查询    |
| `page`     | 当前页码        |
| `prev_num` | 上一个页码       |
| `next_num` | 下一个页码       |
| `has_next` | 为True表示有下一页 |
| `has_prev` | 为True表示有上一页 |
| `pages`    | 查询的总页数      |
| `per_page` | 每页显示项的个数    |
| `total`    | 由查询返回的项的总数  |

分页对象同时也有一些方法

*Table 11-2. Flask-SQLAlchemy pagination object attributes*

| 方法                                       | 描述                                       |
| ---------------------------------------- | :--------------------------------------- |
| `iter_pages(left_edge=2,left_current=2.right_current=5，right_edge=2)` | 一个返回页码序列的迭代器，在一个分页部件中显示，这个列表会在左边有`left_edge`的页。当前页的左边有`left_current`个页，在当前页的右边会有`right_cuurent`个页码，在最右边有`right_edge`个页码。例如对于总页100，当前页为50的例子来说，生成的页码默认为`1,2，None，48，49,50,51,52,53,54,55，None，99,100` |
| `prev()`                                 | 一个分页对象的上一页                               |
| `next()`                                 | 一个分页对象的下一页                               |

为了使用Bootstrap的分页CSS类来武装这个强大的对象，这是相当容易在模板中构建一个分页页脚。

*Example 11-10. app/templates/_macros.html: Pagination template macro*

```html
{% macro pagination_widget(pagination, endpoint) %}
<ul class="pagination">
	<li {% if not pagination.has_prev %} class="disabled" {% endif %}>
		<a href="{% if pagination.has_prev %}{{ url_for(endpoint,
			page = pagination.page - 1, **kwargs) }}{% else %}#{% endif %}">
			&laquo;
		</a>
	</li>
	{% for p in pagination.iter_pages() %}
		{% if p %}
			{% if p == pagination.page %}
			<li class="active">
				<a href="{{ url_for(endpoint, page = p, **kwargs) }}">{{ p }}</a>
			</li>
			{% else %}
			<li>
				<a href="{{ url_for(endpoint, page = p, **kwargs) }}">{{ p }}</a>
			</li>
			{% endif %}
		{% else %}
		<li class="disabled"><a href="#">&hellip;</a></li>
		{% endif %}
	{% endfor %}
	<li {% if not pagination.has_next %} class="disabled"{% endif %}>
		<a href="{% if pagination.has_next %}{{ url_for(endpoint,
			page = pagination.page + 1, **kwargs) }}{% else %}#{% endif %}">
			&raquo;
		</a>
	</li>
</ul>
{% endmacro %}
```

这个宏创建了一个Bootstrap分页元素，以无序列表的样式。在其中它定义了下列页面链接：

- 一个`上一页`链接，如果当前页是第一页，这个链接会被禁用
- 所有由分页对象的`iter_pages()`迭代器返回的所有页码的链接
- 一个`下一页`链接，如果当前页是最后一页，这个链接会被禁用

Jinja2的宏总是接收关键字参数必须包含在`**kwargs`参数列表。分页宏把它接收到的所有参数传递给`url_for()`来生成分页链接。这个方法可以被用来像有一个动态部分的路由。

`pagination_widget`可以在*index.html*和*user.html* 中增加在`_posts.html`之下。

*Example 11-11. app/templates/index.html: Pagination footer for blog post lists*

```html
{% extends "base.html" %}
{% import "bootstrap/wtf.html" as wtf %}
{% import "_macros.html" as macros %}
...
{% include '_posts.html' %}
<div class="pagination">
	{{ macros.pagination_widget(pagination, '.index') }}
</div>
{% endif %}
```

#### 使用Markdown和Flask-PageDown开发富文本文章

普通文本的文章对短消息和状态更新是有效的，但是用户想要写长文章就会发现这种格式是非常受限的。在这一部分，输入文章的文本域将会升级来支持Markdown语法和显示一个文章的富文本预览。

实现这个功能需要一些新的包：

- PageDown，一个客户端的用JavaScript实现的Markdown到HTML的转换器。
- Flask-PageDown，一个Flask的PageDown包装器，使Flask-WTF 表单 集成了PageDown
- Markdown，一个服务端由Python实现的Markdown到HTML的转换器
- Bleach，一个由Python实现的HTML安全器

使用pip进行安装

```shell
(venv) $ pip install flask-pagedown markdown bleach
```

##### 使用Flask-PageDown

Flask-PageDown扩展定义了一个`PageDownFIeld`类和WTForm的`TextAreaField`有同样的页面。在使用这个字段之前，扩展需要被初始化。

*Example 11-12. app/__init__.py: Flask-PageDown initialization*

```python
from flask.ext.pagedown import PageDown
# ...
pagedown = PageDown()
# ...
def create_app(config_name):
	# ...
	pagedown.init_app(app)
	# ...
```

为了转换主页的文本域到Markdown富文本编辑器。PostForm的body字段必须被替换成`PageDownField`

*Example 11-13. app/main/forms.py: Markdown-enabled post form*

```python
from flask.ext.pagedown.fields import PageDownField

class PostForm(Form):
	body = PageDownField("What's on your mind?", validators=[Required()])
	submit = SubmitField('Submit')
```

Markdown预览需要PageDown库的帮助才能被生成，所以这些必须要增加到模板中。Flask-PageDown简化了这个任务，通过提示一个模板宏包含了来自一个CDN的需要的文件。

*Example 11-14. app/index.html: Flask-PageDown template declaration*

```html
{% block scripts %}
{{ super() }}
{{ pagedown.include_pagedown() }}
{% endblock %}
```

通过这些改变，在文本域字段输入的Markdown格式的文本将会被在下面的预览区域立即生成HTML

##### 在服务器端处理富文本

当表单被提交时，只有原始的Markdown文本被POST请求发送。显示在页面上的HTML预览被废弃了。使用表单发送生成后的HTML预览可以被认为有安全风险的。因为这对于攻击者来说非常容易构造一个不匹配Markdown源的HTML序列并提交他们。为了避免任何风险，只有Markdown原始文本被提交，在服务器端使用Markdown(一个Python Markdown到HTML的转换器) 将它再次转换为HTML。产生的HTML会使用Bleach进行清理，来确保只有一部分允许使用的HTML标签。

为了避免重复，当博客文章被创建的时候，只做一次转换。渲染后的博客文章的HTML代码缓存在一个Post新增加的字段中，可以被直接访问。原始的Markdown源代码也会被保存在数据库以防文章需要被编辑。

*Example 11-15. app/models/post.py: Markdown text handling in the Post model*

```python
from markdown import markdown
import bleach
class Post(db.Model):
	# ...
	body_html = db.Column(db.Text)
	# ...
    
	@staticmethod
	def on_changed_body(target, value, oldvalue, initiator):
		allowed_tags = ['a', 'abbr', 'acronym', 'b', 'blockquote', 'code',
						'em', 'i', 'li', 'ol', 'pre', 'strong', 'ul',
						'h1', 'h2', 'h3', 'p']
		target.body_html = bleach.linkify(bleach.clean(
					markdown(value, output_format='html'),
								tags=allowed_tags, strip=True))
        
        
db.event.listen(Post.body, 'set', Post.on_changed_body)
```

`on_chaged_body`函数被作为一个body的SQLAlchemy的 `set`事件监听器注册。这意味着每当这个类的任意实例的body字段被设置了新的值，它都会自动被调用。函数渲染body的HTML版本并把它存在body_html中。有效的全自动的让Markdown文本到HTML转换。

实际的转换做了三个步骤：首先`markdown()`函数做一个初始化转换到HTML，结果传递给`clean()`，提供一个允许的HTML标签列表。`clean()`函数删除不在白名单的任何标签。最终的转换是由`linkify()`完成，Bleach提供的另一个函数转换任何的写在普通文编的URL到恰当的`<a>`链接。最后一步是必须的，因为自动生成链接不在Markdown的规范里。PageDown支持他作为一个扩展。

最后一个改变是当可用的时候在模板中使用  `post.body_html`替换`post.body`

```html
...
<div class="post-body">
{% if post.body_html %}
	{{ post.body_html | safe }}
{% else %}
	{{ post.body }}
{% endif %}
</div>
...
```

当在渲染HTML body的时候，`| safe`后缀告诉Jinja2不要转义HTML元素。默认情况下，Jinja2会转义所有的模板变量，Markdown生成的HTML是在服务器生成。，所以渲染它是安全的。

#### 博客文章的永久链接

用户可能和社交网络上的朋友分享具体的博客文章，为了这个目的，每个博客都会被赋予一个唯一引用它的URL页面

*Example 11-17. app/main/views.py: Permanent links to posts*

```python
@main.route('/post/<int:id>')
def post(id):
	post = Post.query.get_or_404(id)
	return render_template('post.html', posts=[post])
```

永久链接被增加到了公用的`_posts.html`模板的底部

*Example 11-18. app/templates/_posts.html: Permanent links to posts*

```python
<ul class="posts">
	{% for post in posts %}
	<li class="post">
		...
		<div class="post-content">
			...
			<div class="post-footer">
				<a href="{{ url_for('.post', id=post.id) }}">
					<span class="label label-default">Permalink</span>
				</a>
			</div>
		</div>
	</li>
	{% endfor %}
</ul>
```

*Example 11-19. app/templates/post.html: Permanent link template*

```python
{% extends "base.html" %}

{% block title %}Flasky - Post{% endblock %}

{% block page_content %}
{% include '_posts.html' %}
{% endblock %}
```

#### 博客文章编辑器

与博客文章相关的最后一个功能就是允许用户编辑他们自己的文章。博客文章编辑器放在一个单独的页面，

*Example 11-20. app/templates/edit_post.html: Edit blog post template*

```html
{% extends "base.html" %}
{% import "bootstrap/wtf.html" as wtf %}

{% block title %}Flasky - Edit Post{% endblock %}

{% block page_content %}
    <div class="page-header">
        <h1>Edit Post</h1>
    </div>
    <div>
        {{ wtf.quick_form(form) }}
    </div>
{% endblock %}

{% block scripts %}
    {{ super() }}
    {{ pagedown.include_pagedown() }}
{% endblock %}
```

*Example 11-21. app/main/views.py: Edit blog post route*

```python
@main.route('/edit/<int:id>', methods=['GET', 'POST'])
@login_required
def edit(id):
    post = Post.query.get_or_404(id)
    if current_user != post.auhor and not current_user.can(Permission.ADMINISTER):
        abort(403)
    form = PostForm()
    if form.validate_on_submit():
        post.body = form.body.data
        db.session.add(post)
        flash('The post has been updated.')
        return redirect(url_for('post', id=post.id))
    form.body.data = post.body
    return render_template('edit_post.html', form=form)
```

这个视图函数被编写除了管理员之后，只允许一个博客文章的作者去编辑它。管理员允许编辑所有用户的文章。如果一个用户试图编辑一个来自其他用户的文章，视图函数将会响应一个403错误。在这`PostForm`表单类和在主页使用的类是一样的。

为了完成这个功能，一个链接到博客编辑器的链接在每个博客文章下被增加了。

*Example 11-22. app/templates/_posts.html: Edit blog post links*

```html
<ul class="posts">
    {% for post in posts %}
        <li class="post">
            <div class="post-thumbnail">
                <a href="{{ url_for('.user', username=post.author.username) }}">
                    <img class="img-rounded profile-thumbnail" src="{{ post.author.gravatar(size=40) }}">
                </a>
            </div>
            <div class="post-content">
                <div class="post-date">{{ moment(post.timestamp).fromNow() }}</div>
                <div class="post-author"><a
                        href="{{ url_for('.user', username=post.author.username) }}">{{ post.author.username }}</a>
                </div>
                <div class="post-body">
                    {% if post.body_html %}
                        {{ post.body_html | safe }}
                    {% else %}
                        {{ post.body }}
                    {% endif %}
                </div>
                <div class="post-footer">
                    <a href="{{ url_for('.post',id=post.id) }}">
                        <span class="label label-default">Permalink</span>
                    </a>
                    {% if current_user == post.author %}
                        <a href="{{ url_for('.edit', id=post.id) }}">
                            <span class="label label-primary">Edit</span>
                        </a>
                    {% elif current_user.is_administrator() %}
                        <a href="{{ url_for('.edit', id=post.id) }}">
                            <span class="label label-danger">Edit [Admin]</span>
                        </a>
                    {% endif %}
                </div>
            </div>
        </li>
    {% endfor %}
</ul>
```

这个改变增加了一个编辑链接到当前用户被授修改的博客文章，对于管理员来说，这个链接增加到所有的博客文章。