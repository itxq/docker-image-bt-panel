# 基于Centos镜像
FROM centos:latest

# 镜像作者信息
MAINTAINER IT小强xqitw.cn <mail@xqitw.cn>

# 设置时区为上海
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' > /etc/timezone

# 宝塔面板下载地址
ARG BT_VERSION="http://download.bt.cn/install/install_6.0.sh"
ENV BT_VERSION=${BT_VERSION}

# 添加shell脚本
COPY ./shell /itxq/shell

# 安装必要的扩展包
RUN yum update -y \
    && yum install -y git \
    && yum install -y expect \
    && yum install -y crontabs \
    && yum install -y sudo \
    && yum install -y wget \
    && yum clean all

# 安装宝塔面板
RUN wget -O install.sh ${BT_VERSION}
RUN yes y | /bin/bash install.sh

# 修改安全入口 、 面板密码 、 面板用户名
RUN echo "/www_xqitw_cn" > /www/server/panel/data/admin_path.pl \
    && python /www/server/panel/tools.py panel www_xqitw_cn \
    && expect /itxq/shell/expect.sh

# 建立软连接
RUN ln -sfv /itxq/shell/run.sh /usr/bin/run-bt && chmod a+x /usr/bin/run-bt

# 镜像信息
LABEL org.label-schema.schema-version="5.0.0" \
    org.label-schema.name="Docker Bt Panel" \
    org.label-schema.vendor="IT小强xqitw.cn" \
    org.label-schema.license="Apache Licence 2.0" \
    org.label-schema.build-date="20191109"

# 开放端口
EXPOSE 8888 8080 888 443 80 21 20

# 启动命令
CMD ["run-bt"]

