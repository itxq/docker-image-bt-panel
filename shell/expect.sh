#!/bin/expect

spawn python /www/server/panel/tools.py cli

expect "请输入命令编号*"
send 6\n

expect "请输入新的面板用户名*"
send "www_xqitw_cn\n"
expect eof

