Docker Bt Panel
===============

### 环境变量配置（使用docker-composer启动时）

+ 创建 `.env` 文件
+ 复制 `example.env` 文件内容 到 `.env` 文件
+ 修改 `.env` 文件的中的配置项

### 启动命令示例：

```shell
# docker 启动
docker run -p 8888:8888 -p 80:80 -v ./www:/www/wwwroot --name bt-server itxq/bt:latest /bin/bash /www/run.sh
# docker-composer 启动
docker-compose -f docker-compose.yml up -d
```

### 建议端口映射：

+ 8888 宝塔面板端口
+ 8080 Tomcat默认端口
+ 3306 MySQL默认端口
+ 888 phpMyAdmin默认端口
+ 443 https默认端口
+ 80 网站默认端口
+ 21 FTP默认端口
+ 20 FTP主动模式数据端口
+ 39000-40000 FTP被动模端口范围

### 建议挂载目录：

+ /www/wwwroot 站点目录
+ /www/wwwlogs 日志目录
+ /www/backup/database 数据库备份存放目录
+ /www/backup/site  网站备份存放目录
+ /www/backup/path  目录备份存放目录
+ /www/server/data 数据库数据目录
+ /www/server/cron 定时任务脚本存放目录
+ /www/Recycle_bin 回收站目录

### 默认登录信息：

> **地址：** http://ip:port/www_xqitw_cn

> **账号：** www_xqitw_cn

> **密码：** www_xqitw_cn

### 常用命令小结：

```shell
# 导出
docker export -o bt-server.tar bt-server
# 导入
docker import bt-server.tar bt-server:latest
# 进入容器
docker exec -i -t  bt-server /bin/bash
# 可视化管理工具
docker run -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock:ro -v ./portainer:/data --restart=always --name portainer-server portainer/portainer:latest 
```
