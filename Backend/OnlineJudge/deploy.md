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