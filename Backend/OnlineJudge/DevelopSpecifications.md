# 开发规约

本项目代码规约主要使用[《阿里巴巴Java开发规约》](https://github.com/alibaba/p3c)， 以及以下条约：

## 代码风格

- 为保证每位提交者代码的风格保持一致，减少无效代码的修改，请安装 `checkstyle` 插件
- 对于大括号， 我们约定： `class/interface/enum` 等类定义末尾换行后使用 `{` , 其余不换行。。

## Controller

`Controller` 层的注解统一使用`@RestController`， 请勿使用`@Controller`注解， 同时注意**尽量不要**在`Controller`层处理逻辑。

### Http Response

对于 `Controller` 返回的信息，我们约定如下:

1. 除异常外统一返回 `ResponseEntity<T>` 
2. 当状态码为**200**时， 成功的含义取决于 HTTP 方法:
    - GET：资源已被提取并在消息正文中传输。
    - HEAD：实体标头位于消息正文中。
    - POST：描述动作结果的资源在消息体中传输。
    - TRACE：消息正文包含服务器收到的请求消息
    - 当无需信息返回时， 返回 "OK" 即可
3. 当抛出异常时， 将会在全局异常处理类`GlobalExceptionHandler`中捕获并返回`ErrorResponse`, 其中的 `code` 字段**不可忽略**， 状态码为 4xx、5xx 。



## Service

对于`Service` 层，  请通过接口实现。 同时接口继承自`BaseService<DOMAIN, ID>`接口， 里面封装了常用的CRUD操作。 实现类的`public`方法需与接口定义的方法一一对应， **严禁**实现类中出现未重写的`public`方法 



## Util

对于工具类， 当前依赖里有相关工具的时候**尽量不要造轮子**， 如果实在需要，请注意：

1. 请用`private`修饰工具类的无参构造方法，避免后期维护人员使用工具类时进行`new`操作的可能性
2. 在工具类中尽量不进行`new`操作
3. 如果工具类中的方法不想用`static`方法修饰， 可以通过 [单例模式](https://www.runoob.com/design-pattern/singleton-pattern.html) 去实现