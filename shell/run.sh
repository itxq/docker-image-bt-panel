#!/bin/bash

# 执行自定义脚本
/bin/bash /itxq/shell/shell.sh
# 启动 crond
rm -rf /var/run/crond.pid
/usr/sbin/crond restart
# 启动宝塔
/etc/init.d/bt restart
# 维持容器状态
tail -f -n 1 /itxq/shell/run.log