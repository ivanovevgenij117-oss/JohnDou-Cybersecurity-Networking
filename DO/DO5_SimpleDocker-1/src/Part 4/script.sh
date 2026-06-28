#!/bin/bash
gcc /home/hello.c -o hello.fcgi -lfcgi
#запускам fcgi с нашим бинарником
spawn-fcgi -p 8080 /home/hello.fcgi
#перезапускаем nginx
nginx -s reload
#устанавливаем nginx в фоновый режим
nginx -g 'daemon off;'
