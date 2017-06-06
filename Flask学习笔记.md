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

| 块名称            | 描述                 |
| -------------- | ------------------ |
| `doc`          | 整个HTML文档           |
| `html_attribs` | 在`<html>`标签内的属性    |
| `html`         | `<html>`标签的内容      |
| `head`         | `<head>`标签的内容      |
| `title`        | `<title>`标签的内容     |
| `metas`        | `<meta>`标签列表       |
| `styles`       | 级联样式表定义            |
| `body_attribs` | `<body>`标签内的属性     |
| `body`         | `<body>`标签的内容      |
| `navbar`       | 用户自定义的导航栏          |
| `content`      | 用户自定义的页面内容         |
| `scripts`      | 在文档底部声明的JavaScript |

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