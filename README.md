
## 项目要求

详情见：

- 任务书.docx
- 课程设计上缴内容.docx

## 项目介绍

sql 目录存储数据库，按照文件名从0-9,a-z的顺序依次执行；

fake-data 用于生成测试数据。

backup.sql 为数据库导出的sql语句；
backup.tar 为/var/lib/mysql目录的打包；

## TODO

- 关于 Procedures 删除普遍出现执行错误。

## Others

### Docker 数据导出步骤

进入运行中的数据库容器：

```sh
docker exec -it <container_id_or_name> bash
```

这将让你进入运行中的数据库容器的bash shell中。

使用数据库管理工具导出数据：

使用 mysqldump 命令导出数据库。例如，导出数据库 mydatabase 到文件 backup.sql：

```sh
mysqldump -u root -p mydatabase > /path/to/backup.sql
```

在这里，-u 是用户名，-p 会提示你输入密码。将数据导出到容器内部文件系统的路径，然后可以通过 docker cp 命令将其复制到主机上。
复制导出的文件到主机：

```sh
docker cp <container_id_or_name>:/path/to/backup.sql /host/path/backup.sql
```

这将在主机上的 /host/path/ 目录中复制 backup.sql 文件。

### 将 sql 文件倒入

mysql -u root -p mydatabase < /tmp/backup.sql