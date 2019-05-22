FROM centos:7

MAINTAINER IT小强xqitw.cn <mail@xqitw.cn>

RUN yum update -y \
    && yum install -y expect \
    && yum install -y crontabs \
    && yum install -y wget \
    && wget -O install.sh http://download.bt.cn/install/install_6.0.sh

RUN yes y | /bin/bash install.sh

# 修改安全入口 和 面板密码
RUN echo "/www_xqitw_cn" >> /www/server/panel/data/admin_path.pl \
    && python /www/server/panel/tools.py panel www_xqitw_cn

# 修改宝塔面板用户名
RUN echo "#!/bin/expect" >> /www/expect.sh \
    && echo "spawn python /www/server/panel/tools.py cli" >> /www/expect.sh \
    && echo "expect \"请输入命令编号：\"" >> /www/expect.sh \
    && echo "send 6\n" >> /www/expect.sh \
    && echo "expect \"请输入新的面板用户名(>5位)：\"" >> /www/expect.sh \
    && echo "send \"www_xqitw_cn\n\"" >> /www/expect.sh \
    && echo "expect eof" >> /www/expect.sh \
    && expect /www/expect.sh

# 启动脚本
RUN echo "#!/bin/sh" >> /www/run.sh \
    && echo "/usr/sbin/crond start" >> /www/run.sh \
    && echo "/etc/init.d/bt start" >> /www/run.sh \
    && echo "/bin/bash" >> /www/run.sh

LABEL org.label-schema.schema-version="1.0.0" \
    org.label-schema.name="Docker Bt Panel" \
    org.label-schema.vendor="IT小强xqitw.cn" \
    org.label-schema.license="Apache Licence 2.0" \
    org.label-schema.build-date="20190521"

EXPOSE 8888 8080 3306 888 443 80 21 20

VOLUME ["/www/wwwroot","/www/wwwlogs","/www/backup/database","/www/backup/site","/www/server/data","/www/server/cron","/www/Recycle_bin"]

CMD /bin/bash /www/run.sh

