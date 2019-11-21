Docker Bt Panel
===============

宝塔Linux面板是一款简单好用的服务器管理面板， 2分钟安装即可一键管理服务器。

## 安装 Docker

### Windows
+ [Install Docker Desktop for Windows](https://docs.docker.com/docker-for-windows/install/)

### MacOS
+ [Install Docker Desktop for Mac](https://docs.docker.com/docker-for-mac/install/)

### Linux
+ [Get Docker CE for CentOS](https://docs.docker.com/install/linux/docker-ce/centos/)
+ [Get Docker CE for Debian](https://docs.docker.com/install/linux/docker-ce/debian/)
+ [Get Docker CE for Fedora](https://docs.docker.com/install/linux/docker-ce/fedora/)
+ [Get Docker CE for Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

## 安装 Docker Compose

+ [Install Docker Compose](https://docs.docker.com/compose/install/)

## 镜像下载

+ 镜像仓库地址：[https://hub.docker.com/r/itxq/bt](https://hub.docker.com/r/itxq/bt)

+ Github地址：[https://github.com/itxq/docker-image-bt-panel](https://github.com/itxq/docker-image-bt-panel)

```shell
# 下载命令
docker pull itxq/bt:latest
```

## 环境变量配置（使用docker-composer启动时）

+ 创建 `.env` 文件
+ 复制 `.example.env` 文件内容 到 `.env` 文件
+ 修改 `.env` 文件的中的配置项

## 启动命令示例：

```shell
# docker 启动
docker run -p 8888:8888 --name bt-server itxq/bt:latest
# docker-composer 启动
docker-compose -f docker-compose.yml up -d
```

## 建议端口映射：

+ 8888 宝塔面板端口
+ 8080 Tomcat默认端口
+ 3306 MySQL默认端口
+ 888 phpMyAdmin默认端口
+ 443 https默认端口
+ 80 网站默认端口
+ 21 FTP默认端口
+ 20 FTP主动模式数据端口
+ 39000-40000 FTP被动模端口范围

## 建议挂载目录：

+ /www/wwwroot 站点目录
+ /www/wwwlogs 日志目录
+ /www/backup/database 数据库备份存放目录
+ /www/backup/site  网站备份存放目录
+ /www/backup/path  目录备份存放目录
+ /www/server/cron 定时任务脚本存放目录
+ /www/Recycle_bin 回收站目录
+ /www/server/data 数据库数据目录

## 默认登录信息：

+ **地址：** [http://127.0.0.1:9204/www_xqitw_cn](http://127.0.0.1:9204/www_xqitw_cn)（此处需要替换为你的IP及映射的端口号）

+ **账号：** www_xqitw_cn

+ **密码：** www_xqitw_cn

## 常用命令小结：

```shell
# 提交新镜像
docker commit server-bt server-bt:latest
# 导出
docker export -o server-bt.tar server-bt
# 导入
docker import server-bt.tar server-bt:latest
# 进入容器
docker exec -i -t  server-bt /bin/bash
# 可视化管理工具
docker run -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v /portainer:/data --restart=always --name server-portainer portainer/portainer:latest 
```
