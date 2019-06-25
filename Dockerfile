# 基于Centos7镜像
FROM centos:7

# 镜像作者信息
MAINTAINER IT小强xqitw.cn <mail@xqitw.cn>

ARG BT_VERSION=6.9.5

# 添加shell脚本
COPY ./shell /itxq/shell

# 安装必要的扩展包
RUN yum update -y \
    && yum install -y git \
    && yum install -y expect \
    && yum install -y crontabs \
    && yum install -y wget \
    && wget -O install.sh http://download.bt.cn/install/install_6.0.sh?v=${BT_VERSION}

# 安装宝塔面板
RUN yes y | /bin/bash install.sh

# 修改安全入口 和 面板密码
RUN echo "/www_xqitw_cn" > /www/server/panel/data/admin_path.pl \
    && python /www/server/panel/tools.py panel www_xqitw_cn

# 创建目录
RUN cd / && mkdir -m 777 itxq

# 修改宝塔面板用户名
RUN expect /itxq/shell/expect.sh

# 镜像信息
LABEL org.label-schema.schema-version="4.0.0" \
    org.label-schema.name="Docker Bt Panel" \
    org.label-schema.vendor="IT小强xqitw.cn" \
    org.label-schema.license="Apache Licence 2.0" \
    org.label-schema.build-date="20190625"

# 开放端口
EXPOSE 8888 8080 3306 888 443 80 21 20

# 启动命令
CMD /bin/bash /itxq/shell/run.sh

