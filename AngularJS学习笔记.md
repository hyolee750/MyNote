### ng指令

---

#### angular.copy

创建一个源目标的深复制，源目标应该是一个对象或数组

- 如果目的目标没有提供，则创建该对象或数组的复制
- 如果目的目标有提供，所有的元素或属性都被删除，然后从源目标复制所有的元素或属性
- 如果源目标不是对象或数组，源目标被返回
- 如果源目标和目的目标相同，将会抛出异常

#### 用法

`angular.copy(source,[destination]);`

##### 参数

source 	*	可以是任何类型，包括基本类型，null和undefined

destination  [Object,Array] 		目的目标，必须和源目标是同一类型

##### 返回

返回一份源目标的复制，如果目的目标存在，则更新目的目标

---

#### angular.element

**包装一个原始的DOM元素或HTML字符串作为一个jQuery元素**

如果jQuery存在，`angular.element` 是jQuery 函数的别名，如果jQuery不存在，`angular.element`委派给AngularJS的内置jQuery子集`jqLite`

为了使用`jQuery`，要确保它在`angular.js`之前被加载

##### AngularJS的jqLite

jqLite 只提供了以下jQuery的方法：

- `addClass()`不支持function作为第一个参数
- `after()`
- `append()`
- `attr()`不支持function作为参数
- `bind()`过时了，使用`on()`代替
- `children()`不支持选择器
- `clone()`
- `contents()`
- `css()`
- `detach()`
- `empty()`
- `eq()`
- `find()`不支持按标签名查询
- `hasClass()`
- `html()`
- `next()`不支持选择器
- `on()`
- `off()`
- `one()`
- `parent()`
- `prepend()`
- `prop()`
- `ready()` 过时了
- `remove()`
- `removeAttr()`
- `removeClass()`
- `removeData()`
- `replaceWith()`
- `text()`
- `toggleClass()`
- `triggerHandler()`
- `unbind()`
- `val()`
- `wrap()`

##### 用法

`angular.element(element)`

---

#### angular.equals

判断两个对象或两个值是否相等

---

#### angular.forEach

为在`obj`集合中的每一个条目调用`iterator`函数，可以是一个对象，或者一个数组

##### 用法

`angular.forEach(obj,iterator,[context])`

```javascript
var values = {name:'misko',gender:'male'}
var log = [];
angular.forEach(values,function(value,key){
  this.push(key+":"+value);
},log);
except(log).toEqual(['name:misko','gender:male'])
```

---

#### angular.formJson

反序列一个JSON字符串

---

##### angular.isArray 判断一个引用是否是数组

​	`angular.isArray(value)`

##### angular.isDate 

##### angular.isDefined

##### angular.isElement

##### angular.isFunction

##### angular.isNumber

##### angular.isObject

##### angular.isString

##### angular.isUndefined

##### angular.merge

##### angular.toJson

---

