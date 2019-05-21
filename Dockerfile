FROM centos:7

MAINTAINER IT小强xqitw.cn <mail@xqitw.cn>

RUN yum update -y

RUN yum install -y crontabs && /usr/sbin/crond start

RUN yum install -y wget && wget -O install.sh http://download.bt.cn/install/install_6.0.sh

RUN yes | /bin/bash install.sh

COPY ./run.sh /bin/run.sh

LABEL org.label-schema.schema-version="1.0.0" \
    org.label-schema.name="Docker Bt Panel" \
    org.label-schema.vendor="IT小强xqitw.cn" \
    org.label-schema.license="Apache Licence 2.0" \
    org.label-schema.build-date="20190521"

CMD ["/bin/run.sh"]

