# 基于Centos7镜像
FROM centos:7

# 镜像作者信息
MAINTAINER IT小强xqitw.cn <mail@xqitw.cn>

# 包含环境变量
RUN echo "# .bash_profile" > /root/.bash_profile \
    && echo "# Get the aliases and functions" >> /root/.bash_profile \
    && echo "if [ -f ~/.bashrc ]; then" >> /root/.bash_profile \
    && echo "	. ~/.bashrc" >> /root/.bash_profile \
    && echo "fi" >> /root/.bash_profile \
    && echo "# User specific environment and startup programs" >> /root/.bash_profile \
    && echo "PATH=\$PATH:\$HOME/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin" >> /root/.bash_profile \
    && echo "export PATH" >> /root/.bash_profile

# 安装必要的扩展包
RUN yum update -y \
    && yum install -y expect \
    && yum install -y crontabs \
    && yum install -y wget \
    && wget -O install.sh http://download.bt.cn/install/install_6.0.sh

# 安装宝塔面板
RUN yes y | /bin/bash install.sh

# 修改安全入口 和 面板密码
RUN echo "/www_xqitw_cn" > /www/server/panel/data/admin_path.pl \
    && python /www/server/panel/tools.py panel www_xqitw_cn

# 修改宝塔面板用户名
RUN echo "#!/bin/expect" > /www/expect.sh \
    && echo "spawn python /www/server/panel/tools.py cli" >> /www/expect.sh \
    && echo "expect \"请输入命令编号：\"" >> /www/expect.sh \
    && echo "send 6\n" >> /www/expect.sh \
    && echo "expect \"请输入新的面板用户名(>5位)：\"" >> /www/expect.sh \
    && echo "send \"www_xqitw_cn\n\"" >> /www/expect.sh \
    && echo "expect eof" >> /www/expect.sh \
    && expect /www/expect.sh

# 启动脚本
RUN echo "Docker Bt Panel Start Complete!" > /www/run.log \
    && echo "#!/bin/sh" > /www/run.sh \
    && echo "/usr/sbin/crond start" >> /www/run.sh \
    && echo "/etc/init.d/bt restart" >> /www/run.sh \
    && echo "tail -f -n 1 /www/run.log" >> /www/run.sh

# 镜像信息
LABEL org.label-schema.schema-version="2.0.0" \
    org.label-schema.name="Docker Bt Panel" \
    org.label-schema.vendor="IT小强xqitw.cn" \
    org.label-schema.license="Apache Licence 2.0" \
    org.label-schema.build-date="20190523"

# 开放端口
EXPOSE 39000-40000 8888 8080 3306 888 443 80 21 20

# 启动命令
CMD /bin/bash /www/run.sh

