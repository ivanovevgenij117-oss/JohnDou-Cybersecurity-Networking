FROM nginx:latest

WORKDIR /home

#устанавливаем обновления, нужные программы и чистим кэш apt
RUN apt update -y && apt upgrade -y \
&& apt-get install -y gcc -y spawn-fcgi -y libfcgi-dev \
&& rm -rf /var/lib/apt/lists

#копируем исходник cgi сервера
COPY hello.c /home/hello.c
RUN gcc /home/hello.c -o hello.fcgi -lfcgi
COPY script.sh /home/script.sh
COPY default.conf ../etc/nginx/conf.d/default.conf

# Корректируем права доступа на каталог /run для группы nginx
RUN chmod -R g+rwx /run && chgrp -R nginx /run
# Создаем необходимую директорию и настраиваем права владения
RUN mkdir -p /var/cache/nginx && chown -R nginx:nginx /var/cache/nginx

USER nginx

ENTRYPOINT ["bash", "script.sh"]
