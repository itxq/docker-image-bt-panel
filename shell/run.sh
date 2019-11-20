#!/bin/bash
# 启动 crond
/usr/sbin/crond start
# 启动宝塔
/etc/init.d/bt restart
# 执行自定义脚本
/bin/bash /itxq/shell/shell.sh
# 维持容器状态
tail -f -n 1 /itxq/shell/run.log