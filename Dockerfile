# 基于Centos镜像
FROM centos:latest

# 镜像作者信息
MAINTAINER IT小强xqitw.cn <mail@xqitw.cn>

# 宝塔面板下载地址
ARG BT_VERSION="http://download.bt.cn/install/install_6.0.sh?vsersion=6.9.6"
ENV BT_VERSION=$BT_VERSION

# 添加shell脚本
COPY ./shell /itxq/shell

# 安装必要的扩展包
RUN yum update -y \
    && yum install -y git \
    && yum install -y expect \
    && yum install -y crontabs \
    && yum install -y deltarpm \
    && yum install -y wget \
    && wget -O install.sh $BT_VERSION

# 安装宝塔面板
RUN yes y | /bin/bash install.sh

# 修改安全入口 、 面板密码 、 面板用户名
RUN echo "/www_xqitw_cn" > /www/server/panel/data/admin_path.pl \
    && python /www/server/panel/tools.py panel www_xqitw_cn \
    && expect /itxq/shell/expect.sh

# 镜像信息
LABEL org.label-schema.schema-version="4.0.0" \
    org.label-schema.name="Docker Bt Panel" \
    org.label-schema.vendor="IT小强xqitw.cn" \
    org.label-schema.license="Apache Licence 2.0" \
    org.label-schema.build-date="20190628"

# 开放端口
EXPOSE 8888 8080 3306 888 443 80 21 20

# 启动命令
ENTRYPOINT /bin/bash /itxq/shell/run.sh

CMD /bin/bash

