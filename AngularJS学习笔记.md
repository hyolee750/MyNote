### 构建一个简单的AngularJS应用

在这一章将会学到以下内容：

- 从`scratch`创建一个AngularJS应用
- 创建自定义控制器，指令和服务
- 和一个额外的API服务器进行交互
- 使用HTML5 `LocalStorage` 存储客户端数据
- 使用`ngAnimate`创建简单的动画
- 使用`GItHub Pages`打包你的应用进行发行和部署

#### 第一步：使用YEOMAN构建项目手脚架

##### 安装Yeoman

```shell
npm install -g grunt-cli
npm install -g bower
npm install -g generator-angular
npm install -g yo
```

##### 构建项目手脚架

```shell
yo angular StockDog
```

##### 运行应用

```shell
grunt serve
```

##### 清理

删除以下内容：

```html
app/views/main.html
app/views/about.html
app/scripts/controllers/main.js
app/scripts/controllers/about.js
```

接下来删除 Yeoman创建的路由,打开`app/scripts/app.js`

```javascript
.when('/', {
templateUrl: 'views/main.html',
controller: 'MainCtrl'
})
.when('/about', {
templateUrl: 'views/about.html',
controller: 'AboutCtrl'
})
```

最后删除`app/index.html`中的js引用

```html
<script src="scripts/controllers/main.js"></script>
<script src="scripts/controllers/about.js"></script>
```

#### 第二步：创建WATCHLISTS

##### 应用模块

###### 安装模块依赖

安装`AngularStrap`

```shell
bower install angular-strap#v2.1.0 -save
```

添加依赖

```javascript
angular
.module('stockDogApp', [
'ngAnimate',
'ngCookies',
'ngResource',
'ngRoute',
'ngSanitize',
'ngTouch',
'mgcrea.ngStrap'
]);
```

##### 启动应用

```html
<body ng-app="stockDogApp">
  
</body>
```

##### Watchlist 服务

安装服务

```shell
yo angular:service Watchlist-Service
```

安装lodash

```shell
bower install lodash --save
```



