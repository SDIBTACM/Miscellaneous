## 环境依赖
- JDK 11
- MySQL 5.7+
- Redis
- Docker

## 开发工具
- IntelliJ IDEA
- Maven
- IDEA Plugin
  - Alibaba Java Coding Guidelines
  - CheckStyle-IDEA
  - Lombok

## 包依赖
- Swagger (Doc生成)
- Druid
- Spring Boot JPA

## 开发
### 事前准备

1. 准备一个 `MySQL` 用户和表； 重命名 `config/application.yml.example` ， 并且将 `config/application.yml` 中的配置修改为适用于本地开发环境或生产环境的配置。`src/main/resources/application.yml` **不做任何改动**

2. 配置 CheckStyle
    - 进入 CheckStyle 配置：File | Settings | Other Settings | Checkstyle；
    - 在配置文件中点击添加按钮，配置描述可随便填写（建议 Online Judge Checks），选择 ./config/checkstyle/checkstyle.xml，点击下一步和完成；
    - 勾选刚刚创建的配置文件。
3. 配置 Editor
    - 进入编辑器配置：File | Settings | Editor | Code Style；
    - 导入 checkstyle.xm 配置：![](../static/CheckStyleConfigGuide.png)
    - 选择 ./config/checkstyle/checkstyle.xml 配置文件，点击确定即可。
4. 开发阶段，为防止生成假数据可能导致的bug，请将 `spring.jpa.hibernate.ddl-auto` 调至 **create** 模式

## 测试

### DebugData

`DebugData(src/main/resources/DebugData)`作为 Online Judge 的假数据，主要用于接口调试。 如需使用，请指定`online-judge.debug.generator-data=true`(此为application.propertity的格式，需要yaml请自行转换)。

`DebugData`内部数据为JSON, 为防止解析出错，请严格遵循以下格式:

```json
{
    "all-data":[
        {
            "class_pkg":"full name of the json object's class",
            "data":[
                {
                    "id":"obj's id",
                    "object filed":"object properties"
                }
            ]
        }
    ]
}
```

以下内容作为编写DebugData时的参考(请注意在Entity中大部分字段均不可为空):

```json
{
    "all-data":[
        {
            "class_pkg":"cn.edu.sdtbu.model.entity.UserEntity",
            "data":[
                {
                    "id":"1",
                    "email":"admin@mail.com",
                    "nickname":"admin",
                    "password":"password",
                    "role":"ADMIN",
                    "school":"admin_school",
                    "status":"NORMAL",
                    "username":"admin"
                },
                {
                    "id":"2",
                    "email":"teacher@mail.com",
                    "nickname":"teacher",
                    "password":"password",
                    "role":"TEACHER",
                    "school":"teacher_school",
                    "status":"NORMAL",
                    "username":"teacher"
                }
            ]
        },
        {
            "class_pkg":"cn.edu.sdtbu.model.entity.ProblemEntity",
            "data":[
                {
                    "id":"1",
                    "specialJudge":"false",
                    "problemType":"NORMAL",
                    "hide":"false",
                }
            ]
        }
    ]
}
```

